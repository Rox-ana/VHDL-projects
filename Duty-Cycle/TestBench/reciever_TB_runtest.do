SetActiveLib -work
comp -include "$dsn\src\reciever.vhd" 
comp -include "$dsn\src\TestBench\reciever_TB.vhd" 
asim +access +r TESTBENCH_FOR_reciever 
wave 
wave -noreg clk
wave -noreg xin
wave -noreg din
wave -noreg dout
wave -noreg xout
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\reciever_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_reciever 
