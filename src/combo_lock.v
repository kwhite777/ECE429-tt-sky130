

module combo_lock (
    input  wire [3:0] code,
    input  wire reset,
    input  wire mode,

    output reg unlock,
    output reg alarm,
    output reg tamper
);

always @(*) begin

    // Default outputs
    unlock = 0;
    alarm  = 0;
    tamper = 0;

    // Reset clears everything
    if (reset) begin
        unlock = 0;
        alarm  = 0;
        tamper = 0;
    end

    else begin

        // MODE 0
        if (mode == 0) begin

            // Correct code
            if (code == 4'b1011)
                unlock = 1;

            // Tamper code
            else if (code == 4'b1111) begin
                tamper = 1;
                alarm = 1;
            end

            // Wrong code
            else
                alarm = 1;
        end

        // MODE 1
        else begin

            // Alternate correct code
            if (code == 4'b0101)
                unlock = 1;

            // Tamper code
            else if (code == 4'b1111) begin
                tamper = 1;
                alarm = 1;
            end

            // Wrong code
            else
                alarm = 1;
        end
    end
end

endmodule

