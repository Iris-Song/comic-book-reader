`timescale 1ns / 1ps

module vga_control(
	input wire clk100mhz,
	input [11:0]qsig,
	input  sys_rst_n,    //WHEN 1, DISPLAY
	output HSync,     
	output VSync,    
    output [11:0] rgb,
	output wire[16:0]address_sig,
	output [10:0]pixel_x,
	output [10:0]pixel_y
    );
	
reg clk_25mhz;  
reg [11:0]  rgb_reg;  
reg [18:0]address_sig_19;
wire video_en;

assign address_sig=address_sig_19[16:0];
assign rgb = (video_en == 1'b1) ? rgb_reg:12'b0;


always @ (posedge clk_25mhz or negedge sys_rst_n)  
    if(!sys_rst_n)  
        begin  
            rgb_reg <= 12'b0;  
        end   
    else    
        rgb_reg[11:0] <= qsig[11:0];   
           
always @ (posedge clk_25mhz or negedge sys_rst_n)  
    if(!sys_rst_n)  
        begin  
            address_sig_19 <= 19'b0;  
        end   
    else  
    begin                 
        if(pixel_x>=0 && pixel_x<= 639 && pixel_y>=0 && pixel_y<=479)  
        address_sig_19 = (pixel_x/2 + pixel_y/2*320);  
    end  
    
    //·ÖÆµ 
    reg clk50mhz;
  always@(posedge(clk100mhz))
            begin
                clk50mhz <= ~clk50mhz;
            end
            always@(posedge(clk50mhz))
                begin
                    clk_25mhz <= ~clk_25mhz;
                end
  
  
//////////////////////////////////////////////////////////////        
 
  
vga vga_uut(  
            .clk            (clk_25mhz),  
            .rst_n          (sys_rst_n),  
            .video_en       (video_en),  
            .hsync          (HSync),  
            .vsync          (VSync), 
            .pixel_x        (pixel_x),  
            .pixel_y        (pixel_y)                
        );  
  
endmodule  
	
