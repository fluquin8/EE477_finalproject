onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /mux16_1_testbench/sel
add wave -noupdate /mux16_1_testbench/out
add wave -noupdate /mux16_1_testbench/in
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {286773190 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 175
configure wave -valuecolwidth 109
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
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {11010048 ns}
