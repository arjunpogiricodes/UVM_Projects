/************************************************************************
  
Copyright 2019 - Maven Silicon Softech Pvt Ltd.  
  
www.maven-silicon.com 
  
All Rights Reserved. 
This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd. 
It is not to be shared with or used by any third parties who have not enrolled for our paid 
training courses or received any written authorization from Maven Silicon.
  
Filename		:	ram_vtest_lib.sv

Description 	:	Test case for Dual Port RAM
  
Author Name		:   Putta Satish

Support e-mail	: 	For any queries, reach out to us on "techsupport_vm@maven-silicon.com" 

Version			:	1.0

************************************************************************/
//------------------------------------------
// CLASS DESCRIPTION
//------------------------------------------


// Extend ram_base_test from uvm_test;
class ram_base_test extends uvm_test;

   // Factory Registration
	
    `uvm_component_utils(ram_base_test) 
  
    // Declare the handles ram_tb, ram_env_config, ram_wr_agent_config and
    // ram_rd_agent_config as ram_envh, m_tb_cfg, m_wr_cfg & m_rd_cfg       	
   
          ram_tb  ram_envh;
          ram_env_config  m_tb_cfg;
          ram_wr_agent_config   m_wr_cfg;
          ram_rd_agent_config   m_rd_cfg;


    // Declare has_ragent=1 & has_wagent=1 as int data type
   
          int has_ragent = 1;
          int has_wagent = 1;


	//------------------------------------------
	// METHODS
	//------------------------------------------

	// Standard UVM Methods:
	extern function new(string name = "ram_base_test" , uvm_component parent);
	extern function void build_phase(uvm_phase phase);
    extern function void config_ram();
 endclass:ram_base_test

//-----------------  constructor new method  -------------------//
// Define Constructor new() function

function ram_base_test :: new (string name  = "ram_base_test",uvm_component parent);
         
          super.new(name,parent);

endfunction:new

//-----------------  config_ram() method  -------------------//

function void ram_base_test::config_ram();
    if (has_wagent)
		begin 
			//for write agent config
			// set is_active to UVM_ACTIVE 
                          uvm_config_db #(ram_wr_agent_config)::set(this,"*","ram_wr_agent_config",m_wr_cfg);
			
			// Get the virtual interface from the config database "vif"
			  if(!uvm_config_db #(virtual ram_if) :: get(this,"","vif",m_wr_cfg.vif))
                                `uvm_fatal("VIF CINFIG WR","cannot get() vif from top")

			//assign m_wr_cfg to m_tb_cfg.m_wr_cfg
                                m_tb_cfg.m_wr_cfg = m_wr_cfg;		

		end

    if(has_ragent) 
		begin
			//for read agent
			// set is_active to UVM_ACTIVE 
                             
                                   uvm_config_db #(ram_rd_agent_config)::set(this,"*","ram_rd_agent_config",m_rd_cfg);

			// Get the virtual interface from the config database "vif"
			
                              	  if(!uvm_config_db #(virtual ram_if) :: get(this,"","vif",m_rd_cfg.vif))
                                     `uvm_fatal("VIF CINFIG RD","cannot get() vif from top")

			//assign m_rd_cfg to m_tb_cfg.m_rd_cfg
                          
                                     m_tb_cfg.m_rd_cfg = m_rd_cfg; 
			
        end
		// assign local has_wagent & has_ragent variables to the variables in ram_env_config
                          m_tb_cfg.has_wagent = has_wagent;
                          m_tb_cfg.has_ragent = has_ragent;
                
		// set the m_tb_cfg object into UVM config DB "ram_env_config" 
                       uvm_config_db #(ram_env_config) :: set (this,"*","ram_env_config",m_tb_cfg);



endfunction
	

//-----------------  build() phase method  -------------------//
            
function void ram_base_test::build_phase(uvm_phase phase);
	// Create the instance for ram_env_config
                m_tb_cfg = ram_env_config :: type_id :: create("m_tb_cfg");

   
		// Create the instance for  ram_wr_agent_config 
		 if(has_wagent == 1)
                 m_wr_cfg = ram_wr_agent_config :: type_id :: create("m_wr_cfg");

    
		// Create the instance for  ram_rd_agent_config
	     if(has_ragent ==1 )
                m_rd_cfg = ram_rd_agent_config :: type_id :: create("m_rd_cfg");

	//call function config_ram()
                   config_ram();
 
    super.build_phase(phase);
	// create the instance for ram_tb
           ram_envh = ram_tb :: type_id :: create("ram_envh",this); 

endfunction


//------------------------------------------
// CLASS DESCRIPTION
//------------------------------------------

// Extend ram_single_addr_test from ram_base_test;
class ram_single_addr_test extends ram_base_test;

  
   // Factory Registration
	  
            `uvm_component_utils(ram_single_addr_test)

	// Declare the handle for  ram_single_vseq virtual sequence
            ram_single_vseq vseq;
	//------------------------------------------
	// METHODS
	//------------------------------------------

	// Standard UVM Methods:
 	extern function new(string name = "ram_single_addr_test" , uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
endclass

//-----------------  constructor new method  -------------------//

 // Define Constructor new() function
function ram_single_addr_test :: new(string name = "ram_single_addr_test" , uvm_component parent);
   
               super.new(name,parent);

endfunction:new


//-----------------  build() phase method  -------------------//
	  // In build phase call super.build_phase(phase);

function void ram_single_addr_test :: build_phase(uvm_phase phase);

       super.build_phase(phase);

endfunction:build_phase

//-----------------  run() phase method  -------------------//
task ram_single_addr_test::run_phase(uvm_phase phase);
	//raise objection
          phase.raise_objection(this);

	//create instance for sequence
         vseq =  ram_single_vseq :: type_id :: create ("vseq");        
	//start the sequence wrt virtual sequencer
         vseq.start(ram_envh.v_sequencer);
	//drop objection
         phase.drop_objection(this);

endtask   


//------------------------------------------
// CLASS DESCRIPTION
//------------------------------------------

// Extend ram_ten_addr_test from ram_base_test;
class ram_ten_addr_test extends ram_base_test;

  
   // Factory Registration
      
     `uvm_component_utils(ram_ten_addr_test)

   // Declare the handle for  ram_ten_vseq virtual sequence
     ram_ten_vseq vseq;
	//------------------------------------------
	// METHODS
	//------------------------------------------

	// Standard UVM Methods:
 	extern function new(string name = "ram_ten_addr_test" , uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
endclass

//-----------------  constructor new method  -------------------//

 // Define Constructor new() function

function ram_ten_addr_test :: new(string name = "ram_ten_addr_test" , uvm_component parent);
  
            super.new(name,parent); 

endfunction:new

//-----------------  build() phase method  -------------------//
            

   // In build phase call super.build_phase(phase);

function void ram_ten_addr_test :: build_phase(uvm_phase phase);

      super.build_phase(phase);

endfunction:build_phase

//-----------------  run() phase method  -------------------//
task ram_ten_addr_test::run_phase(uvm_phase phase);
	//raise objection
         phase.raise_objection(this);

     	//create instance for sequence
          vseq = ram_ten_vseq :: type_id :: create("vseq");

	//start the sequence wrt virtual sequencer
           vseq.start(ram_envh.v_sequencer);

	//drop objection

         phase.drop_objection(this);
   
endtask   


//------------------------------------------
// CLASS DESCRIPTION
//------------------------------------------

// Extend ram_odd_addr_test from ram_base_test;
class ram_odd_addr_test extends ram_base_test;

  
	// Factory Registration
	
        `uvm_component_utils(ram_odd_addr_test)

	// Declare the handle for  ram_odd_vseq virtual sequence
             
          ram_odd_vseq vseq;    
	//------------------------------------------
	// METHODS
	//------------------------------------------

	// Standard UVM Methods:
 	extern function new(string name = "ram_odd_addr_test" , uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
endclass

//-----------------  constructor new method  -------------------//

 // Define Constructor new() function

function ram_odd_addr_test :: new(string name = "ram_odd_addr_test" , uvm_component parent);

              super.new(name,parent);

endfunction:new


//-----------------  build() phase method  -------------------//
            
	  // In build phase call super.build_phase(phase);

function void ram_odd_addr_test :: build_phase(uvm_phase phase);

      super.build_phase(phase);

endfunction:build_phase


//-----------------  run() phase method  -------------------//
task ram_odd_addr_test::run_phase(uvm_phase phase);
	//raise objection
           phase.raise_objection(this);

	//create instance for sequence
           vseq =  ram_odd_vseq :: type_id :: create ("vseq");   
	//start the sequence wrt virtual sequencer
          vseq.start(ram_envh.v_sequencer);
	//drop objection
         phase.drop_objection(this);

endtask   


//------------------------------------------
// CLASS DESCRIPTION
//------------------------------------------

// Extend ram_even_addr_test from ram_base_test;
class ram_even_addr_test extends ram_base_test;

  
	// Factory Registration
	 
          `uvm_component_utils(ram_even_addr_test)

	// Declare the handle for  ram_even_vseq virtual sequence
            
             ram_even_vseq vseq;
  
	//------------------------------------------
	// METHODS
	//------------------------------------------

	// Standard UVM Methods:
 	extern function new(string name = "ram_even_addr_test" , uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
endclass

//-----------------  constructor new method  -------------------//

 // Define Constructor new() function

function ram_even_addr_test :: new(string name = "ram_even_addr_test" , uvm_component parent);

        super.new(name,parent);

endfunction:new

//-----------------  build() phase method  -------------------//
	  // In build phase call super.build_phase(phase);

function void ram_even_addr_test :: build_phase(uvm_phase phase);

          super.build_phase(phase);

endfunction:build_phase

//-----------------  run() phase method  -------------------//


task ram_even_addr_test::run_phase(uvm_phase phase);
	//raise objection
           phase.raise_objection(this);
    
	//create instance for sequence
           vseq = ram_even_vseq :: type_id :: create("vseq");       
	//start the sequence wrt virtual sequencer
            vseq.start(ram_envh.v_sequencer);

	//drop objection
            phase.drop_objection(this);  
         
endtask   

