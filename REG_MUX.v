module REG_MUL #(parameter RSTTYPR = "SYNC" , //ASYNC OR SYNC
    WIDTH = 18)(
    XREG,in,out,clk,rst,clk_en
);
    
    input [WIDTH-1:0] in;
    input clk,rst,clk_en,XREG;
    output [WIDTH-1:0] out;
    reg [WIDTH-1:0] out_r;
    generate
        if (RSTTYPR == "SYNC") begin
            always @(posedge clk) begin
                if (rst) begin
                    out_r <= 0;
                end
                else begin
                    if (clk_en) begin
                        out_r <= in;
                    end                    
                end
            end
            assign out = (XREG) ? out_r : in;
        end
        else if (RSTTYPR == "ASYNC") begin
            always @(posedge clk or posedge rst) begin
                if (rst) begin
                    out_r <= 0;
                end
                else begin
                    if (clk_en) begin
                        out_r <= in;
                    end                    
                end
            end
            assign out = (XREG) ? out_r : in; 
        end
    endgenerate
endmodule