onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /mov_shifter_testbench/shift
add wave -noupdate -radix hexadecimal /mov_shifter_testbench/replacee
add wave -noupdate -radix hexadecimal /mov_shifter_testbench/out
add wave -noupdate -radix hexadecimal /mov_shifter_testbench/imm
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {67377 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 208
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {84 ns}
