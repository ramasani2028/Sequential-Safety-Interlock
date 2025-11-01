//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/26/2025 11:27:53 PM
// Design Name: 
// Module Name: test
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


`timescale 1ns / 1ps

module tb_SafeStartupSequence_GateLevel;

    
    reg Pump_ON_Signal;
    reg Pressure_OK_Signal;
    reg System_Reset;
    wire Master_Start;

    
    SafeStartupSequence UUT (
        .Pump_ON_Signal     (Pump_ON_Signal),
        .Pressure_OK_Signal (Pressure_OK_Signal),
        .System_Reset       (System_Reset),
        .Master_Start       (Master_Start)
    );

    
    initial begin
        
        Pump_ON_Signal      = 1'b0;
        Pressure_OK_Signal  = 1'b0;
        System_Reset        = 1'b1; 

       
        $display("------------------------------------------------------------------------");
        $display("Time | Pump_ON | Pressure_OK | Reset | Master_Start | Scenario");
        $display("------------------------------------------------------------------------");

       
        #10 System_Reset = 1'b0;
        $display("%4dns | %7b | %11b | %5b | %12b | Initial Ready State", $time, Pump_ON_Signal, Pressure_OK_Signal, System_Reset, Master_Start);

        
        #20 Pump_ON_Signal = 1'b1;
        $display("%4dns | %7b | %11b | %5b | %12b | S1: Pump ON", $time, Pump_ON_Signal, Pressure_OK_Signal, System_Reset, Master_Start);
        
        
        #20 Pressure_OK_Signal = 1'b1;
        $display("%4dns | %7b | %11b | %5b | %12b | S1: Pressure OK -> MASTER START HIGH (Correct)", $time, Pump_ON_Signal, Pressure_OK_Signal, System_Reset, Master_Start);
        
        
        #20 Pump_ON_Signal = 1'b0;
        $display("%4dns | %7b | %11b | %5b | %12b | S1: Pump OFF, Master Start holds", $time, Pump_ON_Signal, Pressure_OK_Signal, System_Reset, Master_Start);


       
        #30 System_Reset = 1'b1; 
        Pressure_OK_Signal = 1'b0;
        $display("%4dns | %7b | %11b | %5b | %12b | Reset Applied. Master Start should be LOW", $time, Pump_ON_Signal, Pressure_OK_Signal, System_Reset, Master_Start);
        #10 System_Reset = 1'b0; 
        $display("%4dns | %7b | %11b | %5b | %12b | Ready for Fault Sequence", $time, Pump_ON_Signal, Pressure_OK_Signal, System_Reset, Master_Start);


        
        #20 Pressure_OK_Signal = 1'b1;
        $display("%4dns | %7b | %11b | %5b | %12b | S2: Pressure OK first. Master Start is LOW (Fault Prevented)", $time, Pump_ON_Signal, Pressure_OK_Signal, System_Reset, Master_Start); 
        
        
        #20 Pump_ON_Signal = 1'b1;
        $display("%4dns | %7b | %11b | %5b | %12b | S2: Pump ON. Master Start now goes HIGH", $time, Pump_ON_Signal, Pressure_OK_Signal, System_Reset, Master_Start);
        
        
        #50 $finish;
    end
    
endmodule
