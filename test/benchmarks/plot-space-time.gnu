#!/usr/bin/env gnuplot

#          Copyright Tom Westerhout 2017.
# Distributed under the Boost Software License, Version 1.0.
#    (See accompanying file LICENSE_1_0.txt or copy at
#          http://www.boost.org/LICENSE_1_0.txt)

if (! exists("testcase")) {
	print "Error: missing the 'testcase' argument"
	exit 1
}

if (! exists("input_file")) {
	print "Error: missing the 'input_file' argument"
	exit 1
}

if (! exists("output_file")) {
	print "Error: missing the 'output_file' argument"
	exit 1
}

set terminal pngcairo noenhanced color notransparent
set output output_file

set title 'Memory usage for "' . testcase . '"'
set xlabel "Time, s"
set ylabel "RAM usage, Mb"
set y2label "Swap usage, Mb"
set ytics nomirror out
set y2tics nomirror out
set key left top

stats input_file u 2:3 name "S" nooutput
stats input_file u 1 name "X" nooutput

set xrange  [X_min / 1000. : X_max / 1000.]
set yrange  [0:]
set y2range [0:]
plot \
	input_file u ($1 / 1000.):(($2 - S_min_x) / 1024.) w l \
		lt 1 lw 1 lc rgb "#777777" notitle, \
	""         u ($1 / 1000.):(($2 - S_min_x) / 1024.) w p \
		pt 7 ps 0.5 lc rgb "#2E911A" title "RAM", \
	""         u ($1 / 1000.):(($3 - S_min_y) / 1024.) axes x1y2 w l \
		lt 1 lw 1 lc rgb "#777777" notitle, \
	""         u ($1 / 1000.):(($3 - S_min_y) / 1024.) axes x1y2 w p \
		pt 7 ps 0.5 lc rgb "#1A6A91" title "Swap"

set output
