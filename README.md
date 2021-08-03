# FPGA Implementation of Image Convolution Filter

The image convolution operation is used in a variety of applications. Sometimes, these applications require real-time processing and using hardware accelerators can be a good way for achieving that. Hardware accelerators can be
implemented on Graphics Processing Units (GPU’s) or Field Programmable Gate Arrays (FPGA’s). In this project, a 2D Image Convolution Filter was implemented in a FPGA with the purpose of filtering 8-bit grayscale images. The convolution architecture design was based on a previous work presented as a thesis and can be found in [1].
The hardware description is done using VHDL and simulations where performed using ModelSim. The results were satisfactorily obtained and evaluated by looking at the output images. No quantitative evaluation was performed, as it is not necessary.

