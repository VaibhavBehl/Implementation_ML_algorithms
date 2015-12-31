# will print to stdout the original TARGETS against which we have to report our metric scores. The input file should have the first token on each line as the TARGET class (eg. POSITIVE/NEGATIVE or SPAM/HAM) 
#
# command line args: <input_file>
# stdout: <formatted_input_file>

import sys;


inputFile = sys.argv[1];
inputF = open(inputFile, 'r');

for lineIdx, line in enumerate(inputF, start=0):
	if lineIdx != 0:
		sys.stdout.write('\n');
	lineTokenArray = line.split();
	sys.stdout.write(lineTokenArray[0]);


#cleanup
inputF.close();
