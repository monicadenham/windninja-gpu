/******************************************************************************
 *
 * WindNinja GPU Solver - CUDA Header
 * Purpose:  GPU-accelerated conjugate gradient solver for wind simulation
 *
 ******************************************************************************/

#ifndef NINJA_GPU_H
#define NINJA_GPU_H

#ifdef __CUDACC__
#include <cuda_runtime.h>
#include <device_launch_parameters.h>
#endif

#include <cmath>

#ifdef __CUDACC__
#define CUDA_CHECK(call) \
    do { \
        cudaError_t err = call; \
        if (err != cudaSuccess) { \
            fprintf(stderr, "CUDA error at %s:%d - %s\n", __FILE__, __LINE__, \
                    cudaGetErrorString(err)); \
        } \
    } while(0)

#define CUDA_BLOCK_SIZE 256
#define CUDA_MAX_GRID_SIZE 65535
#endif

struct GPUSolverData {
    double* d_A;
    int* d_row_ptr;
    int* d_col_ind;
    double* d_x;
    double* d_b;
    double* d_r;
    double* d_z;
    double* d_p;
    double* d_q;
    double* d_diag;
    int n;
    int nnz;
};

#ifdef __cplusplus
extern "C" {
#endif

void gpu_init();
void gpu_cleanup();

bool gpu_allocate(GPUSolverData* data, int n, int nnz);
void gpu_free(GPUSolverData* data);

void gpu_copy_matrix(GPUSolverData* data, double* h_A, int* h_row_ptr, int* h_col_ind);
void gpu_copy_vectors(GPUSolverData* data, double* h_x, double* h_b);

void gpu_get_solution(GPUSolverData* data, double* h_x);

bool gpu_solve_cg(GPUSolverData* data, int max_iter, double tol, int print_iters,
                  double* final_residual, int* iterations);

#ifdef __cplusplus
}
#endif

#ifdef __CUDACC__
void gpu_spmv(int n, const double* A, const int* col_ind, const int* row_ptr,
              const double* x, double* y);

void gpu_vec_copy(int n, const double* src, double* dst);
void gpu_vec_scale(int n, double alpha, double* x);
void gpu_vec_axpy(int n, double alpha, const double* x, double* y);
double gpu_vec_dot(int n, const double* x, const double* y);
double gpu_vec_norm2(int n, const double* x);

__global__ void kernel_spmv(int n, const double* A, const int* col_ind, 
                            const int* row_ptr, const double* x, double* y);
__global__ void kernel_vec_copy(int n, const double* src, double* dst);
__global__ void kernel_vec_scale(int n, double alpha, double* x);
__global__ void kernel_vec_axpy(int n, double alpha, const double* x, double* y);
__global__ void kernel_vec_dot_partial(int n, const double* x, const double* y, double* partial);
__global__ void kernel_reduce_sum(double* partial, int n, double* result);
#endif

#endif
