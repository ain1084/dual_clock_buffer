@echo off
iverilog ../dual_clock_buffer.v dual_clock_buffer_tb.v
if not errorlevel 1 (
	vvp a.out
	del a.out
)
