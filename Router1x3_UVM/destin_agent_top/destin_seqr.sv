





//destination sequencer class

class destin_seqr extends uvm_sequencer #(uvm_sequence_item);

// factory registration

      `uvm_component_utils(destin_seqr)

// fuinction new constructor

      function new (string name="destin_seqr" , uvm_component parent= null);

               super.new(name,parent);


      endfunction 
	  
// build phase
	  
         function void build_phase(uvm_phase phase);

                 super.build_phase(phase);  
                 //`uvm_info(get_full_name(),"this is sequencer destin",UVM_NONE)

         endfunction

endclass
