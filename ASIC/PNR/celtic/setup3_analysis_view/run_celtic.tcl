set parm_filename_prefix celtic/setup3_analysis_view/celtic
set parm_eco_filename_prefix celtic/setup3_analysis_view/celtic
set splitCeltIC -1
set PROCESS 90nm
set EFFORT signoff
set SetVirtualAttackerCmd ""
set SetAttackerSlewCmd ""
set SetParmGtolCmd ""
set SetDelayUsePwlInputWaveCmd ""
set ILM_MODULE {}
set XILM_TGF ""
set TWF_FILE "celtic/setup3_analysis_view/../../MIMO_setup3_analysis_view.twf.gz"
set UseDefaultLoadTiming 1
set LoadTimingCmd ""
set rdagMinimizeDiskUsage 1
set VDD 1.080
set SetOutputCmd ""
set SetGlitchCheckCmd ""
set SetHazardFreeCmd ""
set NOISE_THRESHOLD [expr 20*$VDD/100.0]
set UseDefaultAnalyzeNoise 1
set AnalyzeNoiseCmd ""
set UseDefaultReportEco 1
set ReportEcoCmd ""
set SDF_PROCESS scmetro_tsmc_cl013g_rvt_ss_1p08v_125c
set UseDefaultGenerateSdf 1
set GenerateSdfCmd ""
set SAVE_ECHO 0
set SAVE_CDB 0
set SAVE_XILM 0
set SIM_PATH 0
set SIM_PATH_WITH_NOISE 0
set USE_CTE 0
set VDD_NETS { VDD}
set GND_NETS { VSS}
set SET_SUPPLY_NETS {set_supply -vdd 1.080 {VDD}
set_supply -gnd 0.000 {VSS}
;}
set DELTA_ABSOLUTE -1
set REPORT_VATT 1
set INS_PRE_TCL {;}
set INS_POST_TCL {}
set INS_POST_NETLIST_TCL {}
source celtic/setup3_analysis_view/report_vatt.tcl
source celtic/setup3_analysis_view/init_celtic_fe.tcl
if {$REPORT_VATT} {
if {[catch {generate_report -gzip -vatt -delay max -txtfile celtic/setup3_analysis_view/celtic.vatt.gz} msg]!=0} {
  report_vatt celtic/setup3_analysis_view/celtic.vatt.gz max
}
}
if {$SAVE_XILM} {
save_xilm
}
if {$SAVE_CDB} {
 exec make_cdb create_cdb/create_cdb.tcl
 exec cp -f [glob -type f create_cdb/*cdb] celtic/
}
free_noise_analysis
