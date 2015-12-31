# to create a single file from all Email(enron) labelled data. The folders must be in the same directory as this program. We also need 'enron.vocab' file to be in the same directory as this scripts.
# output_file specified in command line arguments will be loaded with data in 'Project Data Format', with Feature Names starting from "0"
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

spamDirectories = ['./enron1/spam', './enron2/spam', './enron4/spam', './enron5/spam'];
spamFiles=[];
hamDirectories = ['./enron1/ham', './enron2/ham', './enron4/ham', './enron5/ham'];
hamFiles=[];

for spamDir in spamDirectories:
	for subdir, dirs, files in os.walk(spamDir):
		for file in files:
			spamFiles.append(os.path.join(subdir, file));
for hamDir in hamDirectories:
	for subdir, dirs, files in os.walk(hamDir):
		for file in files:
			hamFiles.append(os.path.join(subdir, file));


# iterate over all spam file list
def writeToOutputFile(spamFiles, outputF, startingLabel, count):
	for sIdx, spamFile in enumerate(spamFiles, start=0): #for each file generate one line of 'labelled' output with featureName:FeatureValue
		if count:
			outputF.write('\n');
		count+=1;
		print(count);
		outputF.write(startingLabel);
		featureDic = {}; # feature dictionaty of featureName(index):featureValue(count)
		spamF = open(spamFile, 'r', encoding='latin1');
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
		for k, v in odFeatureDic.items():
			strCat = ' '+str(k)+':'+str(v);
			outputF.write(strCat);

	return count;

count = writeToOutputFile(spamFiles, outputF, 'SPAM', count=0);
writeToOutputFile(hamFiles, outputF, 'HAM', count);
