package com.fh.util.redis;

import com.fh.util.PageData;

import java.util.Map;

public class JiSuan {

    public static PageData save(PageData pd){

        Double a01=0.0;
        Double a02=0.0;
        Double a03=0.0;
        Double a04=0.0;
        Double a05=0.0;
        Double a06=0.0;
        Double a07=0.0;
        Double a08=0.0;
        Double a09=0.0;
        Double a10=0.0;
        Double a11=0.0;
        Double a12=0.0;
        Double a13=0.0;
        Double a14=0.0;
        Double a15=0.0;
        Double a16=0.0;
        Double a17=0.0;
        Double a18=0.0;
        Double a19=0.0;
        Double a20=0.0;
        Double a21=0.0;
        Double a22=0.0;
        Double a23=0.0;
        Double a24=0.0;
        Double a25=0.0;
        Double a26=0.0;
        Double a27=0.0;
        Double a28=0.0;
        Double a29=0.0;
        Double a30=0.0;
        Double a31=0.0;
        Double a32=0.0;

        Double b01=0.0;
        Double b02=0.0;
        Double b03=0.0;
        Double b04=0.0;
        Double b05=0.0;
        Double b06=0.0;
        Double b07=0.0;
        Double b08=0.0;
        Double b09=0.0;
        Double b11=0.0;
        Double b10=0.0;
        Double b12=0.0;
        Double b13=0.0;
        Double b14=0.0;
        Double b15=0.0;
        Double b16=0.0;
        Double b17=0.0;
        Double b18=0.0;
        Double b19=0.0;
        Double b20=0.0;
        Double b21=0.0;
        Double b22=0.0;
        Double b23=0.0;
        Double b24=0.0;

        Double c01=0.0;
        Double c02=0.0;
        Double c03=0.0;
        Double c04=0.0;
        Double c05=0.0;
        Double c06=0.0;
        Double c07=0.0;
        Double c08=0.0;
        Double c09=0.0;
        Double c10=0.0;
        Double c11=0.0;
        Double c12=0.0;
        Double c13=0.0;
        Double c14=0.0;
        Double c15=0.0;
        Double c16=0.0;
        Double c17=0.0;
        Double c18=0.0;
        Double c19=0.0;
        Double c20=0.0;
        Double c21=0.0;
        Double c22=0.0;
        Double c23=0.0;
        Double c24=0.0;
        Double c25=0.0;
        Double c26=0.0;
        Double c27=0.0;
        Double c28=0.0;
        Double c29=0.0;
        Double c30=0.0;
        Double c31=0.0;

        Double d01=0.0;
        Double d02=0.0;
        Double d03=0.0;
        Double d04=0.0;
        Double d05=0.0;
        Double d06=0.0;
        Double d07=0.0;
        Double d08=0.0;
        Double d09=0.0;
        Double d10=0.0;
        Double d11=0.0;
        Double d12=0.0;
        Double d13=0.0;
        Double d14=0.0;
        Double d15=0.0;
        Double d16=0.0;
        Double d17=0.0;
        Double d18=0.0;
        Double d19=0.0;
        Double d20=0.0;

        Double e01=0.0;
        Double e02=0.0;
        Double e03=0.0;
        Double e04=0.0;
        Double e05=0.0;
        Double e06=0.0;
        Double e07=0.0;
        Double e08=0.0;
        Double e09=0.0;
        Double e10=0.0;
        Double e11=0.0;
        Double e12=0.0;
        Double e13=0.0;
        Double e14=0.0;
        Double e15=0.0;
        Double e16=0.0;
        Double e17=0.0;
        Double e18=0.0;
        Double e19=0.0;
        Double e20=0.0;
        Double e21=0.0;
        Double e22=0.0;
        Double e23=0.0;
        Double e24=0.0;
        Double e25=0.0;
        Double e26=0.0;
        Double e27=0.0;

        Double f01=0.0;
        Double f02=0.0;
        Double f03=0.0;
        Double f04=0.0;
        Double f05=0.0;
        Double f06=0.0;
        Double f07=0.0;
        Double f08=0.0;
        Double f09=0.0;
        Double f10=0.0;
        Double f11=0.0;
        Double f12=0.0;
        Double f13=0.0;
        Double f14=0.0;
        Double f15=0.0;
        Double f16=0.0;
        Double f17=0.0;
        Double f18=0.0;
        Double f19=0.0;
        Double f20=0.0;
        Double f21=0.0;
        Double f22=0.0;
        Double f23=0.0;
        Double f24=0.0;
        Double f25=0.0;
        Double f26=0.0;
        Double f27=0.0;

        Double g01=0.0;
        Double g02=0.0;
        Double g03=0.0;
        Double g04=0.0;
        Double g05=0.0;
        Double g06=0.0;
        Double g07=0.0;
        Double g08=0.0;
        Double g09=0.0;
        Double g10=0.0;
        Double g11=0.0;
        Double g12=0.0;
        Double g13=0.0;
        Double g14=0.0;
        Double g15=0.0;
        Double g16=0.0;
        Double g17=0.0;
        Double g18=0.0;
        Double g19=0.0;
        Double g20=0.0;

        Double h01=0.0;

        Double qscore=100.0;

        if(!pd.get("a01").equals("")){
            a01=Double.valueOf(pd.get("a01").toString());
        }
        if(!pd.get("a02").equals("")){
            a02=Double.valueOf(pd.get("a02").toString());
        }
        if(!pd.get("a03").equals("")){
            a03=Double.valueOf(pd.get("a03").toString());
        }
        if(!pd.get("a04").equals("")){
            a04=Double.valueOf(pd.get("a04").toString());
        }
        if(!pd.get("a05").equals("")){
            a05=Double.valueOf(pd.get("a05").toString());
        }
        if(!pd.get("a06").equals("")){
            a06=Double.valueOf(pd.get("a06").toString());
        }
        if(!pd.get("a07").equals("")){
            a07=Double.valueOf(pd.get("a07").toString());
        }
        if(!pd.get("a08").equals("")){
            a08=Double.valueOf(pd.get("a08").toString());
        }
        if(!pd.get("a09").equals("")){
            a09=Double.valueOf(pd.get("a09").toString());
        }
        if(!pd.get("a10").equals("")){
            a10=Double.valueOf(pd.get("a10").toString());
        }
        if(!pd.get("a11").equals("")){
            a11=Double.valueOf(pd.get("a11").toString());
        }
        if(!pd.get("a12").equals("")){
            a12=Double.valueOf(pd.get("a12").toString());
        }
        if(!pd.get("a13").equals("")){
            a13=Double.valueOf(pd.get("a13").toString());
        }
        if(!pd.get("a14").equals("")){
            a14=Double.valueOf(pd.get("a14").toString());
        }
        if(!pd.get("a15").equals("")){
            a15=Double.valueOf(pd.get("a15").toString());
        }
        if(!pd.get("a16").equals("")){
            a16=Double.valueOf(pd.get("a16").toString());
        }
        if(!pd.get("a17").equals("")){
            a17=Double.valueOf(pd.get("a17").toString());
        }
        if(!pd.get("a18").equals("")){
            a18=Double.valueOf(pd.get("a18").toString());
        }
        if(!pd.get("a19").equals("")){
            a19=Double.valueOf(pd.get("a19").toString());
        }
        if(!pd.get("a20").equals("")){
            a20=Double.valueOf(pd.get("a20").toString());
        }
        if(!pd.get("a21").equals("")){
            a21=Double.valueOf(pd.get("a21").toString());
        }
        if(!pd.get("a22").equals("")){
            a22=Double.valueOf(pd.get("a22").toString());
        }
        if(!pd.get("a23").equals("")){
            a23=Double.valueOf(pd.get("a23").toString());
        }
        if(!pd.get("a24").equals("")){
            a24=Double.valueOf(pd.get("a24").toString());
        }
        if(!pd.get("a25").equals("")){
            a25=Double.valueOf(pd.get("a25").toString());
        }
        if(!pd.get("a26").equals("")){
            a26=Double.valueOf(pd.get("a26").toString());
        }
        if(!pd.get("a27").equals("")){
            a27=Double.valueOf(pd.get("a27").toString());
        }
        if(!pd.get("a28").equals("")){
            a28=Double.valueOf(pd.get("a28").toString());
        }
        if(!pd.get("a29").equals("")){
            a29=Double.valueOf(pd.get("a29").toString());
        }
        if(!pd.get("a30").equals("")){
            a30=Double.valueOf(pd.get("a30").toString());
        }
        if(!pd.get("a31").equals("")){
            a31=Double.valueOf(pd.get("a31").toString());
        }
        if(!pd.get("a32").equals("")){
            a32=Double.valueOf(pd.get("a32").toString());
        }


        if(!pd.get("b01").equals("")){
            b01=Double.valueOf(pd.get("b01").toString());
        }
        if(!pd.get("b02").equals("")){
            b02=Double.valueOf(pd.get("b02").toString());
        }
        if(!pd.get("b03").equals("")){
            b03=Double.valueOf(pd.get("b03").toString());
        }
        if(!pd.get("b04").equals("")){
            b04=Double.valueOf(pd.get("b04").toString());
        }
        if(!pd.get("b05").equals("")){
            b05=Double.valueOf(pd.get("b05").toString());
        }
        if(!pd.get("b06").equals("")){
            b06=Double.valueOf(pd.get("b06").toString());
        }
        if(!pd.get("b07").equals("")){
            b07=Double.valueOf(pd.get("b07").toString());
        }
        if(!pd.get("b08").equals("")){
            b08=Double.valueOf(pd.get("b08").toString());
        }
        if(!pd.get("b09").equals("")){
            b09=Double.valueOf(pd.get("b09").toString());
        }
        if(!pd.get("b10").equals("")){
            b10=Double.valueOf(pd.get("b10").toString());
        }
        if(!pd.get("b11").equals("")){
            b11=Double.valueOf(pd.get("b11").toString());
        }
        if(!pd.get("b12").equals("")){
            b12=Double.valueOf(pd.get("b12").toString());
        }
        if(!pd.get("b13").equals("")){
            b13=Double.valueOf(pd.get("b13").toString());
        }
        if(!pd.get("b14").equals("")){
            b14=Double.valueOf(pd.get("b14").toString());
        }
        if(!pd.get("b15").equals("")){
            b15=Double.valueOf(pd.get("b15").toString());
        }
        if(!pd.get("b16").equals("")){
            b16=Double.valueOf(pd.get("b16").toString());
        }
        if(!pd.get("b17").equals("")){
            b17=Double.valueOf(pd.get("b17").toString());
        }
        if(!pd.get("b18").equals("")){
            b18=Double.valueOf(pd.get("b18").toString());
        }
        if(!pd.get("b19").equals("")){
            b19=Double.valueOf(pd.get("b19").toString());
        }
        if(!pd.get("b20").equals("")){
            b20=Double.valueOf(pd.get("b20").toString());
        }
        if(!pd.get("b21").equals("")){
            b21=Double.valueOf(pd.get("b21").toString());
        }
        if(!pd.get("b22").equals("")){
            b22=Double.valueOf(pd.get("b22").toString());
        }
        if(!pd.get("b23").equals("")){
            b23=Double.valueOf(pd.get("b23").toString());
        }
        if(!pd.get("b24").equals("")){
            b24=Double.valueOf(pd.get("b24").toString());
        }


        if(!pd.get("c01").equals("")){
            c01=Double.valueOf(pd.get("c01").toString());
        }
        if(!pd.get("c02").equals("")){
            c02=Double.valueOf(pd.get("c02").toString());
        }
        if(!pd.get("c03").equals("")){
            c03=Double.valueOf(pd.get("c03").toString());
        }
        if(!pd.get("c04").equals("")){
            c04=Double.valueOf(pd.get("c04").toString());
        }
        if(!pd.get("c05").equals("")){
            c05=Double.valueOf(pd.get("c05").toString());
        }
        if(!pd.get("c06").equals("")){
            c06=Double.valueOf(pd.get("c06").toString());
        }
        if(!pd.get("c07").equals("")){
            c07=Double.valueOf(pd.get("c07").toString());
        }
        if(!pd.get("c08").equals("")){
            c08=Double.valueOf(pd.get("c08").toString());
        }
        if(!pd.get("c09").equals("")){
            c09=Double.valueOf(pd.get("c09").toString());
        }
        if(!pd.get("c10").equals("")){
            c10=Double.valueOf(pd.get("c10").toString());
        }
        if(!pd.get("c11").equals("")){
            c11=Double.valueOf(pd.get("c11").toString());
        }
        if(!pd.get("c12").equals("")){
            c12=Double.valueOf(pd.get("c12").toString());
        }
        if(!pd.get("c13").equals("")){
            c13=Double.valueOf(pd.get("c13").toString());
        }
        if(!pd.get("c14").equals("")){
            c14=Double.valueOf(pd.get("c14").toString());
        }
        if(!pd.get("c15").equals("")){
            c15=Double.valueOf(pd.get("c15").toString());
        }
        if(!pd.get("c16").equals("")){
            c16=Double.valueOf(pd.get("c16").toString());
        }
        if(!pd.get("c17").equals("")){
            c17=Double.valueOf(pd.get("c17").toString());
        }
        if(!pd.get("c18").equals("")){
            c18=Double.valueOf(pd.get("c18").toString());
        }
        if(!pd.get("c19").equals("")){
            c19=Double.valueOf(pd.get("c19").toString());
        }
        if(!pd.get("c20").equals("")){
            c20=Double.valueOf(pd.get("c20").toString());
        }
        if(!pd.get("c21").equals("")){
            c21=Double.valueOf(pd.get("c21").toString());
        }
        if(!pd.get("c22").equals("")){
            c22=Double.valueOf(pd.get("c22").toString());
        }
        if(!pd.get("c23").equals("")){
            c23=Double.valueOf(pd.get("c23").toString());
        }
        if(!pd.get("c24").equals("")){
            c24=Double.valueOf(pd.get("c24").toString());
        }
        if(!pd.get("c25").equals("")){
            c25=Double.valueOf(pd.get("c25").toString());
        }
        if(!pd.get("c26").equals("")){
            c26=Double.valueOf(pd.get("c26").toString());
        }
        if(!pd.get("c27").equals("")){
            c27=Double.valueOf(pd.get("c27").toString());
        }
        if(!pd.get("c28").equals("")){
            c28=Double.valueOf(pd.get("c28").toString());
        }
        if(!pd.get("c29").equals("")){
            c29=Double.valueOf(pd.get("c29").toString());
        }
        if(!pd.get("c30").equals("")){
            c30=Double.valueOf(pd.get("c30").toString());
        }
        if(!pd.get("c31").equals("")){
            c31=Double.valueOf(pd.get("c31").toString());
        }


        if(!pd.get("d01").equals("")){
            d01=Double.valueOf(pd.get("d01").toString());
        }
        if(!pd.get("d02").equals("")){
            d02=Double.valueOf(pd.get("d02").toString());
        }
        if(!pd.get("d03").equals("")){
            d03=Double.valueOf(pd.get("d03").toString());
        }
        if(!pd.get("d04").equals("")){
            d04=Double.valueOf(pd.get("d04").toString());
        }
        if(!pd.get("d05").equals("")){
            d05=Double.valueOf(pd.get("d05").toString());
        }
        if(!pd.get("d06").equals("")){
            d06=Double.valueOf(pd.get("d06").toString());
        }
        if(!pd.get("d07").equals("")){
            d07=Double.valueOf(pd.get("d07").toString());
        }
        if(!pd.get("d08").equals("")){
            d08=Double.valueOf(pd.get("d08").toString());
        }
        if(!pd.get("d09").equals("")){
            d09=Double.valueOf(pd.get("d09").toString());
        }
        if(!pd.get("d10").equals("")){
            d10=Double.valueOf(pd.get("d10").toString());
        }
        if(!pd.get("d11").equals("")){
            d11=Double.valueOf(pd.get("d11").toString());
        }
        if(!pd.get("d12").equals("")){
            d12=Double.valueOf(pd.get("d12").toString());
        }
        if(!pd.get("d13").equals("")){
            d13=Double.valueOf(pd.get("d13").toString());
        }
        if(!pd.get("d14").equals("")){
            d14=Double.valueOf(pd.get("d14").toString());
        }
        if(!pd.get("d15").equals("")){
            d15=Double.valueOf(pd.get("d15").toString());
        }
        if(!pd.get("d16").equals("")){
            d16=Double.valueOf(pd.get("d16").toString());
        }
        if(!pd.get("d17").equals("")){
            d17=Double.valueOf(pd.get("d17").toString());
        }
        if(!pd.get("d18").equals("")){
            d18=Double.valueOf(pd.get("d18").toString());
        }
        if(!pd.get("d19").equals("")){
            d19=Double.valueOf(pd.get("d19").toString());
        }
        if(!pd.get("d20").equals("")){
            d20=Double.valueOf(pd.get("d20").toString());
        }


        if(!pd.get("e01").equals("")){
            e01=Double.valueOf(pd.get("e01").toString());
        }
        if(!pd.get("e02").equals("")){
            e02=Double.valueOf(pd.get("e02").toString());
        }
        if(!pd.get("e03").equals("")){
            e03=Double.valueOf(pd.get("e03").toString());
        }
        if(!pd.get("e04").equals("")){
            e04=Double.valueOf(pd.get("e04").toString());
        }
        if(!pd.get("e05").equals("")){
            e05=Double.valueOf(pd.get("e05").toString());
        }
        if(!pd.get("e06").equals("")){
            e06=Double.valueOf(pd.get("e06").toString());
        }
        if(!pd.get("e07").equals("")){
            e07=Double.valueOf(pd.get("e07").toString());
        }
        if(!pd.get("e08").equals("")){
            e08=Double.valueOf(pd.get("e08").toString());
        }
        if(!pd.get("e09").equals("")){
            e09=Double.valueOf(pd.get("e09").toString());
        }
        if(!pd.get("e10").equals("")){
            e10=Double.valueOf(pd.get("e10").toString());
        }
        if(!pd.get("e11").equals("")){
            e11=Double.valueOf(pd.get("e11").toString());
        }
        if(!pd.get("e12").equals("")){
            e12=Double.valueOf(pd.get("e12").toString());
        }
        if(!pd.get("e13").equals("")){
            e13=Double.valueOf(pd.get("e13").toString());
        }
        if(!pd.get("e14").equals("")){
            e14=Double.valueOf(pd.get("e14").toString());
        }
        if(!pd.get("e15").equals("")){
            e15=Double.valueOf(pd.get("e15").toString());
        }
        if(!pd.get("e16").equals("")){
            e16=Double.valueOf(pd.get("e16").toString());
        }
        if(!pd.get("e17").equals("")){
            e17=Double.valueOf(pd.get("e17").toString());
        }
        if(!pd.get("e18").equals("")){
            e18=Double.valueOf(pd.get("e18").toString());
        }
        if(!pd.get("e19").equals("")){
            e19=Double.valueOf(pd.get("e19").toString());
        }
        if(!pd.get("e20").equals("")){
            e20=Double.valueOf(pd.get("e20").toString());
        }
        if(!pd.get("e21").equals("")){
            e21=Double.valueOf(pd.get("e21").toString());
        }
        if(!pd.get("e22").equals("")){
            e22=Double.valueOf(pd.get("e22").toString());
        }
        if(!pd.get("e23").equals("")){
            e23=Double.valueOf(pd.get("e23").toString());
        }
        if(!pd.get("e24").equals("")){
            e24=Double.valueOf(pd.get("e24").toString());
        }
        if(!pd.get("e25").equals("")){
            e25=Double.valueOf(pd.get("e25").toString());
        }
        if(!pd.get("e26").equals("")){
            e26=Double.valueOf(pd.get("e26").toString());
        }
        if(!pd.get("e27").equals("")){
            e27=Double.valueOf(pd.get("e27").toString());
        }

        if(!pd.get("f01").equals("")){
            f01=Double.valueOf(pd.get("f01").toString());
        }
        if(!pd.get("f02").equals("")){
            f02=Double.valueOf(pd.get("f02").toString());
        }
        if(!pd.get("f03").equals("")){
            f03=Double.valueOf(pd.get("f03").toString());
        }
        if(!pd.get("f04").equals("")){
            f04=Double.valueOf(pd.get("f04").toString());
        }
        if(!pd.get("f05").equals("")){
            f05=Double.valueOf(pd.get("f05").toString());
        }
        if(!pd.get("f06").equals("")){
            f06=Double.valueOf(pd.get("f06").toString());
        }
        if(!pd.get("f07").equals("")){
            f07=Double.valueOf(pd.get("f07").toString());
        }
        if(!pd.get("f08").equals("")){
            f08=Double.valueOf(pd.get("f08").toString());
        }
        if(!pd.get("f09").equals("")){
            f09=Double.valueOf(pd.get("f09").toString());
        }
        if(!pd.get("f10").equals("")){
            f10=Double.valueOf(pd.get("f10").toString());
        }
        if(!pd.get("f11").equals("")){
            f11=Double.valueOf(pd.get("f11").toString());
        }
        if(!pd.get("f12").equals("")){
            f12=Double.valueOf(pd.get("f12").toString());
        }
        if(!pd.get("f13").equals("")){
            f13=Double.valueOf(pd.get("f13").toString());
        }
        if(!pd.get("f14").equals("")){
            f14=Double.valueOf(pd.get("f14").toString());
        }
        if(!pd.get("f15").equals("")){
            f15=Double.valueOf(pd.get("f15").toString());
        }
        if(!pd.get("f16").equals("")){
            f16=Double.valueOf(pd.get("f16").toString());
        }
        if(!pd.get("f17").equals("")){
            f17=Double.valueOf(pd.get("f17").toString());
        }
        if(!pd.get("f18").equals("")){
            f18=Double.valueOf(pd.get("f18").toString());
        }
        if(!pd.get("f19").equals("")){
            f19=Double.valueOf(pd.get("f19").toString());
        }
        if(!pd.get("f20").equals("")){
            f20=Double.valueOf(pd.get("f20").toString());
        }
        if(!pd.get("f21").equals("")){
            f21=Double.valueOf(pd.get("f21").toString());
        }
        if(!pd.get("f22").equals("")){
            f22=Double.valueOf(pd.get("f22").toString());
        }
        if(!pd.get("f23").equals("")){
            f23=Double.valueOf(pd.get("f23").toString());
        }


        if(!pd.get("g01").equals("")){
            g01=Double.valueOf(pd.get("g01").toString());
        }
        if(!pd.get("g02").equals("")){
            g02=Double.valueOf(pd.get("g02").toString());
        }
        if(!pd.get("g03").equals("")){
            g03=Double.valueOf(pd.get("g03").toString());
        }
        if(!pd.get("g04").equals("")){
            g04=Double.valueOf(pd.get("g04").toString());
        }
        if(!pd.get("g05").equals("")){
            g05=Double.valueOf(pd.get("g05").toString());
        }
        if(!pd.get("g06").equals("")){
            g06=Double.valueOf(pd.get("g06").toString());
        }
        if(!pd.get("g07").equals("")){
            g07=Double.valueOf(pd.get("g07").toString());
        }
        if(!pd.get("g08").equals("")){
            g08=Double.valueOf(pd.get("g08").toString());
        }
        if(!pd.get("g09").equals("")){
            g09=Double.valueOf(pd.get("g09").toString());
        }
        if(!pd.get("g10").equals("")){
            g10=Double.valueOf(pd.get("g10").toString());
        }
        if(!pd.get("g11").equals("")){
            g11=Double.valueOf(pd.get("g11").toString());
        }
        if(!pd.get("g12").equals("")){
            g12=Double.valueOf(pd.get("g12").toString());
        }
        if(!pd.get("g13").equals("")){
            g13=Double.valueOf(pd.get("g13").toString());
        }
        if(!pd.get("g14").equals("")){
            g14=Double.valueOf(pd.get("g14").toString());
        }
        if(!pd.get("g15").equals("")){
            g15=Double.valueOf(pd.get("g15").toString());
        }
        if(!pd.get("g16").equals("")){
            g16=Double.valueOf(pd.get("g16").toString());
        }
        if(!pd.get("g17").equals("")){
            g17=Double.valueOf(pd.get("g17").toString());
        }
        if(!pd.get("g18").equals("")){
            g18=Double.valueOf(pd.get("g18").toString());
        }
        if(!pd.get("g19").equals("")){
            g19=Double.valueOf(pd.get("g19").toString());
        }
        if(!pd.get("g20").equals("")){
            g20=Double.valueOf(pd.get("g20").toString());
        }


//        if(!pd.get("h01").equals("")){
//            h01=Double.valueOf(pd.get("h01").toString());
//        }
        Double af=a01+a02+a03+a04+a05+a06+a07+a08+a09
                +a10+a11+a12+a13+a14+a15+a16+a17+a18+a19
                +a20+a21+a22+a23+a24+a25+a26+a27+a28+a29+a30+a31+a32;
        Double bf=b01+b02+b03+b04+b05+b06+b07+b08+b09
                +b10+b11+b12+b13+b14+b15+b16+b17+b18+b19
                +b20+b21+b22+b23+b24;
        Double cf=c01+c02+c03+c04+c05+c06+c07+c08+c09
                +c10+c11+c12+c13+c14+c15+c16+c17+c18+c19
                +c20+c21+c22+c23+c24+c25+c26+c27+c28+c29+c30+c31;
        Double df=d01+d02+d03+d04+d05+d06+d07+d08+d09
                +d10+d11+d12+d13+d14+d15+d16+d17+d18+d19+d20;

        Double ef=e01+e02+e03+e04+e05+e06+e07+e08+e09
                +e10+e11+e12+e13+e14+e15+e16+e17+e18+e19
                +e20+e21+e22+e23+e24+e25+e26+e27;
        Double ff=f01+f02+f03+f04+f05+f06+f07+f08+f09
                +f10+f11+f12+f13+f14+f15+f16+f17+f18+f19
                +f20+f21+f22+f23;
        Double gf=g01+g02+g03+g04+g05+g06+g07+g08+g09
                +g10+g11+g12+g13+g14+g15+g16+g17+g18+g19+g20;


        qscore=qscore
                -a01-a02-a03-a04-a05-a06-a07-a08-a09
                -a10-a11-a12-a13-a14-a15-a16-a17-a18-a19
                -a20-a21-a22-a23-a24-a25-a26-a27-a28-a29-a30-a31-a32
                -b01-b02-b03-b04-b05-b06-b07-b08-b09
                -b10-b11-b12-b13-b14-b15-b16-b17-b18-b19
                -b20-b21-b22-b23-b24
                -c01-c02-c03-c04-c05-c06-c07-c08-c09
                -c10-c11-c12-c13-c14-c15-c16-c17-c18-c19
                -c20-c21-c22-c23-c24-c25-c26-c27-c28-c29-c30-c31
                -d01-d02-d03-d04-d05-d06-d07-d08-d09
                -d10-d11-d12-d13-d14-d15-d16-d17-d18-d19-d20
                -e01-e02-e03-e04-e05-e06-e07-e08-e09
                -e10-e11-e12-e13-e14-e15-e16-e17-e18-e19
                -e20-e21-e22-e23-e24-e25-e26-e27
                -f01-f02-f03-f04-f05-f06-f07-f08-f09
                -f10-f11-f12-f13-f14-f15-f16-f17-f18-f19
                -f20-f21-f22-f23
                -g01-g02-g03-g04-g05-g06-g07-g08-g09
                -g10-g11-g12-g13-g14-g15-g16-g17-g18-g19-g20
                -h01;
        pd.put("qscore",qscore);
        pd.put("af",af);
        pd.put("bf",bf);
        pd.put("cf",cf);
        pd.put("df",df);
        pd.put("ef",ef);
        pd.put("ff",ff);
        pd.put("gf",gf);

        return  pd;
    }


}
