# SPDX-FileCopyrightText: © 2025 Tiny Tapeout
# SPDX-License-Identifier: Apache-2.0

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles

@cocotb.test()
async def test_project(dut):
    dut._log.info("Start")
 
    clock = Clock(dut.clk, 10, units="us")
    cocotb.start_soon(clock.start())
 
    dut._log.info("Reset")
    dut.ena.value = 1
    dut.ui_in.value = 0
    dut.uio_in.value = 0
    dut.rst_n.value = 0
    await ClockCycles(dut.clk, 10)
    dut.rst_n.value = 1

    dut._log.info("Test Bitwise Pattern Weaver behavior")
  
    dut.ui_in.value = 0b10101010   
    dut.uio_in.value = 0b11001100  
    await ClockCycles(dut.clk, 1)
    assert dut.uo_out.value == 0b10101010, f"Expected 10101010, got {bin(dut.uo_out.value)}"
 
    dut.ui_in.value = 0b10101010   
    dut.uio_in.value = 0b11001111  
    await ClockCycles(dut.clk, 1)
    assert dut.uo_out.value == 0b10101100, f"Expected 10101100, got {bin(dut.uo_out.value)}"
  
    dut.ui_in.value = 0b10101010  
    dut.uio_in.value = 0b11001100 
    await ClockCycles(dut.clk, 1)
    assert dut.uo_out.value == 0b11001100, f"Expected 11001100, got {bin(dut.uo_out.value)}"

    dut._log.info("All tests passed!")
