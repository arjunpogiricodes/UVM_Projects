




// source sequence class

class source_seq extends uvm_sequence #(source_xtn);

// factory registration

     `uvm_object_utils(source_seq)

// function new constructor

      function new(string name = "source_seq");

            super.new(name);
	//`uvm_info(get_full_name(),"this is sequence soruce",UVM_NONE)

      endfunction    

endclass
 
//---------------- Extended class  Small packets-----------//

class small_seq extends source_seq;

// factory registration

     `uvm_object_utils(small_seq)

// function new constructor

     function new (string name = "small_seq");

         super.new(name);

     endfunction 

// body task =generate 1 to 20 packets payload generates

      task body();
         req = source_xtn :: type_id :: create("req");
         start_item(req);
         assert(req.randomize() with {req.header_byte[7:2] inside{[1:21]};
                                      req.header_byte[1:0] == 2'b00;} )

             else 
                begin
                      `uvm_info(get_full_name(),"!!!!!!!!!!!randomization is failed in source seqs at small seq!!!!!!!!!",UVM_LOW)
                end
         finish_item(req);

      endtask

endclass


// -------------- Extended clas of Medium packets ---------//


class medium_seq extends source_seq;

// factory registration
     `uvm_object_utils(medium_seq)

// function new constructor

       function new(string name = "medium_seq");

               super.new(name);

       endfunction

// task body for packets stimulus 22 to 41

       task body();
           req = source_xtn :: type_id :: create("req");
           start_item(req);
           assert(req.randomize() with {header_byte[7:2] inside {[22:41]};
                                      header_byte[1:0] == 2'b01; } ) 
                else 
                    begin
                         `uvm_info(get_full_name(),"!!!!!!!!randomization is failed in source seqs at medium seq!!!!!!!!!!!",UVM_LOW)
                     end 
            finish_item(req);
         
       endtask

endclass


// large sequnce for generating the from 42 to 63

class large_seq extends source_seq;

// factory registration
   
     `uvm_object_utils(large_seq)

// function new constructor
 
        function new(string name = "large_seq" );
  
                   super.new(name); 
 
         endfunction 
// task body for 42 to 63


       task body();
           repeat(5)
           begin
           req = source_xtn :: type_id :: create("req");
           start_item(req);
           assert(req.randomize() with {header_byte[7:2] inside {[42:63]};
                                      header_byte[1:0] == 2'b10; } ) 
                else 
                    begin
                         `uvm_info(get_full_name(),"!!!!!!!!randomization is failed in source seqs at medium seq!!!!!!!!!!!",UVM_LOW)
                     end 
            finish_item(req);
           end
       endtask

endclass

