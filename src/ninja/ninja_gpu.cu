/******************************************************************************
 *
 * WindNinja GPU Solver - CUDA Implementation
 * Purpose:  GPU-accelerated conjugate gradient solver for wind simulation
 *
 ******************************************************************************/

#include "ninja_gpu.cuh"
#include <stdio.h>
#include <stdlib.h>
#include <cmath>

static cudaDeviceProp g_deviceProp;
static bool g_gpuInitialized = false;

void gpu_init()
{
    if (g_gpuInitialized) return;
    
    int deviceCount;
    cudaError_t err = cudaGetDeviceCount(&deviceCount);
    
    if (err != cudaSuccess || deviceCount == 0) {
        fprintf(stderr, "No CUDA-capable GPU detected. Falling back to CPU.\n");
        return;
    }
    
    int device = 0;
    CUDA_CHECK(cudaSetDevice(device));
    CUDA_CHECK(cudaGetDeviceProperties(&g_deviceProp, device));
    
    printf("GPU Solver initialized: %s\n", g_deviceProp.name);
    printf("  Compute capability: %d.%d\n", g_deviceProp.major, g_deviceProp.minor);
    printf("  Total global memory: %.2f GB\n", 
           (double)g_deviceProp.totalGlobalMem / (1024.0 * 1024.0 * 1024.0));
    
    g_gpuInitialized = true;
}

void gpu_cleanup()
{
    if (g_gpuInitialized) {
        CUDA_CHECK(cudaDeviceReset());
        g_gpuInitialized = false;
    }
}

bool gpu_allocate(GPUSolverData* data, int n, int nnz)
{
    if (!g_gpuInitialized) {
        gpu_init();
        if (!g_gpuInitialized) return false;
    }
    
    data->n = n;
    data->nnz = nnz;
    
    CUDA_CHECK(cudaMalloc(&data->d_A, nnz * sizeof(double)));
    CUDA_CHECK(cudaMalloc(&data->d_row_ptr, (n + 1) * sizeof(int)));
    CUDA_CHECK(cudaMalloc(&data->d_col_ind, nnz * sizeof(int)));
    CUDA_CHECK(cudaMalloc(&data->d_x, n * sizeof(double)));
    CUDA_CHECK(cudaMalloc(&data->d_b, n * sizeof(double)));
    CUDA_CHECK(cudaMalloc(&data->d_r, n * sizeof(double)));
    CUDA_CHECK(cudaMalloc(&data->d_z, n * sizeof(double)));
    CUDA_CHECK(cudaMalloc(&data->d_p, n * sizeof(double)));
    CUDA_CHECK(cudaMalloc(&data->d_q, n * sizeof(double)));
    CUDA_CHECK(cudaMalloc(&data->d_diag, n * sizeof(double)));
    
    return true;
}

void gpu_free(GPUSolverData* data)
{
    if (data->d_A) cudaFree(data->d_A);
    if (data->d_row_ptr) cudaFree(data->d_row_ptr);
    if (data->d_col_ind) cudaFree(data->d_col_ind);
    if (data->d_x) cudaFree(data->d_x);
    if (data->d_b) cudaFree(data->d_b);
    if (data->d_r) cudaFree(data->d_r);
    if (data->d_z) cudaFree(data->d_z);
    if (data->d_p) cudaFree(data->d_p);
    if (data->d_q) cudaFree(data->d_q);
    if (data->d_diag) cudaFree(data->d_diag);
    
    data->d_A = nullptr;
    data->d_row_ptr = nullptr;
    data->d_col_ind = nullptr;
    data->d_x = nullptr;
    data->d_b = nullptr;
    data->d_r = nullptr;
    data->d_z = nullptr;
    data->d_p = nullptr;
    data->d_q = nullptr;
    data->d_diag = nullptr;
}

void gpu_copy_matrix(GPUSolverData* data, double* h_A, int* h_row_ptr, int* h_col_ind)
{
    CUDA_CHECK(cudaMemcpy(data->d_A, h_A, data->nnz * sizeof(double), cudaMemcpyHostToDevice));
    CUDA_CHECK(cudaMemcpy(data->d_row_ptr, h_row_ptr, (data->n + 1) * sizeof(int), cudaMemcpyHostToDevice));
    CUDA_CHECK(cudaMemcpy(data->d_col_ind, h_col_ind, data->nnz * sizeof(int), cudaMemcpyHostToDevice));
}

void gpu_copy_vectors(GPUSolverData* data, double* h_x, double* h_b)
{
    CUDA_CHECK(cudaMemcpy(data->d_x, h_x, data->n * sizeof(double), cudaMemcpyHostToDevice));
    CUDA_CHECK(cudaMemcpy(data->d_b, h_b, data->n * sizeof(double), cudaMemcpyHostToDevice));
}

void gpu_get_solution(GPUSolverData* data, double* h_x)
{
    CUDA_CHECK(cudaMemcpy(h_x, data->d_x, data->n * sizeof(double), cudaMemcpyDeviceToHost));
}

__global__ void kernel_spmv(int n, const double* __restrict__ A, 
                            const int* __restrict__ col_ind, 
                            const int* __restrict__ row_ptr, 
                            const double* __restrict__ x, 
                            double* __restrict__ y)
{
    int row = blockIdx.x * blockDim.x + threadIdx.x;
    
    if (row < n) {
        double sum = 0.0;
        int row_start = row_ptr[row];
        int row_end = row_ptr[row + 1];
        
        for (int i = row_start; i < row_end; i++) {
            sum += A[i] * x[col_ind[i]];
        }
        y[row] = sum;
    }
}

__global__ void kernel_vec_copy(int n, const double* __restrict__ src, 
                                double* __restrict__ dst)
{
    int i = blockIdx.x * blockDim.x + threadIdx.x;
    if (i < n) {
        dst[i] = src[i];
    }
}

__global__ void kernel_vec_scale(int n, double alpha, double* __restrict__ x)
{
    int i = blockIdx.x * blockDim.x + threadIdx.x;
    if (i < n) {
        x[i] *= alpha;
    }
}

__global__ void kernel_vec_axpy(int n, double alpha, 
                                const double* __restrict__ x, 
                                double* __restrict__ y)
{
    int i = blockIdx.x * blockDim.x + threadIdx.x;
    if (i < n) {
        y[i] += alpha * x[i];
    }
}

__global__ void kernel_vec_dot_partial(int n, 
                                       const double* __restrict__ x, 
                                       const double* __restrict__ y, 
                                       double* __restrict__ partial)
{
    __shared__ double sdata[CUDA_BLOCK_SIZE];
    
    int tid = threadIdx.x;
    int i = blockIdx.x * blockDim.x + threadIdx.x;
    
    sdata[tid] = 0.0;
    
    if (i < n) {
        sdata[tid] = x[i] * y[i];
    }
    
    __syncthreads();
    
    for (int s = blockDim.x / 2; s > 0; s >>= 1) {
        if (tid < s) {
            sdata[tid] += sdata[tid + s];
        }
        __syncthreads();
    }
    
    if (tid == 0) {
        partial[blockIdx.x] = sdata[0];
    }
}

__global__ void kernel_reduce_sum(double* __restrict__ partial, int n, 
                                  double* __restrict__ result)
{
    __shared__ double sdata[CUDA_BLOCK_SIZE];
    
    int tid = threadIdx.x;
    
    sdata[tid] = (tid < n) ? partial[tid] : 0.0;
    
    __syncthreads();
    
    for (int s = blockDim.x / 2; s > 0; s >>= 1) {
        if (tid < s) {
            sdata[tid] += sdata[tid + s];
        }
        __syncthreads();
    }
    
    if (tid == 0) {
        *result = sdata[0];
    }
}

__global__ void kernel_extract_diagonal(int n, const double* __restrict__ A,
                                        const int* __restrict__ col_ind,
                                        const int* __restrict__ row_ptr,
                                        double* __restrict__ diag)
{
    int row = blockIdx.x * blockDim.x + threadIdx.x;
    
    if (row < n) {
        int row_start = row_ptr[row];
        int row_end = row_ptr[row + 1];
        
        diag[row] = 1.0;
        
        for (int i = row_start; i < row_end; i++) {
            if (col_ind[i] == row) {
                diag[row] = A[i];
                break;
            }
        }
    }
}

__global__ void kernel_jacobi_precond(int n, 
                                      const double* __restrict__ diag,
                                      const double* __restrict__ r,
                                      double* __restrict__ z)
{
    int i = blockIdx.x * blockDim.x + threadIdx.x;
    if (i < n) {
        z[i] = r[i] / diag[i];
    }
}

__global__ void kernel_initialize_residual(int n, 
                                           const double* __restrict__ b,
                                           const double* __restrict__ Ax,
                                           double* __restrict__ r)
{
    int i = blockIdx.x * blockDim.x + threadIdx.x;
    if (i < n) {
        r[i] = b[i] - Ax[i];
    }
}

void gpu_spmv(int n, const double* d_A, const int* d_col_ind, 
              const int* d_row_ptr, const double* d_x, double* d_y)
{
    int blocks = (n + CUDA_BLOCK_SIZE - 1) / CUDA_BLOCK_SIZE;
    kernel_spmv<<<blocks, CUDA_BLOCK_SIZE>>>(n, d_A, d_col_ind, d_row_ptr, d_x, d_y);
    CUDA_CHECK(cudaGetLastError());
}

void gpu_vec_copy(int n, const double* d_src, double* d_dst)
{
    int blocks = (n + CUDA_BLOCK_SIZE - 1) / CUDA_BLOCK_SIZE;
    kernel_vec_copy<<<blocks, CUDA_BLOCK_SIZE>>>(n, d_src, d_dst);
    CUDA_CHECK(cudaGetLastError());
}

