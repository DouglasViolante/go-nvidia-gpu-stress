Compile the CUDA file:

    nvcc -o stress_gpu.o -c stress_gpu.cu -Xcompiler -fPIC

Create a shared library:

    nvcc -shared -o libcuda_stress.so stress_gpu.o

Run the Go program:

    go run main.go


8GB     |   N = 25819
10GB    |   N = 28867
12GB    |   N = 31623
16GB    |   N = 36515
20GB    |   N = 40825
24GB    |   N = 44721