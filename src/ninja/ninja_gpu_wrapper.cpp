/******************************************************************************
 *
 * WindNinja GPU Solver Wrapper - C++ Implementation
 * Purpose:  C++ wrapper for GPU solver integration with existing WindNinja code
 *
 ******************************************************************************/

#include "ninja_gpu_wrapper.h"

#ifdef NINJA_CUDA_ENABLED
#include "ninja_gpu.cuh"
#endif

NinjaGPUSolver::NinjaGPUSolver() 
    : gpu_data(nullptr), initialized(false), n_size(0)
{
#ifdef NINJA_CUDA_ENABLED
    gpu_data = new GPUSolverData();
    gpu_data->d_A = nullptr;
    gpu_data->d_row_ptr = nullptr;
    gpu_data->d_col_ind = nullptr;
    gpu_data->d_x = nullptr;
    gpu_data->d_b = nullptr;
    gpu_data->d_r = nullptr;
    gpu_data->d_z = nullptr;
    gpu_data->d_p = nullptr;
    gpu_data->d_q = nullptr;
    gpu_data->d_diag = nullptr;
    gpu_data->n = 0;
    gpu_data->nnz = 0;
#endif
}

NinjaGPUSolver::~NinjaGPUSolver()
{
    cleanup();
#ifdef NINJA_CUDA_ENABLED
    if (gpu_data) {
        delete gpu_data;
        gpu_data = nullptr;
    }
#endif
}

bool NinjaGPUSolver::isAvailable() const
{
#ifdef NINJA_CUDA_ENABLED
    return gpu_data != nullptr;
#else
    return false;
#endif
}

bool NinjaGPUSolver::initialize(int n, int nnz)
{
#ifdef NINJA_CUDA_ENABLED
    if (initialized) {
        cleanup();
    }
    
    n_size = n;
    
    if (gpu_data && gpu_allocate(gpu_data, n, nnz)) {
        initialized = true;
        return true;
    }
#endif
    return false;
}

void NinjaGPUSolver::cleanup()
{
#ifdef NINJA_CUDA_ENABLED
    if (initialized && gpu_data) {
        gpu_free(gpu_data);
        initialized = false;
    }
#endif
}

bool NinjaGPUSolver::setMatrix(double* A, int* row_ptr, int* col_ind)
{
#ifdef NINJA_CUDA_ENABLED
    if (initialized && gpu_data) {
        gpu_copy_matrix(gpu_data, A, row_ptr, col_ind);
        return true;
    }
#endif
    return false;
}

bool NinjaGPUSolver::setVectors(double* x, double* b)
{
#ifdef NINJA_CUDA_ENABLED
    if (initialized && gpu_data) {
        gpu_copy_vectors(gpu_data, x, b);
        return true;
    }
#endif
    return false;
}

bool NinjaGPUSolver::solve(int max_iter, double tol, int print_iters,
                           double* final_residual, int* iterations)
{
#ifdef NINJA_CUDA_ENABLED
    if (initialized && gpu_data) {
        return gpu_solve_cg(gpu_data, max_iter, tol, print_iters,
                           final_residual, iterations);
    }
#endif
    return false;
}

void NinjaGPUSolver::getSolution(double* x)
{
#ifdef NINJA_CUDA_ENABLED
    if (initialized && gpu_data) {
        gpu_get_solution(gpu_data, x);
    }
#endif
}

void NinjaGPUSolver::initializeGPU()
{
#ifdef NINJA_CUDA_ENABLED
    gpu_init();
#endif
}

void NinjaGPUSolver::cleanupGPU()
{
#ifdef NINJA_CUDA_ENABLED
    gpu_cleanup();
#endif
}

extern "C" {

void* ninja_gpu_create()
{
    return new NinjaGPUSolver();
}

void ninja_gpu_destroy(void* solver)
{
    delete static_cast<NinjaGPUSolver*>(solver);
}

int ninja_gpu_is_available(void* solver)
{
    NinjaGPUSolver* s = static_cast<NinjaGPUSolver*>(solver);
    return s->isAvailable() ? 1 : 0;
}

int ninja_gpu_initialize(void* solver, int n, int nnz)
{
    NinjaGPUSolver* s = static_cast<NinjaGPUSolver*>(solver);
    return s->initialize(n, nnz) ? 1 : 0;
}

void ninja_gpu_cleanup(void* solver)
{
    NinjaGPUSolver* s = static_cast<NinjaGPUSolver*>(solver);
    s->cleanup();
}

int ninja_gpu_set_matrix(void* solver, double* A, int* row_ptr, int* col_ind)
{
    NinjaGPUSolver* s = static_cast<NinjaGPUSolver*>(solver);
    return s->setMatrix(A, row_ptr, col_ind) ? 1 : 0;
}

int ninja_gpu_set_vectors(void* solver, double* x, double* b)
{
    NinjaGPUSolver* s = static_cast<NinjaGPUSolver*>(solver);
    return s->setVectors(x, b) ? 1 : 0;
}

int ninja_gpu_solve(void* solver, int max_iter, double tol, int print_iters,
                    double* final_residual, int* iterations)
{
    NinjaGPUSolver* s = static_cast<NinjaGPUSolver*>(solver);
    return s->solve(max_iter, tol, print_iters, final_residual, iterations) ? 1 : 0;
}

void ninja_gpu_get_solution(void* solver, double* x)
{
    NinjaGPUSolver* s = static_cast<NinjaGPUSolver*>(solver);
    s->getSolution(x);
}

void ninja_gpu_init_global()
{
    NinjaGPUSolver::initializeGPU();
}

void ninja_gpu_cleanup_global()
{
    NinjaGPUSolver::cleanupGPU();
}

}
