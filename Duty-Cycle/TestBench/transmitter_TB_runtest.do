SetActiveLib -work
comp -include "$dsn\src\transmitter.vhd" 
comp -include "$dsn\src\TestBench\transmitter_TB.vhd" 
asim +access +r TESTBENCH_FOR_transmitter 
wave 
wave -noreg clk
wave -noreg tdin
wave -noreg txin
wave -noreg txout
wave -noreg tdout
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\transmitter_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_transmitter 
