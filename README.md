# dual_clock_buffer
Dual clock buffer for modules connected by valid and ready handshake.

![dual_clock_buffer](https://user-images.githubusercontent.com/14823909/106747448-4c23a080-6667-11eb-8c3c-2519fdb0dc1c.png)

|Name|Direction|Clock domain|Description|
|--|--|--|--|
|reset|input|i_clk, o_clk|Reset signal (Active low)|
|i_clk|input|i_clk|Intake clock|
|i_valid|input|i_clk|Intake valid|
|i_ready|output|i_clk|Intake ready|
|i_data[width-1:0]|input|i_clk|Intake data|
|o_clk|input|o_clk|Outlet clock|
|o_valid|output|o_clk|Outlet valid|
|o_ready|input|o_clk|Outlet ready|
|o_data[width-1:0]|output|o_clk|Outlet data|
