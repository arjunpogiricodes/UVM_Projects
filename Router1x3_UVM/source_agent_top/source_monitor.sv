




// class source monitor

class source_monitor extends uvm_monitor;

// factory registration

     `uvm_component_utils(source_monitor)

// dfeclare  virtual interface

          virtual router_source_if.S_MON vif;
          source_agent_config m_cfg;


// function new constructor

       function new (string name = "source_monitor",uvm_component parent = null );

              super.new(name,parent);
			  
 
       endfunction 
	   
// build phase

         function void build_phase(uvm_phase phase);

                 super.build_phase(phase);  
               // `uvm_info(get_full_name(),"this is monior soruce",UVM_NONE)
                if(!uvm_config_db #(source_agent_config) :: get(this,"","source_agent_config",m_cfg))
                       `uvm_fatal(get_full_name(),"cannot get  the source agent config handle monitor m_cfg from source agent top")


         endfunction

// connect phase

          function void connect_phase(uvm_phase phase);

                    vif = m_cfg.vif;

          endfunction	   
      
// run phase

        task run_phase(uvm_phase phase);

             phase.raise_objection(this);
                super.run_phase(phase);
                      // #20;
              phase.drop_objection(this);
        endtask     




endclass
