/************************************************************************
  
Copyright 2019 - Maven Silicon Softech Pvt Ltd.  
  
www.maven-silicon.com 
  
All Rights Reserved. 
This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd. 
It is not to be shared with or used by any third parties who have not enrolled for our paid 
training courses or received any written authorization from Maven Silicon.
  
Filename		:   top.sv

Description		:	Top Module 
 
Author Name		:   Putta Satish

Support e-mail	: 	For any queries, reach out to us on "techsupport_vm@maven-silicon.com" 

Version			:	1.0

************************************************************************/


module top;
  	import uvm_pkg::*;
	
  
	//import ram_pkg
       	   import ram_pkg::*;
   
          
	// Declare two handles of write_xtn class wr_copy_xtnh and wr_clone_xtnh 
  
          write_xtn wr_copy_xtnh,wr_clone_xtnh;
                    
 
 	// Declare dynamic array of handles for write_xtn as wr_xtnh
         
         write_xtn wr_xtnh[];
               
	// Declare a variable no_trans as int data type and initialize it with value 10.
 	
          int no_trans = 10;
        
	// Within initial block
 	
               initial begin
		// Allocate the size of above declared array equal to 10
                   wr_xtnh  = new[10];
		 
		// Within for loop, Generate ten random transactions	
		// Create 10 tr class objects with different strings using $sformatf 
		// randomize & print the 10 transaction class objects
		
                      for(int i=0; i<no_trans ; i++)
                           begin
                               wr_xtnh[i] =  write_xtn :: type_id :: create($sformatf("\nTransaction-%0d\n",i));
                               assert(wr_xtnh[i].randomize())
                               else $display(" !!!!!!!!!!!!!! Randomize Failed !!!!!!!!!!!!!!!!!!! ");
                               wr_xtnh[i].print();
                           end 
    			
	  
	  
		// Copy the 5th transaction item into the 3rd transaction item using copy method 
	            
                   wr_xtnh[2].copy(wr_xtnh[4]);

		// Copy the 3rd transaction item into another item(wr_copy_xtnh) using copy method
		// Note : Do create an instance for wr_copy_xtnh
                  		
                    wr_copy_xtnh =  write_xtn :: type_id :: create($sformatf("\nCopy_Xtnh_just check\n"));
                    wr_copy_xtnh.copy(wr_xtnh[2]);

                         
		
                   //Print the object wr_copy_xtnh in a tree format
		    wr_copy_xtnh.print(uvm_default_tree_printer);

		// Call Compare method on the 5th and 3rd transaction items
		
                     if(wr_xtnh[2].compare(wr_xtnh[4]))
                          begin
                             $display("\n Compared Success Full Matched \n");
                          end 
                       else 
                            begin
                             $display("\n Compared Success Full Not Matched \n");
                          end 
		// Using clone() method copy the 8th item to another item(wr_clone_xtnh)
		// Note : Do not create an instance for wr_clone_xtnh
		      $cast(wr_clone_xtnh,wr_xtnh[7].clone());
		//Print the object wr_clone_xtnh in a line format
	
		  wr_clone_xtnh.print(uvm_default_line_printer);

              end 
		


endmodule:top 

