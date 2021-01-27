onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /regstim/clk
add wave -noupdate -radix unsigned /regstim/WriteRegister
add wave -noupdate -radix hexadecimal /regstim/WriteData
add wave -noupdate /regstim/RegWrite
add wave -noupdate -radix unsigned /regstim/ReadRegister2
add wave -noupdate -radix unsigned /regstim/ReadRegister1
add wave -noupdate -radix hexadecimal /regstim/ReadData2
add wave -noupdate -radix hexadecimal /regstim/ReadData1
add wave -noupdate -radix hexadecimal -childformat {{{/regstim/dut/regis[31]} -radix hexadecimal} {{/regstim/dut/regis[30]} -radix hexadecimal} {{/regstim/dut/regis[29]} -radix hexadecimal} {{/regstim/dut/regis[28]} -radix hexadecimal} {{/regstim/dut/regis[27]} -radix hexadecimal} {{/regstim/dut/regis[26]} -radix hexadecimal} {{/regstim/dut/regis[25]} -radix hexadecimal} {{/regstim/dut/regis[24]} -radix hexadecimal} {{/regstim/dut/regis[23]} -radix hexadecimal} {{/regstim/dut/regis[22]} -radix hexadecimal} {{/regstim/dut/regis[21]} -radix hexadecimal} {{/regstim/dut/regis[20]} -radix hexadecimal} {{/regstim/dut/regis[19]} -radix hexadecimal} {{/regstim/dut/regis[18]} -radix hexadecimal} {{/regstim/dut/regis[17]} -radix hexadecimal} {{/regstim/dut/regis[16]} -radix hexadecimal} {{/regstim/dut/regis[15]} -radix hexadecimal} {{/regstim/dut/regis[14]} -radix hexadecimal} {{/regstim/dut/regis[13]} -radix hexadecimal} {{/regstim/dut/regis[12]} -radix hexadecimal} {{/regstim/dut/regis[11]} -radix hexadecimal} {{/regstim/dut/regis[10]} -radix hexadecimal} {{/regstim/dut/regis[9]} -radix hexadecimal} {{/regstim/dut/regis[8]} -radix hexadecimal} {{/regstim/dut/regis[7]} -radix hexadecimal} {{/regstim/dut/regis[6]} -radix hexadecimal} {{/regstim/dut/regis[5]} -radix hexadecimal} {{/regstim/dut/regis[4]} -radix hexadecimal} {{/regstim/dut/regis[3]} -radix hexadecimal} {{/regstim/dut/regis[2]} -radix hexadecimal} {{/regstim/dut/regis[1]} -radix hexadecimal} {{/regstim/dut/regis[0]} -radix hexadecimal}} -subitemconfig {{/regstim/dut/regis[31]} {-radix hexadecimal} {/regstim/dut/regis[30]} {-radix hexadecimal} {/regstim/dut/regis[29]} {-radix hexadecimal} {/regstim/dut/regis[28]} {-radix hexadecimal} {/regstim/dut/regis[27]} {-radix hexadecimal} {/regstim/dut/regis[26]} {-radix hexadecimal} {/regstim/dut/regis[25]} {-radix hexadecimal} {/regstim/dut/regis[24]} {-radix hexadecimal} {/regstim/dut/regis[23]} {-radix hexadecimal} {/regstim/dut/regis[22]} {-radix hexadecimal} {/regstim/dut/regis[21]} {-radix hexadecimal} {/regstim/dut/regis[20]} {-radix hexadecimal} {/regstim/dut/regis[19]} {-radix hexadecimal} {/regstim/dut/regis[18]} {-radix hexadecimal} {/regstim/dut/regis[17]} {-radix hexadecimal} {/regstim/dut/regis[16]} {-radix hexadecimal} {/regstim/dut/regis[15]} {-radix hexadecimal} {/regstim/dut/regis[14]} {-radix hexadecimal} {/regstim/dut/regis[13]} {-radix hexadecimal} {/regstim/dut/regis[12]} {-radix hexadecimal} {/regstim/dut/regis[11]} {-radix hexadecimal} {/regstim/dut/regis[10]} {-radix hexadecimal} {/regstim/dut/regis[9]} {-radix hexadecimal} {/regstim/dut/regis[8]} {-radix hexadecimal} {/regstim/dut/regis[7]} {-radix hexadecimal} {/regstim/dut/regis[6]} {-radix hexadecimal} {/regstim/dut/regis[5]} {-radix hexadecimal} {/regstim/dut/regis[4]} {-radix hexadecimal} {/regstim/dut/regis[3]} {-radix hexadecimal} {/regstim/dut/regis[2]} {-radix hexadecimal} {/regstim/dut/regis[1]} {-radix hexadecimal} {/regstim/dut/regis[0]} {-radix hexadecimal}} /regstim/dut/regis
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {324135807 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 172
configure wave -valuecolwidth 141
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
WaveRestoreZoom {0 ps} {501375 ns}
