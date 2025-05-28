// stress_gpu.cu
#include <cuda_runtime.h>
#include <stdio.h>
#include <stdbool.h>

// Global flag - volatile ensures the compiler doesn't cache its value.
volatile bool g_running = true;

__global__ void matrixMul(float *A, float *B, float *C, int N) {
    int row = blockIdx.y * blockDim.y + threadIdx.y;
    int col = blockIdx.x * blockDim.x + threadIdx.x;
    if (row < N && col < N) {
        float sum = 0.0f;
        for (int k = 0; k < N; k++) {
            sum += A[row * N + k] * B[k * N + col];
        }
        C[row * N + col] = sum;
    }
}

extern "C" {

// Runs the stress test loop indefinitely.
// It allocates three matrices on host and device, and in a loop launches the multiplication kernel.
void stressCudaLoop(int N) {
    size_t size = N * N * sizeof(float);
    float *A, *B, *C;
    float *d_A, *d_B, *d_C;
    
    // Allocate host memory.
    cudaMallocHost(&A, size);
    cudaMallocHost(&B, size);
    cudaMallocHost(&C, size);
    
    // Allocate device memory.
    cudaMalloc(&d_A, size);
    cudaMalloc(&d_B, size);
    cudaMalloc(&d_C, size);

    // Initialize input matrices.
    for (int i = 0; i < N * N; i++) {
        A[i] = 1.0f;
        B[i] = 1.0f;
    }
    cudaMemcpy(d_A, A, size, cudaMemcpyHostToDevice);
    cudaMemcpy(d_B, B, size, cudaMemcpyHostToDevice);

    dim3 threadsPerBlock(16, 16);
    dim3 blocksPerGrid((N + 15) / 16, (N + 15) / 16);

    printf("Starting GPU stress test loop...\n");

    // Loop until a stop signal is received.
    while (g_running) {
        matrixMul<<<blocksPerGrid, threadsPerBlock>>>(d_A, d_B, d_C, N);
        cudaDeviceSynchronize();  // Ensure the kernel has finished before looping again.
    }

    // Optional: Copy back result once after exiting loop.
    cudaMemcpy(C, d_C, size, cudaMemcpyDeviceToHost);

    // Free allocated memory.
    cudaFreeHost(A);
    cudaFreeHost(B);
    cudaFreeHost(C);
    cudaFree(d_A);
    cudaFree(d_B);
    cudaFree(d_C);

    printf("GPU stress test loop ended.\n");
}

// Function to signal the CUDA loop to stop.
void stopStressCuda() {
    g_running = false;
}

} // extern "C"
