module regfile(clk, write, wrAddr, wrData, rdAddrA, rdDataA, rdAddrB, rdDataB, led_test/*test led*/);
	input clk;
	input write;
	input [4:0] wrAddr;
	input [31:0] wrData;
	input [4:0] rdAddrA;
	output reg[31:0] rdDataA;
	input [4:0] rdAddrB;
	output reg[31:0] rdDataB;
	output reg[31:0] led_test; //test led
	
	reg[31:0] regfile[31:0];
	
	generate
        genvar i;
        for (i = 0; i < 32; i = i+1) begin
            initial
                regfile[i] <= 0;
        end
    endgenerate
	
	always @(posedge clk) begin
		if(write==1'b1 && wrAddr!=5'b0) begin
			regfile[wrAddr] <= wrData;
		end
		rdDataA <= regfile[rdAddrA];
		rdDataB <= regfile[rdAddrB];
		led_test <= regfile[5'd15];
	end
	
	/*
	//Block RAM interface
	wire[15:0] rdDataA_MSW;
	wire[15:0] rdDataA_LSW;
	
	wire[15:0] rdDataB_MSW;
	wire[15:0] rdDataB_LSW;
	
	wire[15:0] ledVal_MSW;
	wire[15:0] ledVal_LSW;
	
	wire RAM_write;
	
	wire[7:0] led_read_addr;
	assign led_read_addr = 8'd15;
	assign RAM_write = (wrAddr == 32'b0) ? 1'b0 : write;
	
	//data A block MSW
	SB_RAM40_4K dataA_MSW (
		.RDATA(rdDataA_MSW),
		.RADDR({3'b0, rdAddrA}),
		.RCLK(clk),
		.RCLKE(1'b1),
		.RE(1'b1),
		.WADDR({3'b0, wrAddr}),
		.WCLK(clk),
		.WCLKE(1'b1),
		.WDATA(wrData[31:16]),
		.WE(RAM_write),
		.MASK(16'b0)
	);
	defparam dataA_MSW.READ_MODE=0;
	defparam dataA_MSW.WRITE_MODE=0;
	
	//data A block LSW
	SB_RAM40_4K dataA_LSW (
		.RDATA(rdDataA_LSW),
		.RADDR({3'b0, rdAddrA}),
		.RCLK(clk),
		.RCLKE(1'b1),
		.RE(1'b1),
		.WADDR({3'b0, wrAddr}),
		.WCLK(clk),
		.WCLKE(1'b1),
		.WDATA(wrData[15:0]),
		.WE(RAM_write),
		.MASK(16'b0)
	);
	defparam dataA_LSW.READ_MODE=0;
	defparam dataA_LSW.WRITE_MODE=0;
	
	
	//data B block MSW
	SB_RAM40_4K dataB_MSW (
		.RDATA(rdDataB_MSW),
		.RADDR({3'b0, rdAddrB}),
		.RCLK(clk),
		.RCLKE(1'b1),
		.RE(1'b1),
		.WADDR({3'b0, wrAddr}),
		.WCLK(clk),
		.WCLKE(1'b1),
		.WDATA(wrData[31:16]),
		.WE(RAM_write),
		.MASK(16'b0)
	);
	defparam dataB_MSW.READ_MODE=0;
	defparam dataB_MSW.WRITE_MODE=0;
	
	//data B block LSW
	SB_RAM40_4K dataB_LSW (
		.RDATA(rdDataB_LSW),
		.RADDR({3'b0, rdAddrB}),
		.RCLK(clk),
		.RCLKE(1'b1),
		.RE(1'b1),
		.WADDR({3'b0, wrAddr}),
		.WCLK(clk),
		.WCLKE(1'b1),
		.WDATA(wrData[15:0]),
		.WE(RAM_write),
		.MASK(16'b0)
	);
	defparam dataB_LSW.READ_MODE=0;
	defparam dataB_LSW.WRITE_MODE=0;
	
	
	
	//ledVal block MSW
	SB_RAM40_4K ledVal_MSW_inst (
		.RDATA(ledVal_MSW),
		.RADDR(led_read_addr),
		.RCLK(clk),
		.RCLKE(1'b1),
		.RE(1'b1),
		.WADDR({3'b0, wrAddr}),
		.WCLK(clk),
		.WCLKE(1'b1),
		.WDATA(wrData[31:16]),
		.WE(RAM_write),
		.MASK(16'b0)
	);
	defparam ledVal_MSW_inst.READ_MODE=0;
	defparam ledVal_MSW_inst.WRITE_MODE=0;
	
	//ledVal block LSW
	SB_RAM40_4K ledVal_LSW_inst (
		.RDATA(ledVal_LSW),
		.RADDR(led_read_addr),
		.RCLK(clk),
		.RCLKE(1'b1),
		.RE(1'b1),
		.WADDR({3'b0, wrAddr}),
		.WCLK(clk),
		.WCLKE(1'b1),
		.WDATA(wrData[15:0]),
		.WE(RAM_write),
		.MASK(16'b0)
	);
	defparam ledVal_LSW_inst.READ_MODE=0;
	defparam ledVal_LSW_inst.WRITE_MODE=0;
	
	//signal assignments
	assign rdDataA = {rdDataA_MSW, rdDataA_LSW};
	assign rdDataB = {rdDataB_MSW, rdDataB_LSW};
	assign led_test = {ledVal_MSW, ledVal_LSW};//test led
	*/
	
endmodule
