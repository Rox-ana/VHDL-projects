SetActiveLib -work
comp -include "$dsn\src\connection.vhd" 
comp -include "$dsn\src\TestBench\connection_TB.vhd" 
asim +access +r TESTBENCH_FOR_connection 
wave 
wave -noreg clk
wave -noreg txin
wave -noreg rxout
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\connection_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_connection 
