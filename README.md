# go-nvidia-gpu-stress

    Application to stress a Nvidia GPU with CUDA using GO and C++.  

## How To Run

- Compile the CUDA file:

    nvcc -o stress_gpu.obj -c stress_gpu.cu -Xcompiler -fPIC

- Create a shared library:

    nvcc -shared -o libstress_gpu.dll stress_gpu.obj -Xcompiler -fPIC

- Run the Go program:

    go run cmd/main.go

- Make sure the files libstress_gpu.dll/exp/lib and stress_gpu.obj were created at cmd/native!

### How to Run Outside the Visual Studio Code

    - Open CMD at the root of the project.

    - Paste so that Windows can find the DLL: 
        ```set PATH=%CD%\native;%PATH%```

    - Run:
        ```go run cmd/main.go```

## Memory Sizes

8GB     |   N = 25819
10GB    |   N = 28867
12GB    |   N = 31623
16GB    |   N = 36515
20GB    |   N = 40825
24GB    |   N = 44721