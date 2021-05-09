module storage_manager(
       input clk,
       input [9:0]cnt,
       input [16:0]address_sig,
       output reg [11:0]rgb
    );
      wire [11:0] page0;
      wire [11:0] page1;
      wire [11:0] page2;
      wire [11:0] page3;
      wire [11:0] page4;
//      wire [11:0] page5;
//      wire [11:0] page6;
//      wire [11:0] page7;
//      wire [11:0] page8;
//      wire [11:0] page9;
//      wire [11:0] page10;
//      wire [11:0] page11;
//      wire [11:0] page12;
//      wire [11:0] page13;
//      wire signed[16:0]modi_address_sig;
      
//      assign modi_address_sig=address_sig;
      
      frontpage frontpage(.clka(clk),.addra(address_sig),.douta(page0));
//      endpage endpage(.clka(clk),.addra(modi_address_sig[16:0]),.douta(page13));
      pg1 pg1(.clka(clk),.addra(address_sig),.douta(page1));
      pg2 pg2(.clka(clk),.addra(address_sig),.douta(page2));
      pg3 pg3(.clka(clk),.addra(address_sig),.douta(page3));
      pg4 pg4(.clka(clk),.addra(address_sig),.douta(page4));
//      pg5 pg5(.clka(clk),.addra(modi_address_sig[16:0]),.douta(page5));
//      pg6 pg6(.clka(clk),.addra(modi_address_sig[16:0]),.douta(page6));
//      pg7 pg7(.clka(clk),.addra(modi_address_sig[16:0]),.douta(page7));
//      pg8 pg8(.clka(clk),.addra(modi_address_sig[16:0]),.douta(page8));
//      pg9 pg9(.clka(clk),.addra(modi_address_sig[16:0]),.douta(page9));
//      pg10 pg10(.clka(clk),.addra(modi_address_sig[16:0]),.douta(page10));
//      pg11 pg11(.clka(clk),.addra(modi_address_sig[16:0]),.douta(page11));
//      pg12 pg12(.clka(clk),.addra(modi_address_sig[16:0]),.douta(page12));
      
      always@(posedge clk)
      begin
        if(cnt==10'd0)
             rgb<=page0;
        else if(cnt==10'd1)
             rgb<=page1;
        else if(cnt==10'd2)
             rgb<=page2;
        else if(cnt==10'd3)
             rgb<=page3;
        else //if(cnt==27'd4)
             rgb<=page4;
//        else if(cnt==27'd5)
//             rgb<=page5;
//        else if(cnt==27'd6)
//             rgb<=page6;
//        else if(cnt==27'd7)
//             rgb<=page7;
//        else if(cnt==27'd8)
//             rgb<=page8;
//        else if(cnt==27'd9)
//             rgb<=page9;
//        else if(cnt==27'd10)
//             rgb<=page10;
//        else if(cnt==27'd11)
//             rgb<=page11;
//        else if(cnt==27'd12)
//             rgb<=page12;
//        else //if(cnt==27'd13)
//             rgb<=page13;
      end
endmodule