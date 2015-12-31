# to create a single TEST file from *.txt files present in spam_or_ham_test. The folders must be in the same directory as this program. We also need 'enron.vocab' file to be in the same directory as this scripts.
# output_file specified in command line arguments will be loaded with data in 'Project Data Format' for test file, with no labels and Feature Names starting from "0".
#
# command line args: <output_file>
# stdout: <current_file_being_processed>

import sys;
import os;
import collections;



outputFile = sys.argv[1];
outputF = open(outputFile, 'w');

#loading from enron.vocab file
enronVocabArray = [];
vocabFile = open('enron.vocab', 'r', encoding='latin1');
for vocabFileLine in vocabFile:
	enronVocabArray.append(vocabFileLine.rstrip('\n'));
vocabFile.close();

spamHamTestDirectory = './spam_or_ham_test';
spamHamTestFiles=[];


for subdir, dirs, files in os.walk(spamHamTestDirectory):
	for file in files:
		if 'txt' in file:
			spamHamTestFiles.append(os.path.join(subdir, file));
			

for sIdx, spamHamTestFile in enumerate(spamHamTestFiles, start=0): #for each file generate one line of 'labelled' output with featureName:FeatureValue
	if sIdx != 0:
		outputF.write('\n');
	print(sIdx+1);
	featureDic = {}; # feature dictionaty of featureName(index):featureValue(count)
	spamF = open(spamHamTestFile, 'r', encoding='latin1');
	for lineIdx, line in enumerate(spamF, start=0): #line-by-line scan all tokens
		lineTokenArray = line.split();
		for i in range(0, len(lineTokenArray)):	#iterate over all tokens in line
			token = lineTokenArray[i];
			#if token not in enronVocabArray:
				#sys.exit('Not found token in vocab file - ', token); # should not come here
			
			vocabIndex = enronVocabArray.index(token);
			if vocabIndex in featureDic:
				featureDic[vocabIndex] += 1;
			else:
				featureDic[vocabIndex] = 1
		
	spamF.close();
	odFeatureDic = collections.OrderedDict(sorted(featureDic.items()));
	flag = '';
	for k, v in odFeatureDic.items():
		strCat = '';
		if flag:
			 strCat = ' ';
		strCat = strCat + str(k) + ':' + str(v);
		outputF.write(strCat);
		flag = 'true';
		
outputF.close();
