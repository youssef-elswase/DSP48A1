module ADD_SUB_POST(
    in0,in1,out,control,cin,cout
);
    parameter WIDTH = 48;
    input [WIDTH-1:0] in0,in1;
    input control,cin;
    output reg [WIDTH-1:0] out;
    output reg cout ;

    always @(*) begin
        if (control) begin
            {cout,out} = (in1-(in0+cin));
        end
        else begin
            {cout,out} = in0 + in1 + cin;
        end
    end

endmodule