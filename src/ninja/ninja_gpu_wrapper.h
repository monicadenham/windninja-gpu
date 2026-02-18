/******************************************************************************
 *
 * WindNinja GPU Solver Wrapper - C++ Interface
 * Purpose:  C++ wrapper for GPU solver integration with existing WindNinja code
 *
 ******************************************************************************/

#ifndef NINJA_GPU_WRAPPER_H
#define NINJA_GPU_WRAPPER_H

struct GPUSolverData;

class NinjaGPUSolver
{
public:
    NinjaGPUSolver();
    ~NinjaGPUSolver();
    
    bool isAvailable() const;
    
    bool initialize(int n, int nnz);
    void cleanup();
    
    bool setMatrix(double* A, int* row_ptr, int* col_ind);
    bool setVectors(double* x, double* b);
    
    bool solve(int max_iter, double tol, int print_iters, 
               double* final_residual, int* iterations);
    
    void getSolution(double* x);
    
    static void initializeGPU();
    static void cleanupGPU();
    
private:
    GPUSolverData* gpu_data;
    bool initialized;
    int n_size;
};

#ifdef __cplusplus
extern "C" {
#endif

void* ninja_gpu_create();
void ninja_gpu_destroy(void* solver);
int ninja_gpu_is_available(void* solver);
int ninja_gpu_initialize(void* solver, int n, int nnz);
void ninja_gpu_cleanup(void* solver);
int ninja_gpu_set_matrix(void* solver, double* A, int* row_ptr, int* col_ind);
int ninja_gpu_set_vectors(void* solver, double* x, double* b);
int ninja_gpu_solve(void* solver, int max_iter, double tol, int print_iters,
                    double* final_residual, int* iterations);
void ninja_gpu_get_solution(void* solver, double* x);
void ninja_gpu_init_global();
void ninja_gpu_cleanup_global();

#ifdef __cplusplus
}
#endif

#endif