/*
if i use do_copy instead of copy method what happend for normal factory registration

if use field macros it cant work do-copy is overidden in normal but field macros it not working

wr_xtnh[i] =  write_xtn :: type_id :: create(); //($sformatf("\nTransaction-%0d\n",i));

here i am commanted that name i am getting name as uvm_sequnce_item 
in macros write xtn file i commanted function new constructor thats why its not working 


-----------------------------------------------
Name               Type       Size  Value      
-----------------------------------------------
uvm_sequence_item  write_xtn  -     @456       
  data             integral   64    'd40       
  address          integral   12    'd112      
  write            integral   1     1          
  xtn_delay        integral   65    -1193876914
  xtn_type         addr_t     1     GOOD_XTN   
-----------------------------------------------
----------------------------------------------
Name               Type       Size  Value     
----------------------------------------------
uvm_sequence_item  write_xtn  -     @460      
  data             integral   64    'd80      
  address          integral   12    'd173     
  write            integral   1     'd0       
  xtn_delay        integral   65    -930871580
  xtn_type         addr_t     1     GOOD_XTN  
----------------------------------------------
----------------------------------------------
Name               Type       Size  Value     
----------------------------------------------
uvm_sequence_item  write_xtn  -     @464      
  data             integral   64    'd76      
  address          integral   12    'd147     
  write            integral   1     1         
  xtn_delay        integral   65    'd96445067
  xtn_type         addr_t     1     GOOD_XTN  
----------------------------------------------
-----------------------------------------------
Name               Type       Size  Value      
-----------------------------------------------
uvm_sequence_item  write_xtn  -     @468       
  data             integral   64    'd76       
  address          integral   12    'd137      
  write            integral   1     1          
  xtn_delay        integral   65    'd331356990
  xtn_type         addr_t     1     GOOD_XTN   
-----------------------------------------------
-----------------------------------------------
Name               Type       Size  Value      
-----------------------------------------------
uvm_sequence_item  write_xtn  -     @472       
  data             integral   64    'd72       
  address          integral   12    'd13       
  write            integral   1     'd0        
  xtn_delay        integral   65    'd624243963
  xtn_type         addr_t     1     GOOD_XTN   
-----------------------------------------------
----------------------------------------------
Name               Type       Size  Value     
----------------------------------------------
uvm_sequence_item  write_xtn  -     @476      
  data             integral   64    'd47      
  address          integral   12    'd106     
  write            integral   1     1         
  xtn_delay        integral   65    -976301035
  xtn_type         addr_t     1     GOOD_XTN  
----------------------------------------------
----------------------------------------------
Name               Type       Size  Value     
----------------------------------------------
uvm_sequence_item  write_xtn  -     @480      
  data             integral   64    'd22      
  address          integral   12    'd7       
  write            integral   1     'd0       
  xtn_delay        integral   65    -954328551
  xtn_type         addr_t     1     GOOD_XTN  
----------------------------------------------
------------------------------------------------
Name               Type       Size  Value       
------------------------------------------------
uvm_sequence_item  write_xtn  -     @484        
  data             integral   64    'd36        
  address          integral   12    'd141       
  write            integral   1     1           
  xtn_delay        integral   65    'd1167778444
  xtn_type         addr_t     1     GOOD_XTN    
------------------------------------------------
-----------------------------------------------
Name               Type       Size  Value      
-----------------------------------------------
uvm_sequence_item  write_xtn  -     @488       
  data             integral   64    'd70       
  address          integral   12    'd10       
  write            integral   1     'd0        
  xtn_delay        integral   65    -1463218097
  xtn_type         addr_t     1     GOOD_XTN   
-----------------------------------------------
----------------------------------------------
Name               Type       Size  Value     
----------------------------------------------
uvm_sequence_item  write_xtn  -     @492      
  data             integral   64    'd57      
  address          integral   12    'd34      
  write            integral   1     1         
  xtn_delay        integral   65    -500264355
  xtn_type         addr_t     1     GOOD_XTN  
----------------------------------------------
uvm_sequence_item: (write_xtn@496) {
  data: 'd72 
  address: 'd13 
  write: 'd0 
  xtn_delay: 'd624243963 
  xtn_type: GOOD_XTN 
}

 Compared Success Full Matched 

uvm_sequence_item: (write_xtn@500) { data: 'd36  address: 'd141  write: 1  xtn_delay: 'd1167778444  xtn_type: GOOD_XTN  } 
           V C S   S i m u l a t i o n   R e p o r t 


*/


/*

normal copy without testings output
--------------------------------------------
Name             Type       Size  Value     
--------------------------------------------

Transaction-0
  write_xtn  -     @456      
  data           integral   64    'h58      
  address        integral   12    'h34      
  xtn_delay      integral   32    'h457005da
  xtn_type       addr_t     1     GOOD_XTN  
  write          integral   1     'h0       
--------------------------------------------
--------------------------------------------
Name             Type       Size  Value     
--------------------------------------------

Transaction-1
  write_xtn  -     @460      
  data           integral   64    'h3a      
  address        integral   12    'h83      
  xtn_delay      integral   32    'h55688a8c
  xtn_type       addr_t     1     GOOD_XTN  
  write          integral   1     'h1       
--------------------------------------------
--------------------------------------------
Name             Type       Size  Value     
--------------------------------------------

Transaction-2
  write_xtn  -     @464      
  data           integral   64    'h40      
  address        integral   12    'ha6      
  xtn_delay      integral   32    'h8402f2ac
  xtn_type       addr_t     1     GOOD_XTN  
  write          integral   1     'h1       
--------------------------------------------
--------------------------------------------
Name             Type       Size  Value     
--------------------------------------------

Transaction-3
  write_xtn  -     @468      
  data           integral   64    'h11      
  address        integral   12    'h88      
  xtn_delay      integral   32    'h4c8d1012
  xtn_type       addr_t     1     GOOD_XTN  
  write          integral   1     'h1       
--------------------------------------------
--------------------------------------------
Name             Type       Size  Value     
--------------------------------------------

Transaction-4
  write_xtn  -     @472      
  data           integral   64    'h1f      
  address        integral   12    'h770     
  xtn_delay      integral   32    'hdd10c227
  xtn_type       addr_t     1     BAD_XTN   
  write          integral   1     'h0       
--------------------------------------------
--------------------------------------------
Name             Type       Size  Value     
--------------------------------------------

Transaction-5
  write_xtn  -     @476      
  data           integral   64    'h10      
  address        integral   12    'h8f      
  xtn_delay      integral   32    'hf2aa217f
  xtn_type       addr_t     1     GOOD_XTN  
  write          integral   1     'h1       
--------------------------------------------
-------------------------------------------
Name             Type       Size  Value    
-------------------------------------------

Transaction-6
  write_xtn  -     @480     
  data           integral   64    'h52     
  address        integral   12    'h6b     
  xtn_delay      integral   32    'h4441612
  xtn_type       addr_t     1     GOOD_XTN 
  write          integral   1     'h1      
-------------------------------------------
--------------------------------------------
Name             Type       Size  Value     
--------------------------------------------

Transaction-7
  write_xtn  -     @484      
  data           integral   64    'h22      
  address        integral   12    'hc1      
  xtn_delay      integral   32    'h3346a53e
  xtn_type       addr_t     1     GOOD_XTN  
  write          integral   1     'h1       
--------------------------------------------
--------------------------------------------
Name             Type       Size  Value     
--------------------------------------------

Transaction-8
  write_xtn  -     @488      
  data           integral   64    'h15      
  address        integral   12    'h5c      
  xtn_delay      integral   32    'hdd926670
  xtn_type       addr_t     1     GOOD_XTN  
  write          integral   1     'h0       
--------------------------------------------
--------------------------------------------
Name             Type       Size  Value     
--------------------------------------------

Transaction-9
  write_xtn  -     @492      
  data           integral   64    'h47      
  address        integral   12    'h8d      
  xtn_delay      integral   32    'h990220d0
  xtn_type       addr_t     1     GOOD_XTN  
  write          integral   1     'h0       
--------------------------------------------

Copy_Xtnh_just check
: (write_xtn@496) {
  data: 'h1f 
  address: 'h770 
  xtn_delay: 'hdd10c227 
  xtn_type: BAD_XTN 
  write: 'h0 
}

 Compared Success Full Matched 


Transaction-7
: (write_xtn@500) { data: 'h22  address: 'hc1  xtn_delay: 'h3346a53e  xtn_type: GOOD_XTN  write: 'h1  } 
           V C S   S i m u l a t i o n   R e p o r t 

*/
