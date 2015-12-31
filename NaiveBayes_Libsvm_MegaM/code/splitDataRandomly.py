# This file will split out Training file into two files RANDOMLY based on command line argument.
# (eg. if split_location is 75, then- 75% to output_file_1,25% to output_file_2)
# command line args: <input_file> <split_location> <output_file_1> <output_file_2>
# stdout: <none>

import sys;
import linecache;
import random;

inputFile = sys.argv[1];
splitLocation = sys.argv[2];
outputFile1 = sys.argv[3];
outputFile2 = sys.argv[4];
inputF = open(inputFile, 'r');
outputF1 = open(outputFile1, 'w');
outputF2 = open(outputFile2, 'w');

with open(inputFile) as f:
    inputFileTotalLines = sum(1 for _ in f);

randomArr = random.sample(range(inputFileTotalLines),inputFileTotalLines);

for count, random in enumerate(randomArr, start=1):
	randomInputLine = linecache.getline(inputFile, random);
	if count <= (inputFileTotalLines*int(splitLocation)/100):
		print(randomInputLine, file=outputF1, end='');
	else:
		print(randomInputLine, file=outputF2, end='');


#cleanup
inputF.close();
outputF1.close();
outputF2.close();
