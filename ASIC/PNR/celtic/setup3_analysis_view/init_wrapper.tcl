set xngMav 1
pushView setup3_analysis_view
foreach view [all_setup_analysis_views] {
  if {$view != "setup3_analysis_view"} {disableView $view}
}
foreach view [all_hold_analysis_views] {
  if {$view != "setup3_analysis_view"} {disableView $view}
}
setAllRCCornersPerNetInMemory 1
siSetActiveView setup3_analysis_view
setSIMode -analysisView setup3_analysis_view
global dbgCktBias
set dbgCktBias 1.080000
set pwrNetsV [dumpPwrGndNetVoltageForView -view setup3_analysis_view]
set gndNetsV [dumpPwrGndNetVoltageForView -gnd -view setup3_analysis_view]
uplevel #0 initCeltIC 
set cmd { uplevel #0 source celtic/setup3_analysis_view/run_celtic.tcl }
eval $cmd
enableViews
popView
