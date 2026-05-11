# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: Apache-2.0

import cocotb
from cocotb.triggers import Timer


@cocotb.test()
async def test_combination_lock(dut):

    dut.ena.value = 1
    dut.uio_in.value = 0

    #
    # TEST 1
    # Correct code in mode 0
    #
    # code = 1011
    # reset = 0
    # mode = 0
    #
    dut.ui_in.value = 0b00001011

    await Timer(1, unit="ns")

    assert dut.uo_out.value[0] == 1, "UNLOCK should be HIGH"
    assert dut.uo_out.value[1] == 0, "ALARM should be LOW"
    assert dut.uo_out.value[2] == 0, "TAMPER should be LOW"

    #
    # TEST 2
    # Wrong code
    #
    dut.ui_in.value = 0b00000011

    await Timer(1, unit="ns")

    assert dut.uo_out.value[0] == 0, "UNLOCK should be LOW"
    assert dut.uo_out.value[1] == 1, "ALARM should be HIGH"
    assert dut.uo_out.value[2] == 0, "TAMPER should be LOW"

    #
    # TEST 3
    # Tamper detection
    #
    dut.ui_in.value = 0b00001111

    await Timer(1, unit="ns")

    assert dut.uo_out.value[0] == 0, "UNLOCK should be LOW"
    assert dut.uo_out.value[1] == 1, "ALARM should be HIGH"
    assert dut.uo_out.value[2] == 1, "TAMPER should be HIGH"

    #
    # TEST 4
    # Reset active
    #
    dut.ui_in.value = 0b00010000

    await Timer(1, unit="ns")

    assert dut.uo_out.value == 0, "All outputs should reset"

    #
    # TEST 5
    # Mode 1 correct code
    #
    # mode = 1
    # code = 0101
    #
    dut.ui_in.value = 0b00100101

    await Timer(1, unit="ns")

    assert dut.uo_out.value[0] == 1, "UNLOCK should be HIGH in mode 1"
    assert dut.uo_out.value[1] == 0, "ALARM should be LOW"
    assert dut.uo_out.value[2] == 0, "TAMPER should be LOW"
