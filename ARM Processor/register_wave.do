onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal /register_testbench/q
add wave -noupdate /register_testbench/en
add wave -noupdate -radix hexadecimal /register_testbench/d
add wave -noupdate /register_testbench/clk
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {919218 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 173
configure wave -valuecolwidth 116
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
WaveRestoreZoom {0 ps} {1522500 ps}
