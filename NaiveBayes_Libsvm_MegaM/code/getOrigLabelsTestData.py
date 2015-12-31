# will print to stdout the original TARGETS against which we have to report our metric scores.
# The input file should have the first token on each line as the "numeric" TARGET class(specified as class1_number/class2_number) (eg. +1 or -1). These targets would then be converted into specific class label (specified as class1_label, class2_label)
#
# command line args: <input_file> <class1_number> <class1_label> <class2_number> <class2_label>
# stdout: <formatted_input_file>

import sys;


inputFile = sys.argv[1];
class1Number = int(sys.argv[2]);
class1Label = sys.argv[3];
class2Number = int(sys.argv[4]);
class2Label = sys.argv[5];

inputF = open(inputFile, 'r');

for lineIdx, line in enumerate(inputF, start=0):
	if lineIdx != 0:
		sys.stdout.write('\n');

	lineTokenArray = line.split();
	token = int(lineTokenArray[0]);
	if token == class1Number:
		sys.stdout.write(class1Label);
	elif token == class2Number:
		sys.stdout.write(class2Label);


#cleanup
inputF.close();
