`timescale 1ns/1ns
`default_nettype none

module dual_clock_buffer_tb();

    parameter IN_STEP =  200;
    parameter OUT_STEP =  50;

    initial begin
        $dumpfile("dual_clock_buffer_tb.vcd");
        $dumpvars;
    end

    reg o_clk;
    initial begin
        o_clk = 1'b0;
        forever #(OUT_STEP / 2) o_clk = ~o_clk;
    end

    reg i_clk;
    initial begin
        i_clk = 1'b0;
        forever #(IN_STEP / 2) i_clk = ~i_clk;
    end

    reg reset;
    reg i_valid;
    wire i_ready;
    reg [7:0] i_data;
    wire o_valid;
    reg o_ready;
    wire [7:0] o_data;
    reg [7:0] readed_data;

    dual_clock_buffer dual_clock_buffer_(
        .reset(reset),
        .i_clk(i_clk),
        .i_valid(i_valid),
        .i_ready(i_ready),
        .i_data(i_data),
        .o_clk(o_clk),
        .o_valid(o_valid),
        .o_ready(o_ready),
        .o_data(o_data)
    );

    initial begin
        reset = 1'b0;
        i_valid = 1'b0;
        i_data = 0;
        o_ready = 0;

        repeat (2) @(posedge i_clk) reset = 1'b1;
        repeat (2) @(posedge i_clk) reset = 1'b0;

        i_valid = 1'b1;

        i_data = 8'h12;
        $write("write_data: %02h\n", i_data);
        wait (i_ready) @(posedge i_clk);
        @(posedge i_clk);

        i_data = 8'h55;
        $write("write_data: %02h\n", i_data);
        wait (i_ready) @(posedge i_clk);
        @(posedge i_clk);

        i_data = 8'h88;
        $write("write_data: %02h\n", i_data);
        wait (i_ready) @(posedge i_clk);
        @(posedge i_clk);

        i_data = 8'hdd;
        $write("write_data: %02h\n", i_data);
        wait (i_ready) @(posedge i_clk);
        @(posedge i_clk);
        i_valid = 1'b0;
    end

    integer i;

    initial begin
        repeat (4) @(posedge i_clk);

        o_ready = 1'b1;
        @(posedge o_clk);
        for (i = 0; i < 4; ++i) begin
            wait (o_valid) @(posedge o_clk);
            $write("read_data: %02h\n", o_data);
            @(posedge o_clk);
        end

        repeat (30) @(posedge o_clk);

        $finish;
    end


endmodule
