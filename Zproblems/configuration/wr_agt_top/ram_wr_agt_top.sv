/************************************************************************
  
Copyright 2019 - Maven Silicon Softech Pvt Ltd.  
  
www.maven-silicon.com 
  
All Rights Reserved. 
This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd. 
It is not to be shared with or used by any third parties who have not enrolled for our paid 
training courses or received any written authorization from Maven Silicon.
  
Filename		:  	ram_wr_agt_top.sv

Description 	: 	Write agent top class for Dual port RAM TB
  
Author Name		:   Shanthi V A

Support e-mail	: 	For any queries, reach out to us on "techsupport_vm@maven-silicon.com" 

Version			:	1.0

************************************************************************/
//------------------------------------------
// CLASS DESCRIPTION
//------------------------------------------

   // Extend ram_wr_agt_top from uvm_env;
	class ram_wr_agt_top extends uvm_env;

   // Factory Registration
	`uvm_component_utils(ram_wr_agt_top)
	// Declare a variable no_of_agents of int data type to get the configuration
	int no_of_agents=5;
    
   // Declare the dynamic array of agent handles
	ram_wr_agent agt_h[];
   
//------------------------------------------
// METHODS
//------------------------------------------

// Standard UVM Methods:
	extern function new(string name = "ram_wr_agt_top" , uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
  endclass
//-----------------  constructor new method  -------------------//
   // Define Constructor new() function
   	function ram_wr_agt_top::new(string name = "ram_wr_agt_top" , uvm_component parent);
		super.new(name,parent);
	endfunction

    
//-----------------  build() phase method  -------------------//
       	function void ram_wr_agt_top::build_phase(uvm_phase phase);
		//Get the configuration from the config_db "int"
		if(!uvm_config_db #(int)::get(this,"","PURNA",no_of_agents))
			begin
			`uvm_fatal("NO OF ARGUMENTS","getting failed, check the strings")
			end
		
     		super.build_phase(phase);
		// Give the size for the agnth array as equal to no_of_agents
		agt_h=new[no_of_agents];
	
       // Create the instance of ram_wr_agent within foreach loop
		foreach(agt_h[i])
			agt_h[i] = ram_wr_agent::type_id::create($sformatf("agt_h[%0d]",i),this);
		//set first two agents as active & third agent as passive in to config data base "bit"
		
		for(int i=0;i<5;i++)
		uvm_config_db#(bit)::set(this,$sformatf("agt_h[%0d]",i),"bit",1);
		
		uvm_config_db#(bit)::set(this,"agt_h[2]","bit",1);
		
	endfunction


//-----------------  run() phase method  -------------------//
       // Print the topology
	task ram_wr_agt_top::run_phase(uvm_phase phase);
		uvm_top.print_topology;
	endtask   
