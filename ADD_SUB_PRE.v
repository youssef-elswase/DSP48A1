module ADD_SUB_PRE(
    in0,in1,out,control
);
    parameter WIDTH = 18;
    input [WIDTH-1:0] in0,in1;
    input control;
    output reg [WIDTH-1:0] out;

    always @(*) begin
        if (control) begin
            out = in0 - in1;
        end
        else begin
            out = in0 + in1;
        end
    end

endmodule