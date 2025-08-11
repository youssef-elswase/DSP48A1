module DSP48A1_tb ();
    parameter A0REG = 0 , A1REG = 1,B0REG = 0 , B1REG = 1;
    parameter CREG = 1 ,DREG = 1,MREG = 1 ,PREG = 1,CARRYINREG = 1 ,CARRYOUTREG = 1,OPMODEREG = 1;
    parameter CARRYINSEL = "OPMODE5" ; // OPMODE5 OR CARRYIN
    parameter B_INPUT = "DIRECT" ; // DIRECT OR CASCADE
    parameter RSTTYPR = "SYNC" ; //ASYNC OR SYNC
    reg [17:0] A,B,D,BCIN;
    reg [47:0] C,PCIN;
    reg [7:0] OPMODE;
    reg CARRYIN,CEA,CEB,CEC,CECARRYIN,CED,CEM,CEOPMODE,CEP,RSTA,RSTB,RSTC,RSTCARRYIN,RSTD,RSTM,RSTOPMODE,RSTP,CLK;
    wire [35:0] M;
    wire [47:0] P,PCOUT;
    wire [17:0] BCOUT;
    wire CARRYOUTF,CARRYOUT;
    

    integer Error_count=0,correct_count=0;
   DSP48A1 #(A0REG,A1REG,B0REG,B1REG,CREG,DREG,MREG,PREG,CARRYINREG,CARRYOUTREG,OPMODEREG,
    CARRYINSEL, // OPMODE5 OR CARRYIN
    B_INPUT,  // DIRECT OR CASCADE
    RSTTYPR //ASYNC OR SYNC
    ) DUT (
    A,B,C,D,BCIN,CARRYIN,M,P,CARRYOUT,CARRYOUTF,CLK,OPMODE,
    CEA,CEB,CEC,CECARRYIN,CED,CEM,CEOPMODE,CEP,
    RSTA,RSTB,RSTC,RSTCARRYIN,RSTD,RSTM,RSTOPMODE,RSTP,
    BCOUT,PCIN,PCOUT);  //  1
    initial begin
        CLK = 0;
        forever begin
        #1    CLK = ~CLK;
        end
    end
                   // 2
    initial begin
        
        RSTA = 1; // 2.1
        RSTB = 1;
        RSTC = 1;
        RSTCARRYIN = 1;
        RSTD = 1;
        RSTM = 1;
        RSTOPMODE = 1;
        RSTP = 1;
        A =$random;
        B =$random; 
        D =$random;
        BCIN =$random;
        C =$random;
        PCIN =$random;
        OPMODE =$random;
        CARRYIN =$random;
        CEA =$random;
        CEB =$random;
        CEC =$random;
        CECARRYIN =$random;
        CED =$random;
        CEM =$random;
        CEOPMODE =$random;
        CEP =$random;
        @(negedge CLK);
        if (M!=0||
        P!=0||
        PCOUT!=0||
        BCOUT!=0||
        CARRYOUTF!=0||
        CARRYOUT!=0) begin
            $display("ERROR, out is incorrect");
        Error_count = Error_count + 1;
        end
        else begin
            correct_count = correct_count + 1;
        end
        $stop;
        RSTA = 0;
        RSTB = 0;
        RSTC = 0;
        RSTCARRYIN = 0;
        RSTD = 0;
        RSTM = 0;
        RSTOPMODE = 0;
        RSTP = 0;
        CEA = 1;
        CEB = 1;
        CEC = 1;
        CECARRYIN = 1;
        CED = 1;
        CEM = 1;
        CEOPMODE = 1;
        CEP = 1;
        $stop;
                      // 2.2
        OPMODE = 8'b11011101;
        A = 20;
        B = 10;
        C = 350;
        D = 25;
        BCIN = $random;
        PCIN = $random;
        CARRYIN = $random;
        repeat(4) @(negedge CLK);
        if (M!='h12c||
        P!='h32||
        PCOUT!='h32||
        BCOUT!='hf||
        CARRYOUTF!=0||
        CARRYOUT!=0) begin
            $display("ERROR, out is incorrect");
            Error_count = Error_count + 1;
        end
        else begin
            correct_count = correct_count + 1;
        end
        $stop;
                     // 2.3
        OPMODE = 8'b00010000;
        A = 20;
        B = 10;
        C = 350;
        D = 25;
        BCIN = $random;
        PCIN = $random;
        CARRYIN = $random;
        repeat(3) @(negedge CLK);
        if (M!='h2bc||
        P!=0||
        PCOUT!=0||
        BCOUT!='h23||
        CARRYOUTF!=0||
        CARRYOUT!=0) begin
            $display("ERROR, out is incorrect");
        Error_count = Error_count + 1;
        end
        else begin
            correct_count = correct_count + 1;
        end
        $stop;
                     // 2.4
        OPMODE = 8'b00001010;
        A = 20;
        B = 10;
        C = 350;
        D = 25;
        BCIN = $random;
        PCIN = $random;
        CARRYIN = $random;
        repeat(3) @(negedge CLK);
        if (M!='hc8||
        P!=0||
        PCOUT!=0||
        BCOUT!='ha||
        CARRYOUTF!=0||
        CARRYOUT!=0) begin
            $display("ERROR, out is incorrect");
        Error_count = Error_count + 1;
        end
        else begin
            correct_count = correct_count + 1;
        end
        $stop;
                     // 2.5
        OPMODE = 8'b10100111;
        A = 5;
        B = 6;
        C = 350;
        D = 25;
        BCIN = $random;
        PCIN = 3000;
        CARRYIN = $random;
        repeat(3) @(negedge CLK);
        if (M!='h1e||
        P!='hfe6fffec0bb1||
        PCOUT!='hfe6fffec0bb1||
        BCOUT!='h6||
        CARRYOUTF!=1||
        CARRYOUT!=1) begin
            $display("ERROR, out is incorrect");
        Error_count = Error_count + 1;
        end
        else begin
            correct_count = correct_count + 1;
        end
        $display("Error_count=%d,correct_count=%d",Error_count,correct_count);
        $stop;
        
    end

    

endmodule