





// class for agent top 

class destin_agent_top extends uvm_env;

// factory registration 

       `uvm_component_utils(destin_agent_top)

// declaring the handle for destination agent

           destin_agent agth[];
           
           router_env_config m_cfg; 


// function new constructor 

       function new(string name = "destin_agent_top",uvm_component  parent = null);

                super.new(name,parent);
             
       endfunction  

// build phase

       function void build_phase(uvm_phase phase);

           super.build_phase(phase); 
          //`uvm_info(get_full_name(),"this is agt top destin",UVM_NONE)
           if(!uvm_config_db#(router_env_config) :: get(this,"","router_env_config",m_cfg))
                  `uvm_fatal(get_full_name(),"cannot get() m_cfg from base test class data base object of router env config")  
            
           agth = new [m_cfg.no_of_destin];
           foreach(agth[i]) 
                    begin
                       uvm_config_db #(destin_agent_config) :: set(this,$sformatf("agth[%0d]*",i),"destin_agent_config",m_cfg.m_destin_agth[i]);  
                       agth[i] = destin_agent :: type_id :: create ($sformatf("agth[%0d]",i),this);
                     end
       endfunction

// end of elaboration phase

        function void end_of_elaboration_phase(uvm_phase phase);


              // this.print();


       endfunction

endclass