# This file will CONVERT IMDB Training Data data to PDF(Project Data Format)
# It will change the TARGET(first token of each line) as follows: >= 7 (POSITIVE) or <= 4 (NEGATIVE)
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
				sys.stdout.write('POSITIVE');
			elif token <=4: # NEGATIVE
				sys.stdout.write('NEGATIVE');
			else:
				sys.exit('Error, wrong target value found!');
		else:
			sys.stdout.write(' ');
			sys.stdout.write(lineTokenArray[i]);

#cleanup
inputF.close();
