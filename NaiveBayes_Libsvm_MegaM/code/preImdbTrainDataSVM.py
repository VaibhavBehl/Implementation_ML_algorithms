# This file will pre-process the IMDB Training Data(labeledBow.feat) data for SVM
# It will change the TARGET(first number of each line) as follows: >= 7 (POSITIVE=+1) or <= 4 (NEGATIVE=-1)
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
			token = int(lineTokenArray[i]);
			if token >= 7: # POSITIVE
				sys.stdout.write('+1');
			elif token <=4: # NEGATIVE
				sys.stdout.write('-1');
			else:
				sys.exit('Error, wrong target value found!');
		else:
			sys.stdout.write(' '); 
			featureI = lineTokenArray[i];
			splitFeatureI = featureI.split(':');
			splitFeatureI[0] = str(int(splitFeatureI[0]) + 1);
			sys.stdout.write(':'.join(splitFeatureI));

#cleanup
inputF.close();
