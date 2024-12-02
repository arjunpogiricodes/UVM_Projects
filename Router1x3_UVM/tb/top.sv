



// Top module 

module top();

// including the  uvm file  

       import uvm_pkg :: *;
      // include "uvm_macros.svh"
 
// importing  the tb files 

       import router_pkg :: *; 

      
// generating clock
  
       bit clk = 1'b0;
       always #5 clk = ~clk;          
      
// instantiating interace

        router_source_if VIF(clk);
        router_destin_if VIF0(clk);
        router_destin_if VIF1(clk);
        router_destin_if VIF2(clk);



// instantiating DUT
// top module
//module router_top(clk,reset,read_enb_0,read_enb_1,read_enb_2,data_in,pkt_valid,data_out_0,data_out_1,data_out_2,valid_out_0,valid_out_1,valid_out_2,error,busy);


     router_top DUT(
                    .clk(clk),
                    .reset(VIF.reset),
                    .read_enb_0(VIF0.read_enb),
                    .read_enb_1(VIF1.read_enb),
                    .read_enb_2(VIF2.read_enb),
                    .data_in(VIF.data_in),
                    .pkt_valid(VIF.pkt_valid),
                    .data_out_0(VIF0.data_out),
                    .data_out_1(VIF1.data_out),
                    .data_out_2(VIF2.data_out),
                    .valid_out_0(VIF0.valid_out),
                    .valid_out_1(VIF1.valid_out),
                    .valid_out_2(VIF2.valid_out),
                    .error(VIF.error),
                    .busy(VIF.busy)

                     );


        initial begin
// setting the virtual interface  for source agent and 3 destination agents	
                 uvm_config_db #(virtual router_source_if) :: set(null,"*","vif",VIF);
                 uvm_config_db #(virtual router_destin_if) :: set(null,"*","vif0",VIF0);
                 uvm_config_db #(virtual router_destin_if) :: set(null,"*","vif1",VIF1);
                 uvm_config_db #(virtual router_destin_if) :: set(null,"*","vif2",VIF2);
// calling the runtest()

                  run_test();
            end    


endmodule
