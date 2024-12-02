

// creatin interface 

interface ram_if(input bit clk);

     bit      reset,re,we;
     logic [8]data_in;
     bit   [4]r_add,w_add;
     logic [8]data_out;
     

 // clocking block for driver

     clocking ram_drv@(posedge clk);
          default input#1 output#1;

               output reset,re,we;
               output data_in;
               output r_add,w_add;

     endclocking

// clocking block for monior

     clocking ram_mon@(posedge clk);
           default input#1 output#1;

               input reset,re,we;
               input data_in;
               input r_add,w_add;
               input data_out;

     endclocking

// modports for mon drv of ram

      modport RAM_DRV(clocking ram_drv);
      modport RAM_MON(clocking ram_mon);

// dut modport

      modport DUV(input clk,reset,re,we,data_in,r_add,w_add,output data_out);

endinterface


// 16 x 8 dual PORT RAM INTERFACE

module dual_port_sync_16x8_ram(ram_if.DUV IF);

// declaring the input and output ports

  /* input clk,reset,re,we;
   input [8]data_in;
   input [4]r_add,w_add;
   output  logic[8]data_out;*/

   logic [8]mem[16]; 
   int i;
// using algorithem

  always@(posedge IF.clk)
     begin
       if(IF.reset)
          begin
            for(i=0;i<15;i=i+1)
                   begin
		          mem[i]<=8'b0000_0000;
	           end
	          //data_out<=0;   
            end
      	else
            begin
                    if(IF.we)
                            mem[IF.w_add]<=IF.data_in;
	            if(IF.re)
		           IF.data_out <=mem[IF.r_add];     
             end
       end
endmodule  


// TEST BENCH ENVIRONMENT





// TOP MODULE 
module top;

       bit clk = 1'b0;
       always #5 clk = ~clk;

       ram_if RAM_IF(clk);
       dual_port_sync_16x8_ram DUT(RAM_IF);

endmodule     
   
