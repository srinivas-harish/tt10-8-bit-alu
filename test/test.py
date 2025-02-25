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

    # Reset
    dut._log.info("Reset")
    dut.ena.value = 1
    dut.ui_in.value = 0
    dut.uio_in.value = 0
    dut.rst_n.value = 0
    await ClockCycles(dut.clk, 10)
    dut.rst_n.value = 1

    dut._log.info("Test priority encoder behavior")
 
    dut.ui_in.value = 0b00101010   # A[7:0]
    dut.uio_in.value = 0b11110001  # B[7:0]
    await ClockCycles(dut.clk, 1)
    assert dut.uo_out.value == 13, f"Expected 13, got {dut.uo_out.value}"

    # Test  
    dut.ui_in.value = 0b00000000
    dut.uio_in.value = 0b00000001
    await ClockCycles(dut.clk, 1)
    assert dut.uo_out.value == 0, f"Expected 0, got {dut.uo_out.value}"

    # Test  
    dut.ui_in.value = 0b00000000
    dut.uio_in.value = 0b00000000
    await ClockCycles(dut.clk, 1)
    assert dut.uo_out.value == 240, f"Expected 240, got {dut.uo_out.value}"

    dut._log.info("All tests passed!")
