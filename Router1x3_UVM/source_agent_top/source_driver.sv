




// class deriver for source

class source_driver extends uvm_driver #(source_xtn);


// factory registration

      `uvm_component_utils(source_driver)
     

// declare the virtual interface

         virtual router_source_if.S_DRV vif;
          source_agent_config m_cfg;

// function new constructor 

       function new(string name = "source_driver" , uvm_component parent = null);


              super.new(name,parent);
              

       endfunction:new
	   
// build phase

         function void build_phase(uvm_phase phase);

                 super.build_phase(phase);  
                //`uvm_info(get_full_name(),"this is driver soruce",UVM_NONE)
                if(!uvm_config_db #(source_agent_config) :: get(this,"","source_agent_config",m_cfg))
                       `uvm_fatal(get_full_name(),"cannot get  the source agent config handle driver m_cfg from source agent top")

         endfunction

// connect phase

          function void connect_phase(uvm_phase phase);

                   vif = m_cfg.vif;

          endfunction	   

// task run phase and send to dut method calling 

        task run_phase(uvm_phase phase);
               super.run_phase(phase); 
               forever begin
               seq_item_port.get_next_item(req);
               seq_item_port.item_done();
               req.print();
               end  
        endtask




endclass
