




// destin seq class 

class destin_seq extends uvm_sequence #(uvm_sequence_item);

// factory registation

          `uvm_object_utils(destin_seq)
 
// function new constructor

        function new(string name = "destin_seq");

                 super.new(name);

        endfunction
//build phase



// task body for ganerate stimulus

       task body();

      


       endtask



endclass
