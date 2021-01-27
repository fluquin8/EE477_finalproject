onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /mux4_1_64bit_testbench/sel
add wave -noupdate -radix hexadecimal /mux4_1_64bit_testbench/out
add wave -noupdate -radix hexadecimal /mux4_1_64bit_testbench/in
add wave -noupdate -radix hexadecimal /mux4_1_64bit_testbench/d
add wave -noupdate -radix hexadecimal /mux4_1_64bit_testbench/c
add wave -noupdate -radix hexadecimal /mux4_1_64bit_testbench/b
add wave -noupdate -radix hexadecimal /mux4_1_64bit_testbench/a
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {34899 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 200
configure wave -valuecolwidth 113
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
WaveRestoreZoom {0 ps} {42 ns}
