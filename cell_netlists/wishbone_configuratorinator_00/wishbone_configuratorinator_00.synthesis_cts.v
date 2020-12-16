module wishbone_configuratorinator_00 (cen,
    wb_clk_i,
    wb_rst_i,
    wbs_ack_o,
    wbs_cyc_i,
    wbs_stb_i,
    wbs_we_i,
    VPWR,
    VGND,
    set_out,
    shift_out,
    wbs_addr_i,
    wbs_data_i,
    wbs_data_o,
    wbs_sel_i);
 output cen;
 input wb_clk_i;
 input wb_rst_i;
 output wbs_ack_o;
 input wbs_cyc_i;
 input wbs_stb_i;
 input wbs_we_i;
 input VPWR;
 input VGND;
 output [3:0] set_out;
 output [3:0] shift_out;
 input [31:0] wbs_addr_i;
 input [31:0] wbs_data_i;
 output [31:0] wbs_data_o;
 input [3:0] wbs_sel_i;

 sky130_fd_sc_hd__nor2_4 _0620_ (.A(wb_rst_i),
    .B(wbs_ack_o),
    .Y(_0108_));
 sky130_fd_sc_hd__buf_2 _0621_ (.A(_0108_),
    .X(_0109_));
 sky130_fd_sc_hd__buf_2 _0622_ (.A(_0109_),
    .X(_0110_));
 sky130_fd_sc_hd__or4_4 _0623_ (.A(wbs_addr_i[5]),
    .B(wbs_addr_i[4]),
    .C(wbs_addr_i[7]),
    .D(wbs_addr_i[6]),
    .X(_0111_));
 sky130_fd_sc_hd__nand2_4 _0624_ (.A(wbs_cyc_i),
    .B(wbs_stb_i),
    .Y(_0112_));
 sky130_fd_sc_hd__or4_4 _0625_ (.A(\configy.read_transaction_in_progress ),
    .B(wbs_ack_o),
    .C(_0111_),
    .D(_0112_),
    .X(_0113_));
 sky130_fd_sc_hd__or4_4 _0626_ (.A(wbs_addr_i[13]),
    .B(wbs_addr_i[12]),
    .C(wbs_addr_i[15]),
    .D(wbs_addr_i[14]),
    .X(_0114_));
 sky130_fd_sc_hd__or4_4 _0627_ (.A(wbs_addr_i[9]),
    .B(wbs_addr_i[8]),
    .C(wbs_addr_i[11]),
    .D(wbs_addr_i[10]),
    .X(_0115_));
 sky130_fd_sc_hd__or2_4 _0628_ (.A(_0114_),
    .B(_0115_),
    .X(_0116_));
 sky130_fd_sc_hd__inv_2 _0629_ (.A(wbs_addr_i[28]),
    .Y(_0117_));
 sky130_fd_sc_hd__or4_4 _0630_ (.A(wbs_addr_i[16]),
    .B(wbs_addr_i[19]),
    .C(wbs_addr_i[21]),
    .D(wbs_addr_i[22]),
    .X(_0118_));
 sky130_fd_sc_hd__or2_4 _0631_ (.A(wbs_addr_i[25]),
    .B(wbs_addr_i[26]),
    .X(_0119_));
 sky130_fd_sc_hd__or4_4 _0632_ (.A(_0117_),
    .B(wbs_addr_i[31]),
    .C(_0118_),
    .D(_0119_),
    .X(_0120_));
 sky130_fd_sc_hd__inv_2 _0633_ (.A(wbs_addr_i[29]),
    .Y(_0121_));
 sky130_fd_sc_hd__or4_4 _0634_ (.A(wbs_addr_i[17]),
    .B(wbs_addr_i[18]),
    .C(wbs_addr_i[20]),
    .D(wbs_addr_i[23]),
    .X(_0122_));
 sky130_fd_sc_hd__or2_4 _0635_ (.A(wbs_addr_i[24]),
    .B(wbs_addr_i[27]),
    .X(_0123_));
 sky130_fd_sc_hd__or4_4 _0636_ (.A(_0121_),
    .B(wbs_addr_i[30]),
    .C(_0122_),
    .D(_0123_),
    .X(_0124_));
 sky130_fd_sc_hd__nor4_4 _0637_ (.A(_0113_),
    .B(_0116_),
    .C(_0120_),
    .D(_0124_),
    .Y(_0125_));
 sky130_fd_sc_hd__buf_2 _0638_ (.A(_0125_),
    .X(_0126_));
 sky130_fd_sc_hd__buf_2 _0639_ (.A(_0126_),
    .X(_0127_));
 sky130_fd_sc_hd__or2_4 _0640_ (.A(wbs_data_o[30]),
    .B(_0127_),
    .X(_0128_));
 sky130_fd_sc_hd__nor3_4 _0641_ (.A(wbs_addr_i[1]),
    .B(wbs_addr_i[0]),
    .C(wbs_addr_i[2]),
    .Y(_0129_));
 sky130_fd_sc_hd__and2_4 _0642_ (.A(wbs_addr_i[3]),
    .B(_0129_),
    .X(_0130_));
 sky130_fd_sc_hd__buf_2 _0643_ (.A(_0130_),
    .X(_0131_));
 sky130_fd_sc_hd__buf_2 _0644_ (.A(_0131_),
    .X(_0132_));
 sky130_fd_sc_hd__buf_2 _0645_ (.A(_0132_),
    .X(_0133_));
 sky130_fd_sc_hd__inv_2 _0646_ (.A(wbs_addr_i[1]),
    .Y(_0134_));
 sky130_fd_sc_hd__inv_2 _0647_ (.A(wbs_addr_i[0]),
    .Y(_0135_));
 sky130_fd_sc_hd__inv_2 _0648_ (.A(wbs_addr_i[3]),
    .Y(_0136_));
 sky130_fd_sc_hd__and4_4 _0649_ (.A(_0134_),
    .B(_0135_),
    .C(_0136_),
    .D(wbs_addr_i[2]),
    .X(_0137_));
 sky130_fd_sc_hd__buf_2 _0650_ (.A(_0137_),
    .X(_0138_));
 sky130_fd_sc_hd__and2_4 _0651_ (.A(\configy.bits_d[6] ),
    .B(_0138_),
    .X(_0139_));
 sky130_fd_sc_hd__or4_4 _0652_ (.A(_0113_),
    .B(_0116_),
    .C(_0120_),
    .D(_0124_),
    .X(_0140_));
 sky130_fd_sc_hd__buf_2 _0653_ (.A(_0140_),
    .X(_0141_));
 sky130_fd_sc_hd__buf_2 _0654_ (.A(_0141_),
    .X(_0142_));
 sky130_fd_sc_hd__buf_2 _0655_ (.A(_0142_),
    .X(_0143_));
 sky130_fd_sc_hd__a211o_4 _0656_ (.A1(\configy.counter_d[6] ),
    .A2(_0133_),
    .B1(_0139_),
    .C1(_0143_),
    .X(_0144_));
 sky130_fd_sc_hd__and3_4 _0657_ (.A(_0110_),
    .B(_0128_),
    .C(_0144_),
    .X(_0106_));
 sky130_fd_sc_hd__or2_4 _0658_ (.A(wbs_data_o[29]),
    .B(_0127_),
    .X(_0145_));
 sky130_fd_sc_hd__buf_2 _0659_ (.A(\configy.counter_d[5] ),
    .X(_0146_));
 sky130_fd_sc_hd__buf_2 _0660_ (.A(_0138_),
    .X(_0147_));
 sky130_fd_sc_hd__and2_4 _0661_ (.A(\configy.bits_d[5] ),
    .B(_0147_),
    .X(_0148_));
 sky130_fd_sc_hd__a211o_4 _0662_ (.A1(_0146_),
    .A2(_0133_),
    .B1(_0143_),
    .C1(_0148_),
    .X(_0149_));
 sky130_fd_sc_hd__and3_4 _0663_ (.A(_0110_),
    .B(_0145_),
    .C(_0149_),
    .X(_0105_));
 sky130_fd_sc_hd__or2_4 _0664_ (.A(wbs_data_o[28]),
    .B(_0127_),
    .X(_0150_));
 sky130_fd_sc_hd__and2_4 _0665_ (.A(\configy.bits_d[4] ),
    .B(_0147_),
    .X(_0151_));
 sky130_fd_sc_hd__a211o_4 _0666_ (.A1(\configy.counter_d[4] ),
    .A2(_0133_),
    .B1(_0143_),
    .C1(_0151_),
    .X(_0152_));
 sky130_fd_sc_hd__and3_4 _0667_ (.A(_0110_),
    .B(_0150_),
    .C(_0152_),
    .X(_0104_));
 sky130_fd_sc_hd__or2_4 _0668_ (.A(wbs_data_o[27]),
    .B(_0127_),
    .X(_0153_));
 sky130_fd_sc_hd__and2_4 _0669_ (.A(\configy.bits_d[3] ),
    .B(_0147_),
    .X(_0154_));
 sky130_fd_sc_hd__a211o_4 _0670_ (.A1(\configy.counter_d[3] ),
    .A2(_0133_),
    .B1(_0143_),
    .C1(_0154_),
    .X(_0155_));
 sky130_fd_sc_hd__and3_4 _0671_ (.A(_0110_),
    .B(_0153_),
    .C(_0155_),
    .X(_0103_));
 sky130_fd_sc_hd__or2_4 _0672_ (.A(wbs_data_o[26]),
    .B(_0127_),
    .X(_0156_));
 sky130_fd_sc_hd__and2_4 _0673_ (.A(\configy.bits_d[2] ),
    .B(_0147_),
    .X(_0157_));
 sky130_fd_sc_hd__a211o_4 _0674_ (.A1(\configy.counter_d[2] ),
    .A2(_0133_),
    .B1(_0143_),
    .C1(_0157_),
    .X(_0158_));
 sky130_fd_sc_hd__and3_4 _0675_ (.A(_0110_),
    .B(_0156_),
    .C(_0158_),
    .X(_0102_));
 sky130_fd_sc_hd__buf_2 _0676_ (.A(_0109_),
    .X(_0159_));
 sky130_fd_sc_hd__buf_2 _0677_ (.A(_0125_),
    .X(_0160_));
 sky130_fd_sc_hd__buf_2 _0678_ (.A(_0160_),
    .X(_0161_));
 sky130_fd_sc_hd__or2_4 _0679_ (.A(wbs_data_o[25]),
    .B(_0161_),
    .X(_0162_));
 sky130_fd_sc_hd__buf_2 _0680_ (.A(\configy.counter_d[1] ),
    .X(_0163_));
 sky130_fd_sc_hd__buf_2 _0681_ (.A(_0132_),
    .X(_0164_));
 sky130_fd_sc_hd__buf_2 _0682_ (.A(_0142_),
    .X(_0165_));
 sky130_fd_sc_hd__and2_4 _0683_ (.A(\configy.bits_d[1] ),
    .B(_0147_),
    .X(_0166_));
 sky130_fd_sc_hd__a211o_4 _0684_ (.A1(_0163_),
    .A2(_0164_),
    .B1(_0165_),
    .C1(_0166_),
    .X(_0167_));
 sky130_fd_sc_hd__and3_4 _0685_ (.A(_0159_),
    .B(_0162_),
    .C(_0167_),
    .X(_0101_));
 sky130_fd_sc_hd__or2_4 _0686_ (.A(wbs_data_o[24]),
    .B(_0161_),
    .X(_0168_));
 sky130_fd_sc_hd__buf_2 _0687_ (.A(\configy.counter_d[0] ),
    .X(_0169_));
 sky130_fd_sc_hd__buf_2 _0688_ (.A(_0138_),
    .X(_0170_));
 sky130_fd_sc_hd__and2_4 _0689_ (.A(\configy.bits_d[0] ),
    .B(_0170_),
    .X(_0171_));
 sky130_fd_sc_hd__a211o_4 _0690_ (.A1(_0169_),
    .A2(_0164_),
    .B1(_0165_),
    .C1(_0171_),
    .X(_0172_));
 sky130_fd_sc_hd__and3_4 _0691_ (.A(_0159_),
    .B(_0168_),
    .C(_0172_),
    .X(_0100_));
 sky130_fd_sc_hd__or2_4 _0692_ (.A(wbs_data_o[23]),
    .B(_0161_),
    .X(_0173_));
 sky130_fd_sc_hd__and2_4 _0693_ (.A(\configy.bits_c[7] ),
    .B(_0170_),
    .X(_0174_));
 sky130_fd_sc_hd__a211o_4 _0694_ (.A1(\configy.counter_c[7] ),
    .A2(_0164_),
    .B1(_0165_),
    .C1(_0174_),
    .X(_0175_));
 sky130_fd_sc_hd__and3_4 _0695_ (.A(_0159_),
    .B(_0173_),
    .C(_0175_),
    .X(_0099_));
 sky130_fd_sc_hd__or2_4 _0696_ (.A(wbs_data_o[22]),
    .B(_0161_),
    .X(_0176_));
 sky130_fd_sc_hd__and2_4 _0697_ (.A(\configy.bits_c[6] ),
    .B(_0170_),
    .X(_0177_));
 sky130_fd_sc_hd__a211o_4 _0698_ (.A1(\configy.counter_c[6] ),
    .A2(_0164_),
    .B1(_0165_),
    .C1(_0177_),
    .X(_0178_));
 sky130_fd_sc_hd__and3_4 _0699_ (.A(_0159_),
    .B(_0176_),
    .C(_0178_),
    .X(_0098_));
 sky130_fd_sc_hd__or2_4 _0700_ (.A(wbs_data_o[21]),
    .B(_0161_),
    .X(_0179_));
 sky130_fd_sc_hd__buf_2 _0701_ (.A(\configy.counter_c[5] ),
    .X(_0180_));
 sky130_fd_sc_hd__and2_4 _0702_ (.A(\configy.bits_c[5] ),
    .B(_0170_),
    .X(_0181_));
 sky130_fd_sc_hd__a211o_4 _0703_ (.A1(_0180_),
    .A2(_0164_),
    .B1(_0165_),
    .C1(_0181_),
    .X(_0182_));
 sky130_fd_sc_hd__and3_4 _0704_ (.A(_0159_),
    .B(_0179_),
    .C(_0182_),
    .X(_0097_));
 sky130_fd_sc_hd__buf_2 _0705_ (.A(_0108_),
    .X(_0183_));
 sky130_fd_sc_hd__buf_2 _0706_ (.A(_0160_),
    .X(_0184_));
 sky130_fd_sc_hd__or2_4 _0707_ (.A(wbs_data_o[20]),
    .B(_0184_),
    .X(_0185_));
 sky130_fd_sc_hd__buf_2 _0708_ (.A(_0132_),
    .X(_0186_));
 sky130_fd_sc_hd__buf_2 _0709_ (.A(_0142_),
    .X(_0187_));
 sky130_fd_sc_hd__and2_4 _0710_ (.A(\configy.bits_c[4] ),
    .B(_0170_),
    .X(_0188_));
 sky130_fd_sc_hd__a211o_4 _0711_ (.A1(\configy.counter_c[4] ),
    .A2(_0186_),
    .B1(_0187_),
    .C1(_0188_),
    .X(_0189_));
 sky130_fd_sc_hd__and3_4 _0712_ (.A(_0183_),
    .B(_0185_),
    .C(_0189_),
    .X(_0096_));
 sky130_fd_sc_hd__or2_4 _0713_ (.A(wbs_data_o[19]),
    .B(_0184_),
    .X(_0190_));
 sky130_fd_sc_hd__buf_2 _0714_ (.A(_0138_),
    .X(_0191_));
 sky130_fd_sc_hd__and2_4 _0715_ (.A(\configy.bits_c[3] ),
    .B(_0191_),
    .X(_0192_));
 sky130_fd_sc_hd__a211o_4 _0716_ (.A1(\configy.counter_c[3] ),
    .A2(_0186_),
    .B1(_0187_),
    .C1(_0192_),
    .X(_0193_));
 sky130_fd_sc_hd__and3_4 _0717_ (.A(_0183_),
    .B(_0190_),
    .C(_0193_),
    .X(_0095_));
 sky130_fd_sc_hd__or2_4 _0718_ (.A(wbs_data_o[18]),
    .B(_0184_),
    .X(_0194_));
 sky130_fd_sc_hd__and2_4 _0719_ (.A(\configy.bits_c[2] ),
    .B(_0191_),
    .X(_0195_));
 sky130_fd_sc_hd__a211o_4 _0720_ (.A1(\configy.counter_c[2] ),
    .A2(_0186_),
    .B1(_0187_),
    .C1(_0195_),
    .X(_0196_));
 sky130_fd_sc_hd__and3_4 _0721_ (.A(_0183_),
    .B(_0194_),
    .C(_0196_),
    .X(_0094_));
 sky130_fd_sc_hd__or2_4 _0722_ (.A(wbs_data_o[17]),
    .B(_0184_),
    .X(_0197_));
 sky130_fd_sc_hd__buf_2 _0723_ (.A(\configy.counter_c[1] ),
    .X(_0198_));
 sky130_fd_sc_hd__and2_4 _0724_ (.A(\configy.bits_c[1] ),
    .B(_0191_),
    .X(_0199_));
 sky130_fd_sc_hd__a211o_4 _0725_ (.A1(_0198_),
    .A2(_0186_),
    .B1(_0187_),
    .C1(_0199_),
    .X(_0200_));
 sky130_fd_sc_hd__and3_4 _0726_ (.A(_0183_),
    .B(_0197_),
    .C(_0200_),
    .X(_0093_));
 sky130_fd_sc_hd__or2_4 _0727_ (.A(wbs_data_o[16]),
    .B(_0184_),
    .X(_0201_));
 sky130_fd_sc_hd__buf_2 _0728_ (.A(\configy.counter_c[0] ),
    .X(_0202_));
 sky130_fd_sc_hd__and2_4 _0729_ (.A(\configy.bits_c[0] ),
    .B(_0191_),
    .X(_0203_));
 sky130_fd_sc_hd__a211o_4 _0730_ (.A1(_0202_),
    .A2(_0186_),
    .B1(_0187_),
    .C1(_0203_),
    .X(_0204_));
 sky130_fd_sc_hd__and3_4 _0731_ (.A(_0183_),
    .B(_0201_),
    .C(_0204_),
    .X(_0092_));
 sky130_fd_sc_hd__buf_2 _0732_ (.A(_0108_),
    .X(_0205_));
 sky130_fd_sc_hd__buf_2 _0733_ (.A(_0160_),
    .X(_0206_));
 sky130_fd_sc_hd__or2_4 _0734_ (.A(wbs_data_o[15]),
    .B(_0206_),
    .X(_0207_));
 sky130_fd_sc_hd__buf_2 _0735_ (.A(_0132_),
    .X(_0208_));
 sky130_fd_sc_hd__buf_2 _0736_ (.A(_0142_),
    .X(_0209_));
 sky130_fd_sc_hd__and2_4 _0737_ (.A(\configy.bits_b[7] ),
    .B(_0191_),
    .X(_0210_));
 sky130_fd_sc_hd__a211o_4 _0738_ (.A1(\configy.counter_b[7] ),
    .A2(_0208_),
    .B1(_0209_),
    .C1(_0210_),
    .X(_0211_));
 sky130_fd_sc_hd__and3_4 _0739_ (.A(_0205_),
    .B(_0207_),
    .C(_0211_),
    .X(_0091_));
 sky130_fd_sc_hd__or2_4 _0740_ (.A(wbs_data_o[14]),
    .B(_0206_),
    .X(_0212_));
 sky130_fd_sc_hd__buf_2 _0741_ (.A(_0137_),
    .X(_0213_));
 sky130_fd_sc_hd__buf_2 _0742_ (.A(_0213_),
    .X(_0214_));
 sky130_fd_sc_hd__and2_4 _0743_ (.A(\configy.bits_b[6] ),
    .B(_0214_),
    .X(_0215_));
 sky130_fd_sc_hd__a211o_4 _0744_ (.A1(\configy.counter_b[6] ),
    .A2(_0208_),
    .B1(_0209_),
    .C1(_0215_),
    .X(_0216_));
 sky130_fd_sc_hd__and3_4 _0745_ (.A(_0205_),
    .B(_0212_),
    .C(_0216_),
    .X(_0090_));
 sky130_fd_sc_hd__or2_4 _0746_ (.A(wbs_data_o[13]),
    .B(_0206_),
    .X(_0217_));
 sky130_fd_sc_hd__buf_2 _0747_ (.A(\configy.counter_b[5] ),
    .X(_0218_));
 sky130_fd_sc_hd__and2_4 _0748_ (.A(\configy.bits_b[5] ),
    .B(_0214_),
    .X(_0219_));
 sky130_fd_sc_hd__a211o_4 _0749_ (.A1(_0218_),
    .A2(_0208_),
    .B1(_0209_),
    .C1(_0219_),
    .X(_0220_));
 sky130_fd_sc_hd__and3_4 _0750_ (.A(_0205_),
    .B(_0217_),
    .C(_0220_),
    .X(_0089_));
 sky130_fd_sc_hd__or2_4 _0751_ (.A(wbs_data_o[12]),
    .B(_0206_),
    .X(_0221_));
 sky130_fd_sc_hd__and2_4 _0752_ (.A(\configy.bits_b[4] ),
    .B(_0214_),
    .X(_0222_));
 sky130_fd_sc_hd__a211o_4 _0753_ (.A1(\configy.counter_b[4] ),
    .A2(_0208_),
    .B1(_0209_),
    .C1(_0222_),
    .X(_0223_));
 sky130_fd_sc_hd__and3_4 _0754_ (.A(_0205_),
    .B(_0221_),
    .C(_0223_),
    .X(_0088_));
 sky130_fd_sc_hd__or2_4 _0755_ (.A(wbs_data_o[11]),
    .B(_0206_),
    .X(_0224_));
 sky130_fd_sc_hd__and2_4 _0756_ (.A(\configy.bits_b[3] ),
    .B(_0214_),
    .X(_0225_));
 sky130_fd_sc_hd__a211o_4 _0757_ (.A1(\configy.counter_b[3] ),
    .A2(_0208_),
    .B1(_0209_),
    .C1(_0225_),
    .X(_0226_));
 sky130_fd_sc_hd__and3_4 _0758_ (.A(_0205_),
    .B(_0224_),
    .C(_0226_),
    .X(_0087_));
 sky130_fd_sc_hd__buf_2 _0759_ (.A(_0108_),
    .X(_0227_));
 sky130_fd_sc_hd__buf_2 _0760_ (.A(_0160_),
    .X(_0228_));
 sky130_fd_sc_hd__or2_4 _0761_ (.A(wbs_data_o[10]),
    .B(_0228_),
    .X(_0229_));
 sky130_fd_sc_hd__buf_2 _0762_ (.A(_0131_),
    .X(_0230_));
 sky130_fd_sc_hd__buf_2 _0763_ (.A(_0141_),
    .X(_0231_));
 sky130_fd_sc_hd__and2_4 _0764_ (.A(\configy.bits_b[2] ),
    .B(_0214_),
    .X(_0232_));
 sky130_fd_sc_hd__a211o_4 _0765_ (.A1(\configy.counter_b[2] ),
    .A2(_0230_),
    .B1(_0231_),
    .C1(_0232_),
    .X(_0233_));
 sky130_fd_sc_hd__and3_4 _0766_ (.A(_0227_),
    .B(_0229_),
    .C(_0233_),
    .X(_0086_));
 sky130_fd_sc_hd__or2_4 _0767_ (.A(wbs_data_o[9]),
    .B(_0228_),
    .X(_0234_));
 sky130_fd_sc_hd__buf_2 _0768_ (.A(\configy.counter_b[1] ),
    .X(_0235_));
 sky130_fd_sc_hd__buf_2 _0769_ (.A(_0213_),
    .X(_0236_));
 sky130_fd_sc_hd__and2_4 _0770_ (.A(\configy.bits_b[1] ),
    .B(_0236_),
    .X(_0237_));
 sky130_fd_sc_hd__a211o_4 _0771_ (.A1(_0235_),
    .A2(_0230_),
    .B1(_0231_),
    .C1(_0237_),
    .X(_0238_));
 sky130_fd_sc_hd__and3_4 _0772_ (.A(_0227_),
    .B(_0234_),
    .C(_0238_),
    .X(_0085_));
 sky130_fd_sc_hd__or2_4 _0773_ (.A(wbs_data_o[8]),
    .B(_0228_),
    .X(_0239_));
 sky130_fd_sc_hd__buf_2 _0774_ (.A(\configy.counter_b[0] ),
    .X(_0240_));
 sky130_fd_sc_hd__and2_4 _0775_ (.A(\configy.bits_b[0] ),
    .B(_0236_),
    .X(_0241_));
 sky130_fd_sc_hd__a211o_4 _0776_ (.A1(_0240_),
    .A2(_0230_),
    .B1(_0231_),
    .C1(_0241_),
    .X(_0242_));
 sky130_fd_sc_hd__and3_4 _0777_ (.A(_0227_),
    .B(_0239_),
    .C(_0242_),
    .X(_0084_));
 sky130_fd_sc_hd__or2_4 _0778_ (.A(wbs_data_o[7]),
    .B(_0228_),
    .X(_0243_));
 sky130_fd_sc_hd__and2_4 _0779_ (.A(\configy.bits_a[7] ),
    .B(_0236_),
    .X(_0244_));
 sky130_fd_sc_hd__a211o_4 _0780_ (.A1(\configy.counter_a[7] ),
    .A2(_0230_),
    .B1(_0231_),
    .C1(_0244_),
    .X(_0245_));
 sky130_fd_sc_hd__and3_4 _0781_ (.A(_0227_),
    .B(_0243_),
    .C(_0245_),
    .X(_0083_));
 sky130_fd_sc_hd__or2_4 _0782_ (.A(wbs_data_o[6]),
    .B(_0228_),
    .X(_0246_));
 sky130_fd_sc_hd__and2_4 _0783_ (.A(\configy.bits_a[6] ),
    .B(_0236_),
    .X(_0247_));
 sky130_fd_sc_hd__a211o_4 _0784_ (.A1(\configy.counter_a[6] ),
    .A2(_0230_),
    .B1(_0231_),
    .C1(_0247_),
    .X(_0248_));
 sky130_fd_sc_hd__and3_4 _0785_ (.A(_0227_),
    .B(_0246_),
    .C(_0248_),
    .X(_0082_));
 sky130_fd_sc_hd__buf_2 _0786_ (.A(_0108_),
    .X(_0249_));
 sky130_fd_sc_hd__buf_2 _0787_ (.A(_0160_),
    .X(_0250_));
 sky130_fd_sc_hd__or2_4 _0788_ (.A(wbs_data_o[5]),
    .B(_0250_),
    .X(_0251_));
 sky130_fd_sc_hd__buf_2 _0789_ (.A(\configy.counter_a[5] ),
    .X(_0252_));
 sky130_fd_sc_hd__buf_2 _0790_ (.A(_0131_),
    .X(_0253_));
 sky130_fd_sc_hd__buf_2 _0791_ (.A(_0141_),
    .X(_0254_));
 sky130_fd_sc_hd__and2_4 _0792_ (.A(\configy.bits_a[5] ),
    .B(_0236_),
    .X(_0255_));
 sky130_fd_sc_hd__a211o_4 _0793_ (.A1(_0252_),
    .A2(_0253_),
    .B1(_0254_),
    .C1(_0255_),
    .X(_0256_));
 sky130_fd_sc_hd__and3_4 _0794_ (.A(_0249_),
    .B(_0251_),
    .C(_0256_),
    .X(_0081_));
 sky130_fd_sc_hd__or2_4 _0795_ (.A(wbs_data_o[4]),
    .B(_0250_),
    .X(_0257_));
 sky130_fd_sc_hd__buf_2 _0796_ (.A(_0213_),
    .X(_0258_));
 sky130_fd_sc_hd__and2_4 _0797_ (.A(\configy.bits_a[4] ),
    .B(_0258_),
    .X(_0259_));
 sky130_fd_sc_hd__a211o_4 _0798_ (.A1(\configy.counter_a[4] ),
    .A2(_0253_),
    .B1(_0254_),
    .C1(_0259_),
    .X(_0260_));
 sky130_fd_sc_hd__and3_4 _0799_ (.A(_0249_),
    .B(_0257_),
    .C(_0260_),
    .X(_0080_));
 sky130_fd_sc_hd__or2_4 _0800_ (.A(wbs_data_o[3]),
    .B(_0250_),
    .X(_0261_));
 sky130_fd_sc_hd__and2_4 _0801_ (.A(\configy.bits_a[3] ),
    .B(_0258_),
    .X(_0262_));
 sky130_fd_sc_hd__a211o_4 _0802_ (.A1(\configy.counter_a[3] ),
    .A2(_0253_),
    .B1(_0254_),
    .C1(_0262_),
    .X(_0263_));
 sky130_fd_sc_hd__and3_4 _0803_ (.A(_0249_),
    .B(_0261_),
    .C(_0263_),
    .X(_0079_));
 sky130_fd_sc_hd__or2_4 _0804_ (.A(wbs_data_o[2]),
    .B(_0250_),
    .X(_0264_));
 sky130_fd_sc_hd__and2_4 _0805_ (.A(\configy.bits_a[2] ),
    .B(_0258_),
    .X(_0265_));
 sky130_fd_sc_hd__a211o_4 _0806_ (.A1(\configy.counter_a[2] ),
    .A2(_0253_),
    .B1(_0254_),
    .C1(_0265_),
    .X(_0266_));
 sky130_fd_sc_hd__and3_4 _0807_ (.A(_0249_),
    .B(_0264_),
    .C(_0266_),
    .X(_0078_));
 sky130_fd_sc_hd__or2_4 _0808_ (.A(wbs_data_o[1]),
    .B(_0250_),
    .X(_0267_));
 sky130_fd_sc_hd__buf_2 _0809_ (.A(\configy.counter_a[1] ),
    .X(_0268_));
 sky130_fd_sc_hd__and2_4 _0810_ (.A(\configy.bits_a[1] ),
    .B(_0258_),
    .X(_0269_));
 sky130_fd_sc_hd__a211o_4 _0811_ (.A1(_0268_),
    .A2(_0253_),
    .B1(_0254_),
    .C1(_0269_),
    .X(_0270_));
 sky130_fd_sc_hd__and3_4 _0812_ (.A(_0249_),
    .B(_0267_),
    .C(_0270_),
    .X(_0077_));
 sky130_fd_sc_hd__or2_4 _0813_ (.A(wbs_data_o[0]),
    .B(_0126_),
    .X(_0271_));
 sky130_fd_sc_hd__buf_2 _0814_ (.A(\configy.counter_a[0] ),
    .X(_0272_));
 sky130_fd_sc_hd__and2_4 _0815_ (.A(_0272_),
    .B(_0131_),
    .X(_0273_));
 sky130_fd_sc_hd__and3_4 _0816_ (.A(\configy.free_run ),
    .B(_0136_),
    .C(_0129_),
    .X(_0274_));
 sky130_fd_sc_hd__and2_4 _0817_ (.A(\configy.bits_a[0] ),
    .B(_0138_),
    .X(_0275_));
 sky130_fd_sc_hd__or4_4 _0818_ (.A(_0141_),
    .B(_0273_),
    .C(_0274_),
    .D(_0275_),
    .X(_0276_));
 sky130_fd_sc_hd__and3_4 _0819_ (.A(_0109_),
    .B(_0271_),
    .C(_0276_),
    .X(_0076_));
 sky130_fd_sc_hd__buf_2 _0820_ (.A(wb_rst_i),
    .X(_0277_));
 sky130_fd_sc_hd__inv_2 _0821_ (.A(_0277_),
    .Y(_0278_));
 sky130_fd_sc_hd__or2_4 _0822_ (.A(\configy.read_transaction_in_progress ),
    .B(_0126_),
    .X(_0279_));
 sky130_fd_sc_hd__inv_2 _0823_ (.A(\configy.read_transaction_in_progress ),
    .Y(_0280_));
 sky130_fd_sc_hd__buf_2 _0824_ (.A(\configy.write_transaction_in_progress ),
    .X(_0281_));
 sky130_fd_sc_hd__or2_4 _0825_ (.A(_0280_),
    .B(_0281_),
    .X(_0282_));
 sky130_fd_sc_hd__and3_4 _0826_ (.A(_0278_),
    .B(_0279_),
    .C(_0282_),
    .X(_0075_));
 sky130_fd_sc_hd__inv_2 _0827_ (.A(wbs_data_i[0]),
    .Y(_0283_));
 sky130_fd_sc_hd__buf_2 _0828_ (.A(wbs_sel_i[0]),
    .X(_0284_));
 sky130_fd_sc_hd__and4_4 _0829_ (.A(_0136_),
    .B(_0284_),
    .C(_0281_),
    .D(_0129_),
    .X(_0285_));
 sky130_fd_sc_hd__o21a_4 _0830_ (.A1(\configy.free_run ),
    .A2(_0285_),
    .B1(_0278_),
    .X(_0286_));
 sky130_fd_sc_hd__a21boi_4 _0831_ (.A1(_0283_),
    .A2(_0285_),
    .B1_N(_0286_),
    .Y(_0074_));
 sky130_fd_sc_hd__and3_4 _0832_ (.A(wbs_addr_i[3]),
    .B(\configy.write_transaction_in_progress ),
    .C(_0129_),
    .X(_0287_));
 sky130_fd_sc_hd__buf_2 _0833_ (.A(_0287_),
    .X(_0288_));
 sky130_fd_sc_hd__and2_4 _0834_ (.A(wbs_sel_i[3]),
    .B(_0288_),
    .X(_0289_));
 sky130_fd_sc_hd__buf_2 _0835_ (.A(_0289_),
    .X(_0290_));
 sky130_fd_sc_hd__buf_2 _0836_ (.A(\configy.output_initiated ),
    .X(_0291_));
 sky130_fd_sc_hd__buf_2 _0837_ (.A(_0291_),
    .X(_0292_));
 sky130_fd_sc_hd__buf_2 _0838_ (.A(_0292_),
    .X(_0293_));
 sky130_fd_sc_hd__buf_2 _0839_ (.A(_0288_),
    .X(_0294_));
 sky130_fd_sc_hd__and4_4 _0840_ (.A(\configy.charged[3] ),
    .B(\configy.charged[2] ),
    .C(\configy.charged[1] ),
    .D(\configy.charged[0] ),
    .X(_0295_));
 sky130_fd_sc_hd__or2_4 _0841_ (.A(wb_rst_i),
    .B(_0295_),
    .X(_0296_));
 sky130_fd_sc_hd__a21oi_4 _0842_ (.A1(_0293_),
    .A2(_0294_),
    .B1(_0296_),
    .Y(_0297_));
 sky130_fd_sc_hd__o21a_4 _0843_ (.A1(\configy.charged[3] ),
    .A2(_0290_),
    .B1(_0297_),
    .X(_0073_));
 sky130_fd_sc_hd__and2_4 _0844_ (.A(wbs_sel_i[2]),
    .B(_0288_),
    .X(_0298_));
 sky130_fd_sc_hd__buf_2 _0845_ (.A(_0298_),
    .X(_0299_));
 sky130_fd_sc_hd__o21a_4 _0846_ (.A1(\configy.charged[2] ),
    .A2(_0299_),
    .B1(_0297_),
    .X(_0072_));
 sky130_fd_sc_hd__and2_4 _0847_ (.A(wbs_sel_i[1]),
    .B(_0287_),
    .X(_0300_));
 sky130_fd_sc_hd__buf_2 _0848_ (.A(_0300_),
    .X(_0301_));
 sky130_fd_sc_hd__o21a_4 _0849_ (.A1(\configy.charged[1] ),
    .A2(_0301_),
    .B1(_0297_),
    .X(_0071_));
 sky130_fd_sc_hd__and2_4 _0850_ (.A(_0284_),
    .B(_0287_),
    .X(_0302_));
 sky130_fd_sc_hd__buf_2 _0851_ (.A(_0302_),
    .X(_0303_));
 sky130_fd_sc_hd__o21a_4 _0852_ (.A1(\configy.charged[0] ),
    .A2(_0303_),
    .B1(_0297_),
    .X(_0070_));
 sky130_fd_sc_hd__buf_2 _0853_ (.A(_0291_),
    .X(_0304_));
 sky130_fd_sc_hd__buf_2 _0854_ (.A(_0304_),
    .X(_0305_));
 sky130_fd_sc_hd__buf_2 _0855_ (.A(\configy.bits_index[2] ),
    .X(_0306_));
 sky130_fd_sc_hd__buf_2 _0856_ (.A(_0306_),
    .X(_0307_));
 sky130_fd_sc_hd__and2_4 _0857_ (.A(\configy.bits_index[1] ),
    .B(\configy.bits_index[0] ),
    .X(_0308_));
 sky130_fd_sc_hd__or2_4 _0858_ (.A(_0307_),
    .B(_0308_),
    .X(_0309_));
 sky130_fd_sc_hd__inv_2 _0859_ (.A(\configy.bits_index[2] ),
    .Y(_0310_));
 sky130_fd_sc_hd__buf_2 _0860_ (.A(_0310_),
    .X(_0311_));
 sky130_fd_sc_hd__inv_2 _0861_ (.A(_0308_),
    .Y(_0312_));
 sky130_fd_sc_hd__or2_4 _0862_ (.A(_0311_),
    .B(_0312_),
    .X(_0313_));
 sky130_fd_sc_hd__buf_2 _0863_ (.A(\configy.output_initiated ),
    .X(_0314_));
 sky130_fd_sc_hd__buf_2 _0864_ (.A(_0314_),
    .X(_0315_));
 sky130_fd_sc_hd__nor2_4 _0865_ (.A(_0315_),
    .B(_0288_),
    .Y(_0316_));
 sky130_fd_sc_hd__a32o_4 _0866_ (.A1(_0305_),
    .A2(_0309_),
    .A3(_0313_),
    .B1(_0316_),
    .B2(_0307_),
    .X(_0317_));
 sky130_fd_sc_hd__and2_4 _0867_ (.A(_0278_),
    .B(_0317_),
    .X(_0069_));
 sky130_fd_sc_hd__buf_2 _0868_ (.A(_0277_),
    .X(_0318_));
 sky130_fd_sc_hd__buf_2 _0869_ (.A(_0318_),
    .X(_0319_));
 sky130_fd_sc_hd__buf_2 _0870_ (.A(\configy.bits_index[1] ),
    .X(_0320_));
 sky130_fd_sc_hd__a22oi_4 _0871_ (.A1(_0293_),
    .A2(_0312_),
    .B1(_0316_),
    .B2(_0320_),
    .Y(_0321_));
 sky130_fd_sc_hd__inv_2 _0872_ (.A(\configy.bits_index[1] ),
    .Y(_0322_));
 sky130_fd_sc_hd__inv_2 _0873_ (.A(\configy.bits_index[0] ),
    .Y(_0323_));
 sky130_fd_sc_hd__and2_4 _0874_ (.A(_0322_),
    .B(_0323_),
    .X(_0324_));
 sky130_fd_sc_hd__nor3_4 _0875_ (.A(_0319_),
    .B(_0321_),
    .C(_0324_),
    .Y(_0068_));
 sky130_fd_sc_hd__buf_2 _0876_ (.A(_0323_),
    .X(_0325_));
 sky130_fd_sc_hd__or2_4 _0877_ (.A(_0325_),
    .B(_0316_),
    .X(_0326_));
 sky130_fd_sc_hd__buf_2 _0878_ (.A(\configy.bits_index[0] ),
    .X(_0327_));
 sky130_fd_sc_hd__buf_2 _0879_ (.A(_0327_),
    .X(_0328_));
 sky130_fd_sc_hd__or2_4 _0880_ (.A(_0328_),
    .B(_0293_),
    .X(_0329_));
 sky130_fd_sc_hd__and3_4 _0881_ (.A(_0278_),
    .B(_0326_),
    .C(_0329_),
    .X(_0067_));
 sky130_fd_sc_hd__buf_2 _0882_ (.A(_0291_),
    .X(_0330_));
 sky130_fd_sc_hd__or2_4 _0883_ (.A(wbs_data_i[7]),
    .B(_0330_),
    .X(_0331_));
 sky130_fd_sc_hd__or4_4 _0884_ (.A(\configy.counter_a[3] ),
    .B(\configy.counter_a[2] ),
    .C(\configy.counter_a[1] ),
    .D(\configy.counter_a[0] ),
    .X(_0332_));
 sky130_fd_sc_hd__or4_4 _0885_ (.A(\configy.counter_a[6] ),
    .B(_0252_),
    .C(\configy.counter_a[4] ),
    .D(_0332_),
    .X(_0333_));
 sky130_fd_sc_hd__buf_2 _0886_ (.A(\configy.write_transaction_in_progress ),
    .X(_0334_));
 sky130_fd_sc_hd__inv_2 _0887_ (.A(\configy.output_initiated ),
    .Y(_0335_));
 sky130_fd_sc_hd__buf_2 _0888_ (.A(_0335_),
    .X(_0336_));
 sky130_fd_sc_hd__and4_4 _0889_ (.A(\configy.counter_a[5] ),
    .B(\configy.counter_a[4] ),
    .C(\configy.counter_a[3] ),
    .D(\configy.counter_a[2] ),
    .X(_0337_));
 sky130_fd_sc_hd__and4_4 _0890_ (.A(\configy.counter_a[7] ),
    .B(\configy.counter_a[6] ),
    .C(_0268_),
    .D(\configy.counter_a[0] ),
    .X(_0338_));
 sky130_fd_sc_hd__buf_2 _0891_ (.A(_0335_),
    .X(_0339_));
 sky130_fd_sc_hd__a21oi_4 _0892_ (.A1(_0337_),
    .A2(_0338_),
    .B1(_0339_),
    .Y(_0340_));
 sky130_fd_sc_hd__a41oi_4 _0893_ (.A1(_0284_),
    .A2(_0334_),
    .A3(_0336_),
    .A4(_0213_),
    .B1(_0340_),
    .Y(_0341_));
 sky130_fd_sc_hd__a21o_4 _0894_ (.A1(_0331_),
    .A2(_0333_),
    .B1(_0341_),
    .X(_0342_));
 sky130_fd_sc_hd__buf_2 _0895_ (.A(_0137_),
    .X(_0343_));
 sky130_fd_sc_hd__a41o_4 _0896_ (.A1(wbs_sel_i[0]),
    .A2(\configy.write_transaction_in_progress ),
    .A3(_0336_),
    .A4(_0343_),
    .B1(_0340_),
    .X(_0344_));
 sky130_fd_sc_hd__buf_2 _0897_ (.A(_0344_),
    .X(_0345_));
 sky130_fd_sc_hd__buf_2 _0898_ (.A(_0330_),
    .X(_0346_));
 sky130_fd_sc_hd__o21ai_4 _0899_ (.A1(\configy.counter_a[7] ),
    .A2(_0333_),
    .B1(_0346_),
    .Y(_0347_));
 sky130_fd_sc_hd__and3_4 _0900_ (.A(_0345_),
    .B(_0331_),
    .C(_0347_),
    .X(_0348_));
 sky130_fd_sc_hd__buf_2 _0901_ (.A(wb_rst_i),
    .X(_0349_));
 sky130_fd_sc_hd__buf_2 _0902_ (.A(_0349_),
    .X(_0350_));
 sky130_fd_sc_hd__a211o_4 _0903_ (.A1(\configy.counter_a[7] ),
    .A2(_0342_),
    .B1(_0348_),
    .C1(_0350_),
    .X(_0066_));
 sky130_fd_sc_hd__buf_2 _0904_ (.A(_0335_),
    .X(_0351_));
 sky130_fd_sc_hd__buf_2 _0905_ (.A(_0351_),
    .X(_0352_));
 sky130_fd_sc_hd__buf_2 _0906_ (.A(_0352_),
    .X(_0353_));
 sky130_fd_sc_hd__or2_4 _0907_ (.A(_0351_),
    .B(_0333_),
    .X(_0354_));
 sky130_fd_sc_hd__a21bo_4 _0908_ (.A1(wbs_data_i[6]),
    .A2(_0353_),
    .B1_N(_0354_),
    .X(_0355_));
 sky130_fd_sc_hd__or2_4 _0909_ (.A(\configy.counter_a[4] ),
    .B(_0332_),
    .X(_0356_));
 sky130_fd_sc_hd__o21a_4 _0910_ (.A1(_0252_),
    .A2(_0356_),
    .B1(_0330_),
    .X(_0357_));
 sky130_fd_sc_hd__o21a_4 _0911_ (.A1(_0341_),
    .A2(_0357_),
    .B1(\configy.counter_a[6] ),
    .X(_0358_));
 sky130_fd_sc_hd__a211o_4 _0912_ (.A1(_0345_),
    .A2(_0355_),
    .B1(_0358_),
    .C1(_0350_),
    .X(_0065_));
 sky130_fd_sc_hd__or2_4 _0913_ (.A(wbs_data_i[5]),
    .B(_0305_),
    .X(_0359_));
 sky130_fd_sc_hd__a2bb2o_4 _0914_ (.A1_N(_0341_),
    .A2_N(_0357_),
    .B1(_0356_),
    .B2(_0252_),
    .X(_0360_));
 sky130_fd_sc_hd__buf_2 _0915_ (.A(_0341_),
    .X(_0361_));
 sky130_fd_sc_hd__and2_4 _0916_ (.A(_0252_),
    .B(_0361_),
    .X(_0362_));
 sky130_fd_sc_hd__a211o_4 _0917_ (.A1(_0359_),
    .A2(_0360_),
    .B1(_0362_),
    .C1(_0350_),
    .X(_0064_));
 sky130_fd_sc_hd__buf_2 _0918_ (.A(_0291_),
    .X(_0363_));
 sky130_fd_sc_hd__nand2_4 _0919_ (.A(_0363_),
    .B(_0356_),
    .Y(_0364_));
 sky130_fd_sc_hd__buf_2 _0920_ (.A(\configy.output_initiated ),
    .X(_0365_));
 sky130_fd_sc_hd__or2_4 _0921_ (.A(wbs_data_i[4]),
    .B(_0365_),
    .X(_0366_));
 sky130_fd_sc_hd__and3_4 _0922_ (.A(_0344_),
    .B(_0364_),
    .C(_0366_),
    .X(_0367_));
 sky130_fd_sc_hd__buf_2 _0923_ (.A(_0291_),
    .X(_0368_));
 sky130_fd_sc_hd__and2_4 _0924_ (.A(_0368_),
    .B(_0332_),
    .X(_0369_));
 sky130_fd_sc_hd__o21a_4 _0925_ (.A1(_0341_),
    .A2(_0369_),
    .B1(\configy.counter_a[4] ),
    .X(_0370_));
 sky130_fd_sc_hd__or3_4 _0926_ (.A(_0349_),
    .B(_0367_),
    .C(_0370_),
    .X(_0063_));
 sky130_fd_sc_hd__inv_2 _0927_ (.A(\configy.counter_a[3] ),
    .Y(_0371_));
 sky130_fd_sc_hd__o21ai_4 _0928_ (.A1(_0361_),
    .A2(_0369_),
    .B1(_0371_),
    .Y(_0372_));
 sky130_fd_sc_hd__or2_4 _0929_ (.A(_0268_),
    .B(_0272_),
    .X(_0373_));
 sky130_fd_sc_hd__or3_4 _0930_ (.A(\configy.counter_a[2] ),
    .B(_0336_),
    .C(_0373_),
    .X(_0374_));
 sky130_fd_sc_hd__o22a_4 _0931_ (.A1(wbs_data_i[3]),
    .A2(_0292_),
    .B1(_0374_),
    .B2(_0371_),
    .X(_0375_));
 sky130_fd_sc_hd__or2_4 _0932_ (.A(_0361_),
    .B(_0375_),
    .X(_0376_));
 sky130_fd_sc_hd__a21o_4 _0933_ (.A1(_0372_),
    .A2(_0376_),
    .B1(_0319_),
    .X(_0062_));
 sky130_fd_sc_hd__a21bo_4 _0934_ (.A1(wbs_data_i[2]),
    .A2(_0353_),
    .B1_N(_0374_),
    .X(_0377_));
 sky130_fd_sc_hd__buf_2 _0935_ (.A(_0365_),
    .X(_0378_));
 sky130_fd_sc_hd__nand2_4 _0936_ (.A(_0378_),
    .B(_0373_),
    .Y(_0379_));
 sky130_fd_sc_hd__a21boi_4 _0937_ (.A1(_0345_),
    .A2(_0379_),
    .B1_N(\configy.counter_a[2] ),
    .Y(_0380_));
 sky130_fd_sc_hd__a211o_4 _0938_ (.A1(_0345_),
    .A2(_0377_),
    .B1(_0380_),
    .C1(_0350_),
    .X(_0061_));
 sky130_fd_sc_hd__and2_4 _0939_ (.A(_0268_),
    .B(_0272_),
    .X(_0381_));
 sky130_fd_sc_hd__o22a_4 _0940_ (.A1(wbs_data_i[1]),
    .A2(_0346_),
    .B1(_0381_),
    .B2(_0379_),
    .X(_0382_));
 sky130_fd_sc_hd__and2_4 _0941_ (.A(_0268_),
    .B(_0361_),
    .X(_0383_));
 sky130_fd_sc_hd__a211o_4 _0942_ (.A1(_0345_),
    .A2(_0382_),
    .B1(_0383_),
    .C1(_0350_),
    .X(_0060_));
 sky130_fd_sc_hd__or2_4 _0943_ (.A(wbs_data_i[0]),
    .B(_0304_),
    .X(_0384_));
 sky130_fd_sc_hd__nand2_4 _0944_ (.A(_0272_),
    .B(_0315_),
    .Y(_0385_));
 sky130_fd_sc_hd__and3_4 _0945_ (.A(_0344_),
    .B(_0384_),
    .C(_0385_),
    .X(_0386_));
 sky130_fd_sc_hd__buf_2 _0946_ (.A(_0277_),
    .X(_0387_));
 sky130_fd_sc_hd__a211o_4 _0947_ (.A1(_0272_),
    .A2(_0361_),
    .B1(_0386_),
    .C1(_0387_),
    .X(_0059_));
 sky130_fd_sc_hd__or4_4 _0948_ (.A(\configy.counter_b[3] ),
    .B(\configy.counter_b[2] ),
    .C(\configy.counter_b[1] ),
    .D(\configy.counter_b[0] ),
    .X(_0388_));
 sky130_fd_sc_hd__or4_4 _0949_ (.A(\configy.counter_b[6] ),
    .B(_0218_),
    .C(\configy.counter_b[4] ),
    .D(_0388_),
    .X(_0389_));
 sky130_fd_sc_hd__or2_4 _0950_ (.A(wbs_data_i[15]),
    .B(_0314_),
    .X(_0390_));
 sky130_fd_sc_hd__buf_2 _0951_ (.A(_0335_),
    .X(_0391_));
 sky130_fd_sc_hd__and4_4 _0952_ (.A(\configy.counter_b[5] ),
    .B(\configy.counter_b[4] ),
    .C(\configy.counter_b[3] ),
    .D(\configy.counter_b[2] ),
    .X(_0392_));
 sky130_fd_sc_hd__and4_4 _0953_ (.A(\configy.counter_b[7] ),
    .B(\configy.counter_b[6] ),
    .C(_0235_),
    .D(\configy.counter_b[0] ),
    .X(_0393_));
 sky130_fd_sc_hd__a21oi_4 _0954_ (.A1(_0392_),
    .A2(_0393_),
    .B1(_0339_),
    .Y(_0394_));
 sky130_fd_sc_hd__a41oi_4 _0955_ (.A1(_0281_),
    .A2(_0391_),
    .A3(wbs_sel_i[1]),
    .A4(_0213_),
    .B1(_0394_),
    .Y(_0395_));
 sky130_fd_sc_hd__a21o_4 _0956_ (.A1(_0389_),
    .A2(_0390_),
    .B1(_0395_),
    .X(_0396_));
 sky130_fd_sc_hd__a41o_4 _0957_ (.A1(_0334_),
    .A2(_0391_),
    .A3(wbs_sel_i[1]),
    .A4(_0343_),
    .B1(_0394_),
    .X(_0397_));
 sky130_fd_sc_hd__buf_2 _0958_ (.A(_0397_),
    .X(_0398_));
 sky130_fd_sc_hd__o21ai_4 _0959_ (.A1(\configy.counter_b[7] ),
    .A2(_0389_),
    .B1(_0315_),
    .Y(_0399_));
 sky130_fd_sc_hd__and3_4 _0960_ (.A(_0398_),
    .B(_0390_),
    .C(_0399_),
    .X(_0400_));
 sky130_fd_sc_hd__a211o_4 _0961_ (.A1(\configy.counter_b[7] ),
    .A2(_0396_),
    .B1(_0400_),
    .C1(_0387_),
    .X(_0058_));
 sky130_fd_sc_hd__or2_4 _0962_ (.A(_0351_),
    .B(_0389_),
    .X(_0401_));
 sky130_fd_sc_hd__a21bo_4 _0963_ (.A1(wbs_data_i[14]),
    .A2(_0353_),
    .B1_N(_0401_),
    .X(_0402_));
 sky130_fd_sc_hd__or2_4 _0964_ (.A(\configy.counter_b[4] ),
    .B(_0388_),
    .X(_0403_));
 sky130_fd_sc_hd__o21a_4 _0965_ (.A1(_0218_),
    .A2(_0403_),
    .B1(_0330_),
    .X(_0404_));
 sky130_fd_sc_hd__o21a_4 _0966_ (.A1(_0395_),
    .A2(_0404_),
    .B1(\configy.counter_b[6] ),
    .X(_0405_));
 sky130_fd_sc_hd__a211o_4 _0967_ (.A1(_0398_),
    .A2(_0402_),
    .B1(_0405_),
    .C1(_0387_),
    .X(_0057_));
 sky130_fd_sc_hd__or2_4 _0968_ (.A(wbs_data_i[13]),
    .B(_0305_),
    .X(_0406_));
 sky130_fd_sc_hd__a2bb2o_4 _0969_ (.A1_N(_0395_),
    .A2_N(_0404_),
    .B1(_0403_),
    .B2(_0218_),
    .X(_0407_));
 sky130_fd_sc_hd__buf_2 _0970_ (.A(_0395_),
    .X(_0408_));
 sky130_fd_sc_hd__and2_4 _0971_ (.A(_0218_),
    .B(_0408_),
    .X(_0409_));
 sky130_fd_sc_hd__a211o_4 _0972_ (.A1(_0406_),
    .A2(_0407_),
    .B1(_0409_),
    .C1(_0387_),
    .X(_0056_));
 sky130_fd_sc_hd__nand2_4 _0973_ (.A(_0363_),
    .B(_0403_),
    .Y(_0410_));
 sky130_fd_sc_hd__or2_4 _0974_ (.A(wbs_data_i[12]),
    .B(_0365_),
    .X(_0411_));
 sky130_fd_sc_hd__and3_4 _0975_ (.A(_0397_),
    .B(_0410_),
    .C(_0411_),
    .X(_0412_));
 sky130_fd_sc_hd__and2_4 _0976_ (.A(_0368_),
    .B(_0388_),
    .X(_0413_));
 sky130_fd_sc_hd__o21a_4 _0977_ (.A1(_0395_),
    .A2(_0413_),
    .B1(\configy.counter_b[4] ),
    .X(_0414_));
 sky130_fd_sc_hd__or3_4 _0978_ (.A(_0349_),
    .B(_0412_),
    .C(_0414_),
    .X(_0055_));
 sky130_fd_sc_hd__inv_2 _0979_ (.A(\configy.counter_b[3] ),
    .Y(_0415_));
 sky130_fd_sc_hd__o21ai_4 _0980_ (.A1(_0408_),
    .A2(_0413_),
    .B1(_0415_),
    .Y(_0416_));
 sky130_fd_sc_hd__or2_4 _0981_ (.A(_0235_),
    .B(_0240_),
    .X(_0417_));
 sky130_fd_sc_hd__or3_4 _0982_ (.A(\configy.counter_b[2] ),
    .B(_0336_),
    .C(_0417_),
    .X(_0418_));
 sky130_fd_sc_hd__o22a_4 _0983_ (.A1(wbs_data_i[11]),
    .A2(_0292_),
    .B1(_0418_),
    .B2(_0415_),
    .X(_0419_));
 sky130_fd_sc_hd__or2_4 _0984_ (.A(_0408_),
    .B(_0419_),
    .X(_0420_));
 sky130_fd_sc_hd__a21o_4 _0985_ (.A1(_0416_),
    .A2(_0420_),
    .B1(_0319_),
    .X(_0054_));
 sky130_fd_sc_hd__a21bo_4 _0986_ (.A1(wbs_data_i[10]),
    .A2(_0353_),
    .B1_N(_0418_),
    .X(_0421_));
 sky130_fd_sc_hd__nand2_4 _0987_ (.A(_0378_),
    .B(_0417_),
    .Y(_0422_));
 sky130_fd_sc_hd__a21boi_4 _0988_ (.A1(_0398_),
    .A2(_0422_),
    .B1_N(\configy.counter_b[2] ),
    .Y(_0423_));
 sky130_fd_sc_hd__a211o_4 _0989_ (.A1(_0398_),
    .A2(_0421_),
    .B1(_0423_),
    .C1(_0387_),
    .X(_0053_));
 sky130_fd_sc_hd__and2_4 _0990_ (.A(_0235_),
    .B(_0240_),
    .X(_0424_));
 sky130_fd_sc_hd__o22a_4 _0991_ (.A1(wbs_data_i[9]),
    .A2(_0346_),
    .B1(_0424_),
    .B2(_0422_),
    .X(_0425_));
 sky130_fd_sc_hd__and2_4 _0992_ (.A(_0235_),
    .B(_0408_),
    .X(_0426_));
 sky130_fd_sc_hd__buf_2 _0993_ (.A(_0277_),
    .X(_0427_));
 sky130_fd_sc_hd__a211o_4 _0994_ (.A1(_0398_),
    .A2(_0425_),
    .B1(_0426_),
    .C1(_0427_),
    .X(_0052_));
 sky130_fd_sc_hd__or2_4 _0995_ (.A(wbs_data_i[8]),
    .B(_0304_),
    .X(_0428_));
 sky130_fd_sc_hd__nand2_4 _0996_ (.A(_0240_),
    .B(_0378_),
    .Y(_0429_));
 sky130_fd_sc_hd__and3_4 _0997_ (.A(_0397_),
    .B(_0428_),
    .C(_0429_),
    .X(_0430_));
 sky130_fd_sc_hd__a211o_4 _0998_ (.A1(_0240_),
    .A2(_0408_),
    .B1(_0430_),
    .C1(_0427_),
    .X(_0051_));
 sky130_fd_sc_hd__or2_4 _0999_ (.A(wbs_data_i[23]),
    .B(_0330_),
    .X(_0431_));
 sky130_fd_sc_hd__or4_4 _1000_ (.A(\configy.counter_c[3] ),
    .B(\configy.counter_c[2] ),
    .C(\configy.counter_c[1] ),
    .D(\configy.counter_c[0] ),
    .X(_0432_));
 sky130_fd_sc_hd__or4_4 _1001_ (.A(\configy.counter_c[6] ),
    .B(_0180_),
    .C(\configy.counter_c[4] ),
    .D(_0432_),
    .X(_0433_));
 sky130_fd_sc_hd__and4_4 _1002_ (.A(\configy.counter_c[5] ),
    .B(\configy.counter_c[4] ),
    .C(\configy.counter_c[3] ),
    .D(\configy.counter_c[2] ),
    .X(_0434_));
 sky130_fd_sc_hd__and4_4 _1003_ (.A(\configy.counter_c[7] ),
    .B(\configy.counter_c[6] ),
    .C(_0198_),
    .D(\configy.counter_c[0] ),
    .X(_0435_));
 sky130_fd_sc_hd__a21oi_4 _1004_ (.A1(_0434_),
    .A2(_0435_),
    .B1(_0339_),
    .Y(_0436_));
 sky130_fd_sc_hd__a41oi_4 _1005_ (.A1(_0281_),
    .A2(_0391_),
    .A3(wbs_sel_i[2]),
    .A4(_0343_),
    .B1(_0436_),
    .Y(_0437_));
 sky130_fd_sc_hd__a21o_4 _1006_ (.A1(_0431_),
    .A2(_0433_),
    .B1(_0437_),
    .X(_0438_));
 sky130_fd_sc_hd__a41o_4 _1007_ (.A1(_0334_),
    .A2(_0391_),
    .A3(wbs_sel_i[2]),
    .A4(_0343_),
    .B1(_0436_),
    .X(_0439_));
 sky130_fd_sc_hd__buf_2 _1008_ (.A(_0439_),
    .X(_0440_));
 sky130_fd_sc_hd__o21ai_4 _1009_ (.A1(\configy.counter_c[7] ),
    .A2(_0433_),
    .B1(_0315_),
    .Y(_0441_));
 sky130_fd_sc_hd__and3_4 _1010_ (.A(_0440_),
    .B(_0431_),
    .C(_0441_),
    .X(_0442_));
 sky130_fd_sc_hd__a211o_4 _1011_ (.A1(\configy.counter_c[7] ),
    .A2(_0438_),
    .B1(_0442_),
    .C1(_0427_),
    .X(_0050_));
 sky130_fd_sc_hd__or2_4 _1012_ (.A(_0351_),
    .B(_0433_),
    .X(_0443_));
 sky130_fd_sc_hd__a21bo_4 _1013_ (.A1(wbs_data_i[22]),
    .A2(_0353_),
    .B1_N(_0443_),
    .X(_0444_));
 sky130_fd_sc_hd__or2_4 _1014_ (.A(\configy.counter_c[4] ),
    .B(_0432_),
    .X(_0445_));
 sky130_fd_sc_hd__o21a_4 _1015_ (.A1(_0180_),
    .A2(_0445_),
    .B1(_0314_),
    .X(_0446_));
 sky130_fd_sc_hd__o21a_4 _1016_ (.A1(_0437_),
    .A2(_0446_),
    .B1(\configy.counter_c[6] ),
    .X(_0447_));
 sky130_fd_sc_hd__a211o_4 _1017_ (.A1(_0440_),
    .A2(_0444_),
    .B1(_0447_),
    .C1(_0427_),
    .X(_0049_));
 sky130_fd_sc_hd__or2_4 _1018_ (.A(wbs_data_i[21]),
    .B(_0305_),
    .X(_0448_));
 sky130_fd_sc_hd__a2bb2o_4 _1019_ (.A1_N(_0437_),
    .A2_N(_0446_),
    .B1(_0445_),
    .B2(_0180_),
    .X(_0449_));
 sky130_fd_sc_hd__buf_2 _1020_ (.A(_0437_),
    .X(_0450_));
 sky130_fd_sc_hd__and2_4 _1021_ (.A(_0180_),
    .B(_0450_),
    .X(_0451_));
 sky130_fd_sc_hd__a211o_4 _1022_ (.A1(_0448_),
    .A2(_0449_),
    .B1(_0451_),
    .C1(_0427_),
    .X(_0048_));
 sky130_fd_sc_hd__nand2_4 _1023_ (.A(_0363_),
    .B(_0445_),
    .Y(_0452_));
 sky130_fd_sc_hd__or2_4 _1024_ (.A(wbs_data_i[20]),
    .B(_0365_),
    .X(_0453_));
 sky130_fd_sc_hd__and3_4 _1025_ (.A(_0439_),
    .B(_0452_),
    .C(_0453_),
    .X(_0454_));
 sky130_fd_sc_hd__and2_4 _1026_ (.A(_0368_),
    .B(_0432_),
    .X(_0455_));
 sky130_fd_sc_hd__o21a_4 _1027_ (.A1(_0437_),
    .A2(_0455_),
    .B1(\configy.counter_c[4] ),
    .X(_0456_));
 sky130_fd_sc_hd__or3_4 _1028_ (.A(_0349_),
    .B(_0454_),
    .C(_0456_),
    .X(_0047_));
 sky130_fd_sc_hd__inv_2 _1029_ (.A(\configy.counter_c[3] ),
    .Y(_0457_));
 sky130_fd_sc_hd__o21ai_4 _1030_ (.A1(_0450_),
    .A2(_0455_),
    .B1(_0457_),
    .Y(_0458_));
 sky130_fd_sc_hd__or2_4 _1031_ (.A(_0198_),
    .B(_0202_),
    .X(_0459_));
 sky130_fd_sc_hd__or3_4 _1032_ (.A(\configy.counter_c[2] ),
    .B(_0339_),
    .C(_0459_),
    .X(_0460_));
 sky130_fd_sc_hd__o22a_4 _1033_ (.A1(wbs_data_i[19]),
    .A2(_0292_),
    .B1(_0460_),
    .B2(_0457_),
    .X(_0461_));
 sky130_fd_sc_hd__or2_4 _1034_ (.A(_0450_),
    .B(_0461_),
    .X(_0462_));
 sky130_fd_sc_hd__a21o_4 _1035_ (.A1(_0458_),
    .A2(_0462_),
    .B1(_0319_),
    .X(_0046_));
 sky130_fd_sc_hd__a21bo_4 _1036_ (.A1(wbs_data_i[18]),
    .A2(_0352_),
    .B1_N(_0460_),
    .X(_0463_));
 sky130_fd_sc_hd__nand2_4 _1037_ (.A(_0363_),
    .B(_0459_),
    .Y(_0464_));
 sky130_fd_sc_hd__a21boi_4 _1038_ (.A1(_0440_),
    .A2(_0464_),
    .B1_N(\configy.counter_c[2] ),
    .Y(_0465_));
 sky130_fd_sc_hd__buf_2 _1039_ (.A(_0277_),
    .X(_0466_));
 sky130_fd_sc_hd__a211o_4 _1040_ (.A1(_0440_),
    .A2(_0463_),
    .B1(_0465_),
    .C1(_0466_),
    .X(_0045_));
 sky130_fd_sc_hd__and2_4 _1041_ (.A(_0198_),
    .B(_0202_),
    .X(_0467_));
 sky130_fd_sc_hd__o22a_4 _1042_ (.A1(wbs_data_i[17]),
    .A2(_0346_),
    .B1(_0467_),
    .B2(_0464_),
    .X(_0468_));
 sky130_fd_sc_hd__and2_4 _1043_ (.A(_0198_),
    .B(_0450_),
    .X(_0469_));
 sky130_fd_sc_hd__a211o_4 _1044_ (.A1(_0440_),
    .A2(_0468_),
    .B1(_0469_),
    .C1(_0466_),
    .X(_0044_));
 sky130_fd_sc_hd__or2_4 _1045_ (.A(wbs_data_i[16]),
    .B(_0304_),
    .X(_0470_));
 sky130_fd_sc_hd__nand2_4 _1046_ (.A(_0202_),
    .B(_0378_),
    .Y(_0471_));
 sky130_fd_sc_hd__and3_4 _1047_ (.A(_0439_),
    .B(_0470_),
    .C(_0471_),
    .X(_0472_));
 sky130_fd_sc_hd__a211o_4 _1048_ (.A1(_0202_),
    .A2(_0450_),
    .B1(_0472_),
    .C1(_0466_),
    .X(_0043_));
 sky130_fd_sc_hd__or4_4 _1049_ (.A(\configy.counter_d[3] ),
    .B(\configy.counter_d[2] ),
    .C(\configy.counter_d[1] ),
    .D(\configy.counter_d[0] ),
    .X(_0473_));
 sky130_fd_sc_hd__or4_4 _1050_ (.A(\configy.counter_d[6] ),
    .B(_0146_),
    .C(\configy.counter_d[4] ),
    .D(_0473_),
    .X(_0474_));
 sky130_fd_sc_hd__or2_4 _1051_ (.A(wbs_data_i[31]),
    .B(_0314_),
    .X(_0475_));
 sky130_fd_sc_hd__and4_4 _1052_ (.A(\configy.counter_d[5] ),
    .B(\configy.counter_d[4] ),
    .C(\configy.counter_d[3] ),
    .D(\configy.counter_d[2] ),
    .X(_0476_));
 sky130_fd_sc_hd__and4_4 _1053_ (.A(\configy.counter_d[7] ),
    .B(\configy.counter_d[6] ),
    .C(_0163_),
    .D(\configy.counter_d[0] ),
    .X(_0477_));
 sky130_fd_sc_hd__a21oi_4 _1054_ (.A1(_0476_),
    .A2(_0477_),
    .B1(_0335_),
    .Y(_0478_));
 sky130_fd_sc_hd__a41oi_4 _1055_ (.A1(_0334_),
    .A2(_0391_),
    .A3(wbs_sel_i[3]),
    .A4(_0343_),
    .B1(_0478_),
    .Y(_0479_));
 sky130_fd_sc_hd__a21o_4 _1056_ (.A1(_0474_),
    .A2(_0475_),
    .B1(_0479_),
    .X(_0480_));
 sky130_fd_sc_hd__a41o_4 _1057_ (.A1(_0334_),
    .A2(_0336_),
    .A3(wbs_sel_i[3]),
    .A4(_0137_),
    .B1(_0478_),
    .X(_0481_));
 sky130_fd_sc_hd__buf_2 _1058_ (.A(_0481_),
    .X(_0482_));
 sky130_fd_sc_hd__o21ai_4 _1059_ (.A1(\configy.counter_d[7] ),
    .A2(_0474_),
    .B1(_0315_),
    .Y(_0483_));
 sky130_fd_sc_hd__and3_4 _1060_ (.A(_0482_),
    .B(_0475_),
    .C(_0483_),
    .X(_0484_));
 sky130_fd_sc_hd__a211o_4 _1061_ (.A1(\configy.counter_d[7] ),
    .A2(_0480_),
    .B1(_0484_),
    .C1(_0466_),
    .X(_0042_));
 sky130_fd_sc_hd__or2_4 _1062_ (.A(_0351_),
    .B(_0474_),
    .X(_0485_));
 sky130_fd_sc_hd__a21bo_4 _1063_ (.A1(wbs_data_i[30]),
    .A2(_0352_),
    .B1_N(_0485_),
    .X(_0486_));
 sky130_fd_sc_hd__or2_4 _1064_ (.A(\configy.counter_d[4] ),
    .B(_0473_),
    .X(_0487_));
 sky130_fd_sc_hd__o21a_4 _1065_ (.A1(_0146_),
    .A2(_0487_),
    .B1(_0314_),
    .X(_0488_));
 sky130_fd_sc_hd__o21a_4 _1066_ (.A1(_0479_),
    .A2(_0488_),
    .B1(\configy.counter_d[6] ),
    .X(_0489_));
 sky130_fd_sc_hd__a211o_4 _1067_ (.A1(_0482_),
    .A2(_0486_),
    .B1(_0489_),
    .C1(_0466_),
    .X(_0041_));
 sky130_fd_sc_hd__or2_4 _1068_ (.A(wbs_data_i[29]),
    .B(_0305_),
    .X(_0490_));
 sky130_fd_sc_hd__a2bb2o_4 _1069_ (.A1_N(_0479_),
    .A2_N(_0488_),
    .B1(_0487_),
    .B2(_0146_),
    .X(_0491_));
 sky130_fd_sc_hd__buf_2 _1070_ (.A(_0479_),
    .X(_0492_));
 sky130_fd_sc_hd__and2_4 _1071_ (.A(_0146_),
    .B(_0492_),
    .X(_0493_));
 sky130_fd_sc_hd__a211o_4 _1072_ (.A1(_0490_),
    .A2(_0491_),
    .B1(_0493_),
    .C1(_0318_),
    .X(_0040_));
 sky130_fd_sc_hd__nand2_4 _1073_ (.A(_0292_),
    .B(_0487_),
    .Y(_0494_));
 sky130_fd_sc_hd__or2_4 _1074_ (.A(wbs_data_i[28]),
    .B(_0365_),
    .X(_0495_));
 sky130_fd_sc_hd__and3_4 _1075_ (.A(_0481_),
    .B(_0494_),
    .C(_0495_),
    .X(_0496_));
 sky130_fd_sc_hd__and2_4 _1076_ (.A(_0368_),
    .B(_0473_),
    .X(_0497_));
 sky130_fd_sc_hd__o21a_4 _1077_ (.A1(_0479_),
    .A2(_0497_),
    .B1(\configy.counter_d[4] ),
    .X(_0498_));
 sky130_fd_sc_hd__or3_4 _1078_ (.A(_0349_),
    .B(_0496_),
    .C(_0498_),
    .X(_0039_));
 sky130_fd_sc_hd__inv_2 _1079_ (.A(\configy.counter_d[3] ),
    .Y(_0499_));
 sky130_fd_sc_hd__o21ai_4 _1080_ (.A1(_0492_),
    .A2(_0497_),
    .B1(_0499_),
    .Y(_0500_));
 sky130_fd_sc_hd__or2_4 _1081_ (.A(_0163_),
    .B(_0169_),
    .X(_0501_));
 sky130_fd_sc_hd__or3_4 _1082_ (.A(\configy.counter_d[2] ),
    .B(_0339_),
    .C(_0501_),
    .X(_0502_));
 sky130_fd_sc_hd__o22a_4 _1083_ (.A1(wbs_data_i[27]),
    .A2(_0368_),
    .B1(_0502_),
    .B2(_0499_),
    .X(_0503_));
 sky130_fd_sc_hd__or2_4 _1084_ (.A(_0492_),
    .B(_0503_),
    .X(_0504_));
 sky130_fd_sc_hd__a21o_4 _1085_ (.A1(_0500_),
    .A2(_0504_),
    .B1(_0319_),
    .X(_0038_));
 sky130_fd_sc_hd__a21bo_4 _1086_ (.A1(wbs_data_i[26]),
    .A2(_0352_),
    .B1_N(_0502_),
    .X(_0505_));
 sky130_fd_sc_hd__nand2_4 _1087_ (.A(_0363_),
    .B(_0501_),
    .Y(_0506_));
 sky130_fd_sc_hd__a21boi_4 _1088_ (.A1(_0482_),
    .A2(_0506_),
    .B1_N(\configy.counter_d[2] ),
    .Y(_0507_));
 sky130_fd_sc_hd__a211o_4 _1089_ (.A1(_0482_),
    .A2(_0505_),
    .B1(_0507_),
    .C1(_0318_),
    .X(_0037_));
 sky130_fd_sc_hd__and2_4 _1090_ (.A(_0163_),
    .B(_0169_),
    .X(_0508_));
 sky130_fd_sc_hd__o22a_4 _1091_ (.A1(wbs_data_i[25]),
    .A2(_0346_),
    .B1(_0508_),
    .B2(_0506_),
    .X(_0509_));
 sky130_fd_sc_hd__and2_4 _1092_ (.A(_0163_),
    .B(_0492_),
    .X(_0510_));
 sky130_fd_sc_hd__a211o_4 _1093_ (.A1(_0482_),
    .A2(_0509_),
    .B1(_0510_),
    .C1(_0318_),
    .X(_0036_));
 sky130_fd_sc_hd__or2_4 _1094_ (.A(wbs_data_i[24]),
    .B(_0304_),
    .X(_0511_));
 sky130_fd_sc_hd__nand2_4 _1095_ (.A(_0169_),
    .B(_0378_),
    .Y(_0512_));
 sky130_fd_sc_hd__and3_4 _1096_ (.A(_0481_),
    .B(_0511_),
    .C(_0512_),
    .X(_0513_));
 sky130_fd_sc_hd__a211o_4 _1097_ (.A1(_0169_),
    .A2(_0492_),
    .B1(_0513_),
    .C1(_0318_),
    .X(_0035_));
 sky130_fd_sc_hd__o22a_4 _1098_ (.A1(\configy.charged[0] ),
    .A2(_0284_),
    .B1(wbs_sel_i[2]),
    .B2(\configy.charged[2] ),
    .X(_0514_));
 sky130_fd_sc_hd__o22a_4 _1099_ (.A1(\configy.charged[3] ),
    .A2(wbs_sel_i[3]),
    .B1(wbs_sel_i[1]),
    .B2(\configy.charged[1] ),
    .X(_0515_));
 sky130_fd_sc_hd__and3_4 _1100_ (.A(_0294_),
    .B(_0514_),
    .C(_0515_),
    .X(_0516_));
 sky130_fd_sc_hd__inv_2 _1101_ (.A(_0281_),
    .Y(_0517_));
 sky130_fd_sc_hd__and4_4 _1102_ (.A(_0280_),
    .B(_0517_),
    .C(wbs_we_i),
    .D(_0126_),
    .X(_0518_));
 sky130_fd_sc_hd__buf_2 _1103_ (.A(_0352_),
    .X(_0519_));
 sky130_fd_sc_hd__o21a_4 _1104_ (.A1(_0519_),
    .A2(_0313_),
    .B1(_0278_),
    .X(_0520_));
 sky130_fd_sc_hd__o21a_4 _1105_ (.A1(_0516_),
    .A2(_0518_),
    .B1(_0520_),
    .X(_0034_));
 sky130_fd_sc_hd__buf_2 _1106_ (.A(_0293_),
    .X(_0521_));
 sky130_fd_sc_hd__o21a_4 _1107_ (.A1(_0521_),
    .A2(_0295_),
    .B1(_0520_),
    .X(_0033_));
 sky130_fd_sc_hd__and3_4 _1108_ (.A(\configy.read_transaction_in_progress ),
    .B(_0517_),
    .C(_0109_),
    .X(_0032_));
 sky130_fd_sc_hd__nand2_4 _1109_ (.A(wbs_sel_i[1]),
    .B(_0294_),
    .Y(_0522_));
 sky130_fd_sc_hd__buf_2 _1110_ (.A(_0522_),
    .X(_0523_));
 sky130_fd_sc_hd__and2_4 _1111_ (.A(wbs_data_i[15]),
    .B(_0301_),
    .X(_0524_));
 sky130_fd_sc_hd__a21o_4 _1112_ (.A1(\configy.bits_b[7] ),
    .A2(_0523_),
    .B1(_0524_),
    .X(_0031_));
 sky130_fd_sc_hd__and2_4 _1113_ (.A(wbs_data_i[14]),
    .B(_0301_),
    .X(_0525_));
 sky130_fd_sc_hd__a21o_4 _1114_ (.A1(\configy.bits_b[6] ),
    .A2(_0523_),
    .B1(_0525_),
    .X(_0030_));
 sky130_fd_sc_hd__and2_4 _1115_ (.A(wbs_data_i[13]),
    .B(_0301_),
    .X(_0526_));
 sky130_fd_sc_hd__a21o_4 _1116_ (.A1(\configy.bits_b[5] ),
    .A2(_0523_),
    .B1(_0526_),
    .X(_0029_));
 sky130_fd_sc_hd__and2_4 _1117_ (.A(wbs_data_i[12]),
    .B(_0301_),
    .X(_0527_));
 sky130_fd_sc_hd__a21o_4 _1118_ (.A1(\configy.bits_b[4] ),
    .A2(_0523_),
    .B1(_0527_),
    .X(_0028_));
 sky130_fd_sc_hd__and2_4 _1119_ (.A(wbs_data_i[11]),
    .B(_0300_),
    .X(_0528_));
 sky130_fd_sc_hd__a21o_4 _1120_ (.A1(\configy.bits_b[3] ),
    .A2(_0523_),
    .B1(_0528_),
    .X(_0027_));
 sky130_fd_sc_hd__and2_4 _1121_ (.A(wbs_data_i[10]),
    .B(_0300_),
    .X(_0529_));
 sky130_fd_sc_hd__a21o_4 _1122_ (.A1(\configy.bits_b[2] ),
    .A2(_0522_),
    .B1(_0529_),
    .X(_0026_));
 sky130_fd_sc_hd__and2_4 _1123_ (.A(wbs_data_i[9]),
    .B(_0300_),
    .X(_0530_));
 sky130_fd_sc_hd__a21o_4 _1124_ (.A1(\configy.bits_b[1] ),
    .A2(_0522_),
    .B1(_0530_),
    .X(_0025_));
 sky130_fd_sc_hd__and2_4 _1125_ (.A(wbs_data_i[8]),
    .B(_0300_),
    .X(_0531_));
 sky130_fd_sc_hd__a21o_4 _1126_ (.A1(\configy.bits_b[0] ),
    .A2(_0522_),
    .B1(_0531_),
    .X(_0024_));
 sky130_fd_sc_hd__nand2_4 _1127_ (.A(wbs_sel_i[2]),
    .B(_0294_),
    .Y(_0532_));
 sky130_fd_sc_hd__buf_2 _1128_ (.A(_0532_),
    .X(_0533_));
 sky130_fd_sc_hd__and2_4 _1129_ (.A(wbs_data_i[23]),
    .B(_0299_),
    .X(_0534_));
 sky130_fd_sc_hd__a21o_4 _1130_ (.A1(\configy.bits_c[7] ),
    .A2(_0533_),
    .B1(_0534_),
    .X(_0023_));
 sky130_fd_sc_hd__and2_4 _1131_ (.A(wbs_data_i[22]),
    .B(_0299_),
    .X(_0535_));
 sky130_fd_sc_hd__a21o_4 _1132_ (.A1(\configy.bits_c[6] ),
    .A2(_0533_),
    .B1(_0535_),
    .X(_0022_));
 sky130_fd_sc_hd__and2_4 _1133_ (.A(wbs_data_i[21]),
    .B(_0299_),
    .X(_0536_));
 sky130_fd_sc_hd__a21o_4 _1134_ (.A1(\configy.bits_c[5] ),
    .A2(_0533_),
    .B1(_0536_),
    .X(_0021_));
 sky130_fd_sc_hd__and2_4 _1135_ (.A(wbs_data_i[20]),
    .B(_0299_),
    .X(_0537_));
 sky130_fd_sc_hd__a21o_4 _1136_ (.A1(\configy.bits_c[4] ),
    .A2(_0533_),
    .B1(_0537_),
    .X(_0020_));
 sky130_fd_sc_hd__and2_4 _1137_ (.A(wbs_data_i[19]),
    .B(_0298_),
    .X(_0538_));
 sky130_fd_sc_hd__a21o_4 _1138_ (.A1(\configy.bits_c[3] ),
    .A2(_0533_),
    .B1(_0538_),
    .X(_0019_));
 sky130_fd_sc_hd__and2_4 _1139_ (.A(wbs_data_i[18]),
    .B(_0298_),
    .X(_0539_));
 sky130_fd_sc_hd__a21o_4 _1140_ (.A1(\configy.bits_c[2] ),
    .A2(_0532_),
    .B1(_0539_),
    .X(_0018_));
 sky130_fd_sc_hd__and2_4 _1141_ (.A(wbs_data_i[17]),
    .B(_0298_),
    .X(_0540_));
 sky130_fd_sc_hd__a21o_4 _1142_ (.A1(\configy.bits_c[1] ),
    .A2(_0532_),
    .B1(_0540_),
    .X(_0017_));
 sky130_fd_sc_hd__and2_4 _1143_ (.A(wbs_data_i[16]),
    .B(_0298_),
    .X(_0541_));
 sky130_fd_sc_hd__a21o_4 _1144_ (.A1(\configy.bits_c[0] ),
    .A2(_0532_),
    .B1(_0541_),
    .X(_0016_));
 sky130_fd_sc_hd__nand2_4 _1145_ (.A(wbs_sel_i[3]),
    .B(_0294_),
    .Y(_0542_));
 sky130_fd_sc_hd__buf_2 _1146_ (.A(_0542_),
    .X(_0543_));
 sky130_fd_sc_hd__and2_4 _1147_ (.A(wbs_data_i[31]),
    .B(_0290_),
    .X(_0544_));
 sky130_fd_sc_hd__a21o_4 _1148_ (.A1(\configy.bits_d[7] ),
    .A2(_0543_),
    .B1(_0544_),
    .X(_0015_));
 sky130_fd_sc_hd__and2_4 _1149_ (.A(wbs_data_i[30]),
    .B(_0290_),
    .X(_0545_));
 sky130_fd_sc_hd__a21o_4 _1150_ (.A1(\configy.bits_d[6] ),
    .A2(_0543_),
    .B1(_0545_),
    .X(_0014_));
 sky130_fd_sc_hd__and2_4 _1151_ (.A(wbs_data_i[29]),
    .B(_0290_),
    .X(_0546_));
 sky130_fd_sc_hd__a21o_4 _1152_ (.A1(\configy.bits_d[5] ),
    .A2(_0543_),
    .B1(_0546_),
    .X(_0013_));
 sky130_fd_sc_hd__and2_4 _1153_ (.A(wbs_data_i[28]),
    .B(_0290_),
    .X(_0547_));
 sky130_fd_sc_hd__a21o_4 _1154_ (.A1(\configy.bits_d[4] ),
    .A2(_0543_),
    .B1(_0547_),
    .X(_0012_));
 sky130_fd_sc_hd__and2_4 _1155_ (.A(wbs_data_i[27]),
    .B(_0289_),
    .X(_0548_));
 sky130_fd_sc_hd__a21o_4 _1156_ (.A1(\configy.bits_d[3] ),
    .A2(_0543_),
    .B1(_0548_),
    .X(_0011_));
 sky130_fd_sc_hd__and2_4 _1157_ (.A(wbs_data_i[26]),
    .B(_0289_),
    .X(_0549_));
 sky130_fd_sc_hd__a21o_4 _1158_ (.A1(\configy.bits_d[2] ),
    .A2(_0542_),
    .B1(_0549_),
    .X(_0010_));
 sky130_fd_sc_hd__and2_4 _1159_ (.A(wbs_data_i[25]),
    .B(_0289_),
    .X(_0550_));
 sky130_fd_sc_hd__a21o_4 _1160_ (.A1(\configy.bits_d[1] ),
    .A2(_0542_),
    .B1(_0550_),
    .X(_0009_));
 sky130_fd_sc_hd__and2_4 _1161_ (.A(wbs_data_i[24]),
    .B(_0289_),
    .X(_0551_));
 sky130_fd_sc_hd__a21o_4 _1162_ (.A1(\configy.bits_d[0] ),
    .A2(_0542_),
    .B1(_0551_),
    .X(_0008_));
 sky130_fd_sc_hd__nand2_4 _1163_ (.A(_0284_),
    .B(_0288_),
    .Y(_0552_));
 sky130_fd_sc_hd__buf_2 _1164_ (.A(_0552_),
    .X(_0553_));
 sky130_fd_sc_hd__and2_4 _1165_ (.A(wbs_data_i[7]),
    .B(_0303_),
    .X(_0554_));
 sky130_fd_sc_hd__a21o_4 _1166_ (.A1(\configy.bits_a[7] ),
    .A2(_0553_),
    .B1(_0554_),
    .X(_0007_));
 sky130_fd_sc_hd__and2_4 _1167_ (.A(wbs_data_i[6]),
    .B(_0303_),
    .X(_0555_));
 sky130_fd_sc_hd__a21o_4 _1168_ (.A1(\configy.bits_a[6] ),
    .A2(_0553_),
    .B1(_0555_),
    .X(_0006_));
 sky130_fd_sc_hd__and2_4 _1169_ (.A(wbs_data_i[5]),
    .B(_0303_),
    .X(_0556_));
 sky130_fd_sc_hd__a21o_4 _1170_ (.A1(\configy.bits_a[5] ),
    .A2(_0553_),
    .B1(_0556_),
    .X(_0005_));
 sky130_fd_sc_hd__and2_4 _1171_ (.A(wbs_data_i[4]),
    .B(_0303_),
    .X(_0557_));
 sky130_fd_sc_hd__a21o_4 _1172_ (.A1(\configy.bits_a[4] ),
    .A2(_0553_),
    .B1(_0557_),
    .X(_0004_));
 sky130_fd_sc_hd__and2_4 _1173_ (.A(wbs_data_i[3]),
    .B(_0302_),
    .X(_0558_));
 sky130_fd_sc_hd__a21o_4 _1174_ (.A1(\configy.bits_a[3] ),
    .A2(_0553_),
    .B1(_0558_),
    .X(_0003_));
 sky130_fd_sc_hd__and2_4 _1175_ (.A(wbs_data_i[2]),
    .B(_0302_),
    .X(_0559_));
 sky130_fd_sc_hd__a21o_4 _1176_ (.A1(\configy.bits_a[2] ),
    .A2(_0552_),
    .B1(_0559_),
    .X(_0002_));
 sky130_fd_sc_hd__and2_4 _1177_ (.A(wbs_data_i[1]),
    .B(_0302_),
    .X(_0560_));
 sky130_fd_sc_hd__a21o_4 _1178_ (.A1(\configy.bits_a[1] ),
    .A2(_0552_),
    .B1(_0560_),
    .X(_0001_));
 sky130_fd_sc_hd__and2_4 _1179_ (.A(wbs_data_i[0]),
    .B(_0302_),
    .X(_0561_));
 sky130_fd_sc_hd__a21o_4 _1180_ (.A1(\configy.bits_a[0] ),
    .A2(_0552_),
    .B1(_0561_),
    .X(_0000_));
 sky130_fd_sc_hd__or3_4 _1181_ (.A(\configy.counter_d[7] ),
    .B(_0519_),
    .C(_0474_),
    .X(_0562_));
 sky130_fd_sc_hd__inv_2 _1182_ (.A(_0562_),
    .Y(set_out[3]));
 sky130_fd_sc_hd__or3_4 _1183_ (.A(\configy.counter_c[7] ),
    .B(_0519_),
    .C(_0433_),
    .X(_0563_));
 sky130_fd_sc_hd__inv_2 _1184_ (.A(_0563_),
    .Y(set_out[2]));
 sky130_fd_sc_hd__or3_4 _1185_ (.A(\configy.counter_b[7] ),
    .B(_0519_),
    .C(_0389_),
    .X(_0564_));
 sky130_fd_sc_hd__inv_2 _1186_ (.A(_0564_),
    .Y(set_out[1]));
 sky130_fd_sc_hd__or3_4 _1187_ (.A(\configy.counter_a[7] ),
    .B(_0519_),
    .C(_0333_),
    .X(_0565_));
 sky130_fd_sc_hd__inv_2 _1188_ (.A(_0565_),
    .Y(set_out[0]));
 sky130_fd_sc_hd__buf_2 _1189_ (.A(_0311_),
    .X(_0566_));
 sky130_fd_sc_hd__buf_2 _1190_ (.A(_0306_),
    .X(_0567_));
 sky130_fd_sc_hd__or2_4 _1191_ (.A(_0567_),
    .B(\configy.bits_d[2] ),
    .X(_0568_));
 sky130_fd_sc_hd__o21a_4 _1192_ (.A1(_0566_),
    .A2(\configy.bits_d[6] ),
    .B1(_0568_),
    .X(_0569_));
 sky130_fd_sc_hd__buf_2 _1193_ (.A(_0310_),
    .X(_0570_));
 sky130_fd_sc_hd__or2_4 _1194_ (.A(_0570_),
    .B(\configy.bits_d[7] ),
    .X(_0571_));
 sky130_fd_sc_hd__buf_2 _1195_ (.A(\configy.bits_index[2] ),
    .X(_0572_));
 sky130_fd_sc_hd__or2_4 _1196_ (.A(_0572_),
    .B(\configy.bits_d[3] ),
    .X(_0573_));
 sky130_fd_sc_hd__and3_4 _1197_ (.A(_0328_),
    .B(_0571_),
    .C(_0573_),
    .X(_0574_));
 sky130_fd_sc_hd__a211o_4 _1198_ (.A1(_0325_),
    .A2(_0569_),
    .B1(_0574_),
    .C1(_0322_),
    .X(_0575_));
 sky130_fd_sc_hd__or2_4 _1199_ (.A(_0567_),
    .B(\configy.bits_d[0] ),
    .X(_0576_));
 sky130_fd_sc_hd__o21a_4 _1200_ (.A1(_0566_),
    .A2(\configy.bits_d[4] ),
    .B1(_0576_),
    .X(_0577_));
 sky130_fd_sc_hd__or2_4 _1201_ (.A(_0570_),
    .B(\configy.bits_d[5] ),
    .X(_0578_));
 sky130_fd_sc_hd__or2_4 _1202_ (.A(_0572_),
    .B(\configy.bits_d[1] ),
    .X(_0579_));
 sky130_fd_sc_hd__and3_4 _1203_ (.A(_0327_),
    .B(_0578_),
    .C(_0579_),
    .X(_0580_));
 sky130_fd_sc_hd__a211o_4 _1204_ (.A1(_0325_),
    .A2(_0577_),
    .B1(_0580_),
    .C1(_0320_),
    .X(_0581_));
 sky130_fd_sc_hd__and3_4 _1205_ (.A(_0521_),
    .B(_0575_),
    .C(_0581_),
    .X(shift_out[3]));
 sky130_fd_sc_hd__or2_4 _1206_ (.A(_0566_),
    .B(\configy.bits_c[5] ),
    .X(_0582_));
 sky130_fd_sc_hd__or2_4 _1207_ (.A(_0307_),
    .B(\configy.bits_c[1] ),
    .X(_0583_));
 sky130_fd_sc_hd__and4_4 _1208_ (.A(_0322_),
    .B(_0328_),
    .C(_0582_),
    .D(_0583_),
    .X(_0584_));
 sky130_fd_sc_hd__or2_4 _1209_ (.A(_0307_),
    .B(\configy.bits_c[0] ),
    .X(_0585_));
 sky130_fd_sc_hd__or2_4 _1210_ (.A(_0311_),
    .B(\configy.bits_c[4] ),
    .X(_0586_));
 sky130_fd_sc_hd__or2_4 _1211_ (.A(_0306_),
    .B(\configy.bits_c[2] ),
    .X(_0587_));
 sky130_fd_sc_hd__or2_4 _1212_ (.A(_0310_),
    .B(\configy.bits_c[6] ),
    .X(_0588_));
 sky130_fd_sc_hd__or2_4 _1213_ (.A(_0572_),
    .B(\configy.bits_c[3] ),
    .X(_0589_));
 sky130_fd_sc_hd__o21a_4 _1214_ (.A1(_0570_),
    .A2(\configy.bits_c[7] ),
    .B1(_0327_),
    .X(_0590_));
 sky130_fd_sc_hd__a32o_4 _1215_ (.A1(_0323_),
    .A2(_0587_),
    .A3(_0588_),
    .B1(_0589_),
    .B2(_0590_),
    .X(_0591_));
 sky130_fd_sc_hd__a32o_4 _1216_ (.A1(_0324_),
    .A2(_0585_),
    .A3(_0586_),
    .B1(_0591_),
    .B2(_0320_),
    .X(_0592_));
 sky130_fd_sc_hd__o21a_4 _1217_ (.A1(_0584_),
    .A2(_0592_),
    .B1(_0521_),
    .X(shift_out[2]));
 sky130_fd_sc_hd__or2_4 _1218_ (.A(_0567_),
    .B(\configy.bits_b[2] ),
    .X(_0593_));
 sky130_fd_sc_hd__o21a_4 _1219_ (.A1(_0566_),
    .A2(\configy.bits_b[6] ),
    .B1(_0593_),
    .X(_0594_));
 sky130_fd_sc_hd__or2_4 _1220_ (.A(_0570_),
    .B(\configy.bits_b[7] ),
    .X(_0595_));
 sky130_fd_sc_hd__or2_4 _1221_ (.A(_0572_),
    .B(\configy.bits_b[3] ),
    .X(_0596_));
 sky130_fd_sc_hd__and3_4 _1222_ (.A(_0328_),
    .B(_0595_),
    .C(_0596_),
    .X(_0597_));
 sky130_fd_sc_hd__a211o_4 _1223_ (.A1(_0325_),
    .A2(_0594_),
    .B1(_0597_),
    .C1(_0322_),
    .X(_0598_));
 sky130_fd_sc_hd__or2_4 _1224_ (.A(_0567_),
    .B(\configy.bits_b[0] ),
    .X(_0599_));
 sky130_fd_sc_hd__o21a_4 _1225_ (.A1(_0566_),
    .A2(\configy.bits_b[4] ),
    .B1(_0599_),
    .X(_0600_));
 sky130_fd_sc_hd__or2_4 _1226_ (.A(_0570_),
    .B(\configy.bits_b[5] ),
    .X(_0601_));
 sky130_fd_sc_hd__or2_4 _1227_ (.A(_0572_),
    .B(\configy.bits_b[1] ),
    .X(_0602_));
 sky130_fd_sc_hd__and3_4 _1228_ (.A(_0327_),
    .B(_0601_),
    .C(_0602_),
    .X(_0603_));
 sky130_fd_sc_hd__a211o_4 _1229_ (.A1(_0325_),
    .A2(_0600_),
    .B1(_0603_),
    .C1(_0320_),
    .X(_0604_));
 sky130_fd_sc_hd__and3_4 _1230_ (.A(_0521_),
    .B(_0598_),
    .C(_0604_),
    .X(shift_out[1]));
 sky130_fd_sc_hd__or2_4 _1231_ (.A(_0306_),
    .B(\configy.bits_a[2] ),
    .X(_0605_));
 sky130_fd_sc_hd__or2_4 _1232_ (.A(_0310_),
    .B(\configy.bits_a[6] ),
    .X(_0606_));
 sky130_fd_sc_hd__or2_4 _1233_ (.A(_0306_),
    .B(\configy.bits_a[3] ),
    .X(_0607_));
 sky130_fd_sc_hd__o21a_4 _1234_ (.A1(_0310_),
    .A2(\configy.bits_a[7] ),
    .B1(_0327_),
    .X(_0608_));
 sky130_fd_sc_hd__a32o_4 _1235_ (.A1(_0323_),
    .A2(_0605_),
    .A3(_0606_),
    .B1(_0607_),
    .B2(_0608_),
    .X(_0609_));
 sky130_fd_sc_hd__or2_4 _1236_ (.A(_0307_),
    .B(\configy.bits_a[0] ),
    .X(_0610_));
 sky130_fd_sc_hd__or2_4 _1237_ (.A(_0311_),
    .B(\configy.bits_a[4] ),
    .X(_0611_));
 sky130_fd_sc_hd__and3_4 _1238_ (.A(_0324_),
    .B(_0610_),
    .C(_0611_),
    .X(_0612_));
 sky130_fd_sc_hd__or2_4 _1239_ (.A(_0311_),
    .B(\configy.bits_a[5] ),
    .X(_0613_));
 sky130_fd_sc_hd__or2_4 _1240_ (.A(_0567_),
    .B(\configy.bits_a[1] ),
    .X(_0614_));
 sky130_fd_sc_hd__and4_4 _1241_ (.A(_0322_),
    .B(_0328_),
    .C(_0613_),
    .D(_0614_),
    .X(_0615_));
 sky130_fd_sc_hd__a211o_4 _1242_ (.A1(_0320_),
    .A2(_0609_),
    .B1(_0612_),
    .C1(_0615_),
    .X(_0616_));
 sky130_fd_sc_hd__and2_4 _1243_ (.A(_0521_),
    .B(_0616_),
    .X(shift_out[0]));
 sky130_fd_sc_hd__or2_4 _1244_ (.A(\configy.free_run ),
    .B(_0293_),
    .X(cen));
 sky130_fd_sc_hd__or2_4 _1245_ (.A(wbs_data_o[31]),
    .B(_0126_),
    .X(_0617_));
 sky130_fd_sc_hd__and2_4 _1246_ (.A(\configy.bits_d[7] ),
    .B(_0258_),
    .X(_0618_));
 sky130_fd_sc_hd__a211o_4 _1247_ (.A1(\configy.counter_d[7] ),
    .A2(_0132_),
    .B1(_0142_),
    .C1(_0618_),
    .X(_0619_));
 sky130_fd_sc_hd__and3_4 _1248_ (.A(_0109_),
    .B(_0617_),
    .C(_0619_),
    .X(_0107_));
 sky130_fd_sc_hd__dfxtp_4 _1249_ (.D(_0000_),
    .Q(\configy.bits_a[0] ),
    .CLK(clknet_3_1_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1250_ (.D(_0001_),
    .Q(\configy.bits_a[1] ),
    .CLK(clknet_3_0_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1251_ (.D(_0002_),
    .Q(\configy.bits_a[2] ),
    .CLK(clknet_3_0_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1252_ (.D(_0003_),
    .Q(\configy.bits_a[3] ),
    .CLK(clknet_3_0_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1253_ (.D(_0004_),
    .Q(\configy.bits_a[4] ),
    .CLK(clknet_3_0_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1254_ (.D(_0005_),
    .Q(\configy.bits_a[5] ),
    .CLK(clknet_3_0_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1255_ (.D(_0006_),
    .Q(\configy.bits_a[6] ),
    .CLK(clknet_3_0_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1256_ (.D(_0007_),
    .Q(\configy.bits_a[7] ),
    .CLK(clknet_3_0_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1257_ (.D(_0008_),
    .Q(\configy.bits_d[0] ),
    .CLK(clknet_3_7_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1258_ (.D(_0009_),
    .Q(\configy.bits_d[1] ),
    .CLK(clknet_3_5_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1259_ (.D(_0010_),
    .Q(\configy.bits_d[2] ),
    .CLK(clknet_3_5_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1260_ (.D(_0011_),
    .Q(\configy.bits_d[3] ),
    .CLK(clknet_3_7_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1261_ (.D(_0012_),
    .Q(\configy.bits_d[4] ),
    .CLK(clknet_3_5_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1262_ (.D(_0013_),
    .Q(\configy.bits_d[5] ),
    .CLK(clknet_3_5_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1263_ (.D(_0014_),
    .Q(\configy.bits_d[6] ),
    .CLK(clknet_3_5_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1264_ (.D(_0015_),
    .Q(\configy.bits_d[7] ),
    .CLK(clknet_3_5_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1265_ (.D(_0016_),
    .Q(\configy.bits_c[0] ),
    .CLK(clknet_3_6_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1266_ (.D(_0017_),
    .Q(\configy.bits_c[1] ),
    .CLK(clknet_3_6_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1267_ (.D(_0018_),
    .Q(\configy.bits_c[2] ),
    .CLK(clknet_3_6_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1268_ (.D(_0019_),
    .Q(\configy.bits_c[3] ),
    .CLK(clknet_3_6_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1269_ (.D(_0020_),
    .Q(\configy.bits_c[4] ),
    .CLK(clknet_3_6_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1270_ (.D(_0021_),
    .Q(\configy.bits_c[5] ),
    .CLK(clknet_3_6_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1271_ (.D(_0022_),
    .Q(\configy.bits_c[6] ),
    .CLK(clknet_3_6_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1272_ (.D(_0023_),
    .Q(\configy.bits_c[7] ),
    .CLK(clknet_3_6_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1273_ (.D(_0024_),
    .Q(\configy.bits_b[0] ),
    .CLK(clknet_3_0_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1274_ (.D(_0025_),
    .Q(\configy.bits_b[1] ),
    .CLK(clknet_3_1_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1275_ (.D(_0026_),
    .Q(\configy.bits_b[2] ),
    .CLK(clknet_3_0_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1276_ (.D(_0027_),
    .Q(\configy.bits_b[3] ),
    .CLK(clknet_3_2_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1277_ (.D(_0028_),
    .Q(\configy.bits_b[4] ),
    .CLK(clknet_3_3_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1278_ (.D(_0029_),
    .Q(\configy.bits_b[5] ),
    .CLK(clknet_3_3_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1279_ (.D(_0030_),
    .Q(\configy.bits_b[6] ),
    .CLK(clknet_3_3_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1280_ (.D(_0031_),
    .Q(\configy.bits_b[7] ),
    .CLK(clknet_3_3_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1281_ (.D(_0032_),
    .Q(wbs_ack_o),
    .CLK(clknet_3_4_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1282_ (.D(_0033_),
    .Q(\configy.output_initiated ),
    .CLK(clknet_3_4_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1283_ (.D(_0034_),
    .Q(\configy.write_transaction_in_progress ),
    .CLK(clknet_3_1_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1284_ (.D(_0035_),
    .Q(\configy.counter_d[0] ),
    .CLK(clknet_3_4_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1285_ (.D(_0036_),
    .Q(\configy.counter_d[1] ),
    .CLK(clknet_3_5_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1286_ (.D(_0037_),
    .Q(\configy.counter_d[2] ),
    .CLK(clknet_3_5_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1287_ (.D(_0038_),
    .Q(\configy.counter_d[3] ),
    .CLK(clknet_3_5_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1288_ (.D(_0039_),
    .Q(\configy.counter_d[4] ),
    .CLK(clknet_3_4_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1289_ (.D(_0040_),
    .Q(\configy.counter_d[5] ),
    .CLK(clknet_3_5_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1290_ (.D(_0041_),
    .Q(\configy.counter_d[6] ),
    .CLK(clknet_3_5_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1291_ (.D(_0042_),
    .Q(\configy.counter_d[7] ),
    .CLK(clknet_3_5_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1292_ (.D(_0043_),
    .Q(\configy.counter_c[0] ),
    .CLK(clknet_3_5_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1293_ (.D(_0044_),
    .Q(\configy.counter_c[1] ),
    .CLK(clknet_3_5_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1294_ (.D(_0045_),
    .Q(\configy.counter_c[2] ),
    .CLK(clknet_3_5_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1295_ (.D(_0046_),
    .Q(\configy.counter_c[3] ),
    .CLK(clknet_3_5_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1296_ (.D(_0047_),
    .Q(\configy.counter_c[4] ),
    .CLK(clknet_3_4_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1297_ (.D(_0048_),
    .Q(\configy.counter_c[5] ),
    .CLK(clknet_3_7_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1298_ (.D(_0049_),
    .Q(\configy.counter_c[6] ),
    .CLK(clknet_3_4_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1299_ (.D(_0050_),
    .Q(\configy.counter_c[7] ),
    .CLK(clknet_3_4_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1300_ (.D(_0051_),
    .Q(\configy.counter_b[0] ),
    .CLK(clknet_3_0_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1301_ (.D(_0052_),
    .Q(\configy.counter_b[1] ),
    .CLK(clknet_3_0_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1302_ (.D(_0053_),
    .Q(\configy.counter_b[2] ),
    .CLK(clknet_3_0_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1303_ (.D(_0054_),
    .Q(\configy.counter_b[3] ),
    .CLK(clknet_3_0_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1304_ (.D(_0055_),
    .Q(\configy.counter_b[4] ),
    .CLK(clknet_3_1_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1305_ (.D(_0056_),
    .Q(\configy.counter_b[5] ),
    .CLK(clknet_3_3_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1306_ (.D(_0057_),
    .Q(\configy.counter_b[6] ),
    .CLK(clknet_3_1_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1307_ (.D(_0058_),
    .Q(\configy.counter_b[7] ),
    .CLK(clknet_3_1_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1308_ (.D(_0059_),
    .Q(\configy.counter_a[0] ),
    .CLK(clknet_3_0_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1309_ (.D(_0060_),
    .Q(\configy.counter_a[1] ),
    .CLK(clknet_3_0_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1310_ (.D(_0061_),
    .Q(\configy.counter_a[2] ),
    .CLK(clknet_3_0_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1311_ (.D(_0062_),
    .Q(\configy.counter_a[3] ),
    .CLK(clknet_3_0_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1312_ (.D(_0063_),
    .Q(\configy.counter_a[4] ),
    .CLK(clknet_3_1_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1313_ (.D(_0064_),
    .Q(\configy.counter_a[5] ),
    .CLK(clknet_3_0_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1314_ (.D(_0065_),
    .Q(\configy.counter_a[6] ),
    .CLK(clknet_3_1_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1315_ (.D(_0066_),
    .Q(\configy.counter_a[7] ),
    .CLK(clknet_3_1_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1316_ (.D(_0067_),
    .Q(\configy.bits_index[0] ),
    .CLK(clknet_3_3_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1317_ (.D(_0068_),
    .Q(\configy.bits_index[1] ),
    .CLK(clknet_3_3_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1318_ (.D(_0069_),
    .Q(\configy.bits_index[2] ),
    .CLK(clknet_3_3_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1319_ (.D(_0070_),
    .Q(\configy.charged[0] ),
    .CLK(clknet_3_1_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1320_ (.D(_0071_),
    .Q(\configy.charged[1] ),
    .CLK(clknet_3_4_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1321_ (.D(_0072_),
    .Q(\configy.charged[2] ),
    .CLK(clknet_3_4_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1322_ (.D(_0073_),
    .Q(\configy.charged[3] ),
    .CLK(clknet_3_4_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1323_ (.D(_0074_),
    .Q(\configy.free_run ),
    .CLK(clknet_3_1_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1324_ (.D(_0075_),
    .Q(\configy.read_transaction_in_progress ),
    .CLK(clknet_3_4_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1325_ (.D(_0076_),
    .Q(wbs_data_o[0]),
    .CLK(clknet_3_6_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1326_ (.D(_0077_),
    .Q(wbs_data_o[1]),
    .CLK(clknet_3_2_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1327_ (.D(_0078_),
    .Q(wbs_data_o[2]),
    .CLK(clknet_3_2_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1328_ (.D(_0079_),
    .Q(wbs_data_o[3]),
    .CLK(clknet_3_2_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1329_ (.D(_0080_),
    .Q(wbs_data_o[4]),
    .CLK(clknet_3_2_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1330_ (.D(_0081_),
    .Q(wbs_data_o[5]),
    .CLK(clknet_3_2_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1331_ (.D(_0082_),
    .Q(wbs_data_o[6]),
    .CLK(clknet_3_2_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1332_ (.D(_0083_),
    .Q(wbs_data_o[7]),
    .CLK(clknet_3_2_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1333_ (.D(_0084_),
    .Q(wbs_data_o[8]),
    .CLK(clknet_3_2_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1334_ (.D(_0085_),
    .Q(wbs_data_o[9]),
    .CLK(clknet_3_3_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1335_ (.D(_0086_),
    .Q(wbs_data_o[10]),
    .CLK(clknet_3_2_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1336_ (.D(_0087_),
    .Q(wbs_data_o[11]),
    .CLK(clknet_3_3_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1337_ (.D(_0088_),
    .Q(wbs_data_o[12]),
    .CLK(clknet_3_3_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1338_ (.D(_0089_),
    .Q(wbs_data_o[13]),
    .CLK(clknet_3_3_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1339_ (.D(_0090_),
    .Q(wbs_data_o[14]),
    .CLK(clknet_3_3_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1340_ (.D(_0091_),
    .Q(wbs_data_o[15]),
    .CLK(clknet_3_3_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1341_ (.D(_0092_),
    .Q(wbs_data_o[16]),
    .CLK(clknet_3_6_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1342_ (.D(_0093_),
    .Q(wbs_data_o[17]),
    .CLK(clknet_3_6_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1343_ (.D(_0094_),
    .Q(wbs_data_o[18]),
    .CLK(clknet_3_6_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1344_ (.D(_0095_),
    .Q(wbs_data_o[19]),
    .CLK(clknet_3_6_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1345_ (.D(_0096_),
    .Q(wbs_data_o[20]),
    .CLK(clknet_3_6_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1346_ (.D(_0097_),
    .Q(wbs_data_o[21]),
    .CLK(clknet_3_6_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1347_ (.D(_0098_),
    .Q(wbs_data_o[22]),
    .CLK(clknet_3_6_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1348_ (.D(_0099_),
    .Q(wbs_data_o[23]),
    .CLK(clknet_3_7_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1349_ (.D(_0100_),
    .Q(wbs_data_o[24]),
    .CLK(clknet_3_7_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1350_ (.D(_0101_),
    .Q(wbs_data_o[25]),
    .CLK(clknet_3_7_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1351_ (.D(_0102_),
    .Q(wbs_data_o[26]),
    .CLK(clknet_3_7_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1352_ (.D(_0103_),
    .Q(wbs_data_o[27]),
    .CLK(clknet_3_7_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1353_ (.D(_0104_),
    .Q(wbs_data_o[28]),
    .CLK(clknet_3_7_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1354_ (.D(_0105_),
    .Q(wbs_data_o[29]),
    .CLK(clknet_3_7_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1355_ (.D(_0106_),
    .Q(wbs_data_o[30]),
    .CLK(clknet_3_7_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1356_ (.D(_0107_),
    .Q(wbs_data_o[31]),
    .CLK(clknet_3_7_0_wb_clk_i));
 sky130_fd_sc_hd__decap_3 PHY_0 ();
 sky130_fd_sc_hd__decap_3 PHY_1 ();
 sky130_fd_sc_hd__decap_3 PHY_2 ();
 sky130_fd_sc_hd__decap_3 PHY_3 ();
 sky130_fd_sc_hd__decap_3 PHY_4 ();
 sky130_fd_sc_hd__decap_3 PHY_5 ();
 sky130_fd_sc_hd__decap_3 PHY_6 ();
 sky130_fd_sc_hd__decap_3 PHY_7 ();
 sky130_fd_sc_hd__decap_3 PHY_8 ();
 sky130_fd_sc_hd__decap_3 PHY_9 ();
 sky130_fd_sc_hd__decap_3 PHY_10 ();
 sky130_fd_sc_hd__decap_3 PHY_11 ();
 sky130_fd_sc_hd__decap_3 PHY_12 ();
 sky130_fd_sc_hd__decap_3 PHY_13 ();
 sky130_fd_sc_hd__decap_3 PHY_14 ();
 sky130_fd_sc_hd__decap_3 PHY_15 ();
 sky130_fd_sc_hd__decap_3 PHY_16 ();
 sky130_fd_sc_hd__decap_3 PHY_17 ();
 sky130_fd_sc_hd__decap_3 PHY_18 ();
 sky130_fd_sc_hd__decap_3 PHY_19 ();
 sky130_fd_sc_hd__decap_3 PHY_20 ();
 sky130_fd_sc_hd__decap_3 PHY_21 ();
 sky130_fd_sc_hd__decap_3 PHY_22 ();
 sky130_fd_sc_hd__decap_3 PHY_23 ();
 sky130_fd_sc_hd__decap_3 PHY_24 ();
 sky130_fd_sc_hd__decap_3 PHY_25 ();
 sky130_fd_sc_hd__decap_3 PHY_26 ();
 sky130_fd_sc_hd__decap_3 PHY_27 ();
 sky130_fd_sc_hd__decap_3 PHY_28 ();
 sky130_fd_sc_hd__decap_3 PHY_29 ();
 sky130_fd_sc_hd__decap_3 PHY_30 ();
 sky130_fd_sc_hd__decap_3 PHY_31 ();
 sky130_fd_sc_hd__decap_3 PHY_32 ();
 sky130_fd_sc_hd__decap_3 PHY_33 ();
 sky130_fd_sc_hd__decap_3 PHY_34 ();
 sky130_fd_sc_hd__decap_3 PHY_35 ();
 sky130_fd_sc_hd__decap_3 PHY_36 ();
 sky130_fd_sc_hd__decap_3 PHY_37 ();
 sky130_fd_sc_hd__decap_3 PHY_38 ();
 sky130_fd_sc_hd__decap_3 PHY_39 ();
 sky130_fd_sc_hd__decap_3 PHY_40 ();
 sky130_fd_sc_hd__decap_3 PHY_41 ();
 sky130_fd_sc_hd__decap_3 PHY_42 ();
 sky130_fd_sc_hd__decap_3 PHY_43 ();
 sky130_fd_sc_hd__decap_3 PHY_44 ();
 sky130_fd_sc_hd__decap_3 PHY_45 ();
 sky130_fd_sc_hd__decap_3 PHY_46 ();
 sky130_fd_sc_hd__decap_3 PHY_47 ();
 sky130_fd_sc_hd__decap_3 PHY_48 ();
 sky130_fd_sc_hd__decap_3 PHY_49 ();
 sky130_fd_sc_hd__decap_3 PHY_50 ();
 sky130_fd_sc_hd__decap_3 PHY_51 ();
 sky130_fd_sc_hd__decap_3 PHY_52 ();
 sky130_fd_sc_hd__decap_3 PHY_53 ();
 sky130_fd_sc_hd__decap_3 PHY_54 ();
 sky130_fd_sc_hd__decap_3 PHY_55 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_56 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_57 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_58 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_59 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_60 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_61 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_62 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_63 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_64 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_65 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_66 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_67 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_68 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_69 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_70 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_71 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_72 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_73 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_74 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_75 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_76 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_77 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_78 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_79 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_80 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_81 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_82 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_83 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_84 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_85 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_86 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_87 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_88 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_89 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_90 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_91 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_92 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_93 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_94 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_95 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_96 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_97 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_98 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_99 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_100 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_101 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_102 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_103 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_104 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_105 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_106 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_107 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_108 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_109 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_110 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_111 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_112 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_113 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_114 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_115 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_116 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_117 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_118 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_119 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_120 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_121 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_122 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_123 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_124 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_125 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_126 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_127 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_128 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_129 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_130 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_131 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_132 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_133 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_134 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_135 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_136 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_137 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_138 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_139 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_140 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_141 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_142 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_143 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_144 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_145 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_146 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_147 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_148 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_149 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_150 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_151 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_152 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_153 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_154 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_155 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_156 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_157 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_158 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_159 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_160 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_161 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_162 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_163 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_164 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_165 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_166 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_167 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_168 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_169 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_170 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_171 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_172 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_173 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_174 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_175 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_176 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_177 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_178 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_179 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_180 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_181 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_182 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_183 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_184 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_185 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_186 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_187 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_188 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_189 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_190 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_191 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_192 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_193 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_194 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_195 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_196 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_197 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_198 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_199 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_200 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_201 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_202 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_203 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_204 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_205 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_206 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_207 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_208 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_209 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_210 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_211 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_212 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_213 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_214 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_215 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_216 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_217 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_218 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_219 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_220 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_221 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_222 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_223 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_224 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_225 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_226 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_227 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_228 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_229 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_230 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_231 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_232 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_233 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_234 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_235 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_236 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_237 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_238 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_239 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_240 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_241 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_242 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_243 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_244 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_245 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_246 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_247 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_248 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_249 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_250 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_251 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_252 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_253 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_254 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_255 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_256 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_257 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_258 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_259 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_260 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_261 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_262 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_263 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_264 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_265 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_266 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_267 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_268 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_269 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_270 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_271 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_272 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_273 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_274 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_275 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_276 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_277 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_278 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_279 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_280 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_281 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_282 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_283 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_284 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_285 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_286 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_287 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_288 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_289 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_290 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_291 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_292 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_293 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_294 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_295 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_296 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_297 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_298 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_299 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_300 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_301 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_302 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_303 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_304 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_305 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_306 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_307 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_308 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_309 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_310 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_311 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_312 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_313 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_314 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_315 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_316 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_317 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_318 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_319 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_320 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_321 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_322 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_323 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_324 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_325 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_326 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_327 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_328 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_329 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_330 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_331 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_332 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_333 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_334 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_335 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_336 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_337 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_338 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_339 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_340 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_341 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_342 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_343 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_344 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_345 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_346 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_347 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_348 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_349 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_350 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_351 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_352 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_353 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_354 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_355 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_356 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_357 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_358 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_359 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_360 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_361 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_362 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_363 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_364 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_365 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_366 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_367 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_368 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_369 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_370 ();
 sky130_fd_sc_hd__clkbuf_16 clkbuf_0_wb_clk_i (.A(wb_clk_i),
    .X(clknet_0_wb_clk_i));
 sky130_fd_sc_hd__clkbuf_1 clkbuf_1_0_0_wb_clk_i (.A(clknet_0_wb_clk_i),
    .X(clknet_1_0_0_wb_clk_i));
 sky130_fd_sc_hd__clkbuf_1 clkbuf_1_1_0_wb_clk_i (.A(clknet_0_wb_clk_i),
    .X(clknet_1_1_0_wb_clk_i));
 sky130_fd_sc_hd__clkbuf_1 clkbuf_2_0_0_wb_clk_i (.A(clknet_1_0_0_wb_clk_i),
    .X(clknet_2_0_0_wb_clk_i));
 sky130_fd_sc_hd__clkbuf_1 clkbuf_2_1_0_wb_clk_i (.A(clknet_1_0_0_wb_clk_i),
    .X(clknet_2_1_0_wb_clk_i));
 sky130_fd_sc_hd__clkbuf_1 clkbuf_2_2_0_wb_clk_i (.A(clknet_1_1_0_wb_clk_i),
    .X(clknet_2_2_0_wb_clk_i));
 sky130_fd_sc_hd__clkbuf_1 clkbuf_2_3_0_wb_clk_i (.A(clknet_1_1_0_wb_clk_i),
    .X(clknet_2_3_0_wb_clk_i));
 sky130_fd_sc_hd__clkbuf_1 clkbuf_3_0_0_wb_clk_i (.A(clknet_2_0_0_wb_clk_i),
    .X(clknet_3_0_0_wb_clk_i));
 sky130_fd_sc_hd__clkbuf_1 clkbuf_3_1_0_wb_clk_i (.A(clknet_2_0_0_wb_clk_i),
    .X(clknet_3_1_0_wb_clk_i));
 sky130_fd_sc_hd__clkbuf_1 clkbuf_3_2_0_wb_clk_i (.A(clknet_2_1_0_wb_clk_i),
    .X(clknet_3_2_0_wb_clk_i));
 sky130_fd_sc_hd__clkbuf_1 clkbuf_3_3_0_wb_clk_i (.A(clknet_2_1_0_wb_clk_i),
    .X(clknet_3_3_0_wb_clk_i));
 sky130_fd_sc_hd__clkbuf_1 clkbuf_3_4_0_wb_clk_i (.A(clknet_2_2_0_wb_clk_i),
    .X(clknet_3_4_0_wb_clk_i));
 sky130_fd_sc_hd__clkbuf_1 clkbuf_3_5_0_wb_clk_i (.A(clknet_2_2_0_wb_clk_i),
    .X(clknet_3_5_0_wb_clk_i));
 sky130_fd_sc_hd__clkbuf_1 clkbuf_3_6_0_wb_clk_i (.A(clknet_2_3_0_wb_clk_i),
    .X(clknet_3_6_0_wb_clk_i));
 sky130_fd_sc_hd__clkbuf_1 clkbuf_3_7_0_wb_clk_i (.A(clknet_2_3_0_wb_clk_i),
    .X(clknet_3_7_0_wb_clk_i));
endmodule
