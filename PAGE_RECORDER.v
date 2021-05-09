module page_recorder(
    input clk100mhz,
    input [9:0]page,
    input ena,
    output reg[6:0] seg_LED,
    output reg[7:0] seg_select
    );
   
	wire [3:0] num0;
    wire [3:0] num1;
    wire [3:0] num2;
	wire [3:0] num3;
//	wire [3:0] num4;
//	wire [3:0] num5;
//	wire [3:0] num6;
//	wire [3:0] num7;
    reg [2:0] cnt = 0;
    reg [17:0] clk_cnt = 0;
    reg pclk = 0;
	
	assign num0=page%10;
	assign num1=page/10%10;
	assign num2=page/100%10;
	assign num3=page/1000%10;
//    assign num4=page/10000%10;
//    assign num5=page/100000%10;
//    assign num6=page/1000000%10;
//    assign num7=page/10000000%10;
    
    always@(posedge clk100mhz)
        begin
                
            if(clk_cnt == 80000)
            begin
                pclk <= ~pclk;
                clk_cnt <= 0;
            end
            else
                clk_cnt <= clk_cnt + 1;
        end
   
    wire [6:0] out0;
    wire [6:0] out1;
    wire [6:0] out2;
    wire [6:0] out3;
    wire [6:0] out4;//E
    wire [6:0] out5;//g
    wire [6:0] out6;//A
    wire [6:0] out7;//p
    
    display7 seg0(.ena(ena),.iData(num0),.oData(out0));
	display7 seg1(.ena(ena),.iData(num1),.oData(out1));
	display7 seg2(.ena(ena),.iData(num2),.oData(out2));
	display7 seg3(.ena(ena),.iData(num3),.oData(out3));
	assign out4=(ena==0)?7'b1111111:7'b0000110;
    assign out5=(ena==0)?7'b1111111:7'b0010000;
    assign out6=(ena==0)?7'b1111111:7'b0001000;
    assign out7=(ena==0)?7'b1111111:7'b0001100;
//	display7 seg4(.ena(ena),.iData(num4),.oData(out4));
//	display7 seg5(.ena(ena),.iData(num5),.oData(out5));
//	display7 seg6(.ena(ena),.iData(num6),.oData(out6));
//	display7 seg7(.ena(ena),.iData(num7),.oData(out7));

    always@(posedge pclk)
    begin
            cnt <= cnt + 1;
            case(cnt)
            3'b000:
            begin
                seg_LED<= out0;
                seg_select <= 8'b11111110;
            end    
            3'b001:
            begin
                seg_LED<= out1;
                seg_select <= 8'b11111101;
            end
            3'b010:
            begin
                seg_LED<= out2;
                seg_select <= 8'b11111011;
            end
            3'b011:
            begin
                seg_LED <= out3;
                seg_select <= 8'b11110111;
            end
            3'b100:
            begin
                seg_LED <= out4;
                seg_select <= 8'b11101111;
            end
            3'b101:
            begin
                seg_LED <= out5;
                seg_select <= 8'b11011111;
            end
            3'b110:
            begin
                seg_LED <= out6;
                seg_select <= 8'b10111111;
            end
            3'b111:
            begin
                seg_LED <= out7;
                seg_select <= 8'b01111111;
                cnt<=0;
            end
            default:;
            endcase
    end
endmodule

