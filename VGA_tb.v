module vga_tb(  
                    input   wire            sys_clk,  
                    input   wire            sys_rst_n,  
                    output  wire            hsync,  
                    output  wire            vsync,  
                    output  wire   [11:0]   rgb
                );  
//ºì_ÂÌ_À¶  
  
                       
wire    [9:0]   pixel_x;  
wire    [9:0]   pixel_y;  
reg           clk_25mhz;  
reg           clk_50mhz; 
reg     [11:0]  rgb_reg;  
reg     [18:0]  address_sig;  
wire    [11:0]  q_sig;  
  
  always@(posedge(sys_clk))
            begin
                clk_50mhz <= ~clk_50mhz;
            end
            always@(posedge(clk_50mhz))
                begin
                    clk_25mhz <= ~clk_25mhz;
                end
                
//ÏÔÊ¾¾²Ì¬Í¼Ïñ320*240  
always @ (posedge clk_25mhz or negedge sys_rst_n)  
    if(!sys_rst_n)  
        begin  
            rgb_reg <= 12'b0;  
        end   
    else  
        begin               //ÏÔÊ¾Í¼Ïñ  
        //rgb_reg <= q_sig;            
       rgb_reg[11:0] <=q_sig[11:0];  
    end       
always @ (posedge clk_25mhz or negedge sys_rst_n)  
    if(!sys_rst_n)  
        begin  
            address_sig <= 19'b0;  
        end   
    else  
    begin                 
        if(pixel_x>=0 && pixel_x<= 639 && pixel_y>=0 && pixel_y<=479)  
        address_sig = (pixel_x/2 + pixel_y/2*320);
    end   
  
  
  
//////////////////////////////////////////////////////////////        
assign rgb = (video_en == 1'b1) ? rgb_reg:12'b0;  
  
vga_sync vga_uut(  
            .clk            (clk_25mhz),  
            .rst_n          (sys_rst_n),  
            .video_en       (video_en),  
            .hsync          (hsync),  
            .vsync          (vsync),  
            .pixel_x        (pixel_x),  
            .pixel_y        (pixel_y)                
        );  
  

 
blk_mem_gen_2 blk_mem_gen_2 (  
  .clka(clk_25mhz),    // input wire clka  
  .addra(address_sig),  // input wire [18 : 0] addra  
  .douta(q_sig)  // output wire [11 : 0] douta  
);  
                 
endmodule  