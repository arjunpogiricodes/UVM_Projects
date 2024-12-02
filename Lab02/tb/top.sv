/************************************************************************
  
Copyright 2019 - Maven Silicon Softech Pvt Ltd.  
  
www.maven-silicon.com 
  
All Rights Reserved. 
This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd. 
It is not to be shared with or used by any third parties who have not enrolled for our paid 
training courses or received any written authorization from Maven Silicon.
  
Filename		:   top.sv

Description 	: 	Top Module
  
Author Name		:   Putta Satish

Support e-mail	: 	For any queries, reach out to us on "techsupport_vm@maven-silicon.com" 

Version			:	1.0

************************************************************************/

module top;

	import uvm_pkg::*;

	// import the  ram_pkg
         import ram_pkg::*;

        
	// Declare handle for write_xtn as wr_xtnh	
	
           write_xtn  wr_xtnh;
           
	
	// Add build method
	function void build();

		  // Create an instance of wr_xtnh using factory create()
		  wr_xtnh = write_xtn :: type_id :: create(" Write_Xtn "); 
		  // Randomize and print the transactions
		  assert(wr_xtnh.randomize())
                   else $display("!!!!!!!!!!!! Randomization Failed !!!!!!!!!!!!!!!!!");
                   wr_xtnh.print();

	endfunction
  
	// Within initial 

	initial
	    begin
			// Call build function 5 times (Without Overriding)
        	repeat(5)
                   build();

			//call factory overriding method
				//Hint : Use factory.set_type_override_by_type Override 
			// Call build function 5 times 
        	factory.set_type_override_by_type ( write_xtn :: get_type(), short_xtn :: get_type());
		repeat(5)
                    build();
	
                        
      	end
 
endmodule


/*

  ***********       IMPORTANT RELEASE NOTES         ************

  You are using a version of the UVM library that has been compiled
  with `UVM_NO_DEPRECATED undefined.
  See http://www.eda.org/svdb/view.php?id=3313 for more details.

  You are using a version of the UVM library that has been compiled
  with `UVM_OBJECT_MUST_HAVE_CONSTRUCTOR undefined.
  See http://www.eda.org/svdb/view.php?id=3770 for more details.

      (Specify +UVM_NO_RELNOTES to turn off this notice)

----------------------------------------------------
Name         Type       Size  Value                 
----------------------------------------------------
 Write_Xtn   write_xtn  -     @456                  
  data       integral   64    'd43                  
  address    integral   12    'd172                 
  write      integral   1     1                     
  xtn_delay  integral   65    'd14926791701782078926
  xtn_type   addr_t     1     GOOD_XTN              
----------------------------------------------------
----------------------------------------------------
Name         Type       Size  Value                 
----------------------------------------------------
 Write_Xtn   write_xtn  -     @460                  
  data       integral   64    'd47                  
  address    integral   12    'd119                 
  write      integral   1     'd0                   
  xtn_delay  integral   65    'd15347605352174517248
  xtn_type   addr_t     1     GOOD_XTN              
----------------------------------------------------
----------------------------------------------------
Name         Type       Size  Value                 
----------------------------------------------------
 Write_Xtn   write_xtn  -     @464                  
  data       integral   64    'd53                  
  address    integral   12    'd196                 
  write      integral   1     'd0                   
  xtn_delay  integral   65    'd11500261455708453448
  xtn_type   addr_t     1     GOOD_XTN              
----------------------------------------------------
----------------------------------------------------
Name         Type       Size  Value                 
----------------------------------------------------
 Write_Xtn   write_xtn  -     @468                  
  data       integral   64    'd39                  
  address    integral   12    'd104                 
  write      integral   1     'd0                   
  xtn_delay  integral   65    'd15345461173460311972
  xtn_type   addr_t     1     GOOD_XTN              
----------------------------------------------------
---------------------------------------------------
Name         Type       Size  Value                
---------------------------------------------------
 Write_Xtn   write_xtn  -     @472                 
  data       integral   64    'd56                 
  address    integral   12    'd2                  
  write      integral   1     1                    
  xtn_delay  integral   65    'd7058206156074029543
  xtn_type   addr_t     1     GOOD_XTN             
---------------------------------------------------
---------------------------------------------------
Name         Type       Size  Value                
---------------------------------------------------
 Write_Xtn   short_xtn  -     @476                 
  data       integral   64    'd38                 
  address    integral   12    'd15                 
  write      integral   1     'd0                  
  xtn_delay  integral   65    'd4255316133118411757
  xtn_type   addr_t     1     GOOD_XTN             
---------------------------------------------------
---------------------------------------------------
Name         Type       Size  Value                
---------------------------------------------------
 Write_Xtn   short_xtn  -     @480                 
  data       integral   64    'd84                 
  address    integral   12    'd15                 
  write      integral   1     'd0                  
  xtn_delay  integral   65    'd4059611498903881272
  xtn_type   addr_t     1     GOOD_XTN             
---------------------------------------------------
----------------------------------------------------
Name         Type       Size  Value                 
----------------------------------------------------
 Write_Xtn   short_xtn  -     @484                  
  data       integral   64    'd48                  
  address    integral   12    'd15                  
  write      integral   1     'd0                   
  xtn_delay  integral   65    'd11260399448531901299
  xtn_type   addr_t     1     GOOD_XTN              
----------------------------------------------------
----------------------------------------------------
Name         Type       Size  Value                 
----------------------------------------------------
 Write_Xtn   short_xtn  -     @488                  
  data       integral   64    'd35                  
  address    integral   12    'd15                  
  write      integral   1     'd0                   
  xtn_delay  integral   65    'd17745387867136723942
  xtn_type   addr_t     1     GOOD_XTN              
----------------------------------------------------
---------------------------------------------------
Name         Type       Size  Value                
---------------------------------------------------
 Write_Xtn   short_xtn  -     @492                 
  data       integral   64    'd53                 
  address    integral   12    'd15                 
  write      integral   1     'd0                  
  xtn_delay  integral   65    'd1881778655835586784
  xtn_type   addr_t     1     GOOD_XTN             
---------------------------------------------------
           V C S   S i m u l a t i o n   R e p o r t 
Time: 0 ps
*/

  
