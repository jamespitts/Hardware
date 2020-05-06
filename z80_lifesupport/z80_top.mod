MODEL
MODEL_VERSION "v1998.8";
DESIGN "z80_top";

/* port names and type */
INPUT S:PIN43 = clk;
INPUT S:PIN30 = z80_rd;
INPUT S:PIN31 = z80_mreq;
INPUT S:PIN29 = z80_m1;
INPUT S:PIN33 = reset;
TRIOUT S:PIN32 = z80_wait;
OUTPUT S:PIN7 = w25q_cs;
OUTPUT S:PIN6 = w25q_do;
OUTPUT S:PIN2 = w25q_di;
OUTPUT S:PIN3 = w25q_clk;

/* timing arc definitions */
reset_w25q_cs_delay: DELAY reset w25q_cs;
clk_z80_wait_delay: DELAY (ENABLE_HIGH) clk z80_wait;

/* timing check arc definitions */
z80_m1_clk_setup: SETUP(POSEDGE) z80_m1 clk;
z80_mreq_clk_setup: SETUP(POSEDGE) z80_mreq clk;
z80_rd_clk_setup: SETUP(POSEDGE) z80_rd clk;
z80_m1_clk_hold: HOLD(POSEDGE) z80_m1 clk;
z80_mreq_clk_hold: HOLD(POSEDGE) z80_mreq clk;
z80_rd_clk_hold: HOLD(POSEDGE) z80_rd clk;

ENDMODEL
