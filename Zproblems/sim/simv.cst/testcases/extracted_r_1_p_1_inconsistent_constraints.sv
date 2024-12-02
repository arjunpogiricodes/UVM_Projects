class c_1_1;
    rand bit[3:0] prob_3__0_; // rand_mode = ON 
    rand bit[3:0] prob_3__1_; // rand_mode = ON 
    rand bit[3:0] prob_3__2_; // rand_mode = ON 
    rand bit[3:0] prob_3__3_; // rand_mode = ON 
    rand bit[3:0] prob_3__4_; // rand_mode = ON 
    rand bit[3:0] prob_3__5_; // rand_mode = ON 
    rand bit[3:0] prob_3__6_; // rand_mode = ON 
    rand bit[3:0] prob_3__7_; // rand_mode = ON 
    rand bit[3:0] prob_0__0_; // rand_mode = ON 
    rand bit[3:0] prob_0__1_; // rand_mode = ON 
    rand bit[3:0] prob_0__2_; // rand_mode = ON 
    rand bit[3:0] prob_0__3_; // rand_mode = ON 
    rand bit[3:0] prob_0__4_; // rand_mode = ON 
    rand bit[3:0] prob_0__5_; // rand_mode = ON 
    rand bit[3:0] prob_0__6_; // rand_mode = ON 
    rand bit[3:0] prob_0__7_; // rand_mode = ON 
    rand bit[3:0] prob_1__0_; // rand_mode = ON 
    rand bit[3:0] prob_1__1_; // rand_mode = ON 
    rand bit[3:0] prob_1__2_; // rand_mode = ON 
    rand bit[3:0] prob_1__3_; // rand_mode = ON 
    rand bit[3:0] prob_1__4_; // rand_mode = ON 
    rand bit[3:0] prob_1__5_; // rand_mode = ON 
    rand bit[3:0] prob_1__6_; // rand_mode = ON 
    rand bit[3:0] prob_1__7_; // rand_mode = ON 
    rand bit[3:0] prob_2__0_; // rand_mode = ON 
    rand bit[3:0] prob_2__1_; // rand_mode = ON 
    rand bit[3:0] prob_2__2_; // rand_mode = ON 
    rand bit[3:0] prob_2__3_; // rand_mode = ON 
    rand bit[3:0] prob_2__4_; // rand_mode = ON 
    rand bit[3:0] prob_2__5_; // rand_mode = ON 
    rand bit[3:0] prob_2__6_; // rand_mode = ON 
    rand bit[3:0] prob_2__7_; // rand_mode = ON 
    rand bit[3:0] prob_4__0_; // rand_mode = ON 
    rand bit[3:0] prob_4__1_; // rand_mode = ON 
    rand bit[3:0] prob_4__2_; // rand_mode = ON 
    rand bit[3:0] prob_4__3_; // rand_mode = ON 
    rand bit[3:0] prob_4__4_; // rand_mode = ON 
    rand bit[3:0] prob_4__5_; // rand_mode = ON 
    rand bit[3:0] prob_4__6_; // rand_mode = ON 
    rand bit[3:0] prob_4__7_; // rand_mode = ON 
    rand bit[3:0] prob_5__0_; // rand_mode = ON 
    rand bit[3:0] prob_5__1_; // rand_mode = ON 
    rand bit[3:0] prob_5__2_; // rand_mode = ON 
    rand bit[3:0] prob_5__3_; // rand_mode = ON 
    rand bit[3:0] prob_5__4_; // rand_mode = ON 
    rand bit[3:0] prob_5__5_; // rand_mode = ON 
    rand bit[3:0] prob_5__6_; // rand_mode = ON 
    rand bit[3:0] prob_5__7_; // rand_mode = ON 
    rand bit[3:0] prob_6__0_; // rand_mode = ON 
    rand bit[3:0] prob_6__1_; // rand_mode = ON 
    rand bit[3:0] prob_6__2_; // rand_mode = ON 
    rand bit[3:0] prob_6__3_; // rand_mode = ON 
    rand bit[3:0] prob_6__4_; // rand_mode = ON 
    rand bit[3:0] prob_6__5_; // rand_mode = ON 
    rand bit[3:0] prob_6__6_; // rand_mode = ON 
    rand bit[3:0] prob_6__7_; // rand_mode = ON 
    rand bit[3:0] prob_7__0_; // rand_mode = ON 
    rand bit[3:0] prob_7__1_; // rand_mode = ON 
    rand bit[3:0] prob_7__2_; // rand_mode = ON 
    rand bit[3:0] prob_7__3_; // rand_mode = ON 
    rand bit[3:0] prob_7__4_; // rand_mode = ON 
    rand bit[3:0] prob_7__5_; // rand_mode = ON 
    rand bit[3:0] prob_7__6_; // rand_mode = ON 
    rand bit[3:0] prob_7__7_; // rand_mode = ON 

    constraint a_this    // (constraint_mode = ON) (../suedo_code.sv:12)
    {
       unique {prob_0__0_, prob_0__1_, prob_0__2_, prob_0__3_, prob_0__4_, prob_0__5_, prob_0__6_, prob_0__7_, prob_1__0_, prob_1__1_, prob_1__2_, prob_1__3_, prob_1__4_, prob_1__5_, prob_1__6_, prob_1__7_, prob_2__0_, prob_2__1_, prob_2__2_, prob_2__3_, prob_2__4_, prob_2__5_, prob_2__6_, prob_2__7_, prob_3__0_, prob_3__1_, prob_3__2_, prob_3__3_, prob_3__4_, prob_3__5_, prob_3__6_, prob_3__7_, prob_4__0_, prob_4__1_, prob_4__2_, prob_4__3_, prob_4__4_, prob_4__5_, prob_4__6_, prob_4__7_, prob_5__0_, prob_5__1_, prob_5__2_, prob_5__3_, prob_5__4_, prob_5__5_, prob_5__6_, prob_5__7_, prob_6__0_, prob_6__1_, prob_6__2_, prob_6__3_, prob_6__4_, prob_6__5_, prob_6__6_, prob_6__7_, prob_7__0_, prob_7__1_, prob_7__2_, prob_7__3_, prob_7__4_, prob_7__5_, prob_7__6_, prob_7__7_};
    }
endclass

program p_1_1;
    c_1_1 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "z11xzxx10xz01z1z100z10x01xx01z1zxxxxxxzxzzzzzxzxzxxxxzxzzzzzxzxz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
