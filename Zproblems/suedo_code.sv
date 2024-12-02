




// suedo code

class suedo;

        rand int prob[9][9];
		
		constraint a {
						foreach(prob[i,j]) 
						prob[i][j] inside{[1:9]};
		              }
        constraint b {
                        foreach(prob[i,j])
						//unique{prob[i]};
                       {
            			//if(i == 0)
                         unique{prob[0][j]};
						 //else if(i == 1)
						 unique{prob[1][j]};
						 //else if(i == 2)
						 unique{prob[2][j]};
						// else if(i == 3)
						 unique{prob[3][j]};
						 //else if(i == 4)
						 unique{prob[4][j]};
						 //else if(i == 5)
						 unique{prob[5][j]};
						 //else if(i == 6)
						 unique{prob[6][j]};
						 //else if(i == 7)
						 unique{prob[7][j]};
						 //else if(i == 8)
						 unique{prob[8][j]};
						 }
					 						 
                      } 
        constraint c {
                        foreach(prob[i,j])
                         //unique{prob[j]};
						{ 
						// if(j == 0)
                         unique{prob[i][0]};
						 //else if(j == 1)
						 unique{prob[i][1]};
						// else if(j == 2)
						 unique{prob[i][2]};
						 //else if(j == 3)
						 unique{prob[i][3]};
						 //else if(j == 4)
						 unique{prob[i][4]};
						 //else if(j == 5)
						 unique{prob[i][5]};
						 //else if(j == 6)
						 unique{prob[i][6]};
						 //else if(j == 7)
						 unique{prob[i][7]};
						 //else if(j == 8)
						 unique{prob[i][8]};
						} 
						 
                      } 
       // constraint d {
                     //   foreach(prob[i,j])    
                                 //prob[i][j] != prob[i][j]; 						
                    // }		
					  
		function void post_randomize();
		$display ("==========================================");
		
		foreach(prob[i,j])
		begin
		     if(j<8)
		          $write("%0d   ",prob[i][j]);  
		     else
			      $write("%0d\n\n",prob[i][j]);
		end	 
        $display ("==========================================");
				
		endfunction:post_randomize


endclass:suedo

suedo sa;


module test;

        initial begin
		
            sa = new;

             assert(sa.randomize())
                    else $display("\n!!!!!!!!!!!!!!!! Voilation !!!!!!!!!!!!!!!!!!!!!\n");

             $display("\n %0p \n",sa.prob);					
		
		
		end



endmodule:test