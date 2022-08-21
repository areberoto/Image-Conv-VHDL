# FPGA Implementation of Image Convolution Filter

The image convolution operation is used in a variety of applications. Sometimes, these applications require real-time processing and using hardware accelerators can be a good way for achieving this. Hardware accelerators can be implemented on Graphics Processing Units (GPU’s) or Field Programmable Gate Arrays (FPGA’s).

In this project, a 2D Image Convolution Filter was implemented in an FPGA with the purpose of filtering 8-bit grayscale images. The convolution architecture design was based on a previous work presented as a thesis and can be found in [1]. The hardware description is done using VHDL and simulations where performed using ModelSim software. The results were satisfactorily obtained and evaluated by looking at the output images. No quantitative evaluation was performed, as it is not necessary for this project.

## Block Diagram of Convolution System
![1](https://user-images.githubusercontent.com/44409207/128091255-bbc69391-d4ee-4827-8b39-15383c54ad7a.png)

## Convolution Module
![2](https://user-images.githubusercontent.com/44409207/128092389-8a46cf55-e352-4784-893e-bb1f47153bcb.png)

## Filter convolution of three 8-bit grayscale images
![3](https://user-images.githubusercontent.com/44409207/128091186-450ba638-2437-412b-96fd-64067702992d.png)

[1] *Henrik Ström, ”A Parallel FPGA Implementation of Image Convolution” Department of Electrical Engineering, Linköping University, Sweden, 2016.*
