
//Example snippet to understand pack & unpack methods.

import uvm_pkg::*;

`include "uvm_macros.svh"



class mem_seq_item extends uvm_sequence_item;
  //data and control fields
  rand bit [3:0] addr;
  rand bit       wr_en;
  rand bit       rd_en;
  rand bit [7:0] wdata;
       bit [7:0] rdata;
 
  //Utility and Field macros,
  `uvm_object_utils_begin(mem_seq_item)
    `uvm_field_int(addr,UVM_ALL_ON)
    `uvm_field_int(wr_en,UVM_ALL_ON)
    `uvm_field_int(rd_en,UVM_ALL_ON)
    `uvm_field_int(wdata,UVM_ALL_ON)
  `uvm_object_utils_end
 
  //Constructor
  function new(string name = "mem_seq_item");
    super.new(name);
  endfunction
 
  //constaint, to generate any one among write and read
  constraint wr_rd_c { wr_en != rd_en; };
 
endclass

//-------------------------------------------------------------------------
//Simple TestBench to access sequence item
//-------------------------------------------------------------------------
module seq_item_tb;
 
  //instance
  mem_seq_item seq_item_0;
  mem_seq_item seq_item_1;
  bit bit_packed_data[];
 
  initial begin
    //create method
    seq_item_0 = mem_seq_item::type_id::create("seq_item_0");
    seq_item_1 = mem_seq_item::type_id::create("seq_item_1");
   
    //---------------------- PACK  ------------------------------  
    seq_item_0.randomize(); //randomizing the seq_item_0
    seq_item_0.print();     //printing the seq_item_0
   
    seq_item_0.pack(bit_packed_data);    //pack method
    foreach(bit_packed_data[i])
      `uvm_info("PACK",$sformatf("bit_packed_data[%0d] = %b",i,bit_packed_data[i]), UVM_LOW)
     
    //---------------------- UNPACK ------------------------------
    `uvm_info("UNPACK","Before UnPack", UVM_LOW)
    seq_item_1.print();     //printing the seq_item_1
    seq_item_0.unpack(bit_packed_data);     //unpack method
    `uvm_info("UNPACK","After UnPack", UVM_LOW)
    seq_item_0.print();     //printing the seq_item_1

  end  
endmodule




/*

output:


-------------------------------------
Name        Type          Size  Value
-------------------------------------
seq_item_0  mem_seq_item  -     @456 
  addr      integral      4     'h9  
  wr_en     integral      1     'h1  
  rd_en     integral      1     'h0  
  wdata     integral      8     'h6c 
-------------------------------------
UVM_INFO ../tlm_ports_packed_unpacked.sv(55) @ 0: reporter [PACK] bit_packed_data[0] = 1
UVM_INFO ../tlm_ports_packed_unpacked.sv(55) @ 0: reporter [PACK] bit_packed_data[1] = 0
UVM_INFO ../tlm_ports_packed_unpacked.sv(55) @ 0: reporter [PACK] bit_packed_data[2] = 0
UVM_INFO ../tlm_ports_packed_unpacked.sv(55) @ 0: reporter [PACK] bit_packed_data[3] = 1
UVM_INFO ../tlm_ports_packed_unpacked.sv(55) @ 0: reporter [PACK] bit_packed_data[4] = 1
UVM_INFO ../tlm_ports_packed_unpacked.sv(55) @ 0: reporter [PACK] bit_packed_data[5] = 0
UVM_INFO ../tlm_ports_packed_unpacked.sv(55) @ 0: reporter [PACK] bit_packed_data[6] = 0
UVM_INFO ../tlm_ports_packed_unpacked.sv(55) @ 0: reporter [PACK] bit_packed_data[7] = 1
UVM_INFO ../tlm_ports_packed_unpacked.sv(55) @ 0: reporter [PACK] bit_packed_data[8] = 1
UVM_INFO ../tlm_ports_packed_unpacked.sv(55) @ 0: reporter [PACK] bit_packed_data[9] = 0
UVM_INFO ../tlm_ports_packed_unpacked.sv(55) @ 0: reporter [PACK] bit_packed_data[10] = 1
UVM_INFO ../tlm_ports_packed_unpacked.sv(55) @ 0: reporter [PACK] bit_packed_data[11] = 1
UVM_INFO ../tlm_ports_packed_unpacked.sv(55) @ 0: reporter [PACK] bit_packed_data[12] = 0
UVM_INFO ../tlm_ports_packed_unpacked.sv(55) @ 0: reporter [PACK] bit_packed_data[13] = 0
UVM_INFO ../tlm_ports_packed_unpacked.sv(58) @ 0: reporter [UNPACK] Before UnPack
-------------------------------------
Name        Type          Size  Value
-------------------------------------
seq_item_1  mem_seq_item  -     @460 
  addr      integral      4     'h0  
  wr_en     integral      1     'h0  
  rd_en     integral      1     'h0  
  wdata     integral      8     'h0  
-------------------------------------
UVM_INFO ../tlm_ports_packed_unpacked.sv(61) @ 0: reporter [UNPACK] After UnPack
-------------------------------------
Name        Type          Size  Value
-------------------------------------
seq_item_1  mem_seq_item  -     @460 
  addr      integral      4     'h9  
  wr_en     integral      1     'h1  
  rd_en     integral      1     'h0  
  wdata     integral      8     'h6c 
-------------------------------------
           V C S   S i m u l a t i o n   R e p o r t 


*/


