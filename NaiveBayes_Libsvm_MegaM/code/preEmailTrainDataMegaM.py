# This file will pre-process for MegaM the EMAIL Training Data(which is now available as a single file in project data fromat).
# RUN IT BEFORE SPLITTING DATA
# It will change the TARGET(first word of each line) as follows: SPAM=1, HAM=0.
# It will transform "feature:value" format to the space delimited format
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
	
	for i in range(0, len(lineTokenArray)):	#iterate over all tokens in line
		if i == 0:
			token = lineTokenArray[i];
			if token == 'SPAM':
				sys.stdout.write('1');
			elif token =='HAM':
				sys.stdout.write('0');
			#else:
				#sys.exit('Error, wrong target value found!'); # should not happen
		else:
			sys.stdout.write(' ');
			featureI = lineTokenArray[i];
			splitFeatureI = featureI.split(':');
			sys.stdout.write(' '.join(splitFeatureI));

#cleanup
inputF.close();
