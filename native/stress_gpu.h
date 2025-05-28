#ifndef STRESS_GPU_H
#define STRESS_GPU_H

#ifdef __cplusplus
extern "C" {
#endif

// Starts the GPU stress test loop.
// The function launches a CUDA kernel repeatedly on a square matrix of size N x N.
// The loop continues indefinitely until the stop function is called.
void stressCudaLoop(int N);

// Signals the GPU stress test loop to stop.
// The loop will exit gracefully after the current iteration completes.
void stopStressCuda();

#ifdef __cplusplus
}
#endif

#endif // STRESS_GPU_H