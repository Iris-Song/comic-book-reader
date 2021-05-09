module vga(  
        input   wire            clk,  
        input   wire            rst_n,  
        output  wire            video_en,              //数据有效  
        output  reg             hsync,                 //场同步信号  
        output  reg             vsync,                //行同步信号  
        output  wire    [10:0]   pixel_x,               //待显示待像素的x坐标  
        output  wire    [10:0]   pixel_y                //待显示待像素的y坐标   
        );  
           
        reg     [10:0] x_cnt;  
        reg     [10:0] y_cnt;  
            
        reg             v_video_en;  //竖直有效
        reg             h_video_en;  //水平有效
        parameter PAL = 640;		//Pixels/Active Line (pixels)
        parameter LAF = 480;       //Lines/Active Frame (lines)
        parameter PLD = 800;       //Pixel/Line Divider
        parameter LFD = 525;       //Line/Frame Divider
       
        always @(posedge clk or negedge rst_n) 
        begin 
            if(!rst_n)  
                 x_cnt <= 10'b0;    
            else  
            begin  
                 if( x_cnt == PLD-1 ) //have reached the edge of one line
                 begin
                   x_cnt <= 0; //reset the horizontal counter
                 if( y_cnt == LFD-1 ) //only when horizontal pointer reach the edge can the vertical counter ++
                    y_cnt <=0;
                 else
                    y_cnt <= y_cnt + 1;
                 end
                 else
                    x_cnt <= x_cnt + 1;
                end  
          end        
                 
        always @(posedge clk or negedge rst_n)  
           if(!rst_n)  
           begin  
              h_video_en <= 1'b1;  
              hsync <= 1'b1;  
           end  
           else  
           begin  
             case (x_cnt)   
              10'd0:  
                h_video_en <= 1'b1;  
              PAL-1:  
                h_video_en <= 1'b0;   
              PAL+15:  
                hsync <= 1'b0;     
              PAL+111:  
                hsync <= 1'b1;  
             default:; 
                    endcase  
                end  
       
        always @(posedge clk or negedge rst_n)  
            if(!rst_n)  
            begin  
               v_video_en <= 1'b1;  
               vsync <= 1'b1;  
            end  
            else    
               case(y_cnt)  
                 10'd0:  
                       v_video_en <= 1'b1;  
                 LAF-1:  
                        v_video_en <= 1'b0;  
                 LAF+9:  
                        vsync <= 1'b0;   
                 LAF+11:   
                        vsync <= 1'b1;  
                 default:; 
                endcase  
              
        assign pixel_x = x_cnt;  
        assign pixel_y = y_cnt;  
            
    assign video_en = ((h_video_en == 1'b1) &&  (v_video_en == 1'b1)); //水平竖直都有效整体才有效  
          
endmodule  