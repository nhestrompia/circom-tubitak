pragma circom 2.0.3;

include "../node_modules/circomlib/circuits/mux1.circom";
include "../node_modules/circomlib/circuits/comparators.circom";


template CheckTotal(){

    signal input in;
    signal output outPlayer;

    component ltPlayer = LessEqThan(8);

    ltPlayer.in[0] <== in;
    ltPlayer.in[1] <== 21;
   
    outPlayer <== ltPlayer.out * in;
}





template Main(){

    signal input sumPlayer;
    signal input sumHouse;
    signal player21Check;
    signal house21Check;
    signal output out;
    signal output draw;
    signal output playerScore;

    component gtResult = GreaterThan(8);
    component eq = IsEqual();

    component mux1 = Mux1();
    component mux1Equal = Mux1();
    component sumPlayerCheck = CheckTotal();
    component sumHouseCheck = CheckTotal();

    sumPlayerCheck.in <== sumPlayer;
    player21Check <== sumPlayerCheck.outPlayer;



    sumHouseCheck.in <== sumHouse;
    house21Check <== sumHouseCheck.outPlayer;


    eq.in[0] <== player21Check;
    eq.in[1] <== house21Check;


    mux1Equal.s <== eq.out;
    mux1Equal.c[0] <== player21Check;
    mux1Equal.c[1] <== 2;


    gtResult.in[0] <== player21Check;
    gtResult.in[1] <== house21Check;


    mux1.s <== gtResult.out;
    mux1.c[0] <== 0;
    mux1.c[1] <== 1;

    

    

    out <== mux1.out;
    draw <== mux1Equal.out;
    playerScore <== player21Check;
    


}

component main = Main();