SetActiveLib -work
comp -include "$dsn\src\DPM.vhd" 
comp -include "$dsn\src\TestBench\dpm_TB.vhd" 
asim +access +r TESTBENCH_FOR_dpm 
wave 
wave -noreg clk
wave -noreg cs1
wave -noreg we1
wave -noreg cs2
wave -noreg we2
wave -noreg ad1
wave -noreg ad2
wave -noreg d1
wave -noreg d2
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\dpm_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_dpm 
