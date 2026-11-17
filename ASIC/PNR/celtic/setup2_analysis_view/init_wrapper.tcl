set xngMav 1
pushView setup2_analysis_view
foreach view [all_setup_analysis_views] {
  if {$view != "setup2_analysis_view"} {disableView $view}
}
foreach view [all_hold_analysis_views] {
  if {$view != "setup2_analysis_view"} {disableView $view}
}
setAllRCCornersPerNetInMemory 1
siSetActiveView setup2_analysis_view
setSIMode -analysisView setup2_analysis_view
global dbgCktBias
set dbgCktBias 1.080000
set pwrNetsV [dumpPwrGndNetVoltageForView -view setup2_analysis_view]
set gndNetsV [dumpPwrGndNetVoltageForView -gnd -view setup2_analysis_view]
uplevel #0 initCeltIC 
set cmd { uplevel #0 source celtic/setup2_analysis_view/run_celtic.tcl }
eval $cmd
enableViews
popView
