



// environment class 

class tb_env extends uvm_env;

// factory registration

           `uvm_component_utils(tb_env)

// declaring the handle for vritual seqr and source agent top and destin agent top i dont know 

         source_agent_top  source_agth;
         destin_agent_top  destin_agth;
         tb_scoreboard     sb;


// declaring the int varialbles for no of wr agent and  no of read agent - idont know


// declaring for the scoreboard and virtual sequencer no  i dont know

         virtual_seqr  v_seqr;
 
// declaring the  handle for the env_config class to get and 

       router_env_config m_cfg;

// construction new function
 
         function new(string name = "tb_env", uvm_component parent = null);

                       super.new(name,parent);

         endfunction:new
        
// build phase 

        function void build_phase(uvm_phase phase);
              super.build_phase(phase);
               if(! uvm_config_db #(router_env_config) :: get(this,"","router_env_config",m_cfg))
                     `uvm_fatal(get_full_name(),"cannot get the router_env_config handle m_cfg from test in env_tb ")
               source_agth = source_agent_top :: type_id :: create("source_agth",this);
               destin_agth = destin_agent_top :: type_id :: create("destin_agth",this);
               sb          = tb_scoreboard    :: type_id :: create("sb",this); 
               v_seqr      = virtual_seqr     :: type_id :: create("v_seqr",this);      

        endfunction
         

// connect phase

       function void connect_phase(uvm_phase phase);

           for(int i = 0; m_cfg.no_of_source ; i++)
                   begin
                       v_seqr.s_seqr[i] = source_agth.agth[i].seqr;
                    end

       endfunction:connect_phase



endclass:tb_env


/*

topology:

----------------------------------------------------------------
Name                         Type                    Size  Value
----------------------------------------------------------------
uvm_test_top                 base_test               -     @473 
  envh                       tb_env                  -     @494 
    destin_agth              destin_agent_top        -     @510 
      agth[0]                destin_agent            -     @531 
        drvh                 destin_driver           -     @570 
          rsp_port           uvm_analysis_port       -     @587 
          seq_item_port      uvm_seq_item_pull_port  -     @578 
        monh                 destin_monitor          -     @562 
        seqr                 destin_seqr             -     @596 
          rsp_export         uvm_analysis_export     -     @604 
          seq_item_export    uvm_seq_item_pull_imp   -     @710 
          arbitration_queue  array                   0     -    
          lock_queue         array                   0     -    
          num_last_reqs      integral                32    'd1  
          num_last_rsps      integral                32    'd1  
      agth[1]                destin_agent            -     @540 
        drvh                 destin_driver           -     @739 
          rsp_port           uvm_analysis_port       -     @756 
          seq_item_port      uvm_seq_item_pull_port  -     @747 
        monh                 destin_monitor          -     @731 
        seqr                 destin_seqr             -     @765 
          rsp_export         uvm_analysis_export     -     @773 
          seq_item_export    uvm_seq_item_pull_imp   -     @879 
          arbitration_queue  array                   0     -    
          lock_queue         array                   0     -    
          num_last_reqs      integral                32    'd1  
          num_last_rsps      integral                32    'd1  
      agth[2]                destin_agent            -     @549 
        drvh                 destin_driver           -     @908 
          rsp_port           uvm_analysis_port       -     @925 
          seq_item_port      uvm_seq_item_pull_port  -     @916 
        monh                 destin_monitor          -     @900 
        seqr                 destin_seqr             -     @934 
          rsp_export         uvm_analysis_export     -     @942 
          seq_item_export    uvm_seq_item_pull_imp   -     @1048
          arbitration_queue  array                   0     -    
          lock_queue         array                   0     -    
          num_last_reqs      integral                32    'd1  
          num_last_rsps      integral                32    'd1  
    sb                       tb_scoreboard           -     @518 
    source_agth              source_agent_top        -     @502 
      agth[0]                source_agent            -     @1069
        drvh                 source_driver           -     @1090
          rsp_port           uvm_analysis_port       -     @1107
          seq_item_port      uvm_seq_item_pull_port  -     @1098
        monh                 source_monitor          -     @1082
        seqr                 source_seqr             -     @1116
          rsp_export         uvm_analysis_export     -     @1124
          seq_item_export    uvm_seq_item_pull_imp   -     @1230
          arbitration_queue  array                   0     -    
          lock_queue         array                   0     -    
          num_last_reqs      integral                32    'd1  
          num_last_rsps      integral                32    'd1  
----------------------------------------------------------------
*/

