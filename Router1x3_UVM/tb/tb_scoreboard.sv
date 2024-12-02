


class tb_scoreboard extends uvm_scoreboard;


// factory registration
 
          `uvm_component_utils(tb_scoreboard)

// declaring the  handle for env_config 
 
          

// write fucntion covrage cover group



// we have to implement check method  for comparing the data 


// function new constructor

          function new(string name = "tb_scoreboard",uvm_component parent= null );

                super.new(name,parent);


          endfunction:new
 

// build_phase


        task run_phase(uvm_phase phase);
          
               phase.raise_objection(this);
               super.run_phase(phase);
               



               phase.drop_objection(this);

        endtask:run_phase  







endclass:tb_scoreboard
