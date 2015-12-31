# This file will post-process various outputs generated for SVM/MegaM
# The input file should have the result numeric value in first column.
# The values >= decision_point will be classified as class1_label and rest as class2_label
#
# command line args: <input_file> <decision_point> <class1_label> <class2_label>
# stdout: <formatted_input_file>


import sys;


inputFile = sys.argv[1];
decisionPoint = float(sys.argv[2]);
class1Label = sys.argv[3];
class2Label = sys.argv[4];

inputF = open(inputFile, 'r');

for lineIdx, line in enumerate(inputF, start=0):
	if lineIdx != 0:
		sys.stdout.write('\n');

	lineTokenArray = line.split();
	if float(lineTokenArray[0]) >= decisionPoint:
		sys.stdout.write(class1Label);
	else:
		sys.stdout.write(class2Label);

#cleanup
inputF.close();
