



// destination monitor class

class destin_monitor extends uvm_monitor;

// factory registration

        `uvm_component_utils(destin_monitor)

// declare virtual interface handle

            destin_agent_config m_cfg;
            virtual router_destin_if.D_MON vif; 

// function new constructor 


        function new(string name = "destin_monitor" , uvm_component parent = null );

                     super.new(name,parent);
					 
         endfunction 

// build phase
         function void build_phase(uvm_phase phase);

                 super.build_phase(phase);  
                // `uvm_info(get_full_name(),"this is monitor destin",UVM_NONE)
                  if(!uvm_config_db #(destin_agent_config) :: get(this,"","destin_agent_config",m_cfg))
                       `uvm_fatal(get_full_name(),"cannot get  the destin agetn config handle monitor m_cfg from desti agetn top")

         endfunction
		 
// connect_phase connecting the virtual interfcce to local interface handle

         function void connect_phase(uvm_phase phase);
       
                  vif = m_cfg.vif;
 
         endfunction

// run phase

          task run_phase(uvm_phase phase);

                 phase.raise_objection(this);

// calling the method for collect the data from  interface

                 phase.drop_objection(this);
          endtask 


endclass
