onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /mux64x32_1_testbench/sel
add wave -noupdate -radix hexadecimal /mux64x32_1_testbench/out
add wave -noupdate -radix hexadecimal -childformat {{{/mux64x32_1_testbench/in[31]} -radix hexadecimal} {{/mux64x32_1_testbench/in[30]} -radix hexadecimal} {{/mux64x32_1_testbench/in[29]} -radix hexadecimal} {{/mux64x32_1_testbench/in[28]} -radix hexadecimal} {{/mux64x32_1_testbench/in[27]} -radix hexadecimal} {{/mux64x32_1_testbench/in[26]} -radix hexadecimal} {{/mux64x32_1_testbench/in[25]} -radix hexadecimal} {{/mux64x32_1_testbench/in[24]} -radix hexadecimal} {{/mux64x32_1_testbench/in[23]} -radix hexadecimal} {{/mux64x32_1_testbench/in[22]} -radix hexadecimal} {{/mux64x32_1_testbench/in[21]} -radix hexadecimal} {{/mux64x32_1_testbench/in[20]} -radix hexadecimal} {{/mux64x32_1_testbench/in[19]} -radix hexadecimal} {{/mux64x32_1_testbench/in[18]} -radix hexadecimal} {{/mux64x32_1_testbench/in[17]} -radix hexadecimal} {{/mux64x32_1_testbench/in[16]} -radix hexadecimal} {{/mux64x32_1_testbench/in[15]} -radix hexadecimal} {{/mux64x32_1_testbench/in[14]} -radix hexadecimal} {{/mux64x32_1_testbench/in[13]} -radix hexadecimal} {{/mux64x32_1_testbench/in[12]} -radix hexadecimal} {{/mux64x32_1_testbench/in[11]} -radix hexadecimal} {{/mux64x32_1_testbench/in[10]} -radix hexadecimal} {{/mux64x32_1_testbench/in[9]} -radix hexadecimal} {{/mux64x32_1_testbench/in[8]} -radix hexadecimal} {{/mux64x32_1_testbench/in[7]} -radix hexadecimal} {{/mux64x32_1_testbench/in[6]} -radix hexadecimal} {{/mux64x32_1_testbench/in[5]} -radix hexadecimal} {{/mux64x32_1_testbench/in[4]} -radix hexadecimal} {{/mux64x32_1_testbench/in[3]} -radix hexadecimal} {{/mux64x32_1_testbench/in[2]} -radix hexadecimal} {{/mux64x32_1_testbench/in[1]} -radix hexadecimal} {{/mux64x32_1_testbench/in[0]} -radix hexadecimal}} -expand -subitemconfig {{/mux64x32_1_testbench/in[31]} {-radix hexadecimal} {/mux64x32_1_testbench/in[30]} {-radix hexadecimal} {/mux64x32_1_testbench/in[29]} {-radix hexadecimal} {/mux64x32_1_testbench/in[28]} {-radix hexadecimal} {/mux64x32_1_testbench/in[27]} {-radix hexadecimal} {/mux64x32_1_testbench/in[26]} {-radix hexadecimal} {/mux64x32_1_testbench/in[25]} {-radix hexadecimal} {/mux64x32_1_testbench/in[24]} {-radix hexadecimal} {/mux64x32_1_testbench/in[23]} {-radix hexadecimal} {/mux64x32_1_testbench/in[22]} {-radix hexadecimal} {/mux64x32_1_testbench/in[21]} {-radix hexadecimal} {/mux64x32_1_testbench/in[20]} {-radix hexadecimal} {/mux64x32_1_testbench/in[19]} {-radix hexadecimal} {/mux64x32_1_testbench/in[18]} {-radix hexadecimal} {/mux64x32_1_testbench/in[17]} {-radix hexadecimal} {/mux64x32_1_testbench/in[16]} {-radix hexadecimal} {/mux64x32_1_testbench/in[15]} {-radix hexadecimal} {/mux64x32_1_testbench/in[14]} {-radix hexadecimal} {/mux64x32_1_testbench/in[13]} {-radix hexadecimal} {/mux64x32_1_testbench/in[12]} {-radix hexadecimal} {/mux64x32_1_testbench/in[11]} {-radix hexadecimal} {/mux64x32_1_testbench/in[10]} {-radix hexadecimal} {/mux64x32_1_testbench/in[9]} {-radix hexadecimal} {/mux64x32_1_testbench/in[8]} {-radix hexadecimal} {/mux64x32_1_testbench/in[7]} {-radix hexadecimal} {/mux64x32_1_testbench/in[6]} {-radix hexadecimal} {/mux64x32_1_testbench/in[5]} {-radix hexadecimal} {/mux64x32_1_testbench/in[4]} {-radix hexadecimal} {/mux64x32_1_testbench/in[3]} {-radix hexadecimal} {/mux64x32_1_testbench/in[2]} {-radix hexadecimal} {/mux64x32_1_testbench/in[1]} {-radix hexadecimal} {/mux64x32_1_testbench/in[0]} {-radix hexadecimal}} /mux64x32_1_testbench/in
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {14475 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 187
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
WaveRestoreZoom {0 ps} {324605 ps}