void gpu_vec_scale(int n, double alpha, double* d_x)
{
    int blocks = (n + CUDA_BLOCK_SIZE - 1) / CUDA_BLOCK_SIZE;
    kernel_vec_scale<<<blocks, CUDA_BLOCK_SIZE>>>(n, alpha, d_x);
    CUDA_CHECK(cudaGetLastError());
}

void gpu_vec_axpy(int n, double alpha, const double* d_x, double* d_y)
{
    int blocks = (n + CUDA_BLOCK_SIZE - 1) / CUDA_BLOCK_SIZE;
    kernel_vec_axpy<<<blocks, CUDA_BLOCK_SIZE>>>(n, alpha, d_x, d_y);
    CUDA_CHECK(cudaGetLastError());
}

double gpu_vec_dot(int n, const double* d_x, const double* d_y)
{
    int blocks = (n + CUDA_BLOCK_SIZE - 1) / CUDA_BLOCK_SIZE;
    
    double* d_partial;
    double* d_result;
    double h_result;
    
    CUDA_CHECK(cudaMalloc(&d_partial, blocks * sizeof(double)));
    CUDA_CHECK(cudaMalloc(&d_result, sizeof(double)));
    
    kernel_vec_dot_partial<<<blocks, CUDA_BLOCK_SIZE>>>(n, d_x, d_y, d_partial);
    kernel_reduce_sum<<<1, CUDA_BLOCK_SIZE>>>(d_partial, blocks, d_result);
    
    CUDA_CHECK(cudaMemcpy(&h_result, d_result, sizeof(double), cudaMemcpyDeviceToHost));
    
    cudaFree(d_partial);
    cudaFree(d_result);
    
    return h_result;
}

double gpu_vec_norm2(int n, const double* d_x)
{
    return std::sqrt(gpu_vec_dot(n, d_x, d_x));
}

bool gpu_solve_cg(GPUSolverData* data, int max_iter, double tol, 
                  int print_iters, double* final_residual, int* iterations)
{
    int n = data->n;
    
    double* d_A = data->d_A;
    int* d_row_ptr = data->d_row_ptr;
    int* d_col_ind = data->d_col_ind;
    double* d_x = data->d_x;
    double* d_b = data->d_b;
    double* d_r = data->d_r;
    double* d_z = data->d_z;
    double* d_p = data->d_p;
    double* d_q = data->d_q;
    double* d_diag = data->d_diag;
    
    int blocks = (n + CUDA_BLOCK_SIZE - 1) / CUDA_BLOCK_SIZE;
    
    kernel_extract_diagonal<<<blocks, CUDA_BLOCK_SIZE>>>(n, d_A, d_col_ind, d_row_ptr, d_diag);
    
    gpu_spmv(n, d_A, d_col_ind, d_row_ptr, d_x, d_q);
    
    kernel_initialize_residual<<<blocks, CUDA_BLOCK_SIZE>>>(n, d_b, d_q, d_r);
    
    kernel_jacobi_precond<<<blocks, CUDA_BLOCK_SIZE>>>(n, d_diag, d_r, d_z);
    
    gpu_vec_copy(n, d_z, d_p);
    
    double rho = gpu_vec_dot(n, d_r, d_z);
    double bnorm = gpu_vec_norm2(n, d_b);
    
    if (bnorm < 1e-15) {
        bnorm = 1.0;
    }
    
    double start_resid = 0.0;
    
    for (int i = 0; i < max_iter; i++) {
        gpu_spmv(n, d_A, d_col_ind, d_row_ptr, d_p, d_q);
        
        double pq = gpu_vec_dot(n, d_p, d_q);
        
        if (std::abs(pq) < 1e-30) {
            *iterations = i;
            *final_residual = gpu_vec_norm2(n, d_r);
            return true;
        }
        
        double alpha = rho / pq;
        
        gpu_vec_axpy(n, alpha, d_p, d_x);
        
        double neg_alpha = -alpha;
        gpu_vec_axpy(n, neg_alpha, d_q, d_r);
        
        double resid = gpu_vec_norm2(n, d_r);
        double rel_resid = resid / bnorm;
        
        if (i == 0) {
            start_resid = resid;
        }
        
        if (i % print_iters == 0) {
            printf("GPU CG Iteration %d: relative residual = %e\n", i, rel_resid);
        }
        
        if (rel_resid <= tol) {
            *iterations = i + 1;
            *final_residual = resid;
            return true;
        }
        
        kernel_jacobi_precond<<<blocks, CUDA_BLOCK_SIZE>>>(n, d_diag, d_r, d_z);
        
        double rho_new = gpu_vec_dot(n, d_r, d_z);
        double beta = rho_new / rho;
        rho = rho_new;
        
        gpu_vec_scale(n, beta, d_p);
        gpu_vec_axpy(n, 1.0, d_z, d_p);
    }
    
    *iterations = max_iter;
    *final_residual = gpu_vec_norm2(n, d_r);
    return false;
}
