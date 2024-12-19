/************************************************************************
  
Copyright 2019 - Maven Silicon Softech Pvt Ltd.  
  
www.maven-silicon.com 
  
All Rights Reserved. 
This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd. 
It is not to be shared with or used by any third parties who have not enrolled for our paid 
training courses or received any written authorization from Maven Silicon.
  
Filename:       ram_rd_seqs.sv
  
Author Name:    Putta Satish

Support e-mail: For any queries, reach out to us on "techsupport_vm@maven-silicon.com" 

Version:	1.0

************************************************************************/

//------------------------------------------
// CLASS DESCRIPTION
//------------------------------------------

 
  // Extend ram_rbase_seq from uvm_sequence parameterized by read_xtn 
	class ram_rbase_seq extends uvm_sequence #(read_xtn);  
	
  // Factory registration using `uvm_object_utils

	`uvm_object_utils(ram_rbase_seq)  
//------------------------------------------
// METHODS
//------------------------------------------

// Standard UVM Methods:
        extern function new(string name ="ram_rbase_seq");
	endclass
//-----------------  constructor new method  -------------------//
	function ram_rbase_seq::new(string name ="ram_rbase_seq");
		super.new(name);
	endfunction

//------------------------------------------------------------------------------
//
// SEQUENCE: Ram Single address read Transactions   
//
//------------------------------------------------------------------------------


//------------------------------------------
// CLASS DESCRIPTION
//------------------------------------------


  // Extend ram_single_addr_rd_xtns from ram_rbase_seq;
	class ram_single_addr_rd_xtns extends ram_rbase_seq;

  	
  // Factory registration using `uvm_object_utils
  	`uvm_object_utils(ram_single_addr_rd_xtns)

//------------------------------------------
// METHODS
//------------------------------i------------

// Standard UVM Methods:
        extern function new(string name ="ram_single_addr_rd_xtns");
        extern task body();
	endclass
//-----------------  constructor new method  -------------------//
	function ram_single_addr_rd_xtns::new(string name = "ram_single_addr_rd_xtns");
		super.new(name);
	endfunction

	  
//-----------------  task body method  -------------------//
      // Generate 10 sequence items with address always equal to 55
      // Hint use create req, start item, assert for randomization with in line
      //  constraint (with) finish item inside repeat's begin end block 
	
	task ram_single_addr_rd_xtns::body();
    	repeat(10)
	  begin
   	   req=read_xtn::type_id::create("req");
	   start_item(req);
   	   assert(req.randomize() with {address==55;} );
	   `uvm_info("RAM_RD_SEQUENCE",$sformatf("printing from sequence \n %s", req.sprint()),UVM_HIGH) 
	   finish_item(req); 
	   end
    	endtask


//------------------------------------------------------------------------------
//
// SEQUENCE: Ram ten read Transactions  
//
//------------------------------------------------------------------------------


//------------------------------------------
// CLASS DESCRIPTION
//------------------------------------------


  // Extend ram_ten_rd_xtns from ram_rbase_seq;
	class ram_ten_rd_xtns extends ram_rbase_seq;

  	
  // Factory registration using `uvm_object_utils
  	`uvm_object_utils(ram_ten_rd_xtns)

//------------------------------------------
// METHODS
//------------------------------------------

// Standard UVM Methods:
        extern function new(string name ="ram_ten_rd_xtns");
        extern task body();
	endclass
//-----------------  constructor new method  -------------------//
	function ram_ten_rd_xtns::new(string name = "ram_ten_rd_xtns");
		super.new(name);
	endfunction

	  
//-----------------  task body method  -------------------//
      	// read the random data on memory address locations consecutively from 0 to 9
       // Hint use create req, start item, assert for randomization with in line
      //  constraint (with) finish item inside repeat's begin end block    
	
       task ram_ten_rd_xtns::body();
	int addrseq; 
	addrseq=0;	
   	repeat(10) begin
	req=read_xtn::type_id::create("req");
	start_item(req);
	assert(req.randomize() with {address==addrseq; read==1'b1;} );
	`uvm_info("RAM_RD_SEQUENCE",$sformatf("printing from sequence \n %s", req.sprint()),UVM_HIGH) 
	finish_item(req);
	addrseq=addrseq + 1;
	end
       endtask


//------------------------------------------------------------------------------
//
// SEQUENCE: Ram odd read Transactions  
//
//------------------------------------------------------------------------------


//------------------------------------------
// CLASS DESCRIPTION
//------------------------------------------


  // Extend ram_odd_rd_xtns from ram_rbase_seq;
	class ram_odd_rd_xtns extends ram_rbase_seq;

  	
  // Factory registration using `uvm_object_utils
  	`uvm_object_utils(ram_odd_rd_xtns)

//------------------------------------------
// METHODS
//------------------------------------------

// Standard UVM Methods:
        extern function new(string name ="ram_odd_rd_xtns");
        extern task body();
	endclass
//-----------------  constructor new method  -------------------//
	function ram_odd_rd_xtns::new(string name = "ram_odd_rd_xtns");
		super.new(name);
	endfunction

	  
//-----------------  task body method  -------------------//
      // read the 10 random data in odd memory address locations 
      // Hint use create req, start item, assert for randomization with in line
      // constraint (with) finish item inside repeat's begin end block    

       task ram_odd_rd_xtns::body();
	int addrseq; 
	addrseq=0;	
   	repeat(10) begin
	req=read_xtn::type_id::create("req");
	start_item(req);
	assert(req.randomize() with {address==(2*addrseq+1);read==1'b1;} );
	`uvm_info("RAM_RD_SEQUENCE",$sformatf("printing from sequence \n %s", req.sprint()),UVM_HIGH) 
	finish_item(req);
	addrseq=addrseq + 1;
	end
       endtask


