# dual_clock_buffer
Dual clock buffer for modules connected by valid and ready handshake.

![dual_clock_buffer](https://user-images.githubusercontent.com/14823909/105039643-23ff4380-5aa4-11eb-928f-e426cde9e4bb.png)

|Name|Direction|Clock doamin|Description|
|--|--|--|--|
|reset|input|i_clk, o_clk|Reset signal (Active low)|
|i_clk|input|i_clk|Intake clock|
|i_valid|input|i_clk|Intake valid|
|i_ready|output|i_clk|Intake ready|
|i_data[width-1:0]|input|i_clk|Intake data|
|o_clk|input|o_clk|Outtake clock|
|o_valid|output|o_clk|Outtake valid|
|o_ready|input|o_clk|Outtake ready|
|o_data[width-1:0]|output|o_clk|Outtake data|
