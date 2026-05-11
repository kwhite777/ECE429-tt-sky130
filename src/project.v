`default_nettype none

module tt_um_kaileywhite (
    input  wire [7:0] ui_in,
    output wire [7:0] uo_out,

    input  wire [7:0] uio_in,
    output wire [7:0] uio_out,
    output wire [7:0] uio_oe,

    input  wire       ena,
    input  wire       clk,
    input  wire       rst_n
);

    // Inputs
    wire [3:0] code;
    wire reset;
    wire mode;

    // Outputs from lock module
    wire unlock;
    wire alarm;
    wire tamper;

    // Assign inputs
    assign code  = ui_in[3:0];
    assign reset = ui_in[4];
    assign mode  = ui_in[5];

    // Instantiate lock module
    combo_lock lock_inst (
        .code(code),
        .reset(reset),
        .mode(mode),

        .unlock(unlock),
        .alarm(alarm),
        .tamper(tamper)
    );

    // Outputs
    assign uo_out[0] = unlock;
    assign uo_out[1] = alarm;
    assign uo_out[2] = tamper;

    assign uo_out[7:3] = 5'b00000;

    // Bidirectional pins unused
    assign uio_out = 8'b00000000;
    assign uio_oe  = 8'b00000000;

    // Prevent unused warnings
    wire _unused = &{ena, clk, rst_n, uio_in, 1'b0};

endmodule

