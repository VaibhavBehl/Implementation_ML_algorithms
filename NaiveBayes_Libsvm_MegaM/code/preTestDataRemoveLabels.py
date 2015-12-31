# This file will pre-process the Test data(derived from training set) and remove the Labels(first colums) from each line, so that it is converted to PDF format.
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
	for i in range(1, len(lineTokenArray)):	#iterate over all tokens in line
		if i != 1:
			sys.stdout.write(' '); 
		sys.stdout.write(lineTokenArray[i]);

#cleanup
inputF.close();
