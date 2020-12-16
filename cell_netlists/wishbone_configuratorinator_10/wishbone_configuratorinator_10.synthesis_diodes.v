module wishbone_configuratorinator_10 (cen,
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

 sky130_fd_sc_hd__nor2_4 _0671_ (.A(wb_rst_i),
    .B(wbs_ack_o),
    .Y(_0108_));
 sky130_fd_sc_hd__buf_2 _0672_ (.A(_0108_),
    .X(_0109_));
 sky130_fd_sc_hd__buf_2 _0673_ (.A(_0109_),
    .X(_0110_));
 sky130_fd_sc_hd__inv_2 _0674_ (.A(wbs_addr_i[4]),
    .Y(_0111_));
 sky130_fd_sc_hd__or4_4 _0675_ (.A(wbs_addr_i[5]),
    .B(_0111_),
    .C(wbs_addr_i[7]),
    .D(wbs_addr_i[6]),
    .X(_0112_));
 sky130_fd_sc_hd__inv_2 _0676_ (.A(wbs_cyc_i),
    .Y(_0113_));
 sky130_fd_sc_hd__inv_2 _0677_ (.A(wbs_stb_i),
    .Y(_0114_));
 sky130_fd_sc_hd__or4_4 _0678_ (.A(\configy.read_transaction_in_progress ),
    .B(wbs_ack_o),
    .C(_0113_),
    .D(_0114_),
    .X(_0115_));
 sky130_fd_sc_hd__or4_4 _0679_ (.A(wbs_addr_i[16]),
    .B(wbs_addr_i[19]),
    .C(wbs_addr_i[21]),
    .D(wbs_addr_i[22]),
    .X(_0116_));
 sky130_fd_sc_hd__inv_2 _0680_ (.A(wbs_addr_i[28]),
    .Y(_0117_));
 sky130_fd_sc_hd__or4_4 _0681_ (.A(wbs_addr_i[25]),
    .B(wbs_addr_i[26]),
    .C(_0117_),
    .D(wbs_addr_i[31]),
    .X(_0118_));
 sky130_fd_sc_hd__nor4_4 _0682_ (.A(_0112_),
    .B(_0115_),
    .C(_0116_),
    .D(_0118_),
    .Y(_0119_));
 sky130_fd_sc_hd__buf_2 _0683_ (.A(_0119_),
    .X(_0120_));
 sky130_fd_sc_hd__buf_2 _0684_ (.A(_0120_),
    .X(_0121_));
 sky130_fd_sc_hd__or4_4 _0685_ (.A(wbs_addr_i[13]),
    .B(wbs_addr_i[12]),
    .C(wbs_addr_i[15]),
    .D(wbs_addr_i[14]),
    .X(_0122_));
 sky130_fd_sc_hd__or4_4 _0686_ (.A(wbs_addr_i[9]),
    .B(wbs_addr_i[8]),
    .C(wbs_addr_i[11]),
    .D(wbs_addr_i[10]),
    .X(_0123_));
 sky130_fd_sc_hd__or2_4 _0687_ (.A(_0122_),
    .B(_0123_),
    .X(_0124_));
 sky130_fd_sc_hd__or4_4 _0688_ (.A(wbs_addr_i[17]),
    .B(wbs_addr_i[18]),
    .C(wbs_addr_i[20]),
    .D(wbs_addr_i[23]),
    .X(_0125_));
 sky130_fd_sc_hd__inv_2 _0689_ (.A(wbs_addr_i[29]),
    .Y(_0126_));
 sky130_fd_sc_hd__or4_4 _0690_ (.A(wbs_addr_i[24]),
    .B(wbs_addr_i[27]),
    .C(_0126_),
    .D(wbs_addr_i[30]),
    .X(_0127_));
 sky130_fd_sc_hd__nor3_4 _0691_ (.A(_0124_),
    .B(_0125_),
    .C(_0127_),
    .Y(_0128_));
 sky130_fd_sc_hd__buf_2 _0692_ (.A(_0128_),
    .X(_0129_));
 sky130_fd_sc_hd__buf_2 _0693_ (.A(_0129_),
    .X(_0130_));
 sky130_fd_sc_hd__a21o_4 _0694_ (.A1(_0121_),
    .A2(_0130_),
    .B1(wbs_data_o[30]),
    .X(_0131_));
 sky130_fd_sc_hd__nor3_4 _0695_ (.A(wbs_addr_i[1]),
    .B(wbs_addr_i[0]),
    .C(wbs_addr_i[2]),
    .Y(_0132_));
 sky130_fd_sc_hd__and2_4 _0696_ (.A(wbs_addr_i[3]),
    .B(_0132_),
    .X(_0133_));
 sky130_fd_sc_hd__buf_2 _0697_ (.A(_0133_),
    .X(_0134_));
 sky130_fd_sc_hd__and2_4 _0698_ (.A(\configy.counter_d[6] ),
    .B(_0134_),
    .X(_0135_));
 sky130_fd_sc_hd__inv_2 _0699_ (.A(wbs_addr_i[1]),
    .Y(_0136_));
 sky130_fd_sc_hd__inv_2 _0700_ (.A(wbs_addr_i[0]),
    .Y(_0137_));
 sky130_fd_sc_hd__inv_2 _0701_ (.A(wbs_addr_i[3]),
    .Y(_0138_));
 sky130_fd_sc_hd__and4_4 _0702_ (.A(_0136_),
    .B(_0137_),
    .C(_0138_),
    .D(wbs_addr_i[2]),
    .X(_0139_));
 sky130_fd_sc_hd__buf_2 _0703_ (.A(_0139_),
    .X(_0140_));
 sky130_fd_sc_hd__and2_4 _0704_ (.A(\configy.bits_d[6] ),
    .B(_0140_),
    .X(_0141_));
 sky130_fd_sc_hd__or4_4 _0705_ (.A(_0112_),
    .B(_0115_),
    .C(_0116_),
    .D(_0118_),
    .X(_0142_));
 sky130_fd_sc_hd__buf_2 _0706_ (.A(_0142_),
    .X(_0143_));
 sky130_fd_sc_hd__or3_4 _0707_ (.A(_0124_),
    .B(_0125_),
    .C(_0127_),
    .X(_0144_));
 sky130_fd_sc_hd__buf_2 _0708_ (.A(_0144_),
    .X(_0145_));
 sky130_fd_sc_hd__buf_2 _0709_ (.A(_0145_),
    .X(_0146_));
 sky130_fd_sc_hd__or4_4 _0710_ (.A(_0135_),
    .B(_0141_),
    .C(_0143_),
    .D(_0146_),
    .X(_0147_));
 sky130_fd_sc_hd__and3_4 _0711_ (.A(_0110_),
    .B(_0131_),
    .C(_0147_),
    .X(_0106_));
 sky130_fd_sc_hd__a21o_4 _0712_ (.A1(_0121_),
    .A2(_0130_),
    .B1(wbs_data_o[29]),
    .X(_0148_));
 sky130_fd_sc_hd__buf_2 _0713_ (.A(\configy.counter_d[5] ),
    .X(_0149_));
 sky130_fd_sc_hd__buf_2 _0714_ (.A(_0134_),
    .X(_0150_));
 sky130_fd_sc_hd__and2_4 _0715_ (.A(_0149_),
    .B(_0150_),
    .X(_0151_));
 sky130_fd_sc_hd__buf_2 _0716_ (.A(_0140_),
    .X(_0152_));
 sky130_fd_sc_hd__and2_4 _0717_ (.A(\configy.bits_d[5] ),
    .B(_0152_),
    .X(_0153_));
 sky130_fd_sc_hd__or4_4 _0718_ (.A(_0143_),
    .B(_0146_),
    .C(_0151_),
    .D(_0153_),
    .X(_0154_));
 sky130_fd_sc_hd__and3_4 _0719_ (.A(_0110_),
    .B(_0148_),
    .C(_0154_),
    .X(_0105_));
 sky130_fd_sc_hd__a21o_4 _0720_ (.A1(_0121_),
    .A2(_0130_),
    .B1(wbs_data_o[28]),
    .X(_0155_));
 sky130_fd_sc_hd__and2_4 _0721_ (.A(\configy.counter_d[4] ),
    .B(_0150_),
    .X(_0156_));
 sky130_fd_sc_hd__and2_4 _0722_ (.A(\configy.bits_d[4] ),
    .B(_0152_),
    .X(_0157_));
 sky130_fd_sc_hd__or4_4 _0723_ (.A(_0143_),
    .B(_0146_),
    .C(_0156_),
    .D(_0157_),
    .X(_0158_));
 sky130_fd_sc_hd__and3_4 _0724_ (.A(_0110_),
    .B(_0155_),
    .C(_0158_),
    .X(_0104_));
 sky130_fd_sc_hd__a21o_4 _0725_ (.A1(_0121_),
    .A2(_0130_),
    .B1(wbs_data_o[27]),
    .X(_0159_));
 sky130_fd_sc_hd__and2_4 _0726_ (.A(\configy.counter_d[3] ),
    .B(_0150_),
    .X(_0160_));
 sky130_fd_sc_hd__and2_4 _0727_ (.A(\configy.bits_d[3] ),
    .B(_0152_),
    .X(_0161_));
 sky130_fd_sc_hd__or4_4 _0728_ (.A(_0143_),
    .B(_0146_),
    .C(_0160_),
    .D(_0161_),
    .X(_0162_));
 sky130_fd_sc_hd__and3_4 _0729_ (.A(_0110_),
    .B(_0159_),
    .C(_0162_),
    .X(_0103_));
 sky130_fd_sc_hd__buf_2 _0730_ (.A(_0109_),
    .X(_0163_));
 sky130_fd_sc_hd__buf_2 _0731_ (.A(_0119_),
    .X(_0164_));
 sky130_fd_sc_hd__buf_2 _0732_ (.A(_0164_),
    .X(_0165_));
 sky130_fd_sc_hd__buf_2 _0733_ (.A(_0128_),
    .X(_0166_));
 sky130_fd_sc_hd__buf_2 _0734_ (.A(_0166_),
    .X(_0167_));
 sky130_fd_sc_hd__a21o_4 _0735_ (.A1(_0165_),
    .A2(_0167_),
    .B1(wbs_data_o[26]),
    .X(_0168_));
 sky130_fd_sc_hd__and2_4 _0736_ (.A(\configy.counter_d[2] ),
    .B(_0150_),
    .X(_0169_));
 sky130_fd_sc_hd__and2_4 _0737_ (.A(\configy.bits_d[2] ),
    .B(_0152_),
    .X(_0170_));
 sky130_fd_sc_hd__or4_4 _0738_ (.A(_0143_),
    .B(_0146_),
    .C(_0169_),
    .D(_0170_),
    .X(_0171_));
 sky130_fd_sc_hd__and3_4 _0739_ (.A(_0163_),
    .B(_0168_),
    .C(_0171_),
    .X(_0102_));
 sky130_fd_sc_hd__a21o_4 _0740_ (.A1(_0165_),
    .A2(_0167_),
    .B1(wbs_data_o[25]),
    .X(_0172_));
 sky130_fd_sc_hd__buf_2 _0741_ (.A(_0142_),
    .X(_0173_));
 sky130_fd_sc_hd__buf_2 _0742_ (.A(_0173_),
    .X(_0174_));
 sky130_fd_sc_hd__buf_2 _0743_ (.A(_0145_),
    .X(_0175_));
 sky130_fd_sc_hd__buf_2 _0744_ (.A(\configy.counter_d[1] ),
    .X(_0176_));
 sky130_fd_sc_hd__and2_4 _0745_ (.A(_0176_),
    .B(_0150_),
    .X(_0177_));
 sky130_fd_sc_hd__and2_4 _0746_ (.A(\configy.bits_d[1] ),
    .B(_0152_),
    .X(_0178_));
 sky130_fd_sc_hd__or4_4 _0747_ (.A(_0174_),
    .B(_0175_),
    .C(_0177_),
    .D(_0178_),
    .X(_0179_));
 sky130_fd_sc_hd__and3_4 _0748_ (.A(_0163_),
    .B(_0172_),
    .C(_0179_),
    .X(_0101_));
 sky130_fd_sc_hd__a21o_4 _0749_ (.A1(_0165_),
    .A2(_0167_),
    .B1(wbs_data_o[24]),
    .X(_0180_));
 sky130_fd_sc_hd__buf_2 _0750_ (.A(\configy.counter_d[0] ),
    .X(_0181_));
 sky130_fd_sc_hd__buf_2 _0751_ (.A(_0134_),
    .X(_0182_));
 sky130_fd_sc_hd__and2_4 _0752_ (.A(_0181_),
    .B(_0182_),
    .X(_0183_));
 sky130_fd_sc_hd__buf_2 _0753_ (.A(_0140_),
    .X(_0184_));
 sky130_fd_sc_hd__and2_4 _0754_ (.A(\configy.bits_d[0] ),
    .B(_0184_),
    .X(_0185_));
 sky130_fd_sc_hd__or4_4 _0755_ (.A(_0174_),
    .B(_0175_),
    .C(_0183_),
    .D(_0185_),
    .X(_0186_));
 sky130_fd_sc_hd__and3_4 _0756_ (.A(_0163_),
    .B(_0180_),
    .C(_0186_),
    .X(_0100_));
 sky130_fd_sc_hd__a21o_4 _0757_ (.A1(_0165_),
    .A2(_0167_),
    .B1(wbs_data_o[23]),
    .X(_0187_));
 sky130_fd_sc_hd__and2_4 _0758_ (.A(\configy.counter_c[7] ),
    .B(_0182_),
    .X(_0188_));
 sky130_fd_sc_hd__and2_4 _0759_ (.A(\configy.bits_c[7] ),
    .B(_0184_),
    .X(_0189_));
 sky130_fd_sc_hd__or4_4 _0760_ (.A(_0174_),
    .B(_0175_),
    .C(_0188_),
    .D(_0189_),
    .X(_0190_));
 sky130_fd_sc_hd__and3_4 _0761_ (.A(_0163_),
    .B(_0187_),
    .C(_0190_),
    .X(_0099_));
 sky130_fd_sc_hd__a21o_4 _0762_ (.A1(_0165_),
    .A2(_0167_),
    .B1(wbs_data_o[22]),
    .X(_0191_));
 sky130_fd_sc_hd__and2_4 _0763_ (.A(\configy.counter_c[6] ),
    .B(_0182_),
    .X(_0192_));
 sky130_fd_sc_hd__and2_4 _0764_ (.A(\configy.bits_c[6] ),
    .B(_0184_),
    .X(_0193_));
 sky130_fd_sc_hd__or4_4 _0765_ (.A(_0174_),
    .B(_0175_),
    .C(_0192_),
    .D(_0193_),
    .X(_0194_));
 sky130_fd_sc_hd__and3_4 _0766_ (.A(_0163_),
    .B(_0191_),
    .C(_0194_),
    .X(_0098_));
 sky130_fd_sc_hd__buf_2 _0767_ (.A(_0108_),
    .X(_0195_));
 sky130_fd_sc_hd__buf_2 _0768_ (.A(_0120_),
    .X(_0196_));
 sky130_fd_sc_hd__buf_2 _0769_ (.A(_0129_),
    .X(_0197_));
 sky130_fd_sc_hd__a21o_4 _0770_ (.A1(_0196_),
    .A2(_0197_),
    .B1(wbs_data_o[21]),
    .X(_0198_));
 sky130_fd_sc_hd__buf_2 _0771_ (.A(\configy.counter_c[5] ),
    .X(_0199_));
 sky130_fd_sc_hd__and2_4 _0772_ (.A(_0199_),
    .B(_0182_),
    .X(_0200_));
 sky130_fd_sc_hd__and2_4 _0773_ (.A(\configy.bits_c[5] ),
    .B(_0184_),
    .X(_0201_));
 sky130_fd_sc_hd__or4_4 _0774_ (.A(_0174_),
    .B(_0175_),
    .C(_0200_),
    .D(_0201_),
    .X(_0202_));
 sky130_fd_sc_hd__and3_4 _0775_ (.A(_0195_),
    .B(_0198_),
    .C(_0202_),
    .X(_0097_));
 sky130_fd_sc_hd__a21o_4 _0776_ (.A1(_0196_),
    .A2(_0197_),
    .B1(wbs_data_o[20]),
    .X(_0203_));
 sky130_fd_sc_hd__buf_2 _0777_ (.A(_0173_),
    .X(_0204_));
 sky130_fd_sc_hd__buf_2 _0778_ (.A(_0145_),
    .X(_0205_));
 sky130_fd_sc_hd__and2_4 _0779_ (.A(\configy.counter_c[4] ),
    .B(_0182_),
    .X(_0206_));
 sky130_fd_sc_hd__and2_4 _0780_ (.A(\configy.bits_c[4] ),
    .B(_0184_),
    .X(_0207_));
 sky130_fd_sc_hd__or4_4 _0781_ (.A(_0204_),
    .B(_0205_),
    .C(_0206_),
    .D(_0207_),
    .X(_0208_));
 sky130_fd_sc_hd__and3_4 _0782_ (.A(_0195_),
    .B(_0203_),
    .C(_0208_),
    .X(_0096_));
 sky130_fd_sc_hd__a21o_4 _0783_ (.A1(_0196_),
    .A2(_0197_),
    .B1(wbs_data_o[19]),
    .X(_0209_));
 sky130_fd_sc_hd__buf_2 _0784_ (.A(_0134_),
    .X(_0210_));
 sky130_fd_sc_hd__and2_4 _0785_ (.A(\configy.counter_c[3] ),
    .B(_0210_),
    .X(_0211_));
 sky130_fd_sc_hd__buf_2 _0786_ (.A(_0140_),
    .X(_0212_));
 sky130_fd_sc_hd__and2_4 _0787_ (.A(\configy.bits_c[3] ),
    .B(_0212_),
    .X(_0213_));
 sky130_fd_sc_hd__or4_4 _0788_ (.A(_0204_),
    .B(_0205_),
    .C(_0211_),
    .D(_0213_),
    .X(_0214_));
 sky130_fd_sc_hd__and3_4 _0789_ (.A(_0195_),
    .B(_0209_),
    .C(_0214_),
    .X(_0095_));
 sky130_fd_sc_hd__a21o_4 _0790_ (.A1(_0196_),
    .A2(_0197_),
    .B1(wbs_data_o[18]),
    .X(_0215_));
 sky130_fd_sc_hd__and2_4 _0791_ (.A(\configy.counter_c[2] ),
    .B(_0210_),
    .X(_0216_));
 sky130_fd_sc_hd__and2_4 _0792_ (.A(\configy.bits_c[2] ),
    .B(_0212_),
    .X(_0217_));
 sky130_fd_sc_hd__or4_4 _0793_ (.A(_0204_),
    .B(_0205_),
    .C(_0216_),
    .D(_0217_),
    .X(_0218_));
 sky130_fd_sc_hd__and3_4 _0794_ (.A(_0195_),
    .B(_0215_),
    .C(_0218_),
    .X(_0094_));
 sky130_fd_sc_hd__a21o_4 _0795_ (.A1(_0196_),
    .A2(_0197_),
    .B1(wbs_data_o[17]),
    .X(_0219_));
 sky130_fd_sc_hd__buf_2 _0796_ (.A(\configy.counter_c[1] ),
    .X(_0220_));
 sky130_fd_sc_hd__and2_4 _0797_ (.A(_0220_),
    .B(_0210_),
    .X(_0221_));
 sky130_fd_sc_hd__and2_4 _0798_ (.A(\configy.bits_c[1] ),
    .B(_0212_),
    .X(_0222_));
 sky130_fd_sc_hd__or4_4 _0799_ (.A(_0204_),
    .B(_0205_),
    .C(_0221_),
    .D(_0222_),
    .X(_0223_));
 sky130_fd_sc_hd__and3_4 _0800_ (.A(_0195_),
    .B(_0219_),
    .C(_0223_),
    .X(_0093_));
 sky130_fd_sc_hd__buf_2 _0801_ (.A(_0108_),
    .X(_0224_));
 sky130_fd_sc_hd__buf_2 _0802_ (.A(_0120_),
    .X(_0225_));
 sky130_fd_sc_hd__buf_2 _0803_ (.A(_0129_),
    .X(_0226_));
 sky130_fd_sc_hd__a21o_4 _0804_ (.A1(_0225_),
    .A2(_0226_),
    .B1(wbs_data_o[16]),
    .X(_0227_));
 sky130_fd_sc_hd__buf_2 _0805_ (.A(\configy.counter_c[0] ),
    .X(_0228_));
 sky130_fd_sc_hd__and2_4 _0806_ (.A(_0228_),
    .B(_0210_),
    .X(_0229_));
 sky130_fd_sc_hd__and2_4 _0807_ (.A(\configy.bits_c[0] ),
    .B(_0212_),
    .X(_0230_));
 sky130_fd_sc_hd__or4_4 _0808_ (.A(_0204_),
    .B(_0205_),
    .C(_0229_),
    .D(_0230_),
    .X(_0231_));
 sky130_fd_sc_hd__and3_4 _0809_ (.A(_0224_),
    .B(_0227_),
    .C(_0231_),
    .X(_0092_));
 sky130_fd_sc_hd__a21o_4 _0810_ (.A1(_0225_),
    .A2(_0226_),
    .B1(wbs_data_o[15]),
    .X(_0232_));
 sky130_fd_sc_hd__buf_2 _0811_ (.A(_0173_),
    .X(_0233_));
 sky130_fd_sc_hd__buf_2 _0812_ (.A(_0144_),
    .X(_0234_));
 sky130_fd_sc_hd__and2_4 _0813_ (.A(\configy.counter_b[7] ),
    .B(_0210_),
    .X(_0235_));
 sky130_fd_sc_hd__and2_4 _0814_ (.A(\configy.bits_b[7] ),
    .B(_0212_),
    .X(_0236_));
 sky130_fd_sc_hd__or4_4 _0815_ (.A(_0233_),
    .B(_0234_),
    .C(_0235_),
    .D(_0236_),
    .X(_0237_));
 sky130_fd_sc_hd__and3_4 _0816_ (.A(_0224_),
    .B(_0232_),
    .C(_0237_),
    .X(_0091_));
 sky130_fd_sc_hd__a21o_4 _0817_ (.A1(_0225_),
    .A2(_0226_),
    .B1(wbs_data_o[14]),
    .X(_0238_));
 sky130_fd_sc_hd__buf_2 _0818_ (.A(_0134_),
    .X(_0239_));
 sky130_fd_sc_hd__and2_4 _0819_ (.A(\configy.counter_b[6] ),
    .B(_0239_),
    .X(_0240_));
 sky130_fd_sc_hd__buf_2 _0820_ (.A(_0139_),
    .X(_0241_));
 sky130_fd_sc_hd__buf_2 _0821_ (.A(_0241_),
    .X(_0242_));
 sky130_fd_sc_hd__and2_4 _0822_ (.A(\configy.bits_b[6] ),
    .B(_0242_),
    .X(_0243_));
 sky130_fd_sc_hd__or4_4 _0823_ (.A(_0233_),
    .B(_0234_),
    .C(_0240_),
    .D(_0243_),
    .X(_0244_));
 sky130_fd_sc_hd__and3_4 _0824_ (.A(_0224_),
    .B(_0238_),
    .C(_0244_),
    .X(_0090_));
 sky130_fd_sc_hd__a21o_4 _0825_ (.A1(_0225_),
    .A2(_0226_),
    .B1(wbs_data_o[13]),
    .X(_0245_));
 sky130_fd_sc_hd__buf_2 _0826_ (.A(\configy.counter_b[5] ),
    .X(_0246_));
 sky130_fd_sc_hd__and2_4 _0827_ (.A(_0246_),
    .B(_0239_),
    .X(_0247_));
 sky130_fd_sc_hd__and2_4 _0828_ (.A(\configy.bits_b[5] ),
    .B(_0242_),
    .X(_0248_));
 sky130_fd_sc_hd__or4_4 _0829_ (.A(_0233_),
    .B(_0234_),
    .C(_0247_),
    .D(_0248_),
    .X(_0249_));
 sky130_fd_sc_hd__and3_4 _0830_ (.A(_0224_),
    .B(_0245_),
    .C(_0249_),
    .X(_0089_));
 sky130_fd_sc_hd__a21o_4 _0831_ (.A1(_0225_),
    .A2(_0226_),
    .B1(wbs_data_o[12]),
    .X(_0250_));
 sky130_fd_sc_hd__and2_4 _0832_ (.A(\configy.counter_b[4] ),
    .B(_0239_),
    .X(_0251_));
 sky130_fd_sc_hd__and2_4 _0833_ (.A(\configy.bits_b[4] ),
    .B(_0242_),
    .X(_0252_));
 sky130_fd_sc_hd__or4_4 _0834_ (.A(_0233_),
    .B(_0234_),
    .C(_0251_),
    .D(_0252_),
    .X(_0253_));
 sky130_fd_sc_hd__and3_4 _0835_ (.A(_0224_),
    .B(_0250_),
    .C(_0253_),
    .X(_0088_));
 sky130_fd_sc_hd__buf_2 _0836_ (.A(_0108_),
    .X(_0254_));
 sky130_fd_sc_hd__buf_2 _0837_ (.A(_0120_),
    .X(_0255_));
 sky130_fd_sc_hd__buf_2 _0838_ (.A(_0129_),
    .X(_0256_));
 sky130_fd_sc_hd__a21o_4 _0839_ (.A1(_0255_),
    .A2(_0256_),
    .B1(wbs_data_o[11]),
    .X(_0257_));
 sky130_fd_sc_hd__and2_4 _0840_ (.A(\configy.counter_b[3] ),
    .B(_0239_),
    .X(_0258_));
 sky130_fd_sc_hd__and2_4 _0841_ (.A(\configy.bits_b[3] ),
    .B(_0242_),
    .X(_0259_));
 sky130_fd_sc_hd__or4_4 _0842_ (.A(_0233_),
    .B(_0234_),
    .C(_0258_),
    .D(_0259_),
    .X(_0260_));
 sky130_fd_sc_hd__and3_4 _0843_ (.A(_0254_),
    .B(_0257_),
    .C(_0260_),
    .X(_0087_));
 sky130_fd_sc_hd__a21o_4 _0844_ (.A1(_0255_),
    .A2(_0256_),
    .B1(wbs_data_o[10]),
    .X(_0261_));
 sky130_fd_sc_hd__buf_2 _0845_ (.A(_0142_),
    .X(_0262_));
 sky130_fd_sc_hd__buf_2 _0846_ (.A(_0144_),
    .X(_0263_));
 sky130_fd_sc_hd__and2_4 _0847_ (.A(\configy.counter_b[2] ),
    .B(_0239_),
    .X(_0264_));
 sky130_fd_sc_hd__and2_4 _0848_ (.A(\configy.bits_b[2] ),
    .B(_0242_),
    .X(_0265_));
 sky130_fd_sc_hd__or4_4 _0849_ (.A(_0262_),
    .B(_0263_),
    .C(_0264_),
    .D(_0265_),
    .X(_0266_));
 sky130_fd_sc_hd__and3_4 _0850_ (.A(_0254_),
    .B(_0261_),
    .C(_0266_),
    .X(_0086_));
 sky130_fd_sc_hd__a21o_4 _0851_ (.A1(_0255_),
    .A2(_0256_),
    .B1(wbs_data_o[9]),
    .X(_0267_));
 sky130_fd_sc_hd__buf_2 _0852_ (.A(\configy.counter_b[1] ),
    .X(_0268_));
 sky130_fd_sc_hd__buf_2 _0853_ (.A(_0133_),
    .X(_0269_));
 sky130_fd_sc_hd__and2_4 _0854_ (.A(_0268_),
    .B(_0269_),
    .X(_0270_));
 sky130_fd_sc_hd__buf_2 _0855_ (.A(_0241_),
    .X(_0271_));
 sky130_fd_sc_hd__and2_4 _0856_ (.A(\configy.bits_b[1] ),
    .B(_0271_),
    .X(_0272_));
 sky130_fd_sc_hd__or4_4 _0857_ (.A(_0262_),
    .B(_0263_),
    .C(_0270_),
    .D(_0272_),
    .X(_0273_));
 sky130_fd_sc_hd__and3_4 _0858_ (.A(_0254_),
    .B(_0267_),
    .C(_0273_),
    .X(_0085_));
 sky130_fd_sc_hd__a21o_4 _0859_ (.A1(_0255_),
    .A2(_0256_),
    .B1(wbs_data_o[8]),
    .X(_0274_));
 sky130_fd_sc_hd__buf_2 _0860_ (.A(\configy.counter_b[0] ),
    .X(_0275_));
 sky130_fd_sc_hd__and2_4 _0861_ (.A(_0275_),
    .B(_0269_),
    .X(_0276_));
 sky130_fd_sc_hd__and2_4 _0862_ (.A(\configy.bits_b[0] ),
    .B(_0271_),
    .X(_0277_));
 sky130_fd_sc_hd__or4_4 _0863_ (.A(_0262_),
    .B(_0263_),
    .C(_0276_),
    .D(_0277_),
    .X(_0278_));
 sky130_fd_sc_hd__and3_4 _0864_ (.A(_0254_),
    .B(_0274_),
    .C(_0278_),
    .X(_0084_));
 sky130_fd_sc_hd__a21o_4 _0865_ (.A1(_0255_),
    .A2(_0256_),
    .B1(wbs_data_o[7]),
    .X(_0279_));
 sky130_fd_sc_hd__and2_4 _0866_ (.A(\configy.counter_a[7] ),
    .B(_0269_),
    .X(_0280_));
 sky130_fd_sc_hd__and2_4 _0867_ (.A(\configy.bits_a[7] ),
    .B(_0271_),
    .X(_0281_));
 sky130_fd_sc_hd__or4_4 _0868_ (.A(_0262_),
    .B(_0263_),
    .C(_0280_),
    .D(_0281_),
    .X(_0282_));
 sky130_fd_sc_hd__and3_4 _0869_ (.A(_0254_),
    .B(_0279_),
    .C(_0282_),
    .X(_0083_));
 sky130_fd_sc_hd__buf_2 _0870_ (.A(_0108_),
    .X(_0283_));
 sky130_fd_sc_hd__buf_2 _0871_ (.A(_0120_),
    .X(_0284_));
 sky130_fd_sc_hd__buf_2 _0872_ (.A(_0129_),
    .X(_0285_));
 sky130_fd_sc_hd__a21o_4 _0873_ (.A1(_0284_),
    .A2(_0285_),
    .B1(wbs_data_o[6]),
    .X(_0286_));
 sky130_fd_sc_hd__and2_4 _0874_ (.A(\configy.counter_a[6] ),
    .B(_0269_),
    .X(_0287_));
 sky130_fd_sc_hd__and2_4 _0875_ (.A(\configy.bits_a[6] ),
    .B(_0271_),
    .X(_0288_));
 sky130_fd_sc_hd__or4_4 _0876_ (.A(_0262_),
    .B(_0263_),
    .C(_0287_),
    .D(_0288_),
    .X(_0289_));
 sky130_fd_sc_hd__and3_4 _0877_ (.A(_0283_),
    .B(_0286_),
    .C(_0289_),
    .X(_0082_));
 sky130_fd_sc_hd__a21o_4 _0878_ (.A1(_0284_),
    .A2(_0285_),
    .B1(wbs_data_o[5]),
    .X(_0290_));
 sky130_fd_sc_hd__buf_2 _0879_ (.A(_0142_),
    .X(_0291_));
 sky130_fd_sc_hd__buf_2 _0880_ (.A(_0144_),
    .X(_0292_));
 sky130_fd_sc_hd__buf_2 _0881_ (.A(\configy.counter_a[5] ),
    .X(_0293_));
 sky130_fd_sc_hd__and2_4 _0882_ (.A(_0293_),
    .B(_0269_),
    .X(_0294_));
 sky130_fd_sc_hd__and2_4 _0883_ (.A(\configy.bits_a[5] ),
    .B(_0271_),
    .X(_0295_));
 sky130_fd_sc_hd__or4_4 _0884_ (.A(_0291_),
    .B(_0292_),
    .C(_0294_),
    .D(_0295_),
    .X(_0296_));
 sky130_fd_sc_hd__and3_4 _0885_ (.A(_0283_),
    .B(_0290_),
    .C(_0296_),
    .X(_0081_));
 sky130_fd_sc_hd__a21o_4 _0886_ (.A1(_0284_),
    .A2(_0285_),
    .B1(wbs_data_o[4]),
    .X(_0297_));
 sky130_fd_sc_hd__buf_2 _0887_ (.A(_0133_),
    .X(_0298_));
 sky130_fd_sc_hd__and2_4 _0888_ (.A(\configy.counter_a[4] ),
    .B(_0298_),
    .X(_0299_));
 sky130_fd_sc_hd__buf_2 _0889_ (.A(_0241_),
    .X(_0300_));
 sky130_fd_sc_hd__and2_4 _0890_ (.A(\configy.bits_a[4] ),
    .B(_0300_),
    .X(_0301_));
 sky130_fd_sc_hd__or4_4 _0891_ (.A(_0291_),
    .B(_0292_),
    .C(_0299_),
    .D(_0301_),
    .X(_0302_));
 sky130_fd_sc_hd__and3_4 _0892_ (.A(_0283_),
    .B(_0297_),
    .C(_0302_),
    .X(_0080_));
 sky130_fd_sc_hd__a21o_4 _0893_ (.A1(_0284_),
    .A2(_0285_),
    .B1(wbs_data_o[3]),
    .X(_0303_));
 sky130_fd_sc_hd__and2_4 _0894_ (.A(\configy.counter_a[3] ),
    .B(_0298_),
    .X(_0304_));
 sky130_fd_sc_hd__and2_4 _0895_ (.A(\configy.bits_a[3] ),
    .B(_0300_),
    .X(_0305_));
 sky130_fd_sc_hd__or4_4 _0896_ (.A(_0291_),
    .B(_0292_),
    .C(_0304_),
    .D(_0305_),
    .X(_0306_));
 sky130_fd_sc_hd__and3_4 _0897_ (.A(_0283_),
    .B(_0303_),
    .C(_0306_),
    .X(_0079_));
 sky130_fd_sc_hd__a21o_4 _0898_ (.A1(_0284_),
    .A2(_0285_),
    .B1(wbs_data_o[2]),
    .X(_0307_));
 sky130_fd_sc_hd__and2_4 _0899_ (.A(\configy.counter_a[2] ),
    .B(_0298_),
    .X(_0308_));
 sky130_fd_sc_hd__and2_4 _0900_ (.A(\configy.bits_a[2] ),
    .B(_0300_),
    .X(_0309_));
 sky130_fd_sc_hd__or4_4 _0901_ (.A(_0291_),
    .B(_0292_),
    .C(_0308_),
    .D(_0309_),
    .X(_0310_));
 sky130_fd_sc_hd__and3_4 _0902_ (.A(_0283_),
    .B(_0307_),
    .C(_0310_),
    .X(_0078_));
 sky130_fd_sc_hd__a21o_4 _0903_ (.A1(_0164_),
    .A2(_0166_),
    .B1(wbs_data_o[1]),
    .X(_0311_));
 sky130_fd_sc_hd__buf_2 _0904_ (.A(\configy.counter_a[1] ),
    .X(_0312_));
 sky130_fd_sc_hd__and2_4 _0905_ (.A(_0312_),
    .B(_0298_),
    .X(_0313_));
 sky130_fd_sc_hd__and2_4 _0906_ (.A(\configy.bits_a[1] ),
    .B(_0300_),
    .X(_0314_));
 sky130_fd_sc_hd__or4_4 _0907_ (.A(_0291_),
    .B(_0292_),
    .C(_0313_),
    .D(_0314_),
    .X(_0315_));
 sky130_fd_sc_hd__and3_4 _0908_ (.A(_0109_),
    .B(_0311_),
    .C(_0315_),
    .X(_0077_));
 sky130_fd_sc_hd__a21o_4 _0909_ (.A1(_0164_),
    .A2(_0166_),
    .B1(wbs_data_o[0]),
    .X(_0316_));
 sky130_fd_sc_hd__and2_4 _0910_ (.A(\configy.bits_a[0] ),
    .B(_0140_),
    .X(_0317_));
 sky130_fd_sc_hd__and2_4 _0911_ (.A(_0138_),
    .B(_0132_),
    .X(_0318_));
 sky130_fd_sc_hd__buf_2 _0912_ (.A(\configy.counter_a[0] ),
    .X(_0319_));
 sky130_fd_sc_hd__and3_4 _0913_ (.A(_0319_),
    .B(wbs_addr_i[3]),
    .C(_0132_),
    .X(_0320_));
 sky130_fd_sc_hd__a21o_4 _0914_ (.A1(\configy.free_run ),
    .A2(_0318_),
    .B1(_0320_),
    .X(_0321_));
 sky130_fd_sc_hd__or4_4 _0915_ (.A(_0173_),
    .B(_0145_),
    .C(_0317_),
    .D(_0321_),
    .X(_0322_));
 sky130_fd_sc_hd__and3_4 _0916_ (.A(_0109_),
    .B(_0316_),
    .C(_0322_),
    .X(_0076_));
 sky130_fd_sc_hd__buf_2 _0917_ (.A(wb_rst_i),
    .X(_0323_));
 sky130_fd_sc_hd__buf_2 _0918_ (.A(_0323_),
    .X(_0324_));
 sky130_fd_sc_hd__a21oi_4 _0919_ (.A1(_0121_),
    .A2(_0130_),
    .B1(\configy.read_transaction_in_progress ),
    .Y(_0325_));
 sky130_fd_sc_hd__buf_2 _0920_ (.A(\configy.write_transaction_in_progress ),
    .X(_0326_));
 sky130_fd_sc_hd__inv_2 _0921_ (.A(_0326_),
    .Y(_0327_));
 sky130_fd_sc_hd__and2_4 _0922_ (.A(\configy.read_transaction_in_progress ),
    .B(_0327_),
    .X(_0328_));
 sky130_fd_sc_hd__nor3_4 _0923_ (.A(_0324_),
    .B(_0325_),
    .C(_0328_),
    .Y(_0075_));
 sky130_fd_sc_hd__inv_2 _0924_ (.A(wbs_data_i[0]),
    .Y(_0329_));
 sky130_fd_sc_hd__buf_2 _0925_ (.A(wbs_sel_i[0]),
    .X(_0330_));
 sky130_fd_sc_hd__and4_4 _0926_ (.A(_0138_),
    .B(_0330_),
    .C(_0326_),
    .D(_0132_),
    .X(_0331_));
 sky130_fd_sc_hd__buf_2 _0927_ (.A(wb_rst_i),
    .X(_0332_));
 sky130_fd_sc_hd__inv_2 _0928_ (.A(_0332_),
    .Y(_0333_));
 sky130_fd_sc_hd__o21ai_4 _0929_ (.A1(\configy.free_run ),
    .A2(_0331_),
    .B1(_0333_),
    .Y(_0334_));
 sky130_fd_sc_hd__a21oi_4 _0930_ (.A1(_0329_),
    .A2(_0331_),
    .B1(_0334_),
    .Y(_0074_));
 sky130_fd_sc_hd__and3_4 _0931_ (.A(wbs_addr_i[3]),
    .B(\configy.write_transaction_in_progress ),
    .C(_0132_),
    .X(_0335_));
 sky130_fd_sc_hd__buf_2 _0932_ (.A(_0335_),
    .X(_0336_));
 sky130_fd_sc_hd__and2_4 _0933_ (.A(wbs_sel_i[3]),
    .B(_0336_),
    .X(_0337_));
 sky130_fd_sc_hd__buf_2 _0934_ (.A(_0337_),
    .X(_0338_));
 sky130_fd_sc_hd__buf_2 _0935_ (.A(\configy.output_initiated ),
    .X(_0339_));
 sky130_fd_sc_hd__buf_2 _0936_ (.A(_0339_),
    .X(_0340_));
 sky130_fd_sc_hd__buf_2 _0937_ (.A(_0340_),
    .X(_0341_));
 sky130_fd_sc_hd__buf_2 _0938_ (.A(_0336_),
    .X(_0342_));
 sky130_fd_sc_hd__and4_4 _0939_ (.A(\configy.charged[3] ),
    .B(\configy.charged[2] ),
    .C(\configy.charged[1] ),
    .D(\configy.charged[0] ),
    .X(_0343_));
 sky130_fd_sc_hd__or2_4 _0940_ (.A(wb_rst_i),
    .B(_0343_),
    .X(_0344_));
 sky130_fd_sc_hd__a21oi_4 _0941_ (.A1(_0341_),
    .A2(_0342_),
    .B1(_0344_),
    .Y(_0345_));
 sky130_fd_sc_hd__o21a_4 _0942_ (.A1(\configy.charged[3] ),
    .A2(_0338_),
    .B1(_0345_),
    .X(_0073_));
 sky130_fd_sc_hd__and2_4 _0943_ (.A(wbs_sel_i[2]),
    .B(_0336_),
    .X(_0346_));
 sky130_fd_sc_hd__buf_2 _0944_ (.A(_0346_),
    .X(_0347_));
 sky130_fd_sc_hd__o21a_4 _0945_ (.A1(\configy.charged[2] ),
    .A2(_0347_),
    .B1(_0345_),
    .X(_0072_));
 sky130_fd_sc_hd__and2_4 _0946_ (.A(wbs_sel_i[1]),
    .B(_0335_),
    .X(_0348_));
 sky130_fd_sc_hd__buf_2 _0947_ (.A(_0348_),
    .X(_0349_));
 sky130_fd_sc_hd__o21a_4 _0948_ (.A1(\configy.charged[1] ),
    .A2(_0349_),
    .B1(_0345_),
    .X(_0071_));
 sky130_fd_sc_hd__and2_4 _0949_ (.A(_0330_),
    .B(_0335_),
    .X(_0350_));
 sky130_fd_sc_hd__buf_2 _0950_ (.A(_0350_),
    .X(_0351_));
 sky130_fd_sc_hd__o21a_4 _0951_ (.A1(\configy.charged[0] ),
    .A2(_0351_),
    .B1(_0345_),
    .X(_0070_));
 sky130_fd_sc_hd__buf_2 _0952_ (.A(\configy.bits_index[2] ),
    .X(_0352_));
 sky130_fd_sc_hd__buf_2 _0953_ (.A(_0352_),
    .X(_0353_));
 sky130_fd_sc_hd__and2_4 _0954_ (.A(\configy.bits_index[1] ),
    .B(\configy.bits_index[0] ),
    .X(_0354_));
 sky130_fd_sc_hd__or2_4 _0955_ (.A(_0353_),
    .B(_0354_),
    .X(_0355_));
 sky130_fd_sc_hd__and2_4 _0956_ (.A(_0353_),
    .B(_0354_),
    .X(_0356_));
 sky130_fd_sc_hd__inv_2 _0957_ (.A(_0356_),
    .Y(_0357_));
 sky130_fd_sc_hd__buf_2 _0958_ (.A(\configy.output_initiated ),
    .X(_0358_));
 sky130_fd_sc_hd__buf_2 _0959_ (.A(_0358_),
    .X(_0359_));
 sky130_fd_sc_hd__buf_2 _0960_ (.A(_0359_),
    .X(_0360_));
 sky130_fd_sc_hd__nor2_4 _0961_ (.A(_0360_),
    .B(_0336_),
    .Y(_0361_));
 sky130_fd_sc_hd__a32o_4 _0962_ (.A1(_0341_),
    .A2(_0355_),
    .A3(_0357_),
    .B1(_0361_),
    .B2(_0353_),
    .X(_0362_));
 sky130_fd_sc_hd__and2_4 _0963_ (.A(_0333_),
    .B(_0362_),
    .X(_0069_));
 sky130_fd_sc_hd__inv_2 _0964_ (.A(\configy.output_initiated ),
    .Y(_0363_));
 sky130_fd_sc_hd__buf_2 _0965_ (.A(_0363_),
    .X(_0364_));
 sky130_fd_sc_hd__buf_2 _0966_ (.A(_0364_),
    .X(_0365_));
 sky130_fd_sc_hd__buf_2 _0967_ (.A(_0365_),
    .X(_0366_));
 sky130_fd_sc_hd__buf_2 _0968_ (.A(\configy.bits_index[1] ),
    .X(_0367_));
 sky130_fd_sc_hd__a2bb2o_4 _0969_ (.A1_N(_0366_),
    .A2_N(_0354_),
    .B1(_0361_),
    .B2(_0367_),
    .X(_0368_));
 sky130_fd_sc_hd__inv_2 _0970_ (.A(\configy.bits_index[1] ),
    .Y(_0369_));
 sky130_fd_sc_hd__inv_2 _0971_ (.A(\configy.bits_index[0] ),
    .Y(_0370_));
 sky130_fd_sc_hd__and2_4 _0972_ (.A(_0369_),
    .B(_0370_),
    .X(_0371_));
 sky130_fd_sc_hd__nor2_4 _0973_ (.A(_0323_),
    .B(_0371_),
    .Y(_0372_));
 sky130_fd_sc_hd__and2_4 _0974_ (.A(_0368_),
    .B(_0372_),
    .X(_0068_));
 sky130_fd_sc_hd__buf_2 _0975_ (.A(_0370_),
    .X(_0373_));
 sky130_fd_sc_hd__or2_4 _0976_ (.A(_0373_),
    .B(_0361_),
    .X(_0374_));
 sky130_fd_sc_hd__buf_2 _0977_ (.A(\configy.bits_index[0] ),
    .X(_0375_));
 sky130_fd_sc_hd__buf_2 _0978_ (.A(_0375_),
    .X(_0376_));
 sky130_fd_sc_hd__or2_4 _0979_ (.A(_0376_),
    .B(_0341_),
    .X(_0377_));
 sky130_fd_sc_hd__and3_4 _0980_ (.A(_0333_),
    .B(_0374_),
    .C(_0377_),
    .X(_0067_));
 sky130_fd_sc_hd__buf_2 _0981_ (.A(_0358_),
    .X(_0378_));
 sky130_fd_sc_hd__or2_4 _0982_ (.A(wbs_data_i[7]),
    .B(_0378_),
    .X(_0379_));
 sky130_fd_sc_hd__or4_4 _0983_ (.A(\configy.counter_a[3] ),
    .B(\configy.counter_a[2] ),
    .C(\configy.counter_a[1] ),
    .D(\configy.counter_a[0] ),
    .X(_0380_));
 sky130_fd_sc_hd__or4_4 _0984_ (.A(\configy.counter_a[6] ),
    .B(_0293_),
    .C(\configy.counter_a[4] ),
    .D(_0380_),
    .X(_0381_));
 sky130_fd_sc_hd__buf_2 _0985_ (.A(_0381_),
    .X(_0382_));
 sky130_fd_sc_hd__and4_4 _0986_ (.A(\configy.counter_a[5] ),
    .B(\configy.counter_a[4] ),
    .C(\configy.counter_a[3] ),
    .D(\configy.counter_a[2] ),
    .X(_0383_));
 sky130_fd_sc_hd__and4_4 _0987_ (.A(\configy.counter_a[7] ),
    .B(\configy.counter_a[6] ),
    .C(\configy.counter_a[1] ),
    .D(\configy.counter_a[0] ),
    .X(_0384_));
 sky130_fd_sc_hd__buf_2 _0988_ (.A(_0364_),
    .X(_0385_));
 sky130_fd_sc_hd__a21oi_4 _0989_ (.A1(_0383_),
    .A2(_0384_),
    .B1(_0385_),
    .Y(_0386_));
 sky130_fd_sc_hd__a41oi_4 _0990_ (.A1(_0330_),
    .A2(_0326_),
    .A3(_0365_),
    .A4(_0241_),
    .B1(_0386_),
    .Y(_0387_));
 sky130_fd_sc_hd__buf_2 _0991_ (.A(_0387_),
    .X(_0388_));
 sky130_fd_sc_hd__a21o_4 _0992_ (.A1(_0379_),
    .A2(_0382_),
    .B1(_0388_),
    .X(_0389_));
 sky130_fd_sc_hd__buf_2 _0993_ (.A(\configy.write_transaction_in_progress ),
    .X(_0390_));
 sky130_fd_sc_hd__buf_2 _0994_ (.A(_0363_),
    .X(_0391_));
 sky130_fd_sc_hd__buf_2 _0995_ (.A(_0139_),
    .X(_0392_));
 sky130_fd_sc_hd__a41o_4 _0996_ (.A1(wbs_sel_i[0]),
    .A2(_0390_),
    .A3(_0391_),
    .A4(_0392_),
    .B1(_0386_),
    .X(_0393_));
 sky130_fd_sc_hd__buf_2 _0997_ (.A(_0393_),
    .X(_0394_));
 sky130_fd_sc_hd__o21ai_4 _0998_ (.A1(\configy.counter_a[7] ),
    .A2(_0382_),
    .B1(_0360_),
    .Y(_0395_));
 sky130_fd_sc_hd__and3_4 _0999_ (.A(_0394_),
    .B(_0379_),
    .C(_0395_),
    .X(_0396_));
 sky130_fd_sc_hd__buf_2 _1000_ (.A(_0332_),
    .X(_0397_));
 sky130_fd_sc_hd__a211o_4 _1001_ (.A1(\configy.counter_a[7] ),
    .A2(_0389_),
    .B1(_0396_),
    .C1(_0397_),
    .X(_0066_));
 sky130_fd_sc_hd__buf_2 _1002_ (.A(_0358_),
    .X(_0398_));
 sky130_fd_sc_hd__buf_2 _1003_ (.A(_0398_),
    .X(_0399_));
 sky130_fd_sc_hd__nand2_4 _1004_ (.A(_0399_),
    .B(_0382_),
    .Y(_0400_));
 sky130_fd_sc_hd__buf_2 _1005_ (.A(_0358_),
    .X(_0401_));
 sky130_fd_sc_hd__or2_4 _1006_ (.A(wbs_data_i[6]),
    .B(_0401_),
    .X(_0402_));
 sky130_fd_sc_hd__and3_4 _1007_ (.A(_0393_),
    .B(_0400_),
    .C(_0402_),
    .X(_0403_));
 sky130_fd_sc_hd__or2_4 _1008_ (.A(\configy.counter_a[4] ),
    .B(_0380_),
    .X(_0404_));
 sky130_fd_sc_hd__o21a_4 _1009_ (.A1(_0293_),
    .A2(_0404_),
    .B1(_0378_),
    .X(_0405_));
 sky130_fd_sc_hd__o21a_4 _1010_ (.A1(_0387_),
    .A2(_0405_),
    .B1(\configy.counter_a[6] ),
    .X(_0406_));
 sky130_fd_sc_hd__or3_4 _1011_ (.A(_0323_),
    .B(_0403_),
    .C(_0406_),
    .X(_0065_));
 sky130_fd_sc_hd__buf_2 _1012_ (.A(_0340_),
    .X(_0407_));
 sky130_fd_sc_hd__or2_4 _1013_ (.A(wbs_data_i[5]),
    .B(_0407_),
    .X(_0408_));
 sky130_fd_sc_hd__a2bb2o_4 _1014_ (.A1_N(_0387_),
    .A2_N(_0405_),
    .B1(_0404_),
    .B2(_0293_),
    .X(_0409_));
 sky130_fd_sc_hd__and2_4 _1015_ (.A(_0293_),
    .B(_0388_),
    .X(_0410_));
 sky130_fd_sc_hd__a211o_4 _1016_ (.A1(_0408_),
    .A2(_0409_),
    .B1(_0410_),
    .C1(_0397_),
    .X(_0064_));
 sky130_fd_sc_hd__nand2_4 _1017_ (.A(_0407_),
    .B(_0380_),
    .Y(_0411_));
 sky130_fd_sc_hd__nand2_4 _1018_ (.A(_0394_),
    .B(_0411_),
    .Y(_0412_));
 sky130_fd_sc_hd__nand2_4 _1019_ (.A(_0360_),
    .B(_0404_),
    .Y(_0413_));
 sky130_fd_sc_hd__buf_2 _1020_ (.A(_0339_),
    .X(_0414_));
 sky130_fd_sc_hd__or2_4 _1021_ (.A(wbs_data_i[4]),
    .B(_0414_),
    .X(_0415_));
 sky130_fd_sc_hd__and3_4 _1022_ (.A(_0394_),
    .B(_0413_),
    .C(_0415_),
    .X(_0416_));
 sky130_fd_sc_hd__a211o_4 _1023_ (.A1(\configy.counter_a[4] ),
    .A2(_0412_),
    .B1(_0416_),
    .C1(_0397_),
    .X(_0063_));
 sky130_fd_sc_hd__a21o_4 _1024_ (.A1(_0394_),
    .A2(_0411_),
    .B1(\configy.counter_a[3] ),
    .X(_0417_));
 sky130_fd_sc_hd__buf_2 _1025_ (.A(_0398_),
    .X(_0418_));
 sky130_fd_sc_hd__or4_4 _1026_ (.A(\configy.counter_a[2] ),
    .B(_0312_),
    .C(\configy.counter_a[0] ),
    .D(_0385_),
    .X(_0419_));
 sky130_fd_sc_hd__inv_2 _1027_ (.A(\configy.counter_a[3] ),
    .Y(_0420_));
 sky130_fd_sc_hd__o22a_4 _1028_ (.A1(wbs_data_i[3]),
    .A2(_0418_),
    .B1(_0419_),
    .B2(_0420_),
    .X(_0421_));
 sky130_fd_sc_hd__or2_4 _1029_ (.A(_0388_),
    .B(_0421_),
    .X(_0422_));
 sky130_fd_sc_hd__a21o_4 _1030_ (.A1(_0417_),
    .A2(_0422_),
    .B1(_0324_),
    .X(_0062_));
 sky130_fd_sc_hd__a21bo_4 _1031_ (.A1(wbs_data_i[2]),
    .A2(_0366_),
    .B1_N(_0419_),
    .X(_0423_));
 sky130_fd_sc_hd__o21a_4 _1032_ (.A1(_0312_),
    .A2(_0319_),
    .B1(_0339_),
    .X(_0424_));
 sky130_fd_sc_hd__o21a_4 _1033_ (.A1(_0387_),
    .A2(_0424_),
    .B1(\configy.counter_a[2] ),
    .X(_0425_));
 sky130_fd_sc_hd__a211o_4 _1034_ (.A1(_0394_),
    .A2(_0423_),
    .B1(_0425_),
    .C1(_0397_),
    .X(_0061_));
 sky130_fd_sc_hd__buf_2 _1035_ (.A(_0398_),
    .X(_0426_));
 sky130_fd_sc_hd__or2_4 _1036_ (.A(wbs_data_i[1]),
    .B(_0426_),
    .X(_0427_));
 sky130_fd_sc_hd__a21bo_4 _1037_ (.A1(_0312_),
    .A2(_0319_),
    .B1_N(_0424_),
    .X(_0428_));
 sky130_fd_sc_hd__and3_4 _1038_ (.A(_0393_),
    .B(_0427_),
    .C(_0428_),
    .X(_0429_));
 sky130_fd_sc_hd__a211o_4 _1039_ (.A1(_0312_),
    .A2(_0388_),
    .B1(_0429_),
    .C1(_0397_),
    .X(_0060_));
 sky130_fd_sc_hd__or2_4 _1040_ (.A(wbs_data_i[0]),
    .B(_0426_),
    .X(_0430_));
 sky130_fd_sc_hd__buf_2 _1041_ (.A(_0401_),
    .X(_0431_));
 sky130_fd_sc_hd__nand2_4 _1042_ (.A(_0319_),
    .B(_0431_),
    .Y(_0432_));
 sky130_fd_sc_hd__and3_4 _1043_ (.A(_0393_),
    .B(_0430_),
    .C(_0432_),
    .X(_0433_));
 sky130_fd_sc_hd__buf_2 _1044_ (.A(_0332_),
    .X(_0434_));
 sky130_fd_sc_hd__a211o_4 _1045_ (.A1(_0319_),
    .A2(_0388_),
    .B1(_0433_),
    .C1(_0434_),
    .X(_0059_));
 sky130_fd_sc_hd__or4_4 _1046_ (.A(\configy.counter_b[3] ),
    .B(\configy.counter_b[2] ),
    .C(\configy.counter_b[1] ),
    .D(\configy.counter_b[0] ),
    .X(_0435_));
 sky130_fd_sc_hd__or4_4 _1047_ (.A(\configy.counter_b[6] ),
    .B(_0246_),
    .C(\configy.counter_b[4] ),
    .D(_0435_),
    .X(_0436_));
 sky130_fd_sc_hd__buf_2 _1048_ (.A(_0436_),
    .X(_0437_));
 sky130_fd_sc_hd__or2_4 _1049_ (.A(wbs_data_i[15]),
    .B(_0359_),
    .X(_0438_));
 sky130_fd_sc_hd__and4_4 _1050_ (.A(\configy.counter_b[5] ),
    .B(\configy.counter_b[4] ),
    .C(\configy.counter_b[3] ),
    .D(\configy.counter_b[2] ),
    .X(_0439_));
 sky130_fd_sc_hd__and4_4 _1051_ (.A(\configy.counter_b[7] ),
    .B(\configy.counter_b[6] ),
    .C(\configy.counter_b[1] ),
    .D(\configy.counter_b[0] ),
    .X(_0440_));
 sky130_fd_sc_hd__a21oi_4 _1052_ (.A1(_0439_),
    .A2(_0440_),
    .B1(_0364_),
    .Y(_0441_));
 sky130_fd_sc_hd__a41oi_4 _1053_ (.A1(_0390_),
    .A2(_0391_),
    .A3(wbs_sel_i[1]),
    .A4(_0392_),
    .B1(_0441_),
    .Y(_0442_));
 sky130_fd_sc_hd__buf_2 _1054_ (.A(_0442_),
    .X(_0443_));
 sky130_fd_sc_hd__a21o_4 _1055_ (.A1(_0437_),
    .A2(_0438_),
    .B1(_0443_),
    .X(_0444_));
 sky130_fd_sc_hd__a41o_4 _1056_ (.A1(\configy.write_transaction_in_progress ),
    .A2(_0391_),
    .A3(wbs_sel_i[1]),
    .A4(_0139_),
    .B1(_0441_),
    .X(_0445_));
 sky130_fd_sc_hd__buf_2 _1057_ (.A(_0445_),
    .X(_0446_));
 sky130_fd_sc_hd__o21ai_4 _1058_ (.A1(\configy.counter_b[7] ),
    .A2(_0437_),
    .B1(_0431_),
    .Y(_0447_));
 sky130_fd_sc_hd__and3_4 _1059_ (.A(_0446_),
    .B(_0438_),
    .C(_0447_),
    .X(_0448_));
 sky130_fd_sc_hd__a211o_4 _1060_ (.A1(\configy.counter_b[7] ),
    .A2(_0444_),
    .B1(_0448_),
    .C1(_0434_),
    .X(_0058_));
 sky130_fd_sc_hd__buf_2 _1061_ (.A(wb_rst_i),
    .X(_0449_));
 sky130_fd_sc_hd__nand2_4 _1062_ (.A(_0399_),
    .B(_0437_),
    .Y(_0450_));
 sky130_fd_sc_hd__or2_4 _1063_ (.A(wbs_data_i[14]),
    .B(_0401_),
    .X(_0451_));
 sky130_fd_sc_hd__and3_4 _1064_ (.A(_0446_),
    .B(_0450_),
    .C(_0451_),
    .X(_0452_));
 sky130_fd_sc_hd__or2_4 _1065_ (.A(\configy.counter_b[4] ),
    .B(_0435_),
    .X(_0453_));
 sky130_fd_sc_hd__o21a_4 _1066_ (.A1(_0246_),
    .A2(_0453_),
    .B1(_0378_),
    .X(_0454_));
 sky130_fd_sc_hd__o21a_4 _1067_ (.A1(_0443_),
    .A2(_0454_),
    .B1(\configy.counter_b[6] ),
    .X(_0455_));
 sky130_fd_sc_hd__or3_4 _1068_ (.A(_0449_),
    .B(_0452_),
    .C(_0455_),
    .X(_0057_));
 sky130_fd_sc_hd__or2_4 _1069_ (.A(wbs_data_i[13]),
    .B(_0407_),
    .X(_0456_));
 sky130_fd_sc_hd__a2bb2o_4 _1070_ (.A1_N(_0443_),
    .A2_N(_0454_),
    .B1(_0453_),
    .B2(_0246_),
    .X(_0457_));
 sky130_fd_sc_hd__buf_2 _1071_ (.A(_0442_),
    .X(_0458_));
 sky130_fd_sc_hd__and2_4 _1072_ (.A(_0246_),
    .B(_0458_),
    .X(_0459_));
 sky130_fd_sc_hd__a211o_4 _1073_ (.A1(_0456_),
    .A2(_0457_),
    .B1(_0459_),
    .C1(_0434_),
    .X(_0056_));
 sky130_fd_sc_hd__nand2_4 _1074_ (.A(_0418_),
    .B(_0453_),
    .Y(_0460_));
 sky130_fd_sc_hd__or2_4 _1075_ (.A(wbs_data_i[12]),
    .B(_0401_),
    .X(_0461_));
 sky130_fd_sc_hd__and3_4 _1076_ (.A(_0445_),
    .B(_0460_),
    .C(_0461_),
    .X(_0462_));
 sky130_fd_sc_hd__and2_4 _1077_ (.A(_0340_),
    .B(_0435_),
    .X(_0463_));
 sky130_fd_sc_hd__o21a_4 _1078_ (.A1(_0443_),
    .A2(_0463_),
    .B1(\configy.counter_b[4] ),
    .X(_0464_));
 sky130_fd_sc_hd__or3_4 _1079_ (.A(_0449_),
    .B(_0462_),
    .C(_0464_),
    .X(_0055_));
 sky130_fd_sc_hd__inv_2 _1080_ (.A(\configy.counter_b[3] ),
    .Y(_0465_));
 sky130_fd_sc_hd__o21ai_4 _1081_ (.A1(_0458_),
    .A2(_0463_),
    .B1(_0465_),
    .Y(_0466_));
 sky130_fd_sc_hd__or4_4 _1082_ (.A(\configy.counter_b[2] ),
    .B(_0268_),
    .C(\configy.counter_b[0] ),
    .D(_0385_),
    .X(_0467_));
 sky130_fd_sc_hd__o22a_4 _1083_ (.A1(wbs_data_i[11]),
    .A2(_0418_),
    .B1(_0467_),
    .B2(_0465_),
    .X(_0468_));
 sky130_fd_sc_hd__or2_4 _1084_ (.A(_0458_),
    .B(_0468_),
    .X(_0469_));
 sky130_fd_sc_hd__a21o_4 _1085_ (.A1(_0466_),
    .A2(_0469_),
    .B1(_0324_),
    .X(_0054_));
 sky130_fd_sc_hd__a21bo_4 _1086_ (.A1(wbs_data_i[10]),
    .A2(_0366_),
    .B1_N(_0467_),
    .X(_0470_));
 sky130_fd_sc_hd__o21a_4 _1087_ (.A1(_0268_),
    .A2(_0275_),
    .B1(_0339_),
    .X(_0471_));
 sky130_fd_sc_hd__o21a_4 _1088_ (.A1(_0443_),
    .A2(_0471_),
    .B1(\configy.counter_b[2] ),
    .X(_0472_));
 sky130_fd_sc_hd__a211o_4 _1089_ (.A1(_0446_),
    .A2(_0470_),
    .B1(_0472_),
    .C1(_0434_),
    .X(_0053_));
 sky130_fd_sc_hd__or2_4 _1090_ (.A(wbs_data_i[9]),
    .B(_0426_),
    .X(_0473_));
 sky130_fd_sc_hd__a21bo_4 _1091_ (.A1(_0268_),
    .A2(_0275_),
    .B1_N(_0471_),
    .X(_0474_));
 sky130_fd_sc_hd__and3_4 _1092_ (.A(_0446_),
    .B(_0473_),
    .C(_0474_),
    .X(_0475_));
 sky130_fd_sc_hd__a211o_4 _1093_ (.A1(_0268_),
    .A2(_0458_),
    .B1(_0475_),
    .C1(_0434_),
    .X(_0052_));
 sky130_fd_sc_hd__or2_4 _1094_ (.A(wbs_data_i[8]),
    .B(_0426_),
    .X(_0476_));
 sky130_fd_sc_hd__nand2_4 _1095_ (.A(_0275_),
    .B(_0431_),
    .Y(_0477_));
 sky130_fd_sc_hd__and3_4 _1096_ (.A(_0446_),
    .B(_0476_),
    .C(_0477_),
    .X(_0478_));
 sky130_fd_sc_hd__buf_2 _1097_ (.A(_0332_),
    .X(_0479_));
 sky130_fd_sc_hd__a211o_4 _1098_ (.A1(_0275_),
    .A2(_0458_),
    .B1(_0478_),
    .C1(_0479_),
    .X(_0051_));
 sky130_fd_sc_hd__or2_4 _1099_ (.A(wbs_data_i[23]),
    .B(_0378_),
    .X(_0480_));
 sky130_fd_sc_hd__or4_4 _1100_ (.A(\configy.counter_c[3] ),
    .B(\configy.counter_c[2] ),
    .C(\configy.counter_c[1] ),
    .D(\configy.counter_c[0] ),
    .X(_0481_));
 sky130_fd_sc_hd__or4_4 _1101_ (.A(\configy.counter_c[6] ),
    .B(_0199_),
    .C(\configy.counter_c[4] ),
    .D(_0481_),
    .X(_0482_));
 sky130_fd_sc_hd__buf_2 _1102_ (.A(_0482_),
    .X(_0483_));
 sky130_fd_sc_hd__and4_4 _1103_ (.A(\configy.counter_c[5] ),
    .B(\configy.counter_c[4] ),
    .C(\configy.counter_c[3] ),
    .D(\configy.counter_c[2] ),
    .X(_0484_));
 sky130_fd_sc_hd__and4_4 _1104_ (.A(\configy.counter_c[7] ),
    .B(\configy.counter_c[6] ),
    .C(\configy.counter_c[1] ),
    .D(\configy.counter_c[0] ),
    .X(_0485_));
 sky130_fd_sc_hd__a21oi_4 _1105_ (.A1(_0484_),
    .A2(_0485_),
    .B1(_0385_),
    .Y(_0486_));
 sky130_fd_sc_hd__a41oi_4 _1106_ (.A1(_0326_),
    .A2(_0365_),
    .A3(wbs_sel_i[2]),
    .A4(_0241_),
    .B1(_0486_),
    .Y(_0487_));
 sky130_fd_sc_hd__buf_2 _1107_ (.A(_0487_),
    .X(_0488_));
 sky130_fd_sc_hd__a21o_4 _1108_ (.A1(_0480_),
    .A2(_0483_),
    .B1(_0488_),
    .X(_0489_));
 sky130_fd_sc_hd__a41o_4 _1109_ (.A1(_0390_),
    .A2(_0365_),
    .A3(wbs_sel_i[2]),
    .A4(_0392_),
    .B1(_0486_),
    .X(_0490_));
 sky130_fd_sc_hd__buf_2 _1110_ (.A(_0490_),
    .X(_0491_));
 sky130_fd_sc_hd__o21ai_4 _1111_ (.A1(\configy.counter_c[7] ),
    .A2(_0483_),
    .B1(_0431_),
    .Y(_0492_));
 sky130_fd_sc_hd__and3_4 _1112_ (.A(_0491_),
    .B(_0480_),
    .C(_0492_),
    .X(_0493_));
 sky130_fd_sc_hd__a211o_4 _1113_ (.A1(\configy.counter_c[7] ),
    .A2(_0489_),
    .B1(_0493_),
    .C1(_0479_),
    .X(_0050_));
 sky130_fd_sc_hd__nand2_4 _1114_ (.A(_0418_),
    .B(_0483_),
    .Y(_0494_));
 sky130_fd_sc_hd__or2_4 _1115_ (.A(wbs_data_i[22]),
    .B(_0398_),
    .X(_0495_));
 sky130_fd_sc_hd__and3_4 _1116_ (.A(_0490_),
    .B(_0494_),
    .C(_0495_),
    .X(_0496_));
 sky130_fd_sc_hd__or2_4 _1117_ (.A(\configy.counter_c[4] ),
    .B(_0481_),
    .X(_0497_));
 sky130_fd_sc_hd__o21a_4 _1118_ (.A1(_0199_),
    .A2(_0497_),
    .B1(_0359_),
    .X(_0498_));
 sky130_fd_sc_hd__o21a_4 _1119_ (.A1(_0487_),
    .A2(_0498_),
    .B1(\configy.counter_c[6] ),
    .X(_0499_));
 sky130_fd_sc_hd__or3_4 _1120_ (.A(_0449_),
    .B(_0496_),
    .C(_0499_),
    .X(_0049_));
 sky130_fd_sc_hd__or2_4 _1121_ (.A(wbs_data_i[21]),
    .B(_0407_),
    .X(_0500_));
 sky130_fd_sc_hd__a2bb2o_4 _1122_ (.A1_N(_0487_),
    .A2_N(_0498_),
    .B1(_0497_),
    .B2(_0199_),
    .X(_0501_));
 sky130_fd_sc_hd__and2_4 _1123_ (.A(_0199_),
    .B(_0488_),
    .X(_0502_));
 sky130_fd_sc_hd__a211o_4 _1124_ (.A1(_0500_),
    .A2(_0501_),
    .B1(_0502_),
    .C1(_0479_),
    .X(_0048_));
 sky130_fd_sc_hd__nand2_4 _1125_ (.A(_0407_),
    .B(_0481_),
    .Y(_0503_));
 sky130_fd_sc_hd__nand2_4 _1126_ (.A(_0491_),
    .B(_0503_),
    .Y(_0504_));
 sky130_fd_sc_hd__nand2_4 _1127_ (.A(_0360_),
    .B(_0497_),
    .Y(_0505_));
 sky130_fd_sc_hd__or2_4 _1128_ (.A(wbs_data_i[20]),
    .B(_0378_),
    .X(_0506_));
 sky130_fd_sc_hd__and3_4 _1129_ (.A(_0491_),
    .B(_0505_),
    .C(_0506_),
    .X(_0507_));
 sky130_fd_sc_hd__a211o_4 _1130_ (.A1(\configy.counter_c[4] ),
    .A2(_0504_),
    .B1(_0507_),
    .C1(_0479_),
    .X(_0047_));
 sky130_fd_sc_hd__a21o_4 _1131_ (.A1(_0491_),
    .A2(_0503_),
    .B1(\configy.counter_c[3] ),
    .X(_0508_));
 sky130_fd_sc_hd__or4_4 _1132_ (.A(\configy.counter_c[2] ),
    .B(_0220_),
    .C(\configy.counter_c[0] ),
    .D(_0385_),
    .X(_0509_));
 sky130_fd_sc_hd__inv_2 _1133_ (.A(\configy.counter_c[3] ),
    .Y(_0510_));
 sky130_fd_sc_hd__o22a_4 _1134_ (.A1(wbs_data_i[19]),
    .A2(_0340_),
    .B1(_0509_),
    .B2(_0510_),
    .X(_0511_));
 sky130_fd_sc_hd__or2_4 _1135_ (.A(_0488_),
    .B(_0511_),
    .X(_0512_));
 sky130_fd_sc_hd__a21o_4 _1136_ (.A1(_0508_),
    .A2(_0512_),
    .B1(_0324_),
    .X(_0046_));
 sky130_fd_sc_hd__a21bo_4 _1137_ (.A1(wbs_data_i[18]),
    .A2(_0366_),
    .B1_N(_0509_),
    .X(_0513_));
 sky130_fd_sc_hd__o21a_4 _1138_ (.A1(_0220_),
    .A2(_0228_),
    .B1(_0339_),
    .X(_0514_));
 sky130_fd_sc_hd__o21a_4 _1139_ (.A1(_0487_),
    .A2(_0514_),
    .B1(\configy.counter_c[2] ),
    .X(_0515_));
 sky130_fd_sc_hd__a211o_4 _1140_ (.A1(_0491_),
    .A2(_0513_),
    .B1(_0515_),
    .C1(_0479_),
    .X(_0045_));
 sky130_fd_sc_hd__or2_4 _1141_ (.A(wbs_data_i[17]),
    .B(_0414_),
    .X(_0516_));
 sky130_fd_sc_hd__a21bo_4 _1142_ (.A1(_0220_),
    .A2(_0228_),
    .B1_N(_0514_),
    .X(_0517_));
 sky130_fd_sc_hd__and3_4 _1143_ (.A(_0490_),
    .B(_0516_),
    .C(_0517_),
    .X(_0518_));
 sky130_fd_sc_hd__buf_2 _1144_ (.A(_0332_),
    .X(_0519_));
 sky130_fd_sc_hd__a211o_4 _1145_ (.A1(_0220_),
    .A2(_0488_),
    .B1(_0518_),
    .C1(_0519_),
    .X(_0044_));
 sky130_fd_sc_hd__or2_4 _1146_ (.A(wbs_data_i[16]),
    .B(_0414_),
    .X(_0520_));
 sky130_fd_sc_hd__nand2_4 _1147_ (.A(_0228_),
    .B(_0399_),
    .Y(_0521_));
 sky130_fd_sc_hd__and3_4 _1148_ (.A(_0490_),
    .B(_0520_),
    .C(_0521_),
    .X(_0522_));
 sky130_fd_sc_hd__a211o_4 _1149_ (.A1(_0228_),
    .A2(_0488_),
    .B1(_0522_),
    .C1(_0519_),
    .X(_0043_));
 sky130_fd_sc_hd__or4_4 _1150_ (.A(\configy.counter_d[3] ),
    .B(\configy.counter_d[2] ),
    .C(\configy.counter_d[1] ),
    .D(\configy.counter_d[0] ),
    .X(_0523_));
 sky130_fd_sc_hd__or4_4 _1151_ (.A(\configy.counter_d[6] ),
    .B(_0149_),
    .C(\configy.counter_d[4] ),
    .D(_0523_),
    .X(_0524_));
 sky130_fd_sc_hd__buf_2 _1152_ (.A(_0524_),
    .X(_0525_));
 sky130_fd_sc_hd__or2_4 _1153_ (.A(wbs_data_i[31]),
    .B(_0401_),
    .X(_0526_));
 sky130_fd_sc_hd__and4_4 _1154_ (.A(\configy.counter_d[5] ),
    .B(\configy.counter_d[4] ),
    .C(\configy.counter_d[3] ),
    .D(\configy.counter_d[2] ),
    .X(_0527_));
 sky130_fd_sc_hd__and4_4 _1155_ (.A(\configy.counter_d[7] ),
    .B(\configy.counter_d[6] ),
    .C(\configy.counter_d[1] ),
    .D(\configy.counter_d[0] ),
    .X(_0528_));
 sky130_fd_sc_hd__a21oi_4 _1156_ (.A1(_0527_),
    .A2(_0528_),
    .B1(_0364_),
    .Y(_0529_));
 sky130_fd_sc_hd__a41oi_4 _1157_ (.A1(_0390_),
    .A2(_0391_),
    .A3(wbs_sel_i[3]),
    .A4(_0392_),
    .B1(_0529_),
    .Y(_0530_));
 sky130_fd_sc_hd__buf_2 _1158_ (.A(_0530_),
    .X(_0531_));
 sky130_fd_sc_hd__a21o_4 _1159_ (.A1(_0525_),
    .A2(_0526_),
    .B1(_0531_),
    .X(_0532_));
 sky130_fd_sc_hd__a41o_4 _1160_ (.A1(_0390_),
    .A2(_0391_),
    .A3(wbs_sel_i[3]),
    .A4(_0392_),
    .B1(_0529_),
    .X(_0533_));
 sky130_fd_sc_hd__buf_2 _1161_ (.A(_0533_),
    .X(_0534_));
 sky130_fd_sc_hd__o21ai_4 _1162_ (.A1(\configy.counter_d[7] ),
    .A2(_0525_),
    .B1(_0431_),
    .Y(_0535_));
 sky130_fd_sc_hd__and3_4 _1163_ (.A(_0534_),
    .B(_0526_),
    .C(_0535_),
    .X(_0536_));
 sky130_fd_sc_hd__a211o_4 _1164_ (.A1(\configy.counter_d[7] ),
    .A2(_0532_),
    .B1(_0536_),
    .C1(_0519_),
    .X(_0042_));
 sky130_fd_sc_hd__or2_4 _1165_ (.A(\configy.counter_d[4] ),
    .B(_0523_),
    .X(_0537_));
 sky130_fd_sc_hd__o21a_4 _1166_ (.A1(_0149_),
    .A2(_0537_),
    .B1(_0359_),
    .X(_0538_));
 sky130_fd_sc_hd__o21a_4 _1167_ (.A1(_0531_),
    .A2(_0538_),
    .B1(\configy.counter_d[6] ),
    .X(_0539_));
 sky130_fd_sc_hd__nand2_4 _1168_ (.A(_0399_),
    .B(_0525_),
    .Y(_0540_));
 sky130_fd_sc_hd__or2_4 _1169_ (.A(wbs_data_i[30]),
    .B(_0359_),
    .X(_0541_));
 sky130_fd_sc_hd__and3_4 _1170_ (.A(_0534_),
    .B(_0540_),
    .C(_0541_),
    .X(_0542_));
 sky130_fd_sc_hd__or3_4 _1171_ (.A(_0449_),
    .B(_0539_),
    .C(_0542_),
    .X(_0041_));
 sky130_fd_sc_hd__or2_4 _1172_ (.A(wbs_data_i[29]),
    .B(_0360_),
    .X(_0543_));
 sky130_fd_sc_hd__a2bb2o_4 _1173_ (.A1_N(_0531_),
    .A2_N(_0538_),
    .B1(_0537_),
    .B2(_0149_),
    .X(_0544_));
 sky130_fd_sc_hd__buf_2 _1174_ (.A(_0530_),
    .X(_0545_));
 sky130_fd_sc_hd__and2_4 _1175_ (.A(_0149_),
    .B(_0545_),
    .X(_0546_));
 sky130_fd_sc_hd__a211o_4 _1176_ (.A1(_0543_),
    .A2(_0544_),
    .B1(_0546_),
    .C1(_0519_),
    .X(_0040_));
 sky130_fd_sc_hd__nand2_4 _1177_ (.A(_0418_),
    .B(_0537_),
    .Y(_0547_));
 sky130_fd_sc_hd__or2_4 _1178_ (.A(wbs_data_i[28]),
    .B(_0398_),
    .X(_0548_));
 sky130_fd_sc_hd__and3_4 _1179_ (.A(_0533_),
    .B(_0547_),
    .C(_0548_),
    .X(_0549_));
 sky130_fd_sc_hd__and2_4 _1180_ (.A(_0426_),
    .B(_0523_),
    .X(_0550_));
 sky130_fd_sc_hd__o21a_4 _1181_ (.A1(_0531_),
    .A2(_0550_),
    .B1(\configy.counter_d[4] ),
    .X(_0551_));
 sky130_fd_sc_hd__or3_4 _1182_ (.A(_0449_),
    .B(_0549_),
    .C(_0551_),
    .X(_0039_));
 sky130_fd_sc_hd__inv_2 _1183_ (.A(\configy.counter_d[3] ),
    .Y(_0552_));
 sky130_fd_sc_hd__o21ai_4 _1184_ (.A1(_0545_),
    .A2(_0550_),
    .B1(_0552_),
    .Y(_0553_));
 sky130_fd_sc_hd__or4_4 _1185_ (.A(\configy.counter_d[2] ),
    .B(_0176_),
    .C(\configy.counter_d[0] ),
    .D(_0364_),
    .X(_0554_));
 sky130_fd_sc_hd__o22a_4 _1186_ (.A1(wbs_data_i[27]),
    .A2(_0340_),
    .B1(_0554_),
    .B2(_0552_),
    .X(_0555_));
 sky130_fd_sc_hd__or2_4 _1187_ (.A(_0545_),
    .B(_0555_),
    .X(_0556_));
 sky130_fd_sc_hd__a21o_4 _1188_ (.A1(_0553_),
    .A2(_0556_),
    .B1(_0324_),
    .X(_0038_));
 sky130_fd_sc_hd__a21bo_4 _1189_ (.A1(wbs_data_i[26]),
    .A2(_0366_),
    .B1_N(_0554_),
    .X(_0557_));
 sky130_fd_sc_hd__o21a_4 _1190_ (.A1(_0176_),
    .A2(_0181_),
    .B1(_0358_),
    .X(_0558_));
 sky130_fd_sc_hd__o21a_4 _1191_ (.A1(_0531_),
    .A2(_0558_),
    .B1(\configy.counter_d[2] ),
    .X(_0559_));
 sky130_fd_sc_hd__a211o_4 _1192_ (.A1(_0534_),
    .A2(_0557_),
    .B1(_0559_),
    .C1(_0519_),
    .X(_0037_));
 sky130_fd_sc_hd__or2_4 _1193_ (.A(wbs_data_i[25]),
    .B(_0414_),
    .X(_0560_));
 sky130_fd_sc_hd__a21bo_4 _1194_ (.A1(_0176_),
    .A2(_0181_),
    .B1_N(_0558_),
    .X(_0561_));
 sky130_fd_sc_hd__and3_4 _1195_ (.A(_0534_),
    .B(_0560_),
    .C(_0561_),
    .X(_0562_));
 sky130_fd_sc_hd__a211o_4 _1196_ (.A1(_0176_),
    .A2(_0545_),
    .B1(_0562_),
    .C1(_0323_),
    .X(_0036_));
 sky130_fd_sc_hd__or2_4 _1197_ (.A(wbs_data_i[24]),
    .B(_0414_),
    .X(_0563_));
 sky130_fd_sc_hd__nand2_4 _1198_ (.A(_0181_),
    .B(_0399_),
    .Y(_0564_));
 sky130_fd_sc_hd__and3_4 _1199_ (.A(_0534_),
    .B(_0563_),
    .C(_0564_),
    .X(_0565_));
 sky130_fd_sc_hd__a211o_4 _1200_ (.A1(_0181_),
    .A2(_0545_),
    .B1(_0565_),
    .C1(_0323_),
    .X(_0035_));
 sky130_fd_sc_hd__o22a_4 _1201_ (.A1(\configy.charged[0] ),
    .A2(_0330_),
    .B1(wbs_sel_i[2]),
    .B2(\configy.charged[2] ),
    .X(_0566_));
 sky130_fd_sc_hd__o22a_4 _1202_ (.A1(\configy.charged[3] ),
    .A2(wbs_sel_i[3]),
    .B1(wbs_sel_i[1]),
    .B2(\configy.charged[1] ),
    .X(_0567_));
 sky130_fd_sc_hd__and3_4 _1203_ (.A(_0342_),
    .B(_0566_),
    .C(_0567_),
    .X(_0568_));
 sky130_fd_sc_hd__nor2_4 _1204_ (.A(\configy.read_transaction_in_progress ),
    .B(_0326_),
    .Y(_0569_));
 sky130_fd_sc_hd__and4_4 _1205_ (.A(wbs_we_i),
    .B(_0164_),
    .C(_0166_),
    .D(_0569_),
    .X(_0570_));
 sky130_fd_sc_hd__buf_2 _1206_ (.A(_0365_),
    .X(_0571_));
 sky130_fd_sc_hd__o21a_4 _1207_ (.A1(_0571_),
    .A2(_0357_),
    .B1(_0333_),
    .X(_0572_));
 sky130_fd_sc_hd__o21a_4 _1208_ (.A1(_0568_),
    .A2(_0570_),
    .B1(_0572_),
    .X(_0034_));
 sky130_fd_sc_hd__buf_2 _1209_ (.A(_0341_),
    .X(_0573_));
 sky130_fd_sc_hd__o21a_4 _1210_ (.A1(_0573_),
    .A2(_0343_),
    .B1(_0572_),
    .X(_0033_));
 sky130_fd_sc_hd__and2_4 _1211_ (.A(_0110_),
    .B(_0328_),
    .X(_0032_));
 sky130_fd_sc_hd__nand2_4 _1212_ (.A(wbs_sel_i[1]),
    .B(_0342_),
    .Y(_0574_));
 sky130_fd_sc_hd__buf_2 _1213_ (.A(_0574_),
    .X(_0575_));
 sky130_fd_sc_hd__and2_4 _1214_ (.A(wbs_data_i[15]),
    .B(_0349_),
    .X(_0576_));
 sky130_fd_sc_hd__a21o_4 _1215_ (.A1(\configy.bits_b[7] ),
    .A2(_0575_),
    .B1(_0576_),
    .X(_0031_));
 sky130_fd_sc_hd__and2_4 _1216_ (.A(wbs_data_i[14]),
    .B(_0349_),
    .X(_0577_));
 sky130_fd_sc_hd__a21o_4 _1217_ (.A1(\configy.bits_b[6] ),
    .A2(_0575_),
    .B1(_0577_),
    .X(_0030_));
 sky130_fd_sc_hd__and2_4 _1218_ (.A(wbs_data_i[13]),
    .B(_0349_),
    .X(_0578_));
 sky130_fd_sc_hd__a21o_4 _1219_ (.A1(\configy.bits_b[5] ),
    .A2(_0575_),
    .B1(_0578_),
    .X(_0029_));
 sky130_fd_sc_hd__and2_4 _1220_ (.A(wbs_data_i[12]),
    .B(_0349_),
    .X(_0579_));
 sky130_fd_sc_hd__a21o_4 _1221_ (.A1(\configy.bits_b[4] ),
    .A2(_0575_),
    .B1(_0579_),
    .X(_0028_));
 sky130_fd_sc_hd__and2_4 _1222_ (.A(wbs_data_i[11]),
    .B(_0348_),
    .X(_0580_));
 sky130_fd_sc_hd__a21o_4 _1223_ (.A1(\configy.bits_b[3] ),
    .A2(_0575_),
    .B1(_0580_),
    .X(_0027_));
 sky130_fd_sc_hd__and2_4 _1224_ (.A(wbs_data_i[10]),
    .B(_0348_),
    .X(_0581_));
 sky130_fd_sc_hd__a21o_4 _1225_ (.A1(\configy.bits_b[2] ),
    .A2(_0574_),
    .B1(_0581_),
    .X(_0026_));
 sky130_fd_sc_hd__and2_4 _1226_ (.A(wbs_data_i[9]),
    .B(_0348_),
    .X(_0582_));
 sky130_fd_sc_hd__a21o_4 _1227_ (.A1(\configy.bits_b[1] ),
    .A2(_0574_),
    .B1(_0582_),
    .X(_0025_));
 sky130_fd_sc_hd__and2_4 _1228_ (.A(wbs_data_i[8]),
    .B(_0348_),
    .X(_0583_));
 sky130_fd_sc_hd__a21o_4 _1229_ (.A1(\configy.bits_b[0] ),
    .A2(_0574_),
    .B1(_0583_),
    .X(_0024_));
 sky130_fd_sc_hd__nand2_4 _1230_ (.A(wbs_sel_i[2]),
    .B(_0342_),
    .Y(_0584_));
 sky130_fd_sc_hd__buf_2 _1231_ (.A(_0584_),
    .X(_0585_));
 sky130_fd_sc_hd__and2_4 _1232_ (.A(wbs_data_i[23]),
    .B(_0347_),
    .X(_0586_));
 sky130_fd_sc_hd__a21o_4 _1233_ (.A1(\configy.bits_c[7] ),
    .A2(_0585_),
    .B1(_0586_),
    .X(_0023_));
 sky130_fd_sc_hd__and2_4 _1234_ (.A(wbs_data_i[22]),
    .B(_0347_),
    .X(_0587_));
 sky130_fd_sc_hd__a21o_4 _1235_ (.A1(\configy.bits_c[6] ),
    .A2(_0585_),
    .B1(_0587_),
    .X(_0022_));
 sky130_fd_sc_hd__and2_4 _1236_ (.A(wbs_data_i[21]),
    .B(_0347_),
    .X(_0588_));
 sky130_fd_sc_hd__a21o_4 _1237_ (.A1(\configy.bits_c[5] ),
    .A2(_0585_),
    .B1(_0588_),
    .X(_0021_));
 sky130_fd_sc_hd__and2_4 _1238_ (.A(wbs_data_i[20]),
    .B(_0347_),
    .X(_0589_));
 sky130_fd_sc_hd__a21o_4 _1239_ (.A1(\configy.bits_c[4] ),
    .A2(_0585_),
    .B1(_0589_),
    .X(_0020_));
 sky130_fd_sc_hd__and2_4 _1240_ (.A(wbs_data_i[19]),
    .B(_0346_),
    .X(_0590_));
 sky130_fd_sc_hd__a21o_4 _1241_ (.A1(\configy.bits_c[3] ),
    .A2(_0585_),
    .B1(_0590_),
    .X(_0019_));
 sky130_fd_sc_hd__and2_4 _1242_ (.A(wbs_data_i[18]),
    .B(_0346_),
    .X(_0591_));
 sky130_fd_sc_hd__a21o_4 _1243_ (.A1(\configy.bits_c[2] ),
    .A2(_0584_),
    .B1(_0591_),
    .X(_0018_));
 sky130_fd_sc_hd__and2_4 _1244_ (.A(wbs_data_i[17]),
    .B(_0346_),
    .X(_0592_));
 sky130_fd_sc_hd__a21o_4 _1245_ (.A1(\configy.bits_c[1] ),
    .A2(_0584_),
    .B1(_0592_),
    .X(_0017_));
 sky130_fd_sc_hd__and2_4 _1246_ (.A(wbs_data_i[16]),
    .B(_0346_),
    .X(_0593_));
 sky130_fd_sc_hd__a21o_4 _1247_ (.A1(\configy.bits_c[0] ),
    .A2(_0584_),
    .B1(_0593_),
    .X(_0016_));
 sky130_fd_sc_hd__nand2_4 _1248_ (.A(wbs_sel_i[3]),
    .B(_0342_),
    .Y(_0594_));
 sky130_fd_sc_hd__buf_2 _1249_ (.A(_0594_),
    .X(_0595_));
 sky130_fd_sc_hd__and2_4 _1250_ (.A(wbs_data_i[31]),
    .B(_0338_),
    .X(_0596_));
 sky130_fd_sc_hd__a21o_4 _1251_ (.A1(\configy.bits_d[7] ),
    .A2(_0595_),
    .B1(_0596_),
    .X(_0015_));
 sky130_fd_sc_hd__and2_4 _1252_ (.A(wbs_data_i[30]),
    .B(_0338_),
    .X(_0597_));
 sky130_fd_sc_hd__a21o_4 _1253_ (.A1(\configy.bits_d[6] ),
    .A2(_0595_),
    .B1(_0597_),
    .X(_0014_));
 sky130_fd_sc_hd__and2_4 _1254_ (.A(wbs_data_i[29]),
    .B(_0338_),
    .X(_0598_));
 sky130_fd_sc_hd__a21o_4 _1255_ (.A1(\configy.bits_d[5] ),
    .A2(_0595_),
    .B1(_0598_),
    .X(_0013_));
 sky130_fd_sc_hd__and2_4 _1256_ (.A(wbs_data_i[28]),
    .B(_0338_),
    .X(_0599_));
 sky130_fd_sc_hd__a21o_4 _1257_ (.A1(\configy.bits_d[4] ),
    .A2(_0595_),
    .B1(_0599_),
    .X(_0012_));
 sky130_fd_sc_hd__and2_4 _1258_ (.A(wbs_data_i[27]),
    .B(_0337_),
    .X(_0600_));
 sky130_fd_sc_hd__a21o_4 _1259_ (.A1(\configy.bits_d[3] ),
    .A2(_0595_),
    .B1(_0600_),
    .X(_0011_));
 sky130_fd_sc_hd__and2_4 _1260_ (.A(wbs_data_i[26]),
    .B(_0337_),
    .X(_0601_));
 sky130_fd_sc_hd__a21o_4 _1261_ (.A1(\configy.bits_d[2] ),
    .A2(_0594_),
    .B1(_0601_),
    .X(_0010_));
 sky130_fd_sc_hd__and2_4 _1262_ (.A(wbs_data_i[25]),
    .B(_0337_),
    .X(_0602_));
 sky130_fd_sc_hd__a21o_4 _1263_ (.A1(\configy.bits_d[1] ),
    .A2(_0594_),
    .B1(_0602_),
    .X(_0009_));
 sky130_fd_sc_hd__and2_4 _1264_ (.A(wbs_data_i[24]),
    .B(_0337_),
    .X(_0603_));
 sky130_fd_sc_hd__a21o_4 _1265_ (.A1(\configy.bits_d[0] ),
    .A2(_0594_),
    .B1(_0603_),
    .X(_0008_));
 sky130_fd_sc_hd__nand2_4 _1266_ (.A(_0330_),
    .B(_0336_),
    .Y(_0604_));
 sky130_fd_sc_hd__buf_2 _1267_ (.A(_0604_),
    .X(_0605_));
 sky130_fd_sc_hd__and2_4 _1268_ (.A(wbs_data_i[7]),
    .B(_0351_),
    .X(_0606_));
 sky130_fd_sc_hd__a21o_4 _1269_ (.A1(\configy.bits_a[7] ),
    .A2(_0605_),
    .B1(_0606_),
    .X(_0007_));
 sky130_fd_sc_hd__and2_4 _1270_ (.A(wbs_data_i[6]),
    .B(_0351_),
    .X(_0607_));
 sky130_fd_sc_hd__a21o_4 _1271_ (.A1(\configy.bits_a[6] ),
    .A2(_0605_),
    .B1(_0607_),
    .X(_0006_));
 sky130_fd_sc_hd__and2_4 _1272_ (.A(wbs_data_i[5]),
    .B(_0351_),
    .X(_0608_));
 sky130_fd_sc_hd__a21o_4 _1273_ (.A1(\configy.bits_a[5] ),
    .A2(_0605_),
    .B1(_0608_),
    .X(_0005_));
 sky130_fd_sc_hd__and2_4 _1274_ (.A(wbs_data_i[4]),
    .B(_0351_),
    .X(_0609_));
 sky130_fd_sc_hd__a21o_4 _1275_ (.A1(\configy.bits_a[4] ),
    .A2(_0605_),
    .B1(_0609_),
    .X(_0004_));
 sky130_fd_sc_hd__and2_4 _1276_ (.A(wbs_data_i[3]),
    .B(_0350_),
    .X(_0610_));
 sky130_fd_sc_hd__a21o_4 _1277_ (.A1(\configy.bits_a[3] ),
    .A2(_0605_),
    .B1(_0610_),
    .X(_0003_));
 sky130_fd_sc_hd__and2_4 _1278_ (.A(wbs_data_i[2]),
    .B(_0350_),
    .X(_0611_));
 sky130_fd_sc_hd__a21o_4 _1279_ (.A1(\configy.bits_a[2] ),
    .A2(_0604_),
    .B1(_0611_),
    .X(_0002_));
 sky130_fd_sc_hd__and2_4 _1280_ (.A(wbs_data_i[1]),
    .B(_0350_),
    .X(_0612_));
 sky130_fd_sc_hd__a21o_4 _1281_ (.A1(\configy.bits_a[1] ),
    .A2(_0604_),
    .B1(_0612_),
    .X(_0001_));
 sky130_fd_sc_hd__and2_4 _1282_ (.A(wbs_data_i[0]),
    .B(_0350_),
    .X(_0613_));
 sky130_fd_sc_hd__a21o_4 _1283_ (.A1(\configy.bits_a[0] ),
    .A2(_0604_),
    .B1(_0613_),
    .X(_0000_));
 sky130_fd_sc_hd__nor3_4 _1284_ (.A(\configy.counter_d[7] ),
    .B(_0571_),
    .C(_0525_),
    .Y(set_out[3]));
 sky130_fd_sc_hd__nor3_4 _1285_ (.A(\configy.counter_c[7] ),
    .B(_0571_),
    .C(_0483_),
    .Y(set_out[2]));
 sky130_fd_sc_hd__nor3_4 _1286_ (.A(\configy.counter_b[7] ),
    .B(_0571_),
    .C(_0437_),
    .Y(set_out[1]));
 sky130_fd_sc_hd__nor3_4 _1287_ (.A(\configy.counter_a[7] ),
    .B(_0571_),
    .C(_0382_),
    .Y(set_out[0]));
 sky130_fd_sc_hd__inv_2 _1288_ (.A(\configy.bits_index[2] ),
    .Y(_0614_));
 sky130_fd_sc_hd__buf_2 _1289_ (.A(_0614_),
    .X(_0615_));
 sky130_fd_sc_hd__buf_2 _1290_ (.A(_0615_),
    .X(_0616_));
 sky130_fd_sc_hd__buf_2 _1291_ (.A(\configy.bits_index[2] ),
    .X(_0617_));
 sky130_fd_sc_hd__or2_4 _1292_ (.A(_0617_),
    .B(\configy.bits_d[2] ),
    .X(_0618_));
 sky130_fd_sc_hd__o21a_4 _1293_ (.A1(_0616_),
    .A2(\configy.bits_d[6] ),
    .B1(_0618_),
    .X(_0619_));
 sky130_fd_sc_hd__buf_2 _1294_ (.A(_0614_),
    .X(_0620_));
 sky130_fd_sc_hd__or2_4 _1295_ (.A(_0620_),
    .B(\configy.bits_d[7] ),
    .X(_0621_));
 sky130_fd_sc_hd__or2_4 _1296_ (.A(_0352_),
    .B(\configy.bits_d[3] ),
    .X(_0622_));
 sky130_fd_sc_hd__and3_4 _1297_ (.A(_0376_),
    .B(_0621_),
    .C(_0622_),
    .X(_0623_));
 sky130_fd_sc_hd__a211o_4 _1298_ (.A1(_0373_),
    .A2(_0619_),
    .B1(_0623_),
    .C1(_0369_),
    .X(_0624_));
 sky130_fd_sc_hd__or2_4 _1299_ (.A(_0617_),
    .B(\configy.bits_d[0] ),
    .X(_0625_));
 sky130_fd_sc_hd__o21a_4 _1300_ (.A1(_0616_),
    .A2(\configy.bits_d[4] ),
    .B1(_0625_),
    .X(_0626_));
 sky130_fd_sc_hd__or2_4 _1301_ (.A(_0620_),
    .B(\configy.bits_d[5] ),
    .X(_0627_));
 sky130_fd_sc_hd__buf_2 _1302_ (.A(\configy.bits_index[2] ),
    .X(_0628_));
 sky130_fd_sc_hd__or2_4 _1303_ (.A(_0628_),
    .B(\configy.bits_d[1] ),
    .X(_0629_));
 sky130_fd_sc_hd__and3_4 _1304_ (.A(_0375_),
    .B(_0627_),
    .C(_0629_),
    .X(_0630_));
 sky130_fd_sc_hd__a211o_4 _1305_ (.A1(_0373_),
    .A2(_0626_),
    .B1(_0630_),
    .C1(_0367_),
    .X(_0631_));
 sky130_fd_sc_hd__and3_4 _1306_ (.A(_0573_),
    .B(_0624_),
    .C(_0631_),
    .X(shift_out[3]));
 sky130_fd_sc_hd__or2_4 _1307_ (.A(_0616_),
    .B(\configy.bits_c[5] ),
    .X(_0632_));
 sky130_fd_sc_hd__or2_4 _1308_ (.A(_0353_),
    .B(\configy.bits_c[1] ),
    .X(_0633_));
 sky130_fd_sc_hd__and4_4 _1309_ (.A(_0369_),
    .B(_0376_),
    .C(_0632_),
    .D(_0633_),
    .X(_0634_));
 sky130_fd_sc_hd__or2_4 _1310_ (.A(_0353_),
    .B(\configy.bits_c[0] ),
    .X(_0635_));
 sky130_fd_sc_hd__or2_4 _1311_ (.A(_0615_),
    .B(\configy.bits_c[4] ),
    .X(_0636_));
 sky130_fd_sc_hd__or2_4 _1312_ (.A(_0628_),
    .B(\configy.bits_c[2] ),
    .X(_0637_));
 sky130_fd_sc_hd__or2_4 _1313_ (.A(_0614_),
    .B(\configy.bits_c[6] ),
    .X(_0638_));
 sky130_fd_sc_hd__or2_4 _1314_ (.A(_0352_),
    .B(\configy.bits_c[3] ),
    .X(_0639_));
 sky130_fd_sc_hd__o21a_4 _1315_ (.A1(_0615_),
    .A2(\configy.bits_c[7] ),
    .B1(_0375_),
    .X(_0640_));
 sky130_fd_sc_hd__a32o_4 _1316_ (.A1(_0370_),
    .A2(_0637_),
    .A3(_0638_),
    .B1(_0639_),
    .B2(_0640_),
    .X(_0641_));
 sky130_fd_sc_hd__a32o_4 _1317_ (.A1(_0371_),
    .A2(_0635_),
    .A3(_0636_),
    .B1(_0641_),
    .B2(_0367_),
    .X(_0642_));
 sky130_fd_sc_hd__o21a_4 _1318_ (.A1(_0634_),
    .A2(_0642_),
    .B1(_0573_),
    .X(shift_out[2]));
 sky130_fd_sc_hd__or2_4 _1319_ (.A(_0617_),
    .B(\configy.bits_b[2] ),
    .X(_0643_));
 sky130_fd_sc_hd__o21a_4 _1320_ (.A1(_0616_),
    .A2(\configy.bits_b[6] ),
    .B1(_0643_),
    .X(_0644_));
 sky130_fd_sc_hd__or2_4 _1321_ (.A(_0620_),
    .B(\configy.bits_b[7] ),
    .X(_0645_));
 sky130_fd_sc_hd__or2_4 _1322_ (.A(_0352_),
    .B(\configy.bits_b[3] ),
    .X(_0646_));
 sky130_fd_sc_hd__and3_4 _1323_ (.A(_0376_),
    .B(_0645_),
    .C(_0646_),
    .X(_0647_));
 sky130_fd_sc_hd__a211o_4 _1324_ (.A1(_0373_),
    .A2(_0644_),
    .B1(_0647_),
    .C1(_0369_),
    .X(_0648_));
 sky130_fd_sc_hd__or2_4 _1325_ (.A(_0352_),
    .B(\configy.bits_b[0] ),
    .X(_0649_));
 sky130_fd_sc_hd__o21a_4 _1326_ (.A1(_0616_),
    .A2(\configy.bits_b[4] ),
    .B1(_0649_),
    .X(_0650_));
 sky130_fd_sc_hd__or2_4 _1327_ (.A(_0620_),
    .B(\configy.bits_b[5] ),
    .X(_0651_));
 sky130_fd_sc_hd__or2_4 _1328_ (.A(_0628_),
    .B(\configy.bits_b[1] ),
    .X(_0652_));
 sky130_fd_sc_hd__and3_4 _1329_ (.A(_0375_),
    .B(_0651_),
    .C(_0652_),
    .X(_0653_));
 sky130_fd_sc_hd__a211o_4 _1330_ (.A1(_0373_),
    .A2(_0650_),
    .B1(_0653_),
    .C1(_0367_),
    .X(_0654_));
 sky130_fd_sc_hd__and3_4 _1331_ (.A(_0573_),
    .B(_0648_),
    .C(_0654_),
    .X(shift_out[1]));
 sky130_fd_sc_hd__or2_4 _1332_ (.A(_0628_),
    .B(\configy.bits_a[2] ),
    .X(_0655_));
 sky130_fd_sc_hd__or2_4 _1333_ (.A(_0614_),
    .B(\configy.bits_a[6] ),
    .X(_0656_));
 sky130_fd_sc_hd__or2_4 _1334_ (.A(_0628_),
    .B(\configy.bits_a[3] ),
    .X(_0657_));
 sky130_fd_sc_hd__o21a_4 _1335_ (.A1(_0620_),
    .A2(\configy.bits_a[7] ),
    .B1(_0375_),
    .X(_0658_));
 sky130_fd_sc_hd__a32o_4 _1336_ (.A1(_0370_),
    .A2(_0655_),
    .A3(_0656_),
    .B1(_0657_),
    .B2(_0658_),
    .X(_0659_));
 sky130_fd_sc_hd__or2_4 _1337_ (.A(_0617_),
    .B(\configy.bits_a[0] ),
    .X(_0660_));
 sky130_fd_sc_hd__or2_4 _1338_ (.A(_0615_),
    .B(\configy.bits_a[4] ),
    .X(_0661_));
 sky130_fd_sc_hd__and3_4 _1339_ (.A(_0371_),
    .B(_0660_),
    .C(_0661_),
    .X(_0662_));
 sky130_fd_sc_hd__or2_4 _1340_ (.A(_0615_),
    .B(\configy.bits_a[5] ),
    .X(_0663_));
 sky130_fd_sc_hd__or2_4 _1341_ (.A(_0617_),
    .B(\configy.bits_a[1] ),
    .X(_0664_));
 sky130_fd_sc_hd__and4_4 _1342_ (.A(_0369_),
    .B(_0376_),
    .C(_0663_),
    .D(_0664_),
    .X(_0665_));
 sky130_fd_sc_hd__a211o_4 _1343_ (.A1(_0367_),
    .A2(_0659_),
    .B1(_0662_),
    .C1(_0665_),
    .X(_0666_));
 sky130_fd_sc_hd__and2_4 _1344_ (.A(_0573_),
    .B(_0666_),
    .X(shift_out[0]));
 sky130_fd_sc_hd__or2_4 _1345_ (.A(\configy.free_run ),
    .B(_0341_),
    .X(cen));
 sky130_fd_sc_hd__a21o_4 _1346_ (.A1(_0164_),
    .A2(_0166_),
    .B1(wbs_data_o[31]),
    .X(_0667_));
 sky130_fd_sc_hd__and2_4 _1347_ (.A(\configy.counter_d[7] ),
    .B(_0298_),
    .X(_0668_));
 sky130_fd_sc_hd__and2_4 _1348_ (.A(\configy.bits_d[7] ),
    .B(_0300_),
    .X(_0669_));
 sky130_fd_sc_hd__or4_4 _1349_ (.A(_0173_),
    .B(_0145_),
    .C(_0668_),
    .D(_0669_),
    .X(_0670_));
 sky130_fd_sc_hd__and3_4 _1350_ (.A(_0109_),
    .B(_0667_),
    .C(_0670_),
    .X(_0107_));
 sky130_fd_sc_hd__dfxtp_4 _1351_ (.D(_0000_),
    .Q(\configy.bits_a[0] ),
    .CLK(clknet_3_0_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1352_ (.D(_0001_),
    .Q(\configy.bits_a[1] ),
    .CLK(clknet_3_0_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1353_ (.D(_0002_),
    .Q(\configy.bits_a[2] ),
    .CLK(clknet_3_0_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1354_ (.D(_0003_),
    .Q(\configy.bits_a[3] ),
    .CLK(clknet_3_0_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1355_ (.D(_0004_),
    .Q(\configy.bits_a[4] ),
    .CLK(clknet_3_0_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1356_ (.D(_0005_),
    .Q(\configy.bits_a[5] ),
    .CLK(clknet_3_0_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1357_ (.D(_0006_),
    .Q(\configy.bits_a[6] ),
    .CLK(clknet_3_0_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1358_ (.D(_0007_),
    .Q(\configy.bits_a[7] ),
    .CLK(clknet_3_1_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1359_ (.D(_0008_),
    .Q(\configy.bits_d[0] ),
    .CLK(clknet_3_5_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1360_ (.D(_0009_),
    .Q(\configy.bits_d[1] ),
    .CLK(clknet_3_4_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1361_ (.D(_0010_),
    .Q(\configy.bits_d[2] ),
    .CLK(clknet_3_5_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1362_ (.D(_0011_),
    .Q(\configy.bits_d[3] ),
    .CLK(clknet_3_5_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1363_ (.D(_0012_),
    .Q(\configy.bits_d[4] ),
    .CLK(clknet_3_5_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1364_ (.D(_0013_),
    .Q(\configy.bits_d[5] ),
    .CLK(clknet_3_5_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1365_ (.D(_0014_),
    .Q(\configy.bits_d[6] ),
    .CLK(clknet_3_5_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1366_ (.D(_0015_),
    .Q(\configy.bits_d[7] ),
    .CLK(clknet_3_6_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1367_ (.D(_0016_),
    .Q(\configy.bits_c[0] ),
    .CLK(clknet_3_6_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1368_ (.D(_0017_),
    .Q(\configy.bits_c[1] ),
    .CLK(clknet_3_6_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1369_ (.D(_0018_),
    .Q(\configy.bits_c[2] ),
    .CLK(clknet_3_6_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1370_ (.D(_0019_),
    .Q(\configy.bits_c[3] ),
    .CLK(clknet_3_6_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1371_ (.D(_0020_),
    .Q(\configy.bits_c[4] ),
    .CLK(clknet_3_6_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1372_ (.D(_0021_),
    .Q(\configy.bits_c[5] ),
    .CLK(clknet_3_6_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1373_ (.D(_0022_),
    .Q(\configy.bits_c[6] ),
    .CLK(clknet_3_6_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1374_ (.D(_0023_),
    .Q(\configy.bits_c[7] ),
    .CLK(clknet_3_6_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1375_ (.D(_0024_),
    .Q(\configy.bits_b[0] ),
    .CLK(clknet_3_3_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1376_ (.D(_0025_),
    .Q(\configy.bits_b[1] ),
    .CLK(clknet_3_3_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1377_ (.D(_0026_),
    .Q(\configy.bits_b[2] ),
    .CLK(clknet_3_3_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1378_ (.D(_0027_),
    .Q(\configy.bits_b[3] ),
    .CLK(clknet_3_2_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1379_ (.D(_0028_),
    .Q(\configy.bits_b[4] ),
    .CLK(clknet_3_3_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1380_ (.D(_0029_),
    .Q(\configy.bits_b[5] ),
    .CLK(clknet_3_2_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1381_ (.D(_0030_),
    .Q(\configy.bits_b[6] ),
    .CLK(clknet_3_3_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1382_ (.D(_0031_),
    .Q(\configy.bits_b[7] ),
    .CLK(clknet_3_2_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1383_ (.D(_0032_),
    .Q(wbs_ack_o),
    .CLK(clknet_3_7_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1384_ (.D(_0033_),
    .Q(\configy.output_initiated ),
    .CLK(clknet_3_4_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1385_ (.D(_0034_),
    .Q(\configy.write_transaction_in_progress ),
    .CLK(clknet_3_0_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1386_ (.D(_0035_),
    .Q(\configy.counter_d[0] ),
    .CLK(clknet_3_4_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1387_ (.D(_0036_),
    .Q(\configy.counter_d[1] ),
    .CLK(clknet_3_4_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1388_ (.D(_0037_),
    .Q(\configy.counter_d[2] ),
    .CLK(clknet_3_4_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1389_ (.D(_0038_),
    .Q(\configy.counter_d[3] ),
    .CLK(clknet_3_5_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1390_ (.D(_0039_),
    .Q(\configy.counter_d[4] ),
    .CLK(clknet_3_5_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1391_ (.D(_0040_),
    .Q(\configy.counter_d[5] ),
    .CLK(clknet_3_5_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1392_ (.D(_0041_),
    .Q(\configy.counter_d[6] ),
    .CLK(clknet_3_5_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1393_ (.D(_0042_),
    .Q(\configy.counter_d[7] ),
    .CLK(clknet_3_4_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1394_ (.D(_0043_),
    .Q(\configy.counter_c[0] ),
    .CLK(clknet_3_4_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1395_ (.D(_0044_),
    .Q(\configy.counter_c[1] ),
    .CLK(clknet_3_5_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1396_ (.D(_0045_),
    .Q(\configy.counter_c[2] ),
    .CLK(clknet_3_4_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1397_ (.D(_0046_),
    .Q(\configy.counter_c[3] ),
    .CLK(clknet_3_5_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1398_ (.D(_0047_),
    .Q(\configy.counter_c[4] ),
    .CLK(clknet_3_5_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1399_ (.D(_0048_),
    .Q(\configy.counter_c[5] ),
    .CLK(clknet_3_5_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1400_ (.D(_0049_),
    .Q(\configy.counter_c[6] ),
    .CLK(clknet_3_5_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1401_ (.D(_0050_),
    .Q(\configy.counter_c[7] ),
    .CLK(clknet_3_4_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1402_ (.D(_0051_),
    .Q(\configy.counter_b[0] ),
    .CLK(clknet_3_1_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1403_ (.D(_0052_),
    .Q(\configy.counter_b[1] ),
    .CLK(clknet_3_1_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1404_ (.D(_0053_),
    .Q(\configy.counter_b[2] ),
    .CLK(clknet_3_0_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1405_ (.D(_0054_),
    .Q(\configy.counter_b[3] ),
    .CLK(clknet_3_1_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1406_ (.D(_0055_),
    .Q(\configy.counter_b[4] ),
    .CLK(clknet_3_1_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1407_ (.D(_0056_),
    .Q(\configy.counter_b[5] ),
    .CLK(clknet_3_1_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1408_ (.D(_0057_),
    .Q(\configy.counter_b[6] ),
    .CLK(clknet_3_1_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1409_ (.D(_0058_),
    .Q(\configy.counter_b[7] ),
    .CLK(clknet_3_0_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1410_ (.D(_0059_),
    .Q(\configy.counter_a[0] ),
    .CLK(clknet_3_1_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1411_ (.D(_0060_),
    .Q(\configy.counter_a[1] ),
    .CLK(clknet_3_1_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1412_ (.D(_0061_),
    .Q(\configy.counter_a[2] ),
    .CLK(clknet_3_0_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1413_ (.D(_0062_),
    .Q(\configy.counter_a[3] ),
    .CLK(clknet_3_0_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1414_ (.D(_0063_),
    .Q(\configy.counter_a[4] ),
    .CLK(clknet_3_0_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1415_ (.D(_0064_),
    .Q(\configy.counter_a[5] ),
    .CLK(clknet_3_0_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1416_ (.D(_0065_),
    .Q(\configy.counter_a[6] ),
    .CLK(clknet_3_1_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1417_ (.D(_0066_),
    .Q(\configy.counter_a[7] ),
    .CLK(clknet_3_1_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1418_ (.D(_0067_),
    .Q(\configy.bits_index[0] ),
    .CLK(clknet_3_3_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1419_ (.D(_0068_),
    .Q(\configy.bits_index[1] ),
    .CLK(clknet_3_3_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1420_ (.D(_0069_),
    .Q(\configy.bits_index[2] ),
    .CLK(clknet_3_3_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1421_ (.D(_0070_),
    .Q(\configy.charged[0] ),
    .CLK(clknet_3_0_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1422_ (.D(_0071_),
    .Q(\configy.charged[1] ),
    .CLK(clknet_3_0_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1423_ (.D(_0072_),
    .Q(\configy.charged[2] ),
    .CLK(clknet_3_0_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1424_ (.D(_0073_),
    .Q(\configy.charged[3] ),
    .CLK(clknet_3_0_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1425_ (.D(_0074_),
    .Q(\configy.free_run ),
    .CLK(clknet_3_4_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1426_ (.D(_0075_),
    .Q(\configy.read_transaction_in_progress ),
    .CLK(clknet_3_7_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1427_ (.D(_0076_),
    .Q(wbs_data_o[0]),
    .CLK(clknet_3_6_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1428_ (.D(_0077_),
    .Q(wbs_data_o[1]),
    .CLK(clknet_3_2_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1429_ (.D(_0078_),
    .Q(wbs_data_o[2]),
    .CLK(clknet_3_2_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1430_ (.D(_0079_),
    .Q(wbs_data_o[3]),
    .CLK(clknet_3_2_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1431_ (.D(_0080_),
    .Q(wbs_data_o[4]),
    .CLK(clknet_3_2_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1432_ (.D(_0081_),
    .Q(wbs_data_o[5]),
    .CLK(clknet_3_2_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1433_ (.D(_0082_),
    .Q(wbs_data_o[6]),
    .CLK(clknet_3_2_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1434_ (.D(_0083_),
    .Q(wbs_data_o[7]),
    .CLK(clknet_3_2_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1435_ (.D(_0084_),
    .Q(wbs_data_o[8]),
    .CLK(clknet_3_3_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1436_ (.D(_0085_),
    .Q(wbs_data_o[9]),
    .CLK(clknet_3_3_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1437_ (.D(_0086_),
    .Q(wbs_data_o[10]),
    .CLK(clknet_3_3_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1438_ (.D(_0087_),
    .Q(wbs_data_o[11]),
    .CLK(clknet_3_3_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1439_ (.D(_0088_),
    .Q(wbs_data_o[12]),
    .CLK(clknet_3_3_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1440_ (.D(_0089_),
    .Q(wbs_data_o[13]),
    .CLK(clknet_3_3_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1441_ (.D(_0090_),
    .Q(wbs_data_o[14]),
    .CLK(clknet_3_3_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1442_ (.D(_0091_),
    .Q(wbs_data_o[15]),
    .CLK(clknet_3_6_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1443_ (.D(_0092_),
    .Q(wbs_data_o[16]),
    .CLK(clknet_3_6_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1444_ (.D(_0093_),
    .Q(wbs_data_o[17]),
    .CLK(clknet_3_6_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1445_ (.D(_0094_),
    .Q(wbs_data_o[18]),
    .CLK(clknet_3_6_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1446_ (.D(_0095_),
    .Q(wbs_data_o[19]),
    .CLK(clknet_3_6_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1447_ (.D(_0096_),
    .Q(wbs_data_o[20]),
    .CLK(clknet_3_6_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1448_ (.D(_0097_),
    .Q(wbs_data_o[21]),
    .CLK(clknet_3_6_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1449_ (.D(_0098_),
    .Q(wbs_data_o[22]),
    .CLK(clknet_3_7_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1450_ (.D(_0099_),
    .Q(wbs_data_o[23]),
    .CLK(clknet_3_7_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1451_ (.D(_0100_),
    .Q(wbs_data_o[24]),
    .CLK(clknet_3_7_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1452_ (.D(_0101_),
    .Q(wbs_data_o[25]),
    .CLK(clknet_3_7_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1453_ (.D(_0102_),
    .Q(wbs_data_o[26]),
    .CLK(clknet_3_7_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1454_ (.D(_0103_),
    .Q(wbs_data_o[27]),
    .CLK(clknet_3_7_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1455_ (.D(_0104_),
    .Q(wbs_data_o[28]),
    .CLK(clknet_3_7_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1456_ (.D(_0105_),
    .Q(wbs_data_o[29]),
    .CLK(clknet_3_7_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1457_ (.D(_0106_),
    .Q(wbs_data_o[30]),
    .CLK(clknet_3_7_0_wb_clk_i));
 sky130_fd_sc_hd__dfxtp_4 _1458_ (.D(_0107_),
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
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_371 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_372 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_373 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_374 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_375 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_376 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_377 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_378 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_379 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_380 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_381 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_382 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_383 ();
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
 sky130_fd_sc_hd__diode_2 ANTENNA_clkbuf_0_wb_clk_i_A (.DIODE(wb_clk_i));
 sky130_fd_sc_hd__diode_2 ANTENNA__1061__A (.DIODE(wb_rst_i));
 sky130_fd_sc_hd__diode_2 ANTENNA__0940__A (.DIODE(wb_rst_i));
 sky130_fd_sc_hd__diode_2 ANTENNA__0927__A (.DIODE(wb_rst_i));
 sky130_fd_sc_hd__diode_2 ANTENNA__0917__A (.DIODE(wb_rst_i));
 sky130_fd_sc_hd__diode_2 ANTENNA__0671__A (.DIODE(wb_rst_i));
 sky130_fd_sc_hd__diode_2 ANTENNA__0678__B (.DIODE(wbs_ack_o));
 sky130_fd_sc_hd__diode_2 ANTENNA__0671__B (.DIODE(wbs_ack_o));
 sky130_fd_sc_hd__diode_2 ANTENNA__0700__A (.DIODE(wbs_addr_i[0]));
 sky130_fd_sc_hd__diode_2 ANTENNA__0695__B (.DIODE(wbs_addr_i[0]));
 sky130_fd_sc_hd__diode_2 ANTENNA__0686__D (.DIODE(wbs_addr_i[10]));
 sky130_fd_sc_hd__diode_2 ANTENNA__0686__C (.DIODE(wbs_addr_i[11]));
 sky130_fd_sc_hd__diode_2 ANTENNA__0685__B (.DIODE(wbs_addr_i[12]));
 sky130_fd_sc_hd__diode_2 ANTENNA__0685__A (.DIODE(wbs_addr_i[13]));
 sky130_fd_sc_hd__diode_2 ANTENNA__0685__D (.DIODE(wbs_addr_i[14]));
 sky130_fd_sc_hd__diode_2 ANTENNA__0685__C (.DIODE(wbs_addr_i[15]));
 sky130_fd_sc_hd__diode_2 ANTENNA__0679__A (.DIODE(wbs_addr_i[16]));
 sky130_fd_sc_hd__diode_2 ANTENNA__0688__A (.DIODE(wbs_addr_i[17]));
 sky130_fd_sc_hd__diode_2 ANTENNA__0688__B (.DIODE(wbs_addr_i[18]));
 sky130_fd_sc_hd__diode_2 ANTENNA__0679__B (.DIODE(wbs_addr_i[19]));
 sky130_fd_sc_hd__diode_2 ANTENNA__0699__A (.DIODE(wbs_addr_i[1]));
 sky130_fd_sc_hd__diode_2 ANTENNA__0695__A (.DIODE(wbs_addr_i[1]));
 sky130_fd_sc_hd__diode_2 ANTENNA__0688__C (.DIODE(wbs_addr_i[20]));
 sky130_fd_sc_hd__diode_2 ANTENNA__0679__C (.DIODE(wbs_addr_i[21]));
 sky130_fd_sc_hd__diode_2 ANTENNA__0679__D (.DIODE(wbs_addr_i[22]));
 sky130_fd_sc_hd__diode_2 ANTENNA__0688__D (.DIODE(wbs_addr_i[23]));
 sky130_fd_sc_hd__diode_2 ANTENNA__0690__A (.DIODE(wbs_addr_i[24]));
 sky130_fd_sc_hd__diode_2 ANTENNA__0681__A (.DIODE(wbs_addr_i[25]));
 sky130_fd_sc_hd__diode_2 ANTENNA__0681__B (.DIODE(wbs_addr_i[26]));
 sky130_fd_sc_hd__diode_2 ANTENNA__0690__B (.DIODE(wbs_addr_i[27]));
 sky130_fd_sc_hd__diode_2 ANTENNA__0680__A (.DIODE(wbs_addr_i[28]));
 sky130_fd_sc_hd__diode_2 ANTENNA__0689__A (.DIODE(wbs_addr_i[29]));
 sky130_fd_sc_hd__diode_2 ANTENNA__0702__D (.DIODE(wbs_addr_i[2]));
 sky130_fd_sc_hd__diode_2 ANTENNA__0695__C (.DIODE(wbs_addr_i[2]));
 sky130_fd_sc_hd__diode_2 ANTENNA__0690__D (.DIODE(wbs_addr_i[30]));
 sky130_fd_sc_hd__diode_2 ANTENNA__0681__D (.DIODE(wbs_addr_i[31]));
 sky130_fd_sc_hd__diode_2 ANTENNA__0931__A (.DIODE(wbs_addr_i[3]));
 sky130_fd_sc_hd__diode_2 ANTENNA__0913__B (.DIODE(wbs_addr_i[3]));
 sky130_fd_sc_hd__diode_2 ANTENNA__0701__A (.DIODE(wbs_addr_i[3]));
 sky130_fd_sc_hd__diode_2 ANTENNA__0696__A (.DIODE(wbs_addr_i[3]));
 sky130_fd_sc_hd__diode_2 ANTENNA__0674__A (.DIODE(wbs_addr_i[4]));
 sky130_fd_sc_hd__diode_2 ANTENNA__0675__A (.DIODE(wbs_addr_i[5]));
 sky130_fd_sc_hd__diode_2 ANTENNA__0675__D (.DIODE(wbs_addr_i[6]));
 sky130_fd_sc_hd__diode_2 ANTENNA__0675__C (.DIODE(wbs_addr_i[7]));
 sky130_fd_sc_hd__diode_2 ANTENNA__0686__B (.DIODE(wbs_addr_i[8]));
 sky130_fd_sc_hd__diode_2 ANTENNA__0686__A (.DIODE(wbs_addr_i[9]));
 sky130_fd_sc_hd__diode_2 ANTENNA__0676__A (.DIODE(wbs_cyc_i));
 sky130_fd_sc_hd__diode_2 ANTENNA__1282__A (.DIODE(wbs_data_i[0]));
 sky130_fd_sc_hd__diode_2 ANTENNA__1040__A (.DIODE(wbs_data_i[0]));
 sky130_fd_sc_hd__diode_2 ANTENNA__0924__A (.DIODE(wbs_data_i[0]));
 sky130_fd_sc_hd__diode_2 ANTENNA__1224__A (.DIODE(wbs_data_i[10]));
 sky130_fd_sc_hd__diode_2 ANTENNA__1086__A1 (.DIODE(wbs_data_i[10]));
 sky130_fd_sc_hd__diode_2 ANTENNA__1222__A (.DIODE(wbs_data_i[11]));
 sky130_fd_sc_hd__diode_2 ANTENNA__1083__A1 (.DIODE(wbs_data_i[11]));
 sky130_fd_sc_hd__diode_2 ANTENNA__1220__A (.DIODE(wbs_data_i[12]));
 sky130_fd_sc_hd__diode_2 ANTENNA__1075__A (.DIODE(wbs_data_i[12]));
 sky130_fd_sc_hd__diode_2 ANTENNA__1218__A (.DIODE(wbs_data_i[13]));
 sky130_fd_sc_hd__diode_2 ANTENNA__1069__A (.DIODE(wbs_data_i[13]));
 sky130_fd_sc_hd__diode_2 ANTENNA__1216__A (.DIODE(wbs_data_i[14]));
 sky130_fd_sc_hd__diode_2 ANTENNA__1063__A (.DIODE(wbs_data_i[14]));
 sky130_fd_sc_hd__diode_2 ANTENNA__1214__A (.DIODE(wbs_data_i[15]));
 sky130_fd_sc_hd__diode_2 ANTENNA__1049__A (.DIODE(wbs_data_i[15]));
 sky130_fd_sc_hd__diode_2 ANTENNA__1246__A (.DIODE(wbs_data_i[16]));
 sky130_fd_sc_hd__diode_2 ANTENNA__1146__A (.DIODE(wbs_data_i[16]));
 sky130_fd_sc_hd__diode_2 ANTENNA__1244__A (.DIODE(wbs_data_i[17]));
 sky130_fd_sc_hd__diode_2 ANTENNA__1141__A (.DIODE(wbs_data_i[17]));
 sky130_fd_sc_hd__diode_2 ANTENNA__1242__A (.DIODE(wbs_data_i[18]));
 sky130_fd_sc_hd__diode_2 ANTENNA__1137__A1 (.DIODE(wbs_data_i[18]));
 sky130_fd_sc_hd__diode_2 ANTENNA__1240__A (.DIODE(wbs_data_i[19]));
 sky130_fd_sc_hd__diode_2 ANTENNA__1134__A1 (.DIODE(wbs_data_i[19]));
 sky130_fd_sc_hd__diode_2 ANTENNA__1280__A (.DIODE(wbs_data_i[1]));
 sky130_fd_sc_hd__diode_2 ANTENNA__1036__A (.DIODE(wbs_data_i[1]));
 sky130_fd_sc_hd__diode_2 ANTENNA__1238__A (.DIODE(wbs_data_i[20]));
 sky130_fd_sc_hd__diode_2 ANTENNA__1128__A (.DIODE(wbs_data_i[20]));
 sky130_fd_sc_hd__diode_2 ANTENNA__1236__A (.DIODE(wbs_data_i[21]));
 sky130_fd_sc_hd__diode_2 ANTENNA__1121__A (.DIODE(wbs_data_i[21]));
 sky130_fd_sc_hd__diode_2 ANTENNA__1234__A (.DIODE(wbs_data_i[22]));
 sky130_fd_sc_hd__diode_2 ANTENNA__1115__A (.DIODE(wbs_data_i[22]));
 sky130_fd_sc_hd__diode_2 ANTENNA__1232__A (.DIODE(wbs_data_i[23]));
 sky130_fd_sc_hd__diode_2 ANTENNA__1099__A (.DIODE(wbs_data_i[23]));
 sky130_fd_sc_hd__diode_2 ANTENNA__1264__A (.DIODE(wbs_data_i[24]));
 sky130_fd_sc_hd__diode_2 ANTENNA__1197__A (.DIODE(wbs_data_i[24]));
 sky130_fd_sc_hd__diode_2 ANTENNA__1262__A (.DIODE(wbs_data_i[25]));
 sky130_fd_sc_hd__diode_2 ANTENNA__1193__A (.DIODE(wbs_data_i[25]));
 sky130_fd_sc_hd__diode_2 ANTENNA__1260__A (.DIODE(wbs_data_i[26]));
 sky130_fd_sc_hd__diode_2 ANTENNA__1189__A1 (.DIODE(wbs_data_i[26]));
 sky130_fd_sc_hd__diode_2 ANTENNA__1258__A (.DIODE(wbs_data_i[27]));
 sky130_fd_sc_hd__diode_2 ANTENNA__1186__A1 (.DIODE(wbs_data_i[27]));
 sky130_fd_sc_hd__diode_2 ANTENNA__1256__A (.DIODE(wbs_data_i[28]));
 sky130_fd_sc_hd__diode_2 ANTENNA__1178__A (.DIODE(wbs_data_i[28]));
 sky130_fd_sc_hd__diode_2 ANTENNA__1254__A (.DIODE(wbs_data_i[29]));
 sky130_fd_sc_hd__diode_2 ANTENNA__1172__A (.DIODE(wbs_data_i[29]));
 sky130_fd_sc_hd__diode_2 ANTENNA__1278__A (.DIODE(wbs_data_i[2]));
 sky130_fd_sc_hd__diode_2 ANTENNA__1031__A1 (.DIODE(wbs_data_i[2]));
 sky130_fd_sc_hd__diode_2 ANTENNA__1252__A (.DIODE(wbs_data_i[30]));
 sky130_fd_sc_hd__diode_2 ANTENNA__1169__A (.DIODE(wbs_data_i[30]));
 sky130_fd_sc_hd__diode_2 ANTENNA__1250__A (.DIODE(wbs_data_i[31]));
 sky130_fd_sc_hd__diode_2 ANTENNA__1153__A (.DIODE(wbs_data_i[31]));
 sky130_fd_sc_hd__diode_2 ANTENNA__1276__A (.DIODE(wbs_data_i[3]));
 sky130_fd_sc_hd__diode_2 ANTENNA__1028__A1 (.DIODE(wbs_data_i[3]));
 sky130_fd_sc_hd__diode_2 ANTENNA__1274__A (.DIODE(wbs_data_i[4]));
 sky130_fd_sc_hd__diode_2 ANTENNA__1021__A (.DIODE(wbs_data_i[4]));
 sky130_fd_sc_hd__diode_2 ANTENNA__1272__A (.DIODE(wbs_data_i[5]));
 sky130_fd_sc_hd__diode_2 ANTENNA__1013__A (.DIODE(wbs_data_i[5]));
 sky130_fd_sc_hd__diode_2 ANTENNA__1270__A (.DIODE(wbs_data_i[6]));
 sky130_fd_sc_hd__diode_2 ANTENNA__1006__A (.DIODE(wbs_data_i[6]));
 sky130_fd_sc_hd__diode_2 ANTENNA__1268__A (.DIODE(wbs_data_i[7]));
 sky130_fd_sc_hd__diode_2 ANTENNA__0982__A (.DIODE(wbs_data_i[7]));
 sky130_fd_sc_hd__diode_2 ANTENNA__1228__A (.DIODE(wbs_data_i[8]));
 sky130_fd_sc_hd__diode_2 ANTENNA__1094__A (.DIODE(wbs_data_i[8]));
 sky130_fd_sc_hd__diode_2 ANTENNA__1226__A (.DIODE(wbs_data_i[9]));
 sky130_fd_sc_hd__diode_2 ANTENNA__1090__A (.DIODE(wbs_data_i[9]));
 sky130_fd_sc_hd__diode_2 ANTENNA__0909__B1 (.DIODE(wbs_data_o[0]));
 sky130_fd_sc_hd__diode_2 ANTENNA__0844__B1 (.DIODE(wbs_data_o[10]));
 sky130_fd_sc_hd__diode_2 ANTENNA__0839__B1 (.DIODE(wbs_data_o[11]));
 sky130_fd_sc_hd__diode_2 ANTENNA__0831__B1 (.DIODE(wbs_data_o[12]));
 sky130_fd_sc_hd__diode_2 ANTENNA__0825__B1 (.DIODE(wbs_data_o[13]));
 sky130_fd_sc_hd__diode_2 ANTENNA__0817__B1 (.DIODE(wbs_data_o[14]));
 sky130_fd_sc_hd__diode_2 ANTENNA__0810__B1 (.DIODE(wbs_data_o[15]));
 sky130_fd_sc_hd__diode_2 ANTENNA__0804__B1 (.DIODE(wbs_data_o[16]));
 sky130_fd_sc_hd__diode_2 ANTENNA__0795__B1 (.DIODE(wbs_data_o[17]));
 sky130_fd_sc_hd__diode_2 ANTENNA__0790__B1 (.DIODE(wbs_data_o[18]));
 sky130_fd_sc_hd__diode_2 ANTENNA__0783__B1 (.DIODE(wbs_data_o[19]));
 sky130_fd_sc_hd__diode_2 ANTENNA__0903__B1 (.DIODE(wbs_data_o[1]));
 sky130_fd_sc_hd__diode_2 ANTENNA__0776__B1 (.DIODE(wbs_data_o[20]));
 sky130_fd_sc_hd__diode_2 ANTENNA__0770__B1 (.DIODE(wbs_data_o[21]));
 sky130_fd_sc_hd__diode_2 ANTENNA__0762__B1 (.DIODE(wbs_data_o[22]));
 sky130_fd_sc_hd__diode_2 ANTENNA__0757__B1 (.DIODE(wbs_data_o[23]));
 sky130_fd_sc_hd__diode_2 ANTENNA__0749__B1 (.DIODE(wbs_data_o[24]));
 sky130_fd_sc_hd__diode_2 ANTENNA__0740__B1 (.DIODE(wbs_data_o[25]));
 sky130_fd_sc_hd__diode_2 ANTENNA__0735__B1 (.DIODE(wbs_data_o[26]));
 sky130_fd_sc_hd__diode_2 ANTENNA__0725__B1 (.DIODE(wbs_data_o[27]));
 sky130_fd_sc_hd__diode_2 ANTENNA__0720__B1 (.DIODE(wbs_data_o[28]));
 sky130_fd_sc_hd__diode_2 ANTENNA__0712__B1 (.DIODE(wbs_data_o[29]));
 sky130_fd_sc_hd__diode_2 ANTENNA__0898__B1 (.DIODE(wbs_data_o[2]));
 sky130_fd_sc_hd__diode_2 ANTENNA__0694__B1 (.DIODE(wbs_data_o[30]));
 sky130_fd_sc_hd__diode_2 ANTENNA__1346__B1 (.DIODE(wbs_data_o[31]));
 sky130_fd_sc_hd__diode_2 ANTENNA__0893__B1 (.DIODE(wbs_data_o[3]));
 sky130_fd_sc_hd__diode_2 ANTENNA__0886__B1 (.DIODE(wbs_data_o[4]));
 sky130_fd_sc_hd__diode_2 ANTENNA__0878__B1 (.DIODE(wbs_data_o[5]));
 sky130_fd_sc_hd__diode_2 ANTENNA__0873__B1 (.DIODE(wbs_data_o[6]));
 sky130_fd_sc_hd__diode_2 ANTENNA__0865__B1 (.DIODE(wbs_data_o[7]));
 sky130_fd_sc_hd__diode_2 ANTENNA__0859__B1 (.DIODE(wbs_data_o[8]));
 sky130_fd_sc_hd__diode_2 ANTENNA__0851__B1 (.DIODE(wbs_data_o[9]));
 sky130_fd_sc_hd__diode_2 ANTENNA__0996__A1 (.DIODE(wbs_sel_i[0]));
 sky130_fd_sc_hd__diode_2 ANTENNA__0925__A (.DIODE(wbs_sel_i[0]));
 sky130_fd_sc_hd__diode_2 ANTENNA__1212__A (.DIODE(wbs_sel_i[1]));
 sky130_fd_sc_hd__diode_2 ANTENNA__1202__B1 (.DIODE(wbs_sel_i[1]));
 sky130_fd_sc_hd__diode_2 ANTENNA__1056__A3 (.DIODE(wbs_sel_i[1]));
 sky130_fd_sc_hd__diode_2 ANTENNA__1053__A3 (.DIODE(wbs_sel_i[1]));
 sky130_fd_sc_hd__diode_2 ANTENNA__0946__A (.DIODE(wbs_sel_i[1]));
 sky130_fd_sc_hd__diode_2 ANTENNA__1230__A (.DIODE(wbs_sel_i[2]));
 sky130_fd_sc_hd__diode_2 ANTENNA__1201__B1 (.DIODE(wbs_sel_i[2]));
 sky130_fd_sc_hd__diode_2 ANTENNA__1109__A3 (.DIODE(wbs_sel_i[2]));
 sky130_fd_sc_hd__diode_2 ANTENNA__1106__A3 (.DIODE(wbs_sel_i[2]));
 sky130_fd_sc_hd__diode_2 ANTENNA__0943__A (.DIODE(wbs_sel_i[2]));
 sky130_fd_sc_hd__diode_2 ANTENNA__1248__A (.DIODE(wbs_sel_i[3]));
 sky130_fd_sc_hd__diode_2 ANTENNA__1202__A2 (.DIODE(wbs_sel_i[3]));
 sky130_fd_sc_hd__diode_2 ANTENNA__1160__A3 (.DIODE(wbs_sel_i[3]));
 sky130_fd_sc_hd__diode_2 ANTENNA__1157__A3 (.DIODE(wbs_sel_i[3]));
 sky130_fd_sc_hd__diode_2 ANTENNA__0933__A (.DIODE(wbs_sel_i[3]));
 sky130_fd_sc_hd__diode_2 ANTENNA__0677__A (.DIODE(wbs_stb_i));
 sky130_fd_sc_hd__diode_2 ANTENNA__1205__A (.DIODE(wbs_we_i));
 sky130_fd_sc_hd__diode_2 ANTENNA__1351__D (.DIODE(_0000_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1352__D (.DIODE(_0001_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1353__D (.DIODE(_0002_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1354__D (.DIODE(_0003_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1355__D (.DIODE(_0004_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1356__D (.DIODE(_0005_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1357__D (.DIODE(_0006_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1358__D (.DIODE(_0007_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1359__D (.DIODE(_0008_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1360__D (.DIODE(_0009_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1361__D (.DIODE(_0010_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1362__D (.DIODE(_0011_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1363__D (.DIODE(_0012_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1364__D (.DIODE(_0013_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1365__D (.DIODE(_0014_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1366__D (.DIODE(_0015_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1367__D (.DIODE(_0016_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1368__D (.DIODE(_0017_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1369__D (.DIODE(_0018_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1370__D (.DIODE(_0019_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1371__D (.DIODE(_0020_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1372__D (.DIODE(_0021_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1373__D (.DIODE(_0022_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1374__D (.DIODE(_0023_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1375__D (.DIODE(_0024_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1376__D (.DIODE(_0025_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1377__D (.DIODE(_0026_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1378__D (.DIODE(_0027_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1379__D (.DIODE(_0028_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1380__D (.DIODE(_0029_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1381__D (.DIODE(_0030_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1382__D (.DIODE(_0031_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1383__D (.DIODE(_0032_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1384__D (.DIODE(_0033_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1385__D (.DIODE(_0034_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1386__D (.DIODE(_0035_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1387__D (.DIODE(_0036_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1388__D (.DIODE(_0037_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1389__D (.DIODE(_0038_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1390__D (.DIODE(_0039_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1391__D (.DIODE(_0040_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1392__D (.DIODE(_0041_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1393__D (.DIODE(_0042_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1394__D (.DIODE(_0043_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1395__D (.DIODE(_0044_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1396__D (.DIODE(_0045_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1397__D (.DIODE(_0046_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1398__D (.DIODE(_0047_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1399__D (.DIODE(_0048_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1400__D (.DIODE(_0049_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1401__D (.DIODE(_0050_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1402__D (.DIODE(_0051_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1403__D (.DIODE(_0052_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1404__D (.DIODE(_0053_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1405__D (.DIODE(_0054_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1406__D (.DIODE(_0055_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1407__D (.DIODE(_0056_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1408__D (.DIODE(_0057_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1409__D (.DIODE(_0058_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1410__D (.DIODE(_0059_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1411__D (.DIODE(_0060_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1412__D (.DIODE(_0061_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1413__D (.DIODE(_0062_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1414__D (.DIODE(_0063_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1415__D (.DIODE(_0064_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1416__D (.DIODE(_0065_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1417__D (.DIODE(_0066_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1418__D (.DIODE(_0067_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1419__D (.DIODE(_0068_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1420__D (.DIODE(_0069_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1421__D (.DIODE(_0070_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1422__D (.DIODE(_0071_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1423__D (.DIODE(_0072_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1424__D (.DIODE(_0073_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1425__D (.DIODE(_0074_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1426__D (.DIODE(_0075_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1427__D (.DIODE(_0076_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1428__D (.DIODE(_0077_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1429__D (.DIODE(_0078_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1430__D (.DIODE(_0079_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1431__D (.DIODE(_0080_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1432__D (.DIODE(_0081_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1433__D (.DIODE(_0082_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1434__D (.DIODE(_0083_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1435__D (.DIODE(_0084_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1436__D (.DIODE(_0085_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1437__D (.DIODE(_0086_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1438__D (.DIODE(_0087_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1439__D (.DIODE(_0088_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1440__D (.DIODE(_0089_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1441__D (.DIODE(_0090_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1442__D (.DIODE(_0091_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1443__D (.DIODE(_0092_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1444__D (.DIODE(_0093_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1445__D (.DIODE(_0094_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1446__D (.DIODE(_0095_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1447__D (.DIODE(_0096_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1448__D (.DIODE(_0097_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1449__D (.DIODE(_0098_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1450__D (.DIODE(_0099_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1451__D (.DIODE(_0100_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1452__D (.DIODE(_0101_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1453__D (.DIODE(_0102_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1454__D (.DIODE(_0103_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1455__D (.DIODE(_0104_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1456__D (.DIODE(_0105_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1457__D (.DIODE(_0106_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1458__D (.DIODE(_0107_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0870__A (.DIODE(_0108_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0836__A (.DIODE(_0108_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0801__A (.DIODE(_0108_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0767__A (.DIODE(_0108_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0672__A (.DIODE(_0108_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1350__A (.DIODE(_0109_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0916__A (.DIODE(_0109_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0908__A (.DIODE(_0109_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0730__A (.DIODE(_0109_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0673__A (.DIODE(_0109_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1211__A (.DIODE(_0110_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0729__A (.DIODE(_0110_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0724__A (.DIODE(_0110_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0719__A (.DIODE(_0110_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0711__A (.DIODE(_0110_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0675__B (.DIODE(_0111_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0705__A (.DIODE(_0112_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0682__A (.DIODE(_0112_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0678__C (.DIODE(_0113_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0678__D (.DIODE(_0114_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0705__B (.DIODE(_0115_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0682__B (.DIODE(_0115_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0705__C (.DIODE(_0116_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0682__C (.DIODE(_0116_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0681__C (.DIODE(_0117_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0705__D (.DIODE(_0118_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0682__D (.DIODE(_0118_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0731__A (.DIODE(_0119_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0683__A (.DIODE(_0119_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0871__A (.DIODE(_0120_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0837__A (.DIODE(_0120_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0802__A (.DIODE(_0120_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0768__A (.DIODE(_0120_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0684__A (.DIODE(_0120_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0919__A1 (.DIODE(_0121_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0725__A1 (.DIODE(_0121_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0720__A1 (.DIODE(_0121_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0712__A1 (.DIODE(_0121_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0694__A1 (.DIODE(_0121_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0687__A (.DIODE(_0122_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0687__B (.DIODE(_0123_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0707__A (.DIODE(_0124_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0691__A (.DIODE(_0124_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0707__B (.DIODE(_0125_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0691__B (.DIODE(_0125_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0690__C (.DIODE(_0126_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0707__C (.DIODE(_0127_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0691__C (.DIODE(_0127_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0733__A (.DIODE(_0128_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0692__A (.DIODE(_0128_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0872__A (.DIODE(_0129_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0838__A (.DIODE(_0129_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0803__A (.DIODE(_0129_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0769__A (.DIODE(_0129_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0693__A (.DIODE(_0129_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0919__A2 (.DIODE(_0130_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0725__A2 (.DIODE(_0130_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0720__A2 (.DIODE(_0130_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0712__A2 (.DIODE(_0130_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0694__A2 (.DIODE(_0130_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0711__B (.DIODE(_0131_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0931__C (.DIODE(_0132_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0926__D (.DIODE(_0132_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0913__C (.DIODE(_0132_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0911__B (.DIODE(_0132_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0696__B (.DIODE(_0132_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0887__A (.DIODE(_0133_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0853__A (.DIODE(_0133_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0697__A (.DIODE(_0133_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0818__A (.DIODE(_0134_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0784__A (.DIODE(_0134_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0751__A (.DIODE(_0134_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0714__A (.DIODE(_0134_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0698__B (.DIODE(_0134_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0710__A (.DIODE(_0135_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0702__A (.DIODE(_0136_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0702__B (.DIODE(_0137_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0926__A (.DIODE(_0138_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0911__A (.DIODE(_0138_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0702__C (.DIODE(_0138_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1056__A4 (.DIODE(_0139_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0995__A (.DIODE(_0139_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0820__A (.DIODE(_0139_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0703__A (.DIODE(_0139_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0910__B (.DIODE(_0140_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0786__A (.DIODE(_0140_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0753__A (.DIODE(_0140_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0716__A (.DIODE(_0140_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0704__B (.DIODE(_0140_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0710__B (.DIODE(_0141_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0879__A (.DIODE(_0142_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0845__A (.DIODE(_0142_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0741__A (.DIODE(_0142_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0706__A (.DIODE(_0142_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0738__A (.DIODE(_0143_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0728__A (.DIODE(_0143_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0723__A (.DIODE(_0143_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0718__A (.DIODE(_0143_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0710__C (.DIODE(_0143_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0880__A (.DIODE(_0144_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0846__A (.DIODE(_0144_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0812__A (.DIODE(_0144_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0708__A (.DIODE(_0144_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1349__B (.DIODE(_0145_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0915__B (.DIODE(_0145_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0778__A (.DIODE(_0145_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0743__A (.DIODE(_0145_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0709__A (.DIODE(_0145_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0738__B (.DIODE(_0146_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0728__B (.DIODE(_0146_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0723__B (.DIODE(_0146_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0718__B (.DIODE(_0146_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0710__D (.DIODE(_0146_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0711__C (.DIODE(_0147_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0719__B (.DIODE(_0148_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1175__A (.DIODE(_0149_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1173__B2 (.DIODE(_0149_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1166__A1 (.DIODE(_0149_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1151__B (.DIODE(_0149_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0715__A (.DIODE(_0149_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0745__B (.DIODE(_0150_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0736__B (.DIODE(_0150_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0726__B (.DIODE(_0150_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0721__B (.DIODE(_0150_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0715__B (.DIODE(_0150_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0718__C (.DIODE(_0151_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0746__B (.DIODE(_0152_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0737__B (.DIODE(_0152_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0727__B (.DIODE(_0152_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0722__B (.DIODE(_0152_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0717__B (.DIODE(_0152_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0718__D (.DIODE(_0153_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0719__C (.DIODE(_0154_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0724__B (.DIODE(_0155_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0723__C (.DIODE(_0156_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0723__D (.DIODE(_0157_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0724__C (.DIODE(_0158_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0729__B (.DIODE(_0159_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0728__C (.DIODE(_0160_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0728__D (.DIODE(_0161_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0729__C (.DIODE(_0162_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0766__A (.DIODE(_0163_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0761__A (.DIODE(_0163_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0756__A (.DIODE(_0163_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0748__A (.DIODE(_0163_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0739__A (.DIODE(_0163_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1346__A1 (.DIODE(_0164_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1205__B (.DIODE(_0164_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0909__A1 (.DIODE(_0164_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0903__A1 (.DIODE(_0164_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0732__A (.DIODE(_0164_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0762__A1 (.DIODE(_0165_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0757__A1 (.DIODE(_0165_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0749__A1 (.DIODE(_0165_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0740__A1 (.DIODE(_0165_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0735__A1 (.DIODE(_0165_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1346__A2 (.DIODE(_0166_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1205__C (.DIODE(_0166_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0909__A2 (.DIODE(_0166_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0903__A2 (.DIODE(_0166_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0734__A (.DIODE(_0166_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0762__A2 (.DIODE(_0167_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0757__A2 (.DIODE(_0167_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0749__A2 (.DIODE(_0167_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0740__A2 (.DIODE(_0167_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0735__A2 (.DIODE(_0167_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0739__B (.DIODE(_0168_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0738__C (.DIODE(_0169_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0738__D (.DIODE(_0170_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0739__C (.DIODE(_0171_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0748__B (.DIODE(_0172_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1349__A (.DIODE(_0173_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0915__A (.DIODE(_0173_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0811__A (.DIODE(_0173_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0777__A (.DIODE(_0173_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0742__A (.DIODE(_0173_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0774__A (.DIODE(_0174_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0765__A (.DIODE(_0174_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0760__A (.DIODE(_0174_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0755__A (.DIODE(_0174_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0747__A (.DIODE(_0174_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0774__B (.DIODE(_0175_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0765__B (.DIODE(_0175_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0760__B (.DIODE(_0175_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0755__B (.DIODE(_0175_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0747__B (.DIODE(_0175_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1196__A1 (.DIODE(_0176_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1194__A1 (.DIODE(_0176_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1190__A1 (.DIODE(_0176_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1185__B (.DIODE(_0176_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0745__A (.DIODE(_0176_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0747__C (.DIODE(_0177_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0747__D (.DIODE(_0178_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0748__C (.DIODE(_0179_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0756__B (.DIODE(_0180_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1200__A1 (.DIODE(_0181_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1198__A (.DIODE(_0181_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1194__A2 (.DIODE(_0181_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1190__A2 (.DIODE(_0181_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0752__A (.DIODE(_0181_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0779__B (.DIODE(_0182_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0772__B (.DIODE(_0182_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0763__B (.DIODE(_0182_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0758__B (.DIODE(_0182_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0752__B (.DIODE(_0182_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0755__C (.DIODE(_0183_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0780__B (.DIODE(_0184_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0773__B (.DIODE(_0184_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0764__B (.DIODE(_0184_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0759__B (.DIODE(_0184_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0754__B (.DIODE(_0184_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0755__D (.DIODE(_0185_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0756__C (.DIODE(_0186_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0761__B (.DIODE(_0187_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0760__C (.DIODE(_0188_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0760__D (.DIODE(_0189_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0761__C (.DIODE(_0190_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0766__B (.DIODE(_0191_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0765__C (.DIODE(_0192_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0765__D (.DIODE(_0193_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0766__C (.DIODE(_0194_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0800__A (.DIODE(_0195_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0794__A (.DIODE(_0195_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0789__A (.DIODE(_0195_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0782__A (.DIODE(_0195_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0775__A (.DIODE(_0195_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0795__A1 (.DIODE(_0196_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0790__A1 (.DIODE(_0196_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0783__A1 (.DIODE(_0196_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0776__A1 (.DIODE(_0196_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0770__A1 (.DIODE(_0196_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0795__A2 (.DIODE(_0197_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0790__A2 (.DIODE(_0197_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0783__A2 (.DIODE(_0197_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0776__A2 (.DIODE(_0197_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0770__A2 (.DIODE(_0197_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0775__B (.DIODE(_0198_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1123__A (.DIODE(_0199_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1122__B2 (.DIODE(_0199_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1118__A1 (.DIODE(_0199_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1101__B (.DIODE(_0199_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0772__A (.DIODE(_0199_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0774__C (.DIODE(_0200_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0774__D (.DIODE(_0201_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0775__C (.DIODE(_0202_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0782__B (.DIODE(_0203_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0808__A (.DIODE(_0204_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0799__A (.DIODE(_0204_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0793__A (.DIODE(_0204_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0788__A (.DIODE(_0204_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0781__A (.DIODE(_0204_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0808__B (.DIODE(_0205_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0799__B (.DIODE(_0205_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0793__B (.DIODE(_0205_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0788__B (.DIODE(_0205_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0781__B (.DIODE(_0205_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0781__C (.DIODE(_0206_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0781__D (.DIODE(_0207_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0782__C (.DIODE(_0208_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0789__B (.DIODE(_0209_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0813__B (.DIODE(_0210_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0806__B (.DIODE(_0210_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0797__B (.DIODE(_0210_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0791__B (.DIODE(_0210_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0785__B (.DIODE(_0210_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0788__C (.DIODE(_0211_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0814__B (.DIODE(_0212_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0807__B (.DIODE(_0212_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0798__B (.DIODE(_0212_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0792__B (.DIODE(_0212_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0787__B (.DIODE(_0212_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0788__D (.DIODE(_0213_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0789__C (.DIODE(_0214_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0794__B (.DIODE(_0215_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0793__C (.DIODE(_0216_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0793__D (.DIODE(_0217_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0794__C (.DIODE(_0218_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0800__B (.DIODE(_0219_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1145__A1 (.DIODE(_0220_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1142__A1 (.DIODE(_0220_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1138__A1 (.DIODE(_0220_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1132__B (.DIODE(_0220_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0797__A (.DIODE(_0220_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0799__C (.DIODE(_0221_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0799__D (.DIODE(_0222_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0800__C (.DIODE(_0223_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0835__A (.DIODE(_0224_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0830__A (.DIODE(_0224_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0824__A (.DIODE(_0224_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0816__A (.DIODE(_0224_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0809__A (.DIODE(_0224_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0831__A1 (.DIODE(_0225_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0825__A1 (.DIODE(_0225_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0817__A1 (.DIODE(_0225_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0810__A1 (.DIODE(_0225_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0804__A1 (.DIODE(_0225_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0831__A2 (.DIODE(_0226_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0825__A2 (.DIODE(_0226_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0817__A2 (.DIODE(_0226_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0810__A2 (.DIODE(_0226_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0804__A2 (.DIODE(_0226_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0809__B (.DIODE(_0227_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1149__A1 (.DIODE(_0228_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1147__A (.DIODE(_0228_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1142__A2 (.DIODE(_0228_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1138__A2 (.DIODE(_0228_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0806__A (.DIODE(_0228_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0808__C (.DIODE(_0229_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0808__D (.DIODE(_0230_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0809__C (.DIODE(_0231_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0816__B (.DIODE(_0232_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0842__A (.DIODE(_0233_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0834__A (.DIODE(_0233_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0829__A (.DIODE(_0233_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0823__A (.DIODE(_0233_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0815__A (.DIODE(_0233_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0842__B (.DIODE(_0234_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0834__B (.DIODE(_0234_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0829__B (.DIODE(_0234_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0823__B (.DIODE(_0234_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0815__B (.DIODE(_0234_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0815__C (.DIODE(_0235_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0815__D (.DIODE(_0236_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0816__C (.DIODE(_0237_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0824__B (.DIODE(_0238_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0847__B (.DIODE(_0239_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0840__B (.DIODE(_0239_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0832__B (.DIODE(_0239_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0827__B (.DIODE(_0239_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0819__B (.DIODE(_0239_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0823__C (.DIODE(_0240_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1106__A4 (.DIODE(_0241_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0990__A4 (.DIODE(_0241_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0889__A (.DIODE(_0241_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0855__A (.DIODE(_0241_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0821__A (.DIODE(_0241_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0848__B (.DIODE(_0242_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0841__B (.DIODE(_0242_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0833__B (.DIODE(_0242_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0828__B (.DIODE(_0242_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0822__B (.DIODE(_0242_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0823__D (.DIODE(_0243_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0824__C (.DIODE(_0244_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0830__B (.DIODE(_0245_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1072__A (.DIODE(_0246_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1070__B2 (.DIODE(_0246_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1066__A1 (.DIODE(_0246_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1047__B (.DIODE(_0246_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0827__A (.DIODE(_0246_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0829__C (.DIODE(_0247_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0829__D (.DIODE(_0248_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0830__C (.DIODE(_0249_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0835__B (.DIODE(_0250_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0834__C (.DIODE(_0251_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0834__D (.DIODE(_0252_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0835__C (.DIODE(_0253_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0869__A (.DIODE(_0254_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0864__A (.DIODE(_0254_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0858__A (.DIODE(_0254_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0850__A (.DIODE(_0254_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0843__A (.DIODE(_0254_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0865__A1 (.DIODE(_0255_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0859__A1 (.DIODE(_0255_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0851__A1 (.DIODE(_0255_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0844__A1 (.DIODE(_0255_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0839__A1 (.DIODE(_0255_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0865__A2 (.DIODE(_0256_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0859__A2 (.DIODE(_0256_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0851__A2 (.DIODE(_0256_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0844__A2 (.DIODE(_0256_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0839__A2 (.DIODE(_0256_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0843__B (.DIODE(_0257_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0842__C (.DIODE(_0258_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0842__D (.DIODE(_0259_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0843__C (.DIODE(_0260_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0850__B (.DIODE(_0261_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0876__A (.DIODE(_0262_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0868__A (.DIODE(_0262_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0863__A (.DIODE(_0262_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0857__A (.DIODE(_0262_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0849__A (.DIODE(_0262_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0876__B (.DIODE(_0263_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0868__B (.DIODE(_0263_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0863__B (.DIODE(_0263_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0857__B (.DIODE(_0263_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0849__B (.DIODE(_0263_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0849__C (.DIODE(_0264_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0849__D (.DIODE(_0265_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0850__C (.DIODE(_0266_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0858__B (.DIODE(_0267_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1093__A1 (.DIODE(_0268_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1091__A1 (.DIODE(_0268_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1087__A1 (.DIODE(_0268_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1082__B (.DIODE(_0268_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0854__A (.DIODE(_0268_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0882__B (.DIODE(_0269_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0874__B (.DIODE(_0269_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0866__B (.DIODE(_0269_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0861__B (.DIODE(_0269_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0854__B (.DIODE(_0269_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0857__C (.DIODE(_0270_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0883__B (.DIODE(_0271_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0875__B (.DIODE(_0271_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0867__B (.DIODE(_0271_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0862__B (.DIODE(_0271_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0856__B (.DIODE(_0271_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0857__D (.DIODE(_0272_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0858__C (.DIODE(_0273_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0864__B (.DIODE(_0274_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1098__A1 (.DIODE(_0275_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1095__A (.DIODE(_0275_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1091__A2 (.DIODE(_0275_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1087__A2 (.DIODE(_0275_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0861__A (.DIODE(_0275_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0863__C (.DIODE(_0276_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0863__D (.DIODE(_0277_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0864__C (.DIODE(_0278_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0869__B (.DIODE(_0279_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0868__C (.DIODE(_0280_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0868__D (.DIODE(_0281_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0869__C (.DIODE(_0282_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0902__A (.DIODE(_0283_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0897__A (.DIODE(_0283_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0892__A (.DIODE(_0283_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0885__A (.DIODE(_0283_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0877__A (.DIODE(_0283_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0898__A1 (.DIODE(_0284_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0893__A1 (.DIODE(_0284_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0886__A1 (.DIODE(_0284_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0878__A1 (.DIODE(_0284_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0873__A1 (.DIODE(_0284_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0898__A2 (.DIODE(_0285_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0893__A2 (.DIODE(_0285_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0886__A2 (.DIODE(_0285_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0878__A2 (.DIODE(_0285_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0873__A2 (.DIODE(_0285_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0877__B (.DIODE(_0286_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0876__C (.DIODE(_0287_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0876__D (.DIODE(_0288_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0877__C (.DIODE(_0289_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0885__B (.DIODE(_0290_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0907__A (.DIODE(_0291_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0901__A (.DIODE(_0291_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0896__A (.DIODE(_0291_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0891__A (.DIODE(_0291_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0884__A (.DIODE(_0291_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0907__B (.DIODE(_0292_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0901__B (.DIODE(_0292_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0896__B (.DIODE(_0292_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0891__B (.DIODE(_0292_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0884__B (.DIODE(_0292_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1015__A (.DIODE(_0293_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1014__B2 (.DIODE(_0293_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1009__A1 (.DIODE(_0293_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0984__B (.DIODE(_0293_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0882__A (.DIODE(_0293_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0884__C (.DIODE(_0294_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0884__D (.DIODE(_0295_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0885__C (.DIODE(_0296_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0892__B (.DIODE(_0297_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1347__B (.DIODE(_0298_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0905__B (.DIODE(_0298_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0899__B (.DIODE(_0298_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0894__B (.DIODE(_0298_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0888__B (.DIODE(_0298_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0891__C (.DIODE(_0299_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1348__B (.DIODE(_0300_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0906__B (.DIODE(_0300_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0900__B (.DIODE(_0300_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0895__B (.DIODE(_0300_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0890__B (.DIODE(_0300_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0891__D (.DIODE(_0301_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0892__C (.DIODE(_0302_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0897__B (.DIODE(_0303_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0896__C (.DIODE(_0304_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0896__D (.DIODE(_0305_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0897__C (.DIODE(_0306_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0902__B (.DIODE(_0307_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0901__C (.DIODE(_0308_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0901__D (.DIODE(_0309_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0902__C (.DIODE(_0310_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0908__B (.DIODE(_0311_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1039__A1 (.DIODE(_0312_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1037__A1 (.DIODE(_0312_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1032__A1 (.DIODE(_0312_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1026__B (.DIODE(_0312_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0905__A (.DIODE(_0312_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0907__C (.DIODE(_0313_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0907__D (.DIODE(_0314_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0908__C (.DIODE(_0315_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0916__B (.DIODE(_0316_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0915__C (.DIODE(_0317_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0914__A2 (.DIODE(_0318_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1045__A1 (.DIODE(_0319_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1042__A (.DIODE(_0319_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1037__A2 (.DIODE(_0319_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1032__A2 (.DIODE(_0319_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0913__A (.DIODE(_0319_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0914__B1 (.DIODE(_0320_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0915__D (.DIODE(_0321_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0916__C (.DIODE(_0322_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1200__C1 (.DIODE(_0323_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1196__C1 (.DIODE(_0323_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1011__A (.DIODE(_0323_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0973__A (.DIODE(_0323_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0918__A (.DIODE(_0323_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1188__B1 (.DIODE(_0324_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1136__B1 (.DIODE(_0324_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1085__B1 (.DIODE(_0324_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1030__B1 (.DIODE(_0324_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0923__A (.DIODE(_0324_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0923__B (.DIODE(_0325_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1204__B (.DIODE(_0326_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1106__A1 (.DIODE(_0326_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0990__A2 (.DIODE(_0326_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0926__C (.DIODE(_0326_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0921__A (.DIODE(_0326_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0922__B (.DIODE(_0327_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1211__B (.DIODE(_0328_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0923__C (.DIODE(_0328_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0930__A1 (.DIODE(_0329_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1266__A (.DIODE(_0330_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1201__A2 (.DIODE(_0330_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0990__A1 (.DIODE(_0330_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0949__A (.DIODE(_0330_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0926__B (.DIODE(_0330_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0930__A2 (.DIODE(_0331_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0929__A2 (.DIODE(_0331_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1144__A (.DIODE(_0332_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1097__A (.DIODE(_0332_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1044__A (.DIODE(_0332_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1000__A (.DIODE(_0332_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0928__A (.DIODE(_0332_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1207__B1 (.DIODE(_0333_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0980__A (.DIODE(_0333_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0963__A (.DIODE(_0333_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0929__B1 (.DIODE(_0333_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0930__B1 (.DIODE(_0334_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0949__B (.DIODE(_0335_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0946__B (.DIODE(_0335_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0932__A (.DIODE(_0335_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1266__B (.DIODE(_0336_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0961__B (.DIODE(_0336_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0943__B (.DIODE(_0336_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0938__A (.DIODE(_0336_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0933__B (.DIODE(_0336_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1264__B (.DIODE(_0337_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1262__B (.DIODE(_0337_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1260__B (.DIODE(_0337_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1258__B (.DIODE(_0337_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0934__A (.DIODE(_0337_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1256__B (.DIODE(_0338_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1254__B (.DIODE(_0338_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1252__B (.DIODE(_0338_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1250__B (.DIODE(_0338_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0942__A2 (.DIODE(_0338_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1138__B1 (.DIODE(_0339_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1087__B1 (.DIODE(_0339_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1032__B1 (.DIODE(_0339_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1020__A (.DIODE(_0339_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0936__A (.DIODE(_0339_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1186__A2 (.DIODE(_0340_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1134__A2 (.DIODE(_0340_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1077__A (.DIODE(_0340_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1012__A (.DIODE(_0340_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0937__A (.DIODE(_0340_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1345__B (.DIODE(_0341_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1209__A (.DIODE(_0341_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0979__B (.DIODE(_0341_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0962__A1 (.DIODE(_0341_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0941__A1 (.DIODE(_0341_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1248__B (.DIODE(_0342_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1230__B (.DIODE(_0342_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1212__B (.DIODE(_0342_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1203__A (.DIODE(_0342_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0941__A2 (.DIODE(_0342_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1210__A2 (.DIODE(_0343_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0940__B (.DIODE(_0343_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0941__B1 (.DIODE(_0344_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0951__B1 (.DIODE(_0345_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0948__B1 (.DIODE(_0345_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0945__B1 (.DIODE(_0345_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0942__B1 (.DIODE(_0345_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1246__B (.DIODE(_0346_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1244__B (.DIODE(_0346_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1242__B (.DIODE(_0346_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1240__B (.DIODE(_0346_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0944__A (.DIODE(_0346_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1238__B (.DIODE(_0347_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1236__B (.DIODE(_0347_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1234__B (.DIODE(_0347_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1232__B (.DIODE(_0347_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0945__A2 (.DIODE(_0347_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1228__B (.DIODE(_0348_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1226__B (.DIODE(_0348_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1224__B (.DIODE(_0348_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1222__B (.DIODE(_0348_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0947__A (.DIODE(_0348_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1220__B (.DIODE(_0349_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1218__B (.DIODE(_0349_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1216__B (.DIODE(_0349_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1214__B (.DIODE(_0349_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0948__A2 (.DIODE(_0349_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1282__B (.DIODE(_0350_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1280__B (.DIODE(_0350_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1278__B (.DIODE(_0350_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1276__B (.DIODE(_0350_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0950__A (.DIODE(_0350_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1274__B (.DIODE(_0351_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1272__B (.DIODE(_0351_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1270__B (.DIODE(_0351_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1268__B (.DIODE(_0351_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0951__A2 (.DIODE(_0351_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1325__A (.DIODE(_0352_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1322__A (.DIODE(_0352_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1314__A (.DIODE(_0352_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1296__A (.DIODE(_0352_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0953__A (.DIODE(_0352_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1310__A (.DIODE(_0353_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1308__A (.DIODE(_0353_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0962__B2 (.DIODE(_0353_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0956__A (.DIODE(_0353_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0955__A (.DIODE(_0353_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0969__A2_N (.DIODE(_0354_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0956__B (.DIODE(_0354_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0955__B (.DIODE(_0354_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0962__A2 (.DIODE(_0355_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0957__A (.DIODE(_0356_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1207__A2 (.DIODE(_0357_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0962__A3 (.DIODE(_0357_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1190__B1 (.DIODE(_0358_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1005__A (.DIODE(_0358_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1002__A (.DIODE(_0358_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0981__A (.DIODE(_0358_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0959__A (.DIODE(_0358_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1169__B (.DIODE(_0359_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1166__B1 (.DIODE(_0359_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1118__B1 (.DIODE(_0359_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1049__B (.DIODE(_0359_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0960__A (.DIODE(_0359_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1172__B (.DIODE(_0360_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1127__A (.DIODE(_0360_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1019__A (.DIODE(_0360_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0998__B1 (.DIODE(_0360_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0961__A (.DIODE(_0360_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0976__B (.DIODE(_0361_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0969__B1 (.DIODE(_0361_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0962__B1 (.DIODE(_0361_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0963__B (.DIODE(_0362_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0994__A (.DIODE(_0363_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0965__A (.DIODE(_0363_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1185__D (.DIODE(_0364_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1156__B1 (.DIODE(_0364_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1052__B1 (.DIODE(_0364_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0988__A (.DIODE(_0364_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0966__A (.DIODE(_0364_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1206__A (.DIODE(_0365_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1109__A2 (.DIODE(_0365_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1106__A2 (.DIODE(_0365_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0990__A3 (.DIODE(_0365_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0967__A (.DIODE(_0365_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1189__A2 (.DIODE(_0366_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1137__A2 (.DIODE(_0366_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1086__A2 (.DIODE(_0366_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1031__A2 (.DIODE(_0366_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0969__A1_N (.DIODE(_0366_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1343__A1 (.DIODE(_0367_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1330__C1 (.DIODE(_0367_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1317__B2 (.DIODE(_0367_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1305__C1 (.DIODE(_0367_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0969__B2 (.DIODE(_0367_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0974__A (.DIODE(_0368_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1342__A (.DIODE(_0369_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1324__C1 (.DIODE(_0369_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1309__A (.DIODE(_0369_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1298__C1 (.DIODE(_0369_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0972__A (.DIODE(_0369_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1336__A1 (.DIODE(_0370_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1316__A1 (.DIODE(_0370_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0975__A (.DIODE(_0370_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0972__B (.DIODE(_0370_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1339__A (.DIODE(_0371_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1317__A1 (.DIODE(_0371_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0973__B (.DIODE(_0371_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0974__B (.DIODE(_0372_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1330__A1 (.DIODE(_0373_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1324__A1 (.DIODE(_0373_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1305__A1 (.DIODE(_0373_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1298__A1 (.DIODE(_0373_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0976__A (.DIODE(_0373_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0980__B (.DIODE(_0374_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1335__B1 (.DIODE(_0375_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1329__A (.DIODE(_0375_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1315__B1 (.DIODE(_0375_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1304__A (.DIODE(_0375_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0978__A (.DIODE(_0375_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1342__B (.DIODE(_0376_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1323__A (.DIODE(_0376_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1309__B (.DIODE(_0376_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1297__A (.DIODE(_0376_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0979__A (.DIODE(_0376_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0980__C (.DIODE(_0377_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1128__B (.DIODE(_0378_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1099__B (.DIODE(_0378_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1066__B1 (.DIODE(_0378_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1009__B1 (.DIODE(_0378_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0982__B (.DIODE(_0378_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0999__B (.DIODE(_0379_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0992__A1 (.DIODE(_0379_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1017__B (.DIODE(_0380_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1008__B (.DIODE(_0380_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0984__D (.DIODE(_0380_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0985__A (.DIODE(_0381_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1287__C (.DIODE(_0382_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1004__B (.DIODE(_0382_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0998__A2 (.DIODE(_0382_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0992__A2 (.DIODE(_0382_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0989__A1 (.DIODE(_0383_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0989__A2 (.DIODE(_0384_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1132__D (.DIODE(_0385_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1105__B1 (.DIODE(_0385_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1082__D (.DIODE(_0385_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1026__D (.DIODE(_0385_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0989__B1 (.DIODE(_0385_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0996__B1 (.DIODE(_0386_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0990__B1 (.DIODE(_0386_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1033__A1 (.DIODE(_0387_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1014__A1_N (.DIODE(_0387_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1010__A1 (.DIODE(_0387_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0991__A (.DIODE(_0387_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1045__A2 (.DIODE(_0388_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1039__A2 (.DIODE(_0388_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1029__A (.DIODE(_0388_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1015__B (.DIODE(_0388_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0992__B1 (.DIODE(_0388_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1001__A2 (.DIODE(_0389_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1160__A1 (.DIODE(_0390_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1157__A1 (.DIODE(_0390_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1109__A1 (.DIODE(_0390_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1053__A1 (.DIODE(_0390_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0996__A2 (.DIODE(_0390_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1160__A2 (.DIODE(_0391_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1157__A2 (.DIODE(_0391_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1056__A2 (.DIODE(_0391_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1053__A2 (.DIODE(_0391_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0996__A3 (.DIODE(_0391_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1160__A4 (.DIODE(_0392_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1157__A4 (.DIODE(_0392_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1109__A4 (.DIODE(_0392_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1053__A4 (.DIODE(_0392_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0996__A4 (.DIODE(_0392_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1043__A (.DIODE(_0393_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1038__A (.DIODE(_0393_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1007__A (.DIODE(_0393_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0997__A (.DIODE(_0393_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1034__A1 (.DIODE(_0394_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1024__A1 (.DIODE(_0394_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1022__A (.DIODE(_0394_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1018__A (.DIODE(_0394_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0999__A (.DIODE(_0394_));
 sky130_fd_sc_hd__diode_2 ANTENNA__0999__C (.DIODE(_0395_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1001__B1 (.DIODE(_0396_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1039__C1 (.DIODE(_0397_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1034__C1 (.DIODE(_0397_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1023__C1 (.DIODE(_0397_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1016__C1 (.DIODE(_0397_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1001__C1 (.DIODE(_0397_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1178__B (.DIODE(_0398_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1115__B (.DIODE(_0398_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1035__A (.DIODE(_0398_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1025__A (.DIODE(_0398_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1003__A (.DIODE(_0398_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1198__B (.DIODE(_0399_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1168__A (.DIODE(_0399_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1147__B (.DIODE(_0399_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1062__A (.DIODE(_0399_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1004__A (.DIODE(_0399_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1007__B (.DIODE(_0400_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1153__B (.DIODE(_0401_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1075__B (.DIODE(_0401_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1063__B (.DIODE(_0401_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1041__A (.DIODE(_0401_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1006__B (.DIODE(_0401_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1007__C (.DIODE(_0402_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1011__B (.DIODE(_0403_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1019__B (.DIODE(_0404_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1014__B1 (.DIODE(_0404_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1009__A2 (.DIODE(_0404_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1014__A2_N (.DIODE(_0405_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1010__A2 (.DIODE(_0405_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1011__C (.DIODE(_0406_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1125__A (.DIODE(_0407_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1121__B (.DIODE(_0407_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1069__B (.DIODE(_0407_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1017__A (.DIODE(_0407_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1013__B (.DIODE(_0407_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1016__A1 (.DIODE(_0408_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1016__A2 (.DIODE(_0409_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1016__B1 (.DIODE(_0410_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1024__A2 (.DIODE(_0411_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1018__B (.DIODE(_0411_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1023__A2 (.DIODE(_0412_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1022__B (.DIODE(_0413_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1197__B (.DIODE(_0414_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1193__B (.DIODE(_0414_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1146__B (.DIODE(_0414_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1141__B (.DIODE(_0414_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1021__B (.DIODE(_0414_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1022__C (.DIODE(_0415_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1023__B1 (.DIODE(_0416_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1030__A1 (.DIODE(_0417_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1177__A (.DIODE(_0418_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1114__A (.DIODE(_0418_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1083__A2 (.DIODE(_0418_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1074__A (.DIODE(_0418_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1028__A2 (.DIODE(_0418_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1031__B1_N (.DIODE(_0419_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1028__B1 (.DIODE(_0419_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1028__B2 (.DIODE(_0420_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1029__B (.DIODE(_0421_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1030__A2 (.DIODE(_0422_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1034__A2 (.DIODE(_0423_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1037__B1_N (.DIODE(_0424_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1033__A2 (.DIODE(_0424_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1034__B1 (.DIODE(_0425_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1180__A (.DIODE(_0426_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1094__B (.DIODE(_0426_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1090__B (.DIODE(_0426_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1040__B (.DIODE(_0426_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1036__B (.DIODE(_0426_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1038__B (.DIODE(_0427_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1038__C (.DIODE(_0428_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1039__B1 (.DIODE(_0429_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1043__B (.DIODE(_0430_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1162__B1 (.DIODE(_0431_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1111__B1 (.DIODE(_0431_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1095__B (.DIODE(_0431_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1058__B1 (.DIODE(_0431_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1042__B (.DIODE(_0431_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1043__C (.DIODE(_0432_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1045__B1 (.DIODE(_0433_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1093__C1 (.DIODE(_0434_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1089__C1 (.DIODE(_0434_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1073__C1 (.DIODE(_0434_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1060__C1 (.DIODE(_0434_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1045__C1 (.DIODE(_0434_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1077__B (.DIODE(_0435_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1065__B (.DIODE(_0435_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1047__D (.DIODE(_0435_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1048__A (.DIODE(_0436_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1286__C (.DIODE(_0437_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1062__B (.DIODE(_0437_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1058__A2 (.DIODE(_0437_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1055__A1 (.DIODE(_0437_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1059__B (.DIODE(_0438_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1055__A2 (.DIODE(_0438_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1052__A1 (.DIODE(_0439_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1052__A2 (.DIODE(_0440_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1056__B1 (.DIODE(_0441_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1053__B1 (.DIODE(_0441_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1071__A (.DIODE(_0442_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1054__A (.DIODE(_0442_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1088__A1 (.DIODE(_0443_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1078__A1 (.DIODE(_0443_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1070__A1_N (.DIODE(_0443_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1067__A1 (.DIODE(_0443_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1055__B1 (.DIODE(_0443_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1060__A2 (.DIODE(_0444_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1076__A (.DIODE(_0445_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1057__A (.DIODE(_0445_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1096__A (.DIODE(_0446_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1092__A (.DIODE(_0446_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1089__A1 (.DIODE(_0446_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1064__A (.DIODE(_0446_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1059__A (.DIODE(_0446_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1059__C (.DIODE(_0447_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1060__B1 (.DIODE(_0448_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1182__A (.DIODE(_0449_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1171__A (.DIODE(_0449_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1120__A (.DIODE(_0449_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1079__A (.DIODE(_0449_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1068__A (.DIODE(_0449_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1064__B (.DIODE(_0450_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1064__C (.DIODE(_0451_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1068__B (.DIODE(_0452_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1074__B (.DIODE(_0453_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1070__B1 (.DIODE(_0453_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1066__A2 (.DIODE(_0453_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1070__A2_N (.DIODE(_0454_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1067__A2 (.DIODE(_0454_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1068__C (.DIODE(_0455_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1073__A1 (.DIODE(_0456_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1073__A2 (.DIODE(_0457_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1098__A2 (.DIODE(_0458_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1093__A2 (.DIODE(_0458_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1084__A (.DIODE(_0458_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1081__A1 (.DIODE(_0458_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1072__B (.DIODE(_0458_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1073__B1 (.DIODE(_0459_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1076__B (.DIODE(_0460_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1076__C (.DIODE(_0461_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1079__B (.DIODE(_0462_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1081__A2 (.DIODE(_0463_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1078__A2 (.DIODE(_0463_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1079__C (.DIODE(_0464_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1083__B2 (.DIODE(_0465_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1081__B1 (.DIODE(_0465_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1085__A1 (.DIODE(_0466_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1086__B1_N (.DIODE(_0467_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1083__B1 (.DIODE(_0467_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1084__B (.DIODE(_0468_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1085__A2 (.DIODE(_0469_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1089__A2 (.DIODE(_0470_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1091__B1_N (.DIODE(_0471_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1088__A2 (.DIODE(_0471_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1089__B1 (.DIODE(_0472_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1092__B (.DIODE(_0473_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1092__C (.DIODE(_0474_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1093__B1 (.DIODE(_0475_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1096__B (.DIODE(_0476_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1096__C (.DIODE(_0477_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1098__B1 (.DIODE(_0478_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1140__C1 (.DIODE(_0479_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1130__C1 (.DIODE(_0479_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1124__C1 (.DIODE(_0479_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1113__C1 (.DIODE(_0479_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1098__C1 (.DIODE(_0479_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1112__B (.DIODE(_0480_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1108__A1 (.DIODE(_0480_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1125__B (.DIODE(_0481_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1117__B (.DIODE(_0481_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1101__D (.DIODE(_0481_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1102__A (.DIODE(_0482_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1285__C (.DIODE(_0483_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1114__B (.DIODE(_0483_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1111__A2 (.DIODE(_0483_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1108__A2 (.DIODE(_0483_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1105__A1 (.DIODE(_0484_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1105__A2 (.DIODE(_0485_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1109__B1 (.DIODE(_0486_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1106__B1 (.DIODE(_0486_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1139__A1 (.DIODE(_0487_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1122__A1_N (.DIODE(_0487_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1119__A1 (.DIODE(_0487_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1107__A (.DIODE(_0487_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1149__A2 (.DIODE(_0488_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1145__A2 (.DIODE(_0488_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1135__A (.DIODE(_0488_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1123__B (.DIODE(_0488_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1108__B1 (.DIODE(_0488_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1113__A2 (.DIODE(_0489_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1148__A (.DIODE(_0490_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1143__A (.DIODE(_0490_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1116__A (.DIODE(_0490_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1110__A (.DIODE(_0490_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1140__A1 (.DIODE(_0491_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1131__A1 (.DIODE(_0491_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1129__A (.DIODE(_0491_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1126__A (.DIODE(_0491_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1112__A (.DIODE(_0491_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1112__C (.DIODE(_0492_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1113__B1 (.DIODE(_0493_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1116__B (.DIODE(_0494_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1116__C (.DIODE(_0495_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1120__B (.DIODE(_0496_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1127__B (.DIODE(_0497_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1122__B1 (.DIODE(_0497_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1118__A2 (.DIODE(_0497_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1122__A2_N (.DIODE(_0498_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1119__A2 (.DIODE(_0498_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1120__C (.DIODE(_0499_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1124__A1 (.DIODE(_0500_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1124__A2 (.DIODE(_0501_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1124__B1 (.DIODE(_0502_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1131__A2 (.DIODE(_0503_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1126__B (.DIODE(_0503_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1130__A2 (.DIODE(_0504_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1129__B (.DIODE(_0505_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1129__C (.DIODE(_0506_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1130__B1 (.DIODE(_0507_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1136__A1 (.DIODE(_0508_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1137__B1_N (.DIODE(_0509_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1134__B1 (.DIODE(_0509_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1134__B2 (.DIODE(_0510_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1135__B (.DIODE(_0511_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1136__A2 (.DIODE(_0512_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1140__A2 (.DIODE(_0513_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1142__B1_N (.DIODE(_0514_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1139__A2 (.DIODE(_0514_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1140__B1 (.DIODE(_0515_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1143__B (.DIODE(_0516_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1143__C (.DIODE(_0517_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1145__B1 (.DIODE(_0518_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1192__C1 (.DIODE(_0519_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1176__C1 (.DIODE(_0519_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1164__C1 (.DIODE(_0519_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1149__C1 (.DIODE(_0519_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1145__C1 (.DIODE(_0519_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1148__B (.DIODE(_0520_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1148__C (.DIODE(_0521_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1149__B1 (.DIODE(_0522_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1180__B (.DIODE(_0523_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1165__B (.DIODE(_0523_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1151__D (.DIODE(_0523_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1152__A (.DIODE(_0524_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1284__C (.DIODE(_0525_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1168__B (.DIODE(_0525_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1162__A2 (.DIODE(_0525_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1159__A1 (.DIODE(_0525_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1163__B (.DIODE(_0526_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1159__A2 (.DIODE(_0526_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1156__A1 (.DIODE(_0527_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1156__A2 (.DIODE(_0528_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1160__B1 (.DIODE(_0529_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1157__B1 (.DIODE(_0529_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1174__A (.DIODE(_0530_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1158__A (.DIODE(_0530_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1191__A1 (.DIODE(_0531_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1181__A1 (.DIODE(_0531_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1173__A1_N (.DIODE(_0531_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1167__A1 (.DIODE(_0531_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1159__B1 (.DIODE(_0531_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1164__A2 (.DIODE(_0532_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1179__A (.DIODE(_0533_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1161__A (.DIODE(_0533_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1199__A (.DIODE(_0534_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1195__A (.DIODE(_0534_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1192__A1 (.DIODE(_0534_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1170__A (.DIODE(_0534_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1163__A (.DIODE(_0534_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1163__C (.DIODE(_0535_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1164__B1 (.DIODE(_0536_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1177__B (.DIODE(_0537_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1173__B1 (.DIODE(_0537_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1166__A2 (.DIODE(_0537_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1173__A2_N (.DIODE(_0538_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1167__A2 (.DIODE(_0538_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1171__B (.DIODE(_0539_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1170__B (.DIODE(_0540_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1170__C (.DIODE(_0541_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1171__C (.DIODE(_0542_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1176__A1 (.DIODE(_0543_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1176__A2 (.DIODE(_0544_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1200__A2 (.DIODE(_0545_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1196__A2 (.DIODE(_0545_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1187__A (.DIODE(_0545_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1184__A1 (.DIODE(_0545_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1175__B (.DIODE(_0545_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1176__B1 (.DIODE(_0546_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1179__B (.DIODE(_0547_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1179__C (.DIODE(_0548_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1182__B (.DIODE(_0549_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1184__A2 (.DIODE(_0550_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1181__A2 (.DIODE(_0550_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1182__C (.DIODE(_0551_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1186__B2 (.DIODE(_0552_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1184__B1 (.DIODE(_0552_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1188__A1 (.DIODE(_0553_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1189__B1_N (.DIODE(_0554_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1186__B1 (.DIODE(_0554_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1187__B (.DIODE(_0555_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1188__A2 (.DIODE(_0556_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1192__A2 (.DIODE(_0557_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1194__B1_N (.DIODE(_0558_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1191__A2 (.DIODE(_0558_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1192__B1 (.DIODE(_0559_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1195__B (.DIODE(_0560_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1195__C (.DIODE(_0561_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1196__B1 (.DIODE(_0562_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1199__B (.DIODE(_0563_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1199__C (.DIODE(_0564_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1200__B1 (.DIODE(_0565_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1203__B (.DIODE(_0566_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1203__C (.DIODE(_0567_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1208__A1 (.DIODE(_0568_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1205__D (.DIODE(_0569_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1208__A2 (.DIODE(_0570_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1287__B (.DIODE(_0571_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1286__B (.DIODE(_0571_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1285__B (.DIODE(_0571_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1284__B (.DIODE(_0571_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1207__A1 (.DIODE(_0571_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1210__B1 (.DIODE(_0572_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1208__B1 (.DIODE(_0572_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1344__A (.DIODE(_0573_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1331__A (.DIODE(_0573_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1318__B1 (.DIODE(_0573_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1306__A (.DIODE(_0573_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1210__A1 (.DIODE(_0573_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1229__A2 (.DIODE(_0574_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1227__A2 (.DIODE(_0574_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1225__A2 (.DIODE(_0574_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1213__A (.DIODE(_0574_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1223__A2 (.DIODE(_0575_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1221__A2 (.DIODE(_0575_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1219__A2 (.DIODE(_0575_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1217__A2 (.DIODE(_0575_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1215__A2 (.DIODE(_0575_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1215__B1 (.DIODE(_0576_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1217__B1 (.DIODE(_0577_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1219__B1 (.DIODE(_0578_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1221__B1 (.DIODE(_0579_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1223__B1 (.DIODE(_0580_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1225__B1 (.DIODE(_0581_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1227__B1 (.DIODE(_0582_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1229__B1 (.DIODE(_0583_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1247__A2 (.DIODE(_0584_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1245__A2 (.DIODE(_0584_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1243__A2 (.DIODE(_0584_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1231__A (.DIODE(_0584_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1241__A2 (.DIODE(_0585_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1239__A2 (.DIODE(_0585_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1237__A2 (.DIODE(_0585_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1235__A2 (.DIODE(_0585_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1233__A2 (.DIODE(_0585_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1233__B1 (.DIODE(_0586_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1235__B1 (.DIODE(_0587_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1237__B1 (.DIODE(_0588_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1239__B1 (.DIODE(_0589_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1241__B1 (.DIODE(_0590_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1243__B1 (.DIODE(_0591_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1245__B1 (.DIODE(_0592_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1247__B1 (.DIODE(_0593_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1265__A2 (.DIODE(_0594_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1263__A2 (.DIODE(_0594_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1261__A2 (.DIODE(_0594_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1249__A (.DIODE(_0594_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1259__A2 (.DIODE(_0595_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1257__A2 (.DIODE(_0595_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1255__A2 (.DIODE(_0595_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1253__A2 (.DIODE(_0595_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1251__A2 (.DIODE(_0595_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1251__B1 (.DIODE(_0596_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1253__B1 (.DIODE(_0597_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1255__B1 (.DIODE(_0598_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1257__B1 (.DIODE(_0599_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1259__B1 (.DIODE(_0600_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1261__B1 (.DIODE(_0601_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1263__B1 (.DIODE(_0602_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1265__B1 (.DIODE(_0603_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1283__A2 (.DIODE(_0604_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1281__A2 (.DIODE(_0604_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1279__A2 (.DIODE(_0604_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1267__A (.DIODE(_0604_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1277__A2 (.DIODE(_0605_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1275__A2 (.DIODE(_0605_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1273__A2 (.DIODE(_0605_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1271__A2 (.DIODE(_0605_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1269__A2 (.DIODE(_0605_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1269__B1 (.DIODE(_0606_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1271__B1 (.DIODE(_0607_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1273__B1 (.DIODE(_0608_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1275__B1 (.DIODE(_0609_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1277__B1 (.DIODE(_0610_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1279__B1 (.DIODE(_0611_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1281__B1 (.DIODE(_0612_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1283__B1 (.DIODE(_0613_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1333__A (.DIODE(_0614_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1313__A (.DIODE(_0614_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1294__A (.DIODE(_0614_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1289__A (.DIODE(_0614_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1340__A (.DIODE(_0615_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1338__A (.DIODE(_0615_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1315__A1 (.DIODE(_0615_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1311__A (.DIODE(_0615_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1290__A (.DIODE(_0615_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1326__A1 (.DIODE(_0616_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1320__A1 (.DIODE(_0616_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1307__A (.DIODE(_0616_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1300__A1 (.DIODE(_0616_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1293__A1 (.DIODE(_0616_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1341__A (.DIODE(_0617_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1337__A (.DIODE(_0617_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1319__A (.DIODE(_0617_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1299__A (.DIODE(_0617_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1292__A (.DIODE(_0617_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1293__B1 (.DIODE(_0618_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1298__A2 (.DIODE(_0619_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1335__A1 (.DIODE(_0620_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1327__A (.DIODE(_0620_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1321__A (.DIODE(_0620_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1301__A (.DIODE(_0620_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1295__A (.DIODE(_0620_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1297__B (.DIODE(_0621_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1297__C (.DIODE(_0622_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1298__B1 (.DIODE(_0623_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1306__B (.DIODE(_0624_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1300__B1 (.DIODE(_0625_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1305__A2 (.DIODE(_0626_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1304__B (.DIODE(_0627_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1334__A (.DIODE(_0628_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1332__A (.DIODE(_0628_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1328__A (.DIODE(_0628_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1312__A (.DIODE(_0628_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1303__A (.DIODE(_0628_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1304__C (.DIODE(_0629_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1305__B1 (.DIODE(_0630_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1306__C (.DIODE(_0631_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1309__C (.DIODE(_0632_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1309__D (.DIODE(_0633_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1318__A1 (.DIODE(_0634_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1317__A2 (.DIODE(_0635_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1317__A3 (.DIODE(_0636_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1316__A2 (.DIODE(_0637_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1316__A3 (.DIODE(_0638_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1316__B1 (.DIODE(_0639_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1316__B2 (.DIODE(_0640_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1317__B1 (.DIODE(_0641_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1318__A2 (.DIODE(_0642_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1320__B1 (.DIODE(_0643_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1324__A2 (.DIODE(_0644_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1323__B (.DIODE(_0645_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1323__C (.DIODE(_0646_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1324__B1 (.DIODE(_0647_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1331__B (.DIODE(_0648_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1326__B1 (.DIODE(_0649_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1330__A2 (.DIODE(_0650_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1329__B (.DIODE(_0651_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1329__C (.DIODE(_0652_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1330__B1 (.DIODE(_0653_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1331__C (.DIODE(_0654_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1336__A2 (.DIODE(_0655_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1336__A3 (.DIODE(_0656_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1336__B1 (.DIODE(_0657_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1336__B2 (.DIODE(_0658_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1343__A2 (.DIODE(_0659_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1339__B (.DIODE(_0660_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1339__C (.DIODE(_0661_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1343__B1 (.DIODE(_0662_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1342__C (.DIODE(_0663_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1342__D (.DIODE(_0664_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1343__C1 (.DIODE(_0665_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1344__B (.DIODE(_0666_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1350__B (.DIODE(_0667_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1349__C (.DIODE(_0668_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1349__D (.DIODE(_0669_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1350__C (.DIODE(_0670_));
 sky130_fd_sc_hd__diode_2 ANTENNA__1337__B (.DIODE(\configy.bits_a[0] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1283__A1 (.DIODE(\configy.bits_a[0] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__0910__A (.DIODE(\configy.bits_a[0] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1341__B (.DIODE(\configy.bits_a[1] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1281__A1 (.DIODE(\configy.bits_a[1] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__0906__A (.DIODE(\configy.bits_a[1] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1332__B (.DIODE(\configy.bits_a[2] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1279__A1 (.DIODE(\configy.bits_a[2] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__0900__A (.DIODE(\configy.bits_a[2] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1334__B (.DIODE(\configy.bits_a[3] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1277__A1 (.DIODE(\configy.bits_a[3] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__0895__A (.DIODE(\configy.bits_a[3] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1338__B (.DIODE(\configy.bits_a[4] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1275__A1 (.DIODE(\configy.bits_a[4] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__0890__A (.DIODE(\configy.bits_a[4] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1340__B (.DIODE(\configy.bits_a[5] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1273__A1 (.DIODE(\configy.bits_a[5] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__0883__A (.DIODE(\configy.bits_a[5] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1333__B (.DIODE(\configy.bits_a[6] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1271__A1 (.DIODE(\configy.bits_a[6] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__0875__A (.DIODE(\configy.bits_a[6] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1335__A2 (.DIODE(\configy.bits_a[7] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1269__A1 (.DIODE(\configy.bits_a[7] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__0867__A (.DIODE(\configy.bits_a[7] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1325__B (.DIODE(\configy.bits_b[0] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1229__A1 (.DIODE(\configy.bits_b[0] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__0862__A (.DIODE(\configy.bits_b[0] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1328__B (.DIODE(\configy.bits_b[1] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1227__A1 (.DIODE(\configy.bits_b[1] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__0856__A (.DIODE(\configy.bits_b[1] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1319__B (.DIODE(\configy.bits_b[2] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1225__A1 (.DIODE(\configy.bits_b[2] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__0848__A (.DIODE(\configy.bits_b[2] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1322__B (.DIODE(\configy.bits_b[3] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1223__A1 (.DIODE(\configy.bits_b[3] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__0841__A (.DIODE(\configy.bits_b[3] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1326__A2 (.DIODE(\configy.bits_b[4] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1221__A1 (.DIODE(\configy.bits_b[4] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__0833__A (.DIODE(\configy.bits_b[4] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1327__B (.DIODE(\configy.bits_b[5] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1219__A1 (.DIODE(\configy.bits_b[5] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__0828__A (.DIODE(\configy.bits_b[5] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1320__A2 (.DIODE(\configy.bits_b[6] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1217__A1 (.DIODE(\configy.bits_b[6] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__0822__A (.DIODE(\configy.bits_b[6] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1321__B (.DIODE(\configy.bits_b[7] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1215__A1 (.DIODE(\configy.bits_b[7] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__0814__A (.DIODE(\configy.bits_b[7] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1310__B (.DIODE(\configy.bits_c[0] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1247__A1 (.DIODE(\configy.bits_c[0] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__0807__A (.DIODE(\configy.bits_c[0] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1308__B (.DIODE(\configy.bits_c[1] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1245__A1 (.DIODE(\configy.bits_c[1] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__0798__A (.DIODE(\configy.bits_c[1] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1312__B (.DIODE(\configy.bits_c[2] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1243__A1 (.DIODE(\configy.bits_c[2] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__0792__A (.DIODE(\configy.bits_c[2] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1314__B (.DIODE(\configy.bits_c[3] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1241__A1 (.DIODE(\configy.bits_c[3] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__0787__A (.DIODE(\configy.bits_c[3] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1311__B (.DIODE(\configy.bits_c[4] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1239__A1 (.DIODE(\configy.bits_c[4] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__0780__A (.DIODE(\configy.bits_c[4] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1307__B (.DIODE(\configy.bits_c[5] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1237__A1 (.DIODE(\configy.bits_c[5] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__0773__A (.DIODE(\configy.bits_c[5] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1313__B (.DIODE(\configy.bits_c[6] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1235__A1 (.DIODE(\configy.bits_c[6] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__0764__A (.DIODE(\configy.bits_c[6] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1315__A2 (.DIODE(\configy.bits_c[7] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1233__A1 (.DIODE(\configy.bits_c[7] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__0759__A (.DIODE(\configy.bits_c[7] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1299__B (.DIODE(\configy.bits_d[0] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1265__A1 (.DIODE(\configy.bits_d[0] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__0754__A (.DIODE(\configy.bits_d[0] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1303__B (.DIODE(\configy.bits_d[1] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1263__A1 (.DIODE(\configy.bits_d[1] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__0746__A (.DIODE(\configy.bits_d[1] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1292__B (.DIODE(\configy.bits_d[2] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1261__A1 (.DIODE(\configy.bits_d[2] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__0737__A (.DIODE(\configy.bits_d[2] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1296__B (.DIODE(\configy.bits_d[3] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1259__A1 (.DIODE(\configy.bits_d[3] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__0727__A (.DIODE(\configy.bits_d[3] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1300__A2 (.DIODE(\configy.bits_d[4] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1257__A1 (.DIODE(\configy.bits_d[4] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__0722__A (.DIODE(\configy.bits_d[4] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1301__B (.DIODE(\configy.bits_d[5] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1255__A1 (.DIODE(\configy.bits_d[5] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__0717__A (.DIODE(\configy.bits_d[5] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1293__A2 (.DIODE(\configy.bits_d[6] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1253__A1 (.DIODE(\configy.bits_d[6] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__0704__A (.DIODE(\configy.bits_d[6] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1348__A (.DIODE(\configy.bits_d[7] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1295__B (.DIODE(\configy.bits_d[7] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1251__A1 (.DIODE(\configy.bits_d[7] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__0977__A (.DIODE(\configy.bits_index[0] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__0971__A (.DIODE(\configy.bits_index[0] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__0954__B (.DIODE(\configy.bits_index[0] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__0970__A (.DIODE(\configy.bits_index[1] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__0968__A (.DIODE(\configy.bits_index[1] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__0954__A (.DIODE(\configy.bits_index[1] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1302__A (.DIODE(\configy.bits_index[2] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1291__A (.DIODE(\configy.bits_index[2] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1288__A (.DIODE(\configy.bits_index[2] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__0952__A (.DIODE(\configy.bits_index[2] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1201__A1 (.DIODE(\configy.charged[0] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__0951__A1 (.DIODE(\configy.charged[0] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__0939__D (.DIODE(\configy.charged[0] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1202__B2 (.DIODE(\configy.charged[1] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__0948__A1 (.DIODE(\configy.charged[1] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__0939__C (.DIODE(\configy.charged[1] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1201__B2 (.DIODE(\configy.charged[2] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__0945__A1 (.DIODE(\configy.charged[2] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__0939__B (.DIODE(\configy.charged[2] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1202__A1 (.DIODE(\configy.charged[3] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__0942__A1 (.DIODE(\configy.charged[3] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__0939__A (.DIODE(\configy.charged[3] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1026__C (.DIODE(\configy.counter_a[0] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__0987__D (.DIODE(\configy.counter_a[0] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__0983__D (.DIODE(\configy.counter_a[0] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__0912__A (.DIODE(\configy.counter_a[0] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__0987__C (.DIODE(\configy.counter_a[1] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__0983__C (.DIODE(\configy.counter_a[1] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__0904__A (.DIODE(\configy.counter_a[1] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1033__B1 (.DIODE(\configy.counter_a[2] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1026__A (.DIODE(\configy.counter_a[2] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__0986__D (.DIODE(\configy.counter_a[2] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__0983__B (.DIODE(\configy.counter_a[2] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__0899__A (.DIODE(\configy.counter_a[2] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1027__A (.DIODE(\configy.counter_a[3] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1024__B1 (.DIODE(\configy.counter_a[3] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__0986__C (.DIODE(\configy.counter_a[3] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__0983__A (.DIODE(\configy.counter_a[3] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__0894__A (.DIODE(\configy.counter_a[3] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1023__A1 (.DIODE(\configy.counter_a[4] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1008__A (.DIODE(\configy.counter_a[4] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__0986__B (.DIODE(\configy.counter_a[4] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__0984__C (.DIODE(\configy.counter_a[4] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__0888__A (.DIODE(\configy.counter_a[4] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__0986__A (.DIODE(\configy.counter_a[5] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__0881__A (.DIODE(\configy.counter_a[5] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1010__B1 (.DIODE(\configy.counter_a[6] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__0987__B (.DIODE(\configy.counter_a[6] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__0984__A (.DIODE(\configy.counter_a[6] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__0874__A (.DIODE(\configy.counter_a[6] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1287__A (.DIODE(\configy.counter_a[7] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1001__A1 (.DIODE(\configy.counter_a[7] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__0998__A1 (.DIODE(\configy.counter_a[7] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__0987__A (.DIODE(\configy.counter_a[7] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__0866__A (.DIODE(\configy.counter_a[7] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1082__C (.DIODE(\configy.counter_b[0] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1051__D (.DIODE(\configy.counter_b[0] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1046__D (.DIODE(\configy.counter_b[0] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__0860__A (.DIODE(\configy.counter_b[0] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1051__C (.DIODE(\configy.counter_b[1] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1046__C (.DIODE(\configy.counter_b[1] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__0852__A (.DIODE(\configy.counter_b[1] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1088__B1 (.DIODE(\configy.counter_b[2] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1082__A (.DIODE(\configy.counter_b[2] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1050__D (.DIODE(\configy.counter_b[2] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1046__B (.DIODE(\configy.counter_b[2] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__0847__A (.DIODE(\configy.counter_b[2] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1080__A (.DIODE(\configy.counter_b[3] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1050__C (.DIODE(\configy.counter_b[3] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1046__A (.DIODE(\configy.counter_b[3] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__0840__A (.DIODE(\configy.counter_b[3] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1078__B1 (.DIODE(\configy.counter_b[4] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1065__A (.DIODE(\configy.counter_b[4] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1050__B (.DIODE(\configy.counter_b[4] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1047__C (.DIODE(\configy.counter_b[4] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__0832__A (.DIODE(\configy.counter_b[4] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1050__A (.DIODE(\configy.counter_b[5] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__0826__A (.DIODE(\configy.counter_b[5] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1067__B1 (.DIODE(\configy.counter_b[6] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1051__B (.DIODE(\configy.counter_b[6] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1047__A (.DIODE(\configy.counter_b[6] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__0819__A (.DIODE(\configy.counter_b[6] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1286__A (.DIODE(\configy.counter_b[7] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1060__A1 (.DIODE(\configy.counter_b[7] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1058__A1 (.DIODE(\configy.counter_b[7] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1051__A (.DIODE(\configy.counter_b[7] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__0813__A (.DIODE(\configy.counter_b[7] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1132__C (.DIODE(\configy.counter_c[0] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1104__D (.DIODE(\configy.counter_c[0] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1100__D (.DIODE(\configy.counter_c[0] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__0805__A (.DIODE(\configy.counter_c[0] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1104__C (.DIODE(\configy.counter_c[1] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1100__C (.DIODE(\configy.counter_c[1] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__0796__A (.DIODE(\configy.counter_c[1] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1139__B1 (.DIODE(\configy.counter_c[2] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1132__A (.DIODE(\configy.counter_c[2] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1103__D (.DIODE(\configy.counter_c[2] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1100__B (.DIODE(\configy.counter_c[2] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__0791__A (.DIODE(\configy.counter_c[2] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1133__A (.DIODE(\configy.counter_c[3] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1131__B1 (.DIODE(\configy.counter_c[3] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1103__C (.DIODE(\configy.counter_c[3] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1100__A (.DIODE(\configy.counter_c[3] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__0785__A (.DIODE(\configy.counter_c[3] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1130__A1 (.DIODE(\configy.counter_c[4] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1117__A (.DIODE(\configy.counter_c[4] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1103__B (.DIODE(\configy.counter_c[4] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1101__C (.DIODE(\configy.counter_c[4] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__0779__A (.DIODE(\configy.counter_c[4] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1103__A (.DIODE(\configy.counter_c[5] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__0771__A (.DIODE(\configy.counter_c[5] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1119__B1 (.DIODE(\configy.counter_c[6] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1104__B (.DIODE(\configy.counter_c[6] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1101__A (.DIODE(\configy.counter_c[6] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__0763__A (.DIODE(\configy.counter_c[6] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1285__A (.DIODE(\configy.counter_c[7] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1113__A1 (.DIODE(\configy.counter_c[7] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1111__A1 (.DIODE(\configy.counter_c[7] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1104__A (.DIODE(\configy.counter_c[7] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__0758__A (.DIODE(\configy.counter_c[7] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1185__C (.DIODE(\configy.counter_d[0] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1155__D (.DIODE(\configy.counter_d[0] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1150__D (.DIODE(\configy.counter_d[0] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__0750__A (.DIODE(\configy.counter_d[0] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1155__C (.DIODE(\configy.counter_d[1] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1150__C (.DIODE(\configy.counter_d[1] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__0744__A (.DIODE(\configy.counter_d[1] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1191__B1 (.DIODE(\configy.counter_d[2] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1185__A (.DIODE(\configy.counter_d[2] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1154__D (.DIODE(\configy.counter_d[2] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1150__B (.DIODE(\configy.counter_d[2] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__0736__A (.DIODE(\configy.counter_d[2] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1183__A (.DIODE(\configy.counter_d[3] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1154__C (.DIODE(\configy.counter_d[3] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1150__A (.DIODE(\configy.counter_d[3] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__0726__A (.DIODE(\configy.counter_d[3] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1181__B1 (.DIODE(\configy.counter_d[4] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1165__A (.DIODE(\configy.counter_d[4] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1154__B (.DIODE(\configy.counter_d[4] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1151__C (.DIODE(\configy.counter_d[4] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__0721__A (.DIODE(\configy.counter_d[4] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1154__A (.DIODE(\configy.counter_d[5] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__0713__A (.DIODE(\configy.counter_d[5] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1167__B1 (.DIODE(\configy.counter_d[6] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1155__B (.DIODE(\configy.counter_d[6] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1151__A (.DIODE(\configy.counter_d[6] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__0698__A (.DIODE(\configy.counter_d[6] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1347__A (.DIODE(\configy.counter_d[7] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1284__A (.DIODE(\configy.counter_d[7] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1164__A1 (.DIODE(\configy.counter_d[7] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1162__A1 (.DIODE(\configy.counter_d[7] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1155__A (.DIODE(\configy.counter_d[7] ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1345__A (.DIODE(\configy.free_run ));
 sky130_fd_sc_hd__diode_2 ANTENNA__0929__A1 (.DIODE(\configy.free_run ));
 sky130_fd_sc_hd__diode_2 ANTENNA__0914__A1 (.DIODE(\configy.free_run ));
 sky130_fd_sc_hd__diode_2 ANTENNA__0964__A (.DIODE(\configy.output_initiated ));
 sky130_fd_sc_hd__diode_2 ANTENNA__0958__A (.DIODE(\configy.output_initiated ));
 sky130_fd_sc_hd__diode_2 ANTENNA__0935__A (.DIODE(\configy.output_initiated ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1204__A (.DIODE(\configy.read_transaction_in_progress ));
 sky130_fd_sc_hd__diode_2 ANTENNA__0922__A (.DIODE(\configy.read_transaction_in_progress ));
 sky130_fd_sc_hd__diode_2 ANTENNA__0919__B1 (.DIODE(\configy.read_transaction_in_progress ));
 sky130_fd_sc_hd__diode_2 ANTENNA__0678__A (.DIODE(\configy.read_transaction_in_progress ));
 sky130_fd_sc_hd__diode_2 ANTENNA__1056__A1 (.DIODE(\configy.write_transaction_in_progress ));
 sky130_fd_sc_hd__diode_2 ANTENNA__0993__A (.DIODE(\configy.write_transaction_in_progress ));
 sky130_fd_sc_hd__diode_2 ANTENNA__0931__B (.DIODE(\configy.write_transaction_in_progress ));
 sky130_fd_sc_hd__diode_2 ANTENNA__0920__A (.DIODE(\configy.write_transaction_in_progress ));
 sky130_fd_sc_hd__diode_2 ANTENNA_clkbuf_1_1_0_wb_clk_i_A (.DIODE(clknet_0_wb_clk_i));
 sky130_fd_sc_hd__diode_2 ANTENNA_clkbuf_1_0_0_wb_clk_i_A (.DIODE(clknet_0_wb_clk_i));
 sky130_fd_sc_hd__diode_2 ANTENNA_clkbuf_2_1_0_wb_clk_i_A (.DIODE(clknet_1_0_0_wb_clk_i));
 sky130_fd_sc_hd__diode_2 ANTENNA_clkbuf_2_0_0_wb_clk_i_A (.DIODE(clknet_1_0_0_wb_clk_i));
 sky130_fd_sc_hd__diode_2 ANTENNA_clkbuf_2_3_0_wb_clk_i_A (.DIODE(clknet_1_1_0_wb_clk_i));
 sky130_fd_sc_hd__diode_2 ANTENNA_clkbuf_2_2_0_wb_clk_i_A (.DIODE(clknet_1_1_0_wb_clk_i));
 sky130_fd_sc_hd__diode_2 ANTENNA_clkbuf_3_1_0_wb_clk_i_A (.DIODE(clknet_2_0_0_wb_clk_i));
 sky130_fd_sc_hd__diode_2 ANTENNA_clkbuf_3_0_0_wb_clk_i_A (.DIODE(clknet_2_0_0_wb_clk_i));
 sky130_fd_sc_hd__diode_2 ANTENNA_clkbuf_3_3_0_wb_clk_i_A (.DIODE(clknet_2_1_0_wb_clk_i));
 sky130_fd_sc_hd__diode_2 ANTENNA_clkbuf_3_2_0_wb_clk_i_A (.DIODE(clknet_2_1_0_wb_clk_i));
 sky130_fd_sc_hd__diode_2 ANTENNA_clkbuf_3_5_0_wb_clk_i_A (.DIODE(clknet_2_2_0_wb_clk_i));
 sky130_fd_sc_hd__diode_2 ANTENNA_clkbuf_3_4_0_wb_clk_i_A (.DIODE(clknet_2_2_0_wb_clk_i));
 sky130_fd_sc_hd__diode_2 ANTENNA_clkbuf_3_7_0_wb_clk_i_A (.DIODE(clknet_2_3_0_wb_clk_i));
 sky130_fd_sc_hd__diode_2 ANTENNA_clkbuf_3_6_0_wb_clk_i_A (.DIODE(clknet_2_3_0_wb_clk_i));
 sky130_fd_sc_hd__diode_2 ANTENNA__1351__CLK (.DIODE(clknet_3_0_0_wb_clk_i));
 sky130_fd_sc_hd__diode_2 ANTENNA__1352__CLK (.DIODE(clknet_3_0_0_wb_clk_i));
 sky130_fd_sc_hd__diode_2 ANTENNA__1353__CLK (.DIODE(clknet_3_0_0_wb_clk_i));
 sky130_fd_sc_hd__diode_2 ANTENNA__1354__CLK (.DIODE(clknet_3_0_0_wb_clk_i));
 sky130_fd_sc_hd__diode_2 ANTENNA__1355__CLK (.DIODE(clknet_3_0_0_wb_clk_i));
 sky130_fd_sc_hd__diode_2 ANTENNA__1356__CLK (.DIODE(clknet_3_0_0_wb_clk_i));
 sky130_fd_sc_hd__diode_2 ANTENNA__1357__CLK (.DIODE(clknet_3_0_0_wb_clk_i));
 sky130_fd_sc_hd__diode_2 ANTENNA__1385__CLK (.DIODE(clknet_3_0_0_wb_clk_i));
 sky130_fd_sc_hd__diode_2 ANTENNA__1404__CLK (.DIODE(clknet_3_0_0_wb_clk_i));
 sky130_fd_sc_hd__diode_2 ANTENNA__1409__CLK (.DIODE(clknet_3_0_0_wb_clk_i));
 sky130_fd_sc_hd__diode_2 ANTENNA__1412__CLK (.DIODE(clknet_3_0_0_wb_clk_i));
 sky130_fd_sc_hd__diode_2 ANTENNA__1413__CLK (.DIODE(clknet_3_0_0_wb_clk_i));
 sky130_fd_sc_hd__diode_2 ANTENNA__1414__CLK (.DIODE(clknet_3_0_0_wb_clk_i));
 sky130_fd_sc_hd__diode_2 ANTENNA__1415__CLK (.DIODE(clknet_3_0_0_wb_clk_i));
 sky130_fd_sc_hd__diode_2 ANTENNA__1421__CLK (.DIODE(clknet_3_0_0_wb_clk_i));
 sky130_fd_sc_hd__diode_2 ANTENNA__1422__CLK (.DIODE(clknet_3_0_0_wb_clk_i));
 sky130_fd_sc_hd__diode_2 ANTENNA__1423__CLK (.DIODE(clknet_3_0_0_wb_clk_i));
 sky130_fd_sc_hd__diode_2 ANTENNA__1424__CLK (.DIODE(clknet_3_0_0_wb_clk_i));
 sky130_fd_sc_hd__diode_2 ANTENNA__1358__CLK (.DIODE(clknet_3_1_0_wb_clk_i));
 sky130_fd_sc_hd__diode_2 ANTENNA__1402__CLK (.DIODE(clknet_3_1_0_wb_clk_i));
 sky130_fd_sc_hd__diode_2 ANTENNA__1403__CLK (.DIODE(clknet_3_1_0_wb_clk_i));
 sky130_fd_sc_hd__diode_2 ANTENNA__1405__CLK (.DIODE(clknet_3_1_0_wb_clk_i));
 sky130_fd_sc_hd__diode_2 ANTENNA__1406__CLK (.DIODE(clknet_3_1_0_wb_clk_i));
 sky130_fd_sc_hd__diode_2 ANTENNA__1407__CLK (.DIODE(clknet_3_1_0_wb_clk_i));
 sky130_fd_sc_hd__diode_2 ANTENNA__1408__CLK (.DIODE(clknet_3_1_0_wb_clk_i));
 sky130_fd_sc_hd__diode_2 ANTENNA__1410__CLK (.DIODE(clknet_3_1_0_wb_clk_i));
 sky130_fd_sc_hd__diode_2 ANTENNA__1411__CLK (.DIODE(clknet_3_1_0_wb_clk_i));
 sky130_fd_sc_hd__diode_2 ANTENNA__1416__CLK (.DIODE(clknet_3_1_0_wb_clk_i));
 sky130_fd_sc_hd__diode_2 ANTENNA__1417__CLK (.DIODE(clknet_3_1_0_wb_clk_i));
 sky130_fd_sc_hd__diode_2 ANTENNA__1378__CLK (.DIODE(clknet_3_2_0_wb_clk_i));
 sky130_fd_sc_hd__diode_2 ANTENNA__1380__CLK (.DIODE(clknet_3_2_0_wb_clk_i));
 sky130_fd_sc_hd__diode_2 ANTENNA__1382__CLK (.DIODE(clknet_3_2_0_wb_clk_i));
 sky130_fd_sc_hd__diode_2 ANTENNA__1428__CLK (.DIODE(clknet_3_2_0_wb_clk_i));
 sky130_fd_sc_hd__diode_2 ANTENNA__1429__CLK (.DIODE(clknet_3_2_0_wb_clk_i));
 sky130_fd_sc_hd__diode_2 ANTENNA__1430__CLK (.DIODE(clknet_3_2_0_wb_clk_i));
 sky130_fd_sc_hd__diode_2 ANTENNA__1431__CLK (.DIODE(clknet_3_2_0_wb_clk_i));
 sky130_fd_sc_hd__diode_2 ANTENNA__1432__CLK (.DIODE(clknet_3_2_0_wb_clk_i));
 sky130_fd_sc_hd__diode_2 ANTENNA__1433__CLK (.DIODE(clknet_3_2_0_wb_clk_i));
 sky130_fd_sc_hd__diode_2 ANTENNA__1434__CLK (.DIODE(clknet_3_2_0_wb_clk_i));
 sky130_fd_sc_hd__diode_2 ANTENNA__1375__CLK (.DIODE(clknet_3_3_0_wb_clk_i));
 sky130_fd_sc_hd__diode_2 ANTENNA__1376__CLK (.DIODE(clknet_3_3_0_wb_clk_i));
 sky130_fd_sc_hd__diode_2 ANTENNA__1377__CLK (.DIODE(clknet_3_3_0_wb_clk_i));
 sky130_fd_sc_hd__diode_2 ANTENNA__1379__CLK (.DIODE(clknet_3_3_0_wb_clk_i));
 sky130_fd_sc_hd__diode_2 ANTENNA__1381__CLK (.DIODE(clknet_3_3_0_wb_clk_i));
 sky130_fd_sc_hd__diode_2 ANTENNA__1418__CLK (.DIODE(clknet_3_3_0_wb_clk_i));
 sky130_fd_sc_hd__diode_2 ANTENNA__1419__CLK (.DIODE(clknet_3_3_0_wb_clk_i));
 sky130_fd_sc_hd__diode_2 ANTENNA__1420__CLK (.DIODE(clknet_3_3_0_wb_clk_i));
 sky130_fd_sc_hd__diode_2 ANTENNA__1435__CLK (.DIODE(clknet_3_3_0_wb_clk_i));
 sky130_fd_sc_hd__diode_2 ANTENNA__1436__CLK (.DIODE(clknet_3_3_0_wb_clk_i));
 sky130_fd_sc_hd__diode_2 ANTENNA__1437__CLK (.DIODE(clknet_3_3_0_wb_clk_i));
 sky130_fd_sc_hd__diode_2 ANTENNA__1438__CLK (.DIODE(clknet_3_3_0_wb_clk_i));
 sky130_fd_sc_hd__diode_2 ANTENNA__1439__CLK (.DIODE(clknet_3_3_0_wb_clk_i));
 sky130_fd_sc_hd__diode_2 ANTENNA__1440__CLK (.DIODE(clknet_3_3_0_wb_clk_i));
 sky130_fd_sc_hd__diode_2 ANTENNA__1441__CLK (.DIODE(clknet_3_3_0_wb_clk_i));
 sky130_fd_sc_hd__diode_2 ANTENNA__1360__CLK (.DIODE(clknet_3_4_0_wb_clk_i));
 sky130_fd_sc_hd__diode_2 ANTENNA__1384__CLK (.DIODE(clknet_3_4_0_wb_clk_i));
 sky130_fd_sc_hd__diode_2 ANTENNA__1386__CLK (.DIODE(clknet_3_4_0_wb_clk_i));
 sky130_fd_sc_hd__diode_2 ANTENNA__1387__CLK (.DIODE(clknet_3_4_0_wb_clk_i));
 sky130_fd_sc_hd__diode_2 ANTENNA__1388__CLK (.DIODE(clknet_3_4_0_wb_clk_i));
 sky130_fd_sc_hd__diode_2 ANTENNA__1393__CLK (.DIODE(clknet_3_4_0_wb_clk_i));
 sky130_fd_sc_hd__diode_2 ANTENNA__1394__CLK (.DIODE(clknet_3_4_0_wb_clk_i));
 sky130_fd_sc_hd__diode_2 ANTENNA__1396__CLK (.DIODE(clknet_3_4_0_wb_clk_i));
 sky130_fd_sc_hd__diode_2 ANTENNA__1401__CLK (.DIODE(clknet_3_4_0_wb_clk_i));
 sky130_fd_sc_hd__diode_2 ANTENNA__1425__CLK (.DIODE(clknet_3_4_0_wb_clk_i));
 sky130_fd_sc_hd__diode_2 ANTENNA__1359__CLK (.DIODE(clknet_3_5_0_wb_clk_i));
 sky130_fd_sc_hd__diode_2 ANTENNA__1361__CLK (.DIODE(clknet_3_5_0_wb_clk_i));
 sky130_fd_sc_hd__diode_2 ANTENNA__1362__CLK (.DIODE(clknet_3_5_0_wb_clk_i));
 sky130_fd_sc_hd__diode_2 ANTENNA__1363__CLK (.DIODE(clknet_3_5_0_wb_clk_i));
 sky130_fd_sc_hd__diode_2 ANTENNA__1364__CLK (.DIODE(clknet_3_5_0_wb_clk_i));
 sky130_fd_sc_hd__diode_2 ANTENNA__1365__CLK (.DIODE(clknet_3_5_0_wb_clk_i));
 sky130_fd_sc_hd__diode_2 ANTENNA__1389__CLK (.DIODE(clknet_3_5_0_wb_clk_i));
 sky130_fd_sc_hd__diode_2 ANTENNA__1390__CLK (.DIODE(clknet_3_5_0_wb_clk_i));
 sky130_fd_sc_hd__diode_2 ANTENNA__1391__CLK (.DIODE(clknet_3_5_0_wb_clk_i));
 sky130_fd_sc_hd__diode_2 ANTENNA__1392__CLK (.DIODE(clknet_3_5_0_wb_clk_i));
 sky130_fd_sc_hd__diode_2 ANTENNA__1395__CLK (.DIODE(clknet_3_5_0_wb_clk_i));
 sky130_fd_sc_hd__diode_2 ANTENNA__1397__CLK (.DIODE(clknet_3_5_0_wb_clk_i));
 sky130_fd_sc_hd__diode_2 ANTENNA__1398__CLK (.DIODE(clknet_3_5_0_wb_clk_i));
 sky130_fd_sc_hd__diode_2 ANTENNA__1399__CLK (.DIODE(clknet_3_5_0_wb_clk_i));
 sky130_fd_sc_hd__diode_2 ANTENNA__1400__CLK (.DIODE(clknet_3_5_0_wb_clk_i));
 sky130_fd_sc_hd__diode_2 ANTENNA__1366__CLK (.DIODE(clknet_3_6_0_wb_clk_i));
 sky130_fd_sc_hd__diode_2 ANTENNA__1367__CLK (.DIODE(clknet_3_6_0_wb_clk_i));
 sky130_fd_sc_hd__diode_2 ANTENNA__1368__CLK (.DIODE(clknet_3_6_0_wb_clk_i));
 sky130_fd_sc_hd__diode_2 ANTENNA__1369__CLK (.DIODE(clknet_3_6_0_wb_clk_i));
 sky130_fd_sc_hd__diode_2 ANTENNA__1370__CLK (.DIODE(clknet_3_6_0_wb_clk_i));
 sky130_fd_sc_hd__diode_2 ANTENNA__1371__CLK (.DIODE(clknet_3_6_0_wb_clk_i));
 sky130_fd_sc_hd__diode_2 ANTENNA__1372__CLK (.DIODE(clknet_3_6_0_wb_clk_i));
 sky130_fd_sc_hd__diode_2 ANTENNA__1373__CLK (.DIODE(clknet_3_6_0_wb_clk_i));
 sky130_fd_sc_hd__diode_2 ANTENNA__1374__CLK (.DIODE(clknet_3_6_0_wb_clk_i));
 sky130_fd_sc_hd__diode_2 ANTENNA__1427__CLK (.DIODE(clknet_3_6_0_wb_clk_i));
 sky130_fd_sc_hd__diode_2 ANTENNA__1442__CLK (.DIODE(clknet_3_6_0_wb_clk_i));
 sky130_fd_sc_hd__diode_2 ANTENNA__1443__CLK (.DIODE(clknet_3_6_0_wb_clk_i));
 sky130_fd_sc_hd__diode_2 ANTENNA__1444__CLK (.DIODE(clknet_3_6_0_wb_clk_i));
 sky130_fd_sc_hd__diode_2 ANTENNA__1445__CLK (.DIODE(clknet_3_6_0_wb_clk_i));
 sky130_fd_sc_hd__diode_2 ANTENNA__1446__CLK (.DIODE(clknet_3_6_0_wb_clk_i));
 sky130_fd_sc_hd__diode_2 ANTENNA__1447__CLK (.DIODE(clknet_3_6_0_wb_clk_i));
 sky130_fd_sc_hd__diode_2 ANTENNA__1448__CLK (.DIODE(clknet_3_6_0_wb_clk_i));
 sky130_fd_sc_hd__diode_2 ANTENNA__1383__CLK (.DIODE(clknet_3_7_0_wb_clk_i));
 sky130_fd_sc_hd__diode_2 ANTENNA__1426__CLK (.DIODE(clknet_3_7_0_wb_clk_i));
 sky130_fd_sc_hd__diode_2 ANTENNA__1449__CLK (.DIODE(clknet_3_7_0_wb_clk_i));
 sky130_fd_sc_hd__diode_2 ANTENNA__1450__CLK (.DIODE(clknet_3_7_0_wb_clk_i));
 sky130_fd_sc_hd__diode_2 ANTENNA__1451__CLK (.DIODE(clknet_3_7_0_wb_clk_i));
 sky130_fd_sc_hd__diode_2 ANTENNA__1452__CLK (.DIODE(clknet_3_7_0_wb_clk_i));
 sky130_fd_sc_hd__diode_2 ANTENNA__1453__CLK (.DIODE(clknet_3_7_0_wb_clk_i));
 sky130_fd_sc_hd__diode_2 ANTENNA__1454__CLK (.DIODE(clknet_3_7_0_wb_clk_i));
 sky130_fd_sc_hd__diode_2 ANTENNA__1455__CLK (.DIODE(clknet_3_7_0_wb_clk_i));
 sky130_fd_sc_hd__diode_2 ANTENNA__1456__CLK (.DIODE(clknet_3_7_0_wb_clk_i));
 sky130_fd_sc_hd__diode_2 ANTENNA__1457__CLK (.DIODE(clknet_3_7_0_wb_clk_i));
 sky130_fd_sc_hd__diode_2 ANTENNA__1458__CLK (.DIODE(clknet_3_7_0_wb_clk_i));
endmodule
