package main

/*
#cgo LDFLAGS: -L. -lcuda_stress
#include "stress_gpu.h"
*/
import "C"
import (
	"bufio"
	"fmt"
	"os"
	"time"
)

func main() {
    N := 25819 // Matrix dimension for the stress kernel (8GB).
    fmt.Println("GPU Stress to run indefinitely...")
    fmt.Println("Press Enter Key to stop the test.")

    // Run the CUDA loop in a separate goroutine.
    go func() {
        C.stressCudaLoop(C.int(N))
    }()

    // Wait for the user to press Enter.
    reader := bufio.NewReader(os.Stdin)
    _, err := reader.ReadString('\n')
    if err != nil {
        fmt.Println("Error Reading Input: ", err)
    }

    fmt.Println("Stopping GPU stress test...")
    C.stopStressCuda()

    // Time for the CUDA loop to complete cleanup.
    time.Sleep(1 * time.Second)
    fmt.Println("Stress Test Ended!")
}
