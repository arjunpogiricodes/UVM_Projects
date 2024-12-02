






//destination driver class

class destin_driver extends uvm_driver #(uvm_sequence_item);

// factory registration

         `uvm_component_utils(destin_driver)

// declare the virtual interface handle

         destin_agent_config m_cfg;

         virtual router_destin_if.D_DRV vif; 

// funcion new constructor


       function new (string name = "destin_driver", uvm_component parent = null );

       
                super.new(name,parent);
                 
        endfunction
   
// build phase

         function void build_phase(uvm_phase phase);

                 super.build_phase(phase);  
                // `uvm_info(get_full_name(),"this is driver destin",UVM_NONE)
                 if(!uvm_config_db #(destin_agent_config) :: get(this,"","destin_agent_config",m_cfg))
                       `uvm_fatal(get_full_name(),"cannot get  the destin agetn config handle driver  m_cfg from desti agetn top")

         endfunction
// connect phase connect the virtual interface to local interface 

         function void connect_phase(uvm_phase phase);

                vif = m_cfg.vif;

         endfunction
		 
 
 // task run_phase here we send req and and then data req sended to new method for driving
  
          task run_phase(uvm_phase phase);
 
               phase.raise_objection(this);
                     super.run_phase(phase);
                     // #10; 
               phase.drop_objection(this);

          endtask


       

endclass
