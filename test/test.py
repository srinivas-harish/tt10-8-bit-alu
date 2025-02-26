 
import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles

@cocotb.test()
async def test_project(dut):
    dut._log.info("Start")
 
    clock = Clock(dut.clk, 10, units="us")
    cocotb.start_soon(clock.start())

    # Reset
    dut._log.info("Reset")
    dut.ena.value = 1
    dut.ui_in.value = 0
    dut.uio_in.value = 0
    dut.rst_n.value = 0
    await ClockCycles(dut.clk, 10)
    dut.rst_n.value = 1

    dut._log.info("Test Bitwise Rotation Selector behavior")
 
    dut.ui_in.value = 0b10101010   
    dut.uio_in.value = 0b00000000  
    await ClockCycles(dut.clk, 1)
    assert dut.uo_out.value == 0b10101010, f"Expected 10101010, got {dut.uo_out.value}"
 
    dut.ui_in.value = 0b10101010   
    dut.uio_in.value = 0b00000001  
    await ClockCycles(dut.clk, 1)
    assert dut.uo_out.value == 0b01010101, f"Expected 01010101, got {dut.uo_out.value}"
 
    dut.ui_in.value = 0b10101010   
    dut.uio_in.value = 0b00000011  
    await ClockCycles(dut.clk, 1)
    assert dut.uo_out.value == 0b01010101, f"Expected 01010101, got {dut.uo_out.value}"
 
    dut.ui_in.value = 0b10101010   
    dut.uio_in.value = 0b00000111  
    await ClockCycles(dut.clk, 1)
    assert dut.uo_out.value == 0b11010101, f"Expected 11010101, got {dut.uo_out.value}"

    dut._log.info("All tests passed!")
