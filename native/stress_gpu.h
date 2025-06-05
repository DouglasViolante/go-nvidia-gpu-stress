#ifndef STRESS_GPU_H
#define STRESS_GPU_H

#ifdef __cplusplus
extern "C" {
#endif

#ifdef _WIN32
#define EXPORT __declspec(dllexport)
#else
#define EXPORT
#endif

EXPORT void stressCudaLoop(int N);
EXPORT void stopStressCuda();

#ifdef __cplusplus
}
#endif

#endif // STRESS_GPU_H