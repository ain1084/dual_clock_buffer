`default_nettype none

module dual_clock_buffer #(parameter width = 8) (
    input wire reset,
    input wire i_clk,
    input wire i_valid,
    output wire i_ready,
    input wire [width-1:0] i_data,
    input wire o_clk,
    output wire o_valid,
    input wire o_ready,
    output wire [width-1:0] o_data);

    reg [width-1:0] data;
    assign o_data = data;

    reg out_flag_1;
    reg in_flag_2;
    reg in_flag_3;

    reg in_flag_1;
    reg out_flag_2;
    reg out_flag_3;

    assign i_ready = out_flag_1 == in_flag_3;
    assign o_valid = out_flag_3 != in_flag_1;

    always @(posedge i_clk or posedge reset) begin
        if (reset) begin
            { in_flag_3, in_flag_2, out_flag_1 } <= 3'b000;
            data <= 0;
        end else begin
            { in_flag_3, in_flag_2 } <= { in_flag_2, in_flag_1 };
            if (i_valid && i_ready)
                { out_flag_1, data } <= { ~out_flag_1, i_data };
        end
    end

    always @(posedge o_clk or posedge reset) begin
        if (reset)
            { out_flag_3, out_flag_2, in_flag_1 } <= 3'b000;
        else begin
            { out_flag_3, out_flag_2 } <= { out_flag_2, out_flag_1 };
            if (o_valid && o_ready)
                in_flag_1 <= ~in_flag_1;
        end
    end
endmodule
