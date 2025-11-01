//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/26/2025 11:18:15 PM
// Design Name: 
// Module Name: de-proj-t2
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
module SafeStartupSequence (
    input wire Pump_ON_Signal,    
    input wire Pressure_OK_Signal, 
    input wire System_Reset,     
    output reg Master_Start      
);

    
    reg Pump_Sequence_Met;

    
    always @(posedge Pump_ON_Signal or posedge System_Reset) begin
        if (System_Reset) begin
            
            Pump_Sequence_Met <= 1'b0;
        end else if (Pump_ON_Signal) begin
           
            Pump_Sequence_Met <= 1'b1;
        end
    end

   
    always @(*) begin
        if (Pump_Sequence_Met & Pressure_OK_Signal) begin
            Master_Start = 1'b1;
        end else begin
            Master_Start = 1'b0;
        end
end

endmodule