///////////////////
//Example to understand TLM Methods.



import uvm_pkg::*;
`include "uvm_macros.svh"
class xtn extends uvm_sequence_item;

    function new(string name = "xtn");
        super.new(name);
    endfunction
    rand bit [3:0]addr;
    rand bit [5:0]data;

    `uvm_object_utils_begin(xtn)
        `uvm_field_int(addr,UVM_ALL_ON)
        `uvm_field_int(data,UVM_DEFAULT)
    `uvm_object_utils_end
endclass

class my_seqr extends uvm_component;
    uvm_put_port #(xtn)put_port;
    `uvm_component_utils(my_seqr)
   
    function new(string name = "my_seqr",uvm_component parent = null);
        super.new(name,parent);
        put_port = new("put_port",this);
    endfunction

    virtual task run_phase(uvm_phase phase);
        xtn xtn1;
        super.run_phase(phase);
        repeat(2) begin
            xtn1 = xtn::type_id::create("xtn1");
            assert(xtn1.randomize());
            `uvm_info(get_type_name(),"Packet Generated",UVM_LOW);
            xtn1.print();
            phase.raise_objection(this);
            `uvm_info(get_type_name(),$sformatf("###Can I put the packet in FIFO yes = %0d",put_port.can_put()),UVM_LOW)
            put_port.put(xtn1);
            `uvm_info(get_type_name(),$sformatf("$$$Can I put the packet in FIFO yes = %0d",put_port.can_put()),UVM_LOW)
            phase.drop_objection(this);
        end
    endtask
   
    virtual function void extract_phase(uvm_phase phase);
        super.extract_phase(phase);
        `uvm_info(get_type_name(),"Test Extract Phase",UVM_LOW)
    endfunction
endclass

class my_drv1 extends uvm_component;
    uvm_blocking_peek_port #(xtn)peek_port;
    `uvm_component_utils(my_drv1)

    function new(string name = "my_drv1",uvm_component parent = null);
        super.new(name,parent);
        peek_port = new("peek_port",this);
    endfunction

    task run_phase(uvm_phase phase);
        xtn xtn3;
        super.run_phase(phase);
        phase.raise_objection(this);
        repeat(2) begin
        xtn3 = xtn::type_id::create("xtn3",this);
        #5 peek_port.peek(xtn3);
        `uvm_info(get_type_name(),"Packet Peeked",UVM_LOW);
        xtn3.print();
        end
        phase.drop_objection(this);
    endtask
   
endclass

class my_drv2 extends uvm_component;
    uvm_get_port #(xtn)get_port;
    `uvm_component_utils(my_drv2)

    function new(string name = "my_drv2",uvm_component parent = null);
        super.new(name,parent);
        get_port = new("get_port",this);
    endfunction

    task run_phase(uvm_phase phase);
        xtn xtn3;
        super.run_phase(phase);
        phase.raise_objection(this);
        repeat(2) begin
        xtn3 = xtn::type_id::create("xtn3",this);
        #8 get_port.get(xtn3);
        `uvm_info(get_type_name(),"Packet Received",UVM_LOW);
        xtn3.print();
        `uvm_info(get_type_name(),$sformatf("Can I get the packet yes = %0d",get_port.can_get()),UVM_LOW)
        end
        phase.drop_objection(this);
    endtask
   
endclass



class my_test extends uvm_test;
    `uvm_component_utils(my_test)
    my_seqr seqr;
    my_drv1 drvh1;
    my_drv2 drvh2;
    uvm_tlm_fifo #(xtn)fifo1;

        function new(string name = "my_test",uvm_component parent = null);
            super.new(name,parent);
            seqr = my_seqr::type_id::create("seqr",this);
            drvh1 = my_drv1::type_id::create("drvh1",this);
            drvh2 = my_drv2::type_id::create("drvh2",this);
            fifo1 = new("fifo1",this,2);
        endfunction
        function void build_phase(uvm_phase phase);
            super.build_phase(phase);
        endfunction

        function void connect_phase(uvm_phase phase);
            super.connect_phase(phase);
            seqr.put_port.connect(fifo1.put_export);
            drvh1.peek_port.connect(fifo1.get_peek_export);
            drvh2.get_port.connect(fifo1.get_export);
        endfunction

        function void end_of_elaboration_phase(uvm_phase phase);
            super.end_of_elaboration_phase(phase);
            uvm_top.print_topology();
        endfunction


endclass

module top();
    initial
        run_test("my_test");
endmodule


/*

output:

UVM_INFO @ 0: reporter [RNTST] Running test my_test...
UVM_INFO @ 0: reporter [UVMTOP] UVM testbench topology:
--------------------------------------------------------
Name                 Type                    Size  Value
--------------------------------------------------------
uvm_test_top         my_test                 -     @456 
  drvh1              my_drv1                 -     @481 
    peek_port        uvm_blocking_peek_port  -     @489 
  drvh2              my_drv2                 -     @498 
    get_port         uvm_get_port            -     @506 
  fifo1              uvm_tlm_fifo #(T)       -     @515 
    get_ap           uvm_analysis_port       -     @550 
    get_peek_export  uvm_get_peek_imp        -     @532 
    put_ap           uvm_analysis_port       -     @541 
    put_export       uvm_put_imp             -     @523 
  seqr               my_seqr                 -     @464 
    put_port         uvm_put_port            -     @472 
--------------------------------------------------------

UVM_INFO ../tlm_ports_packed_unpacked.sv(161) @ 0: uvm_test_top.seqr [my_seqr] Packet Generated
-----------------------------
Name    Type      Size  Value
-----------------------------
xtn1    xtn       -     @567 
  addr  integral  4     'hc  
  data  integral  6     'h9  
-----------------------------
UVM_INFO ../tlm_ports_packed_unpacked.sv(164) @ 0: uvm_test_top.seqr [my_seqr] ###Can I put the packet in FIFO yes = 1
UVM_INFO ../tlm_ports_packed_unpacked.sv(166) @ 0: uvm_test_top.seqr [my_seqr] $$$Can I put the packet in FIFO yes = 1
UVM_INFO ../tlm_ports_packed_unpacked.sv(161) @ 0: uvm_test_top.seqr [my_seqr] Packet Generated
-----------------------------
Name    Type      Size  Value
-----------------------------
xtn1    xtn       -     @571 
  addr  integral  4     'h0  
  data  integral  6     'h22 
-----------------------------
UVM_INFO ../tlm_ports_packed_unpacked.sv(164) @ 0: uvm_test_top.seqr [my_seqr] ###Can I put the packet in FIFO yes = 1
UVM_INFO ../tlm_ports_packed_unpacked.sv(166) @ 0: uvm_test_top.seqr [my_seqr] $$$Can I put the packet in FIFO yes = 0
UVM_INFO ../tlm_ports_packed_unpacked.sv(193) @ 5: uvm_test_top.drvh1 [my_drv1] Packet Peeked
-----------------------------
Name    Type      Size  Value
-----------------------------
xtn1    xtn       -     @567 
  addr  integral  4     'hc  
  data  integral  6     'h9  
-----------------------------
UVM_INFO ../tlm_ports_packed_unpacked.sv(217) @ 8: uvm_test_top.drvh2 [my_drv2] Packet Received
-----------------------------
Name    Type      Size  Value
-----------------------------
xtn1    xtn       -     @567 
  addr  integral  4     'hc  
  data  integral  6     'h9  
-----------------------------
UVM_INFO ../tlm_ports_packed_unpacked.sv(219) @ 8: uvm_test_top.drvh2 [my_drv2] Can I get the packet yes = 1
UVM_INFO ../tlm_ports_packed_unpacked.sv(193) @ 10: uvm_test_top.drvh1 [my_drv1] Packet Peeked
-----------------------------
Name    Type      Size  Value
-----------------------------
xtn1    xtn       -     @571 
  addr  integral  4     'h0  
  data  integral  6     'h22 
-----------------------------
UVM_INFO ../tlm_ports_packed_unpacked.sv(217) @ 16: uvm_test_top.drvh2 [my_drv2] Packet Received
-----------------------------
Name    Type      Size  Value
-----------------------------
xtn1    xtn       -     @571 
  addr  integral  4     'h0  
  data  integral  6     'h22 
-----------------------------
UVM_INFO ../tlm_ports_packed_unpacked.sv(219) @ 16: uvm_test_top.drvh2 [my_drv2] Can I get the packet yes = 0
UVM_INFO /home/cad/eda/SYNOPSYS/VCS/vcs/T-2022.06-SP1/etc/uvm/base/uvm_objection.svh(1274) @ 16: reporter [TEST_DONE] 'run' phase is ready to proceed to the 'extract' phase
UVM_INFO ../tlm_ports_packed_unpacked.sv(173) @ 16: uvm_test_top.seqr [my_seqr] Test Extract Phase

--- UVM Report Summary ---

** Report counts by severity
UVM_INFO :   16
UVM_WARNING :    0
UVM_ERROR :    0
UVM_FATAL :    0
** Report counts by id
[RNTST]     1
[TEST_DONE]     1
[UVMTOP]     1
[my_drv1]     2
[my_drv2]     4
[my_seqr]     7
$finish called from file "/home/cad/eda/SYNOPSYS/VCS/vcs/T-2022.06-SP1/etc/uvm/base/uvm_root.svh", line 437.
$finish at simulation time                   16
           V C S   S i m u l a t i o n   R e p o r t 

*/