//------------------------------------------------------------------------------
//
// SEQUENCE: Ram even read Transactions  
//
//------------------------------------------------------------------------------


//------------------------------------------
// CLASS DESCRIPTION
//------------------------------------------


  // Extend ram_even_rd_xtns from ram_rbase_seq;
	class ram_even_rd_xtns extends ram_rbase_seq;

  	
  // Factory registration using `uvm_object_utils
  	`uvm_object_utils(ram_even_rd_xtns)

//------------------------------------------
// METHODS
//------------------------------------------

// Standard UVM Methods:
        extern function new(string name ="ram_even_rd_xtns");
        extern task body();
	endclass
//-----------------  constructor new method  -------------------//
	function ram_even_rd_xtns::new(string name = "ram_even_rd_xtns");
		super.new(name);
	endfunction

	  
//-----------------  task body method  -------------------//
      // read the 10 random data in even memory address locations 
      // Hint use create req, start item, assert for randomization with in line
      // constraint (with) finish item inside repeat's begin end block    

       task ram_even_rd_xtns::body();
	int addrseq; 
	addrseq=0;	
   	repeat(10) begin
	req=read_xtn::type_id::create("req");
	start_item(req);
	assert(req.randomize() with {address==(2*addrseq);read==1'b1;} );
	`uvm_info("RAM_RD_SEQUENCE",$sformatf("printing from sequence \n %s", req.sprint()),UVM_HIGH) 
	finish_item(req);
	addrseq=addrseq + 1;
	end
       endtask


//------------------------------------------
// CLASS DESCRIPTION
//------------------------------------------


  // Extend ram_even_rd_xtns from ram_rbase_seq;
	class ram_rd_addr_rd_xtns extends ram_rbase_seq;

  	
  // Factory registration using `uvm_object_utils
  	`uvm_object_utils(ram_rd_addr_rd_xtns)

//------------------------------------------
// METHODS
//------------------------------------------

// Standard UVM Methods:
        extern function new(string name ="ram_rd_addr_rd_xtns");
        extern task body();
	endclass
//-----------------  constructor new method  -------------------//
	function ram_rd_addr_rd_xtns::new(string name = "ram_rd_addr_rd_xtns");
		super.new(name);
	endfunction

	  
//-----------------  task body method  -------------------//
      // read the 10 random data in even memory address locations 
      // Hint use create req, start item, assert for randomization with in line
      // constraint (with) finish item inside repeat's begin end block    

       task ram_rd_addr_rd_xtns::body();
//	int addrseq; 
//	addrseq=0;	
   	repeat(100) begin
	req=read_xtn::type_id::create("req");
	start_item(req);
	assert(req.randomize() with {address inside{[0:100],[101:511],[512:1023],[1024:1535],[1536:2047],[2048:2559],[2560:3071],[3072:3583],[3584:4094],[3996:4095]};} );
	`uvm_info("RAM_RD_SEQUENCE",$sformatf("printing from sequence \n %s", req.sprint()),UVM_HIGH) 
	finish_item(req);
//	addrseq=addrseq + 1;
	end
       endtask




//------------------------------------------
// CLASS DESCRIPTION

//ram_rd_data_rd_xtns rd_d_rxtns;


//------------------------------------------


  // Extend ram_even_wr_xtns from ram_wbase_seq;
	class ram_rd_data_rd_xtns  extends ram_wbase_seq;

  	
  // Factory registration using `uvm_object_utils
  	`uvm_object_utils(ram_rd_data_rd_xtns)

//------------------------------------------
// METHODS
//------------------------------------------

// Standard UVM Methods:
        extern function new(string name ="ram_rd_data_rd_xtns");
        extern task body();
	endclass
//-----------------  constructor new method  -------------------//
	function ram_rd_data_rd_xtns::new(string name = "ram_rd_data_rd_xtns");
		super.new(name);
	endfunction

	  
//-----------------  task body method  -------------------//
      // write the 10 random data in even memory address locations 
      // Hint use create req, start item, assert for randomization with in line
      // constraint (with) finish item inside repeat's begin end block    

       task ram_rd_data_rd_xtns::body();
//	int addrseq; 
//	addrseq=0;	
   	repeat(100) begin
	req=write_xtn::type_id::create("req");
	start_item(req);
		assert(req.randomize() with {data inside{[0:281474976710655]};});

	`uvm_info("RAM_WR_SEQUENCE",$sformatf("printing from sequence \n %s", req.sprint()),UVM_HIGH) 
	finish_item(req);
//	addrseq=addrseq + 1;
	end
       endtask











