# This file will pre-process the Test data(sentiment_test.feat or enron_test.feat) data, which is in PDF format, for SVM. MUST DO BEFORE FINAL RUN ON UNLABELED TEST DATA.
# It will ADD a placeholder TARGET (=-1), as it is required by SVM.
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
			sys.stdout.write('-1');

		sys.stdout.write(' '); 
		featureI = lineTokenArray[i];
		splitFeatureI = featureI.split(':');
		splitFeatureI[0] = str(int(splitFeatureI[0]) + 1);
		sys.stdout.write(':'.join(splitFeatureI));

#cleanup
inputF.close();
