`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/19 14:23:01
// Design Name: 
// Module Name: centralcontroller
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Controller(
  input pgdown,//下一页
  input pgup,//上一页
  input clk,
  input ena,
  output [11:0]  rgb,
  output  hsync,  
  output  vsync,
  output [6:0] seg_LED,
  output [7:0] seg_select
    );
    
  reg [9:0]cnt=0;
  wire [18:0]address_sig;
//  wire [10:0]pixel_x;
//  wire [10:0]pixel_y;
  parameter [26:0]pagemax=4;
  wire [11:0]rgb_rom;
  wire [26:0]page_cnt;
  
  //为按键分频
  reg [22:0] clk_cnt = 0;
  reg sclk = 0;
  always@(posedge clk)
      begin   
          if(clk_cnt == 8000000)
          begin
              sclk <= ~sclk;
              clk_cnt <= 0;
          end
          else
              clk_cnt <= clk_cnt + 1;
      end
      
  always@(negedge sclk)
  begin
     if(pgup&&cnt>0&&ena)
        cnt<=cnt-1;
     else if(pgdown&&cnt<pagemax&&ena)
        cnt<=cnt+1;
     else ;
  end
//  always@(posedge pgup)
//  begin
//     if(cnt>0)
//        cnt<=cnt-1;
//  end
//   always@(posedge pgdown)
//   begin
//      if(cnt<pagemax)
//         cnt<=cnt+1;
//   end
  //显示页码
  assign page_cnt=cnt+1;
  page_recorder page_recorder(.clk100mhz(clk),.page(page_cnt),.ena(ena),.seg_LED(seg_LED),.seg_select(seg_select));

  //内存控制
  storage_manager storage_manager(.clk(clk),.cnt(cnt),.address_sig(address_sig), .rgb(rgb_rom));
         
  //显示器
  vga_control vga_control( .clk100mhz(clk),.qsig(rgb_rom), .sys_rst_n(ena),.HSync(hsync),.VSync(vsync),    
      .rgb(rgb),.address_sig(address_sig),.pixel_x(pixel_x),.pixel_y(pixel_y));
      
endmodule
