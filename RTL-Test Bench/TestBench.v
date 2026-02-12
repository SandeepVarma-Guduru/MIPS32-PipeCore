module test_mips32;

reg clk1, clk2;
integer k;

mips_32 mips(clk1, clk2);   

// Two-phase clock generation
initial
begin
    clk1 = 0;
    clk2 = 0;

    repeat (50)
    begin
        #5 clk1 = 1;  #5 clk1 = 0;
        #5 clk2 = 1;  #5 clk2 = 0;
    end
end


// Initialize registers and memory
initial
begin
    for (k = 0; k < 31; k = k + 1)
        mips.REGBANK[k] = k;   

    mips.MEM[0] = 32'h28010078;
    mips.MEM[1] = 32'h0c631800;
    mips.MEM[2] = 32'h20220000;
    mips.MEM[3] = 32'h0c631800;
    mips.MEM[4] = 32'h2842002d;
    mips.MEM[5] = 32'h0c631800;
    mips.MEM[6] = 32'h24220001;
    mips.MEM[7] = 32'hfc000000;

    mips.MEM[120] = 85;

    mips.PC = 0;
    mips.HALTED = 0;
    mips.TAKEN_BRANCH = 0;

    #500
    $display("Mem[120]: %4d  Mem[121]: %4d",
             mips.MEM[120], mips.MEM[121]);
end


initial
begin
    $dumpfile("mips.vcd");
    $dumpvars(0, test_mips32);
    #600 $finish;
end

endmodule
