/************************************************************************
  
Copyright 2019 - Maven Silicon Softech Pvt Ltd.  
  
www.maven-silicon.com 
  
All Rights Reserved. 
This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd. 
It is not to be shared with or used by any third parties who have not enrolled for our paid 
training courses or received any written authorization from Maven Silicon.
  
Filename		:  	ram_wr_agent.sv

Description 	: 	Write agent class for Dual port RAM TB
  
Author Name		:   Shanthi V A

Support e-mail	: 	For any queries, reach out to us on "techsupport_vm@maven-silicon.com" 

Version			:	1.0

************************************************************************/


//------------------------------------------
// CLASS DESCRIPTION
//------------------------------------------

// Extend ram_wr_agent from uvm_agent
class ram_wr_agent extends uvm_agent;

   // Factory Registration
	`uvm_component_utils(ram_wr_agent)

 
        
   // Declare handles of ram_wr_monitor,ram_wr_sequencer and ram_wr_driver
	ram_wr_monitor monh;
	ram_wr_sequencer seqrh;
	ram_wr_driver drvh;
	
	//Declare a variable is_active of bit data type to get the configuration
	bit is_active;
    
	//------------------------------------------
	// METHODS
	//------------------------------------------

	// Standard UVM Methods :
	extern function new(string name = "ram_wr_agent", uvm_component parent = null);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase phase);

endclass : ram_wr_agent
//-----------------  constructor new method  -------------------//

function ram_wr_agent::new(string name = "ram_wr_agent", 
                           uvm_component parent = null);
	super.new(name, parent);
endfunction
     
  
//-----------------  build() phase method  -------------------//


function void ram_wr_agent::build_phase(uvm_phase phase);
	// Call parent build phase
	super.build_phase(phase);
   // get the config object using uvm_config_db bit
	
	// Create ram_wr_monitor instance	
	
	// If config parameter is_active ==1 
	// Create instance of driver and sequencer
	if(!uvm_config_db #(bit)::get(this,"","bit",is_active))
		begin
		`uvm_fatal("IS ACTIVE","cannot get the tb_config from uvm_config")
		end
		monh=ram_wr_monitor::type_id::create("monh",this);
		if(is_active==UVM_ACTIVE)
			begin
				seqrh=ram_wr_sequencer::type_id::create("seqrh",this);
				drvh=ram_wr_driver::type_id::create("drvh",this);
			end
				
				
		
	
		
endfunction:build_phase

      
//-----------------  connect() phase method  -------------------//
//If config parameter is_active==1, 
//connect driver(TLM seq_item_port) and sequencer(TLM seq_item_export)

function void ram_wr_agent::connect_phase(uvm_phase phase);
		if(is_active==UVM_ACTIVE)
			begin
			drvh.seq_item_port.connect(seqrh.seq_item_export);
			end
endfunction:connect_phase
	
   

   


