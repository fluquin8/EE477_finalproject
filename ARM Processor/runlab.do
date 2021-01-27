# Create work library
vlib work

# Compile Verilog
#     All Verilog files that are part of this design should have
#     their own "vlog" line below.
vlog "./mux2_1.sv"
vlog "./mux4_1.sv"
vlog "./mux8_1.sv"
vlog "./mux16_1.sv"
vlog "./mux32_1.sv"
vlog "./mux64x32_1.sv"
vlog "./decoder1_2.sv"
vlog "./decoder2_4.sv"
vlog "./decoder3_8.sv"
vlog "./decoder5_32.sv"
vlog "./D_FF.sv"
vlog "./register.sv"
vlog "./regfile.sv"
vlog "./fulladder.sv"
vlog "./alu_slice.sv"
vlog "./nor16_1.sv"
vlog "./fast_zero.sv"
vlog "./zero_check.sv"
vlog "./alu.sv"
vlog "./flag_register.sv"
vlog "./sign_extend.sv"
vlog "./zero_extend.sv"
vlog "./fulladder_64bit.sv"
vlog "./mux2_1_64bit.sv"
vlog "./mux2_1_5bit.sv"
vlog "./mux4_1_64bit.sv"
vlog "./mov_shifter.sv"
vlog "./pipe_register.sv"
vlog "./pc.sv"
vlog "./forwarding_unit.sv"
vlog "./instructmem.sv"
vlog "./datamem.sv"
vlog "./control_logic.sv"
vlog "./cpu.sv"
vlog "./cpustim.sv"

# Call vsim to invoke simulator
#     Make sure the last item on the line is the name of the
#     testbench module you want to execute.
vsim -voptargs="+acc" -t 1ps -lib work cpustim

# Source the wave do file
#     This should be the file that sets up the signal window for
#     the module you are testing.
do cpustim_wave.do

# Set the window types
view wave
view structure
view signals

# Run the simulation
run -all

# End
