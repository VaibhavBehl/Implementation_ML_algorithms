# This file will pre-process for SVM the EMAIL Training Data(which is now available as a single file in project data fromat).
# It will change the TARGET(first word of each line) as follows: SPAM=+1, HAM=-1.
# It will increment all feature values by 1. (SVM requires feature values >0)
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
				sys.stdout.write('+1');
			elif token =='HAM':
				sys.stdout.write('-1');
			#else:
				#sys.exit('Error, wrong target value found!'); # should not happen
		else:
			sys.stdout.write(' ');
			featureI = lineTokenArray[i];
			splitFeatureI = featureI.split(':');
			splitFeatureI[0] = str(int(splitFeatureI[0]) + 1);
			sys.stdout.write(':'.join(splitFeatureI));

#cleanup
inputF.close();
