`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.09.2021 16:09:28
// Design Name: 
// Module Name: selection_sort
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

`include "CSR_ADDR.vh"

module selection_sort;

    reg clk;
    reg rst;              
   

    //assuming o/ps of processor should be wires
    wire [31:0] address_out;
    wire [31:0] data_out,data_in;
    wire B;
    wire H;
    wire [11:0]instr_addr;
    reg [31:0]instr;
    wire mem_read_ctrl;
    wire mem_write_ctrl;
    
    parameter BOOT_ADDRESS=32'b0;
    
     /*Internals*/
    integer f,j,m,n,k;
    
    
    
    ///////////////////////////////////////////////////////////
    /*                          Tests                        */
    reg [8*100:0] tests[0:1]={
    "../../../../../custom-instruction-tests/selection-sort/selection-sort-normal.txt",
    "../../../../../custom-instruction-tests/selection-sort/selection-sort-custom.txt"};

    
    ///////////////////////////////////////////////////////////
    /*                         Data Memory                   */
    reg [31:0]read_data;
    reg [31:0]mem_data_custom;
    reg [14:0]mem_address_custom;
    reg custom;
    assign data_in=read_data;
    
    //RAM
    reg [31:0] mem_ram [0:32767];              //64KB of data memory, 2048 data words present in the memory
    
    always@(posedge clk)
    begin
        if(mem_read_ctrl) //load and custom
            read_data=mem_ram[address_out[16:2]];
        else
            read_data=32'b0;//In case of store
        if(!mem_read_ctrl && mem_write_ctrl) //store the data into the memory
        begin
            if(B==1 && H==0)
                  case(address_out[1:0])
                        2'b00: mem_ram[address_out[16:2]][7:0]=data_out[7:0];
                        2'b01: mem_ram[address_out[16:2]][15:8]=data_out[7:0];
                        2'b10: mem_ram[address_out[16:2]][23:16]=data_out[7:0];
                        2'b11: mem_ram[address_out[16:2]][31:24]=data_out[7:0];
                    endcase
            else if(B==0 && H==1)
                case(address_out[1])
                      2'b0: mem_ram[address_out[16:2]][15:0]=data_out[15:0];
                      2'b1: mem_ram[address_out[16:2]][31:16]=data_out[15:0];
                endcase
            else
                mem_ram[address_out[16:2]]=data_out;
        end
    end
    
    always @(posedge clk)
    begin
        if(mem_read_ctrl && mem_write_ctrl)
            begin
                custom<=1;
                mem_data_custom<=data_out;
                mem_address_custom<=address_out[16:2]; 
            end
        else
            begin
                custom<=0;
                mem_data_custom<=32'b0;
                mem_address_custom<=15'b0;
            end
    end
    
    always @ (negedge clk)
    begin
        if(custom)
            mem_ram[mem_address_custom]=mem_data_custom;
    end
    
    
    
    
    ////////////////////////////////////////////////////////////////////
    /*                        Instruction Memory                      */
    reg [31:0] instruction_memory [0:4095]; //Total memory size: 16KB, capable of storing 2048 instructions.

    always@(negedge clk)
    begin
         instr <= instruction_memory[instr_addr]; 
    end
    
    
    
    ///////////////////////////////////////////////////////////////////
    /*                              Test                            */
    always
        #5 clk = ~clk;
        
    always@(posedge clk)
        f=f+1;          //counter
        
    initial begin
        $display("Test Started......\n");
        for(m = 0; m < 2; m = m+1)
        begin
                    f=0;
                    for(n = 0; n < 32767; n = n+1)
                    begin
                        instruction_memory[n] = 1'b0;
                        mem_ram[n] = 1'b0;
                    end
                    k=2048;
                    for(n=100; n > 0; n=n-1)
                    begin
                        mem_ram[k] = n;
                        k = k+1;
                    end
                    
        $readmemb(tests[m],instruction_memory);
        $display("Running... %s...\n", tests[m]);
        rst=1;
        clk=0;
        #10 rst=0;
                    // one second loop
                    for(j = 0; j < 50000000; j = j + 1)
                    begin
                        #10;
                        if(mem_write_ctrl == 1'b1 && address_out == 32'h00000100)
                        begin  
                                    $display("Sorting complete!\n\n");
//                                    $display("%d ",mem_ram[2048]);
//                                    $display("%d ",mem_ram[2049]);
//                                    $display("%d ",mem_ram[2050]);
//                                    $display("%d ",mem_ram[2051]);
//                                    $display("%d ",mem_ram[2052]);
//                                    $display("%d ",mem_ram[2053]);
//                                    $display("%d ",mem_ram[2054]);
                                      k=2048;
                                      for(n=100; n > 0; n=n-1)
                                      begin
                                        $display("%d ",mem_ram[k]);
                                        k = k+1;
                                      end
                                    $display("Total No. of clock cycles taken: %d\n\n",f);         
                            #10;
                            j = 50000000;
                        end
                    end
        end
        #100;
        $display("Sorting test Finished!!");

 
        $finish;
        end
        
        
        
    /////////////////////////////////////////    
    /*             Instantiation           */    
    processor #(.BOOT_ADDRESS(BOOT_ADDRESS))
          processor(.clk(clk),.rst(rst),.data_in(data_in),.instr_in(instr),.mem_read_ctrl(mem_read_ctrl),.mem_write_ctrl(mem_write_ctrl),.address_out(address_out),.data_out(data_out),.B(B),.H(H),.instr_addr(instr_addr));

endmodule
