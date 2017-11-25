`timescale 1 ns / 100 ps

module testbench
# (
    parameter w        = 8,
              n_stages = 4
);

    //------------------------------------------------------------------------
    //
    //  Signals
    //
    //------------------------------------------------------------------------

    reg clk;
    reg rst_n;
    reg clk_en;
    reg n_vld;

    reg [ w - 1:0 ] n;

    wire                        res_vld_pow_5_en_single_cycle_struct;
    wire                        res_vld_pow_5_en_single_cycle_always;
    wire                        res_vld_pow_5_en_multi_cycle_struct;
    wire                        res_vld_pow_5_en_multi_cycle_always;
    wire [ n_stages     - 1:0 ] res_vld_pow_5_en_pipe_struct;
    wire [ 4            - 1:0 ] res_vld_pow_5_en_pipe_struct_with_generate_4;
    wire [ n_stages     - 1:0 ] res_vld_pow_5_en_pipe_always;
    wire [ n_stages     - 1:0 ] res_vld_pow_5_en_pipe_always_with_array;
    wire [ 4            - 1:0 ] res_vld_pow_5_en_pipe_always_with_array_and_n_stages_4;
    wire [ 5            - 1:0 ] res_vld_pow_5_en_pipe_struct_with_generate_5;
    wire [ 5            - 1:0 ] res_vld_pow_5_en_pipe_always_with_array_and_n_stages_5;


    wire [ w            - 1:0 ] res_pow_5_en_single_cycle_struct;
    wire [ w            - 1:0 ] res_pow_5_en_single_cycle_always;
    wire [ w            - 1:0 ] res_pow_5_en_multi_cycle_struct;
    wire [ w            - 1:0 ] res_pow_5_en_multi_cycle_always;
    wire [ w * n_stages - 1:0 ] res_pow_5_en_pipe_struct;
    wire [ w * 4        - 1:0 ] res_pow_5_en_pipe_struct_with_generate_4;
    wire [ w * n_stages - 1:0 ] res_pow_5_en_pipe_always;
    wire [ w * n_stages - 1:0 ] res_pow_5_en_pipe_always_with_array;
    wire [ w * 4        - 1:0 ] res_pow_5_en_pipe_always_with_array_and_n_stages_4;
    wire [ w * 5        - 1:0 ] res_pow_5_en_pipe_struct_with_generate_5;
    wire [ w * 5        - 1:0 ] res_pow_5_en_pipe_always_with_array_and_n_stages_5;

    //------------------------------------------------------------------------
    //
    //  Instantiations
    //
    //------------------------------------------------------------------------

      pow_5_en_single_cycle_struct
    # (.w (w))
    i_pow_5_en_single_cycle_struct
    (
        .clk     ( clk    ),
        .rst_n   ( rst_n  ),
        .clk_en  ( clk_en ),
        .n_vld   ( n_vld  ),
        .n       ( n      ),
        .res_vld ( res_vld_pow_5_en_single_cycle_struct ),
        .res     ( res_pow_5_en_single_cycle_struct     )
    );

      pow_5_en_single_cycle_always
    # (.w (w))
    i_pow_5_en_single_cycle_always
    (
        .clk     ( clk    ),
        .rst_n   ( rst_n  ),
        .clk_en  ( clk_en ),
        .n_vld   ( n_vld  ),
        .n       ( n      ),
        .res_vld ( res_vld_pow_5_en_single_cycle_always ),
        .res     ( res_pow_5_en_single_cycle_always     )
    );

      pow_5_en_multi_cycle_struct
    # (.w (w))
    i_pow_5_en_multi_cycle_struct
    (
        .clk     ( clk    ),
        .rst_n   ( rst_n  ),
        .clk_en  ( clk_en ),
        .n_vld   ( n_vld  ),
        .n       ( n      ),
        .res_vld ( res_vld_pow_5_en_multi_cycle_struct ),
        .res     ( res_pow_5_en_multi_cycle_struct     )
    );

      pow_5_en_multi_cycle_always
    # (.w (w))
    i_pow_5_en_multi_cycle_always
    (
        .clk     ( clk    ),
        .rst_n   ( rst_n  ),
        .clk_en  ( clk_en ),
        .n_vld   ( n_vld  ),
        .n       ( n      ),
        .res_vld ( res_vld_pow_5_en_multi_cycle_always ),
        .res     ( res_pow_5_en_multi_cycle_always     )
    );

      pow_5_en_pipe_struct
    # (.w (w))
    i_pow_5_en_pipe_struct
    (
        .clk     ( clk    ),
        .rst_n   ( rst_n  ),
        .clk_en  ( clk_en ),
        .n_vld   ( n_vld  ),
        .n       ( n      ),
        .res_vld ( res_vld_pow_5_en_pipe_struct ),
        .res     ( res_pow_5_en_pipe_struct     )
    );

      pow_5_en_pipe_struct_with_generate
    # (.w (w), .n_stages (4))
    i_pow_5_en_pipe_struct_with_generate_4
    (
        .clk     ( clk    ),
        .rst_n   ( rst_n  ),
        .clk_en  ( clk_en ),
        .n_vld   ( n_vld  ),
        .n       ( n      ),
        .res_vld ( res_vld_pow_5_en_pipe_struct_with_generate_4 ),
        .res     ( res_pow_5_en_pipe_struct_with_generate_4     )
    );

      pow_5_en_pipe_always
    # (.w (w))
    i_pow_5_en_pipe_always
    (
        .clk     ( clk    ),
        .rst_n   ( rst_n  ),
        .clk_en  ( clk_en ),
        .n_vld   ( n_vld  ),
        .n       ( n      ),
        .res_vld ( res_vld_pow_5_en_pipe_always ),
        .res     ( res_pow_5_en_pipe_always     )
    );

      pow_5_en_pipe_always_with_array
    # (.w (w))
    i_pow_5_en_pipe_always_with_array
    (
        .clk     ( clk    ),
        .rst_n   ( rst_n  ),
        .clk_en  ( clk_en ),
        .n_vld   ( n_vld  ),
        .n       ( n      ),
        .res_vld ( res_vld_pow_5_en_pipe_always_with_array ),
        .res     ( res_pow_5_en_pipe_always_with_array     )
    );
      
      pow_5_en_pipe_always_with_array_and_n_stages
    # (.w (w), .n_stages (4))
    i_pow_5_en_pipe_always_with_array_and_n_stages_4
    (
        .clk     ( clk    ),
        .rst_n   ( rst_n  ),
        .clk_en  ( clk_en ),
        .n_vld   ( n_vld  ),
        .n       ( n      ),
        .res_vld ( res_vld_pow_5_en_pipe_always_with_array_and_n_stages_4 ),
        .res     ( res_pow_5_en_pipe_always_with_array_and_n_stages_4     )
    );

      pow_5_en_pipe_struct_with_generate
    # (.w (w), .n_stages (5))
    i_pow_5_en_pipe_struct_with_generate_5
    (
        .clk     ( clk    ),
        .rst_n   ( rst_n  ),
        .clk_en  ( clk_en ),
        .n_vld   ( n_vld  ),
        .n       ( n      ),
        .res_vld ( res_vld_pow_5_en_pipe_struct_with_generate_5 ),
        .res     ( res_pow_5_en_pipe_struct_with_generate_5     )
    );

      pow_5_en_pipe_always_with_array_and_n_stages
    # (.w (w), .n_stages (5))
    i_pow_5_en_pipe_always_with_array_and_n_stages_5
    (
        .clk     ( clk    ),
        .rst_n   ( rst_n  ),
        .clk_en  ( clk_en ),
        .n_vld   ( n_vld  ),
        .n       ( n      ),
        .res_vld ( res_vld_pow_5_en_pipe_always_with_array_and_n_stages_5 ),
        .res     ( res_pow_5_en_pipe_always_with_array_and_n_stages_5     )
    );

    //------------------------------------------------------------------------
    //
    //  Clock and reset
    //
    //------------------------------------------------------------------------

    initial
    begin
        clk = 0;
   
        forever
            # 10 clk = ! clk;
    end
 
    initial
    begin
        clk_en <= 1'b1;
        n_vld  <= 1'b0;

        repeat (2) @ (posedge clk);
        rst_n <= 0;
        repeat (2) @ (posedge clk);
        rst_n <= 1;
    end

    //------------------------------------------------------------------------
    //
    //  Main sequence
    //
    //------------------------------------------------------------------------

    integer i;

    initial
    begin
        #0
        $dumpvars;

        @ (posedge rst_n);

        repeat (10) @ (posedge clk);

        n     <= 3;
        n_vld <= 1;

        @ (posedge clk);

        n_vld <= 0;

        repeat (10) @ (posedge clk);

        @ (posedge clk);

        for (i = 0; i < 50; i = i + 1)
        begin
            n     <= i & 7;
            n_vld <= (i == 0 || res_vld_pow_5_en_multi_cycle_struct);

            @ (posedge clk);
        end

        repeat (10) @ (posedge clk);

        for (i = 0; i < 50; i = i + 1)
        begin
            n     <= i & 7;
            n_vld <= 1;

            @ (posedge clk);
        end

        $stop;
    end

    //------------------------------------------------------------------------
    //
    //  Checking with assertions
    //
    //------------------------------------------------------------------------


    reg check;

    always @ (posedge clk)
    begin
        check =
    
               res_vld_pow_5_en_single_cycle_struct
           === res_vld_pow_5_en_single_cycle_always    

        &&     res_vld_pow_5_en_multi_cycle_struct
           === res_vld_pow_5_en_multi_cycle_always    
                 
        &&     res_vld_pow_5_en_pipe_struct
           === res_vld_pow_5_en_pipe_struct_with_generate_4    
                 
        &&     res_vld_pow_5_en_pipe_struct
           === res_vld_pow_5_en_pipe_always    
                 
        &&     res_vld_pow_5_en_pipe_struct
           === res_vld_pow_5_en_pipe_always_with_array    
                 
        &&     res_vld_pow_5_en_pipe_struct
           === res_vld_pow_5_en_pipe_always_with_array_and_n_stages_4

        &&     res_vld_pow_5_en_pipe_struct_with_generate_5
           === res_vld_pow_5_en_pipe_always_with_array_and_n_stages_5

        //--------------------------------------------------------------------

        &&     res_pow_5_en_single_cycle_struct
           === res_pow_5_en_single_cycle_always   

        &&     res_pow_5_en_multi_cycle_struct
           === res_pow_5_en_multi_cycle_always    
                 
        &&     res_pow_5_en_pipe_struct
           === res_pow_5_en_pipe_struct_with_generate_4    
                 
        &&     res_pow_5_en_pipe_struct
           === res_pow_5_en_pipe_always    
                 
        &&     res_pow_5_en_pipe_struct
           === res_pow_5_en_pipe_always_with_array    
                 
        &&     res_pow_5_en_pipe_struct
           === res_pow_5_en_pipe_always_with_array_and_n_stages_4    

        &&     res_pow_5_en_pipe_struct_with_generate_5
           === res_pow_5_en_pipe_always_with_array_and_n_stages_5
        ;
        
        if (! check)
            $display ("Something went wrong");
    end

endmodule
