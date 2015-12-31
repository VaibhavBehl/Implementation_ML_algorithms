# Prints various scores/metrics(precision, recall, F1) to the STDOUT. Needs two files containing SAME number of lines and having same classes.
# Also pass in the classes on which to report the metric.
#
# command line args: <original_file> <predicted_file> <Class1> <Class2>
# stdout: <scores>

import sys;


originalFile = sys.argv[1];
predictedFile = sys.argv[2];
class1 = sys.argv[3];
class2 = sys.argv[4];
originalF = open(originalFile, 'r');
predictedF = open(predictedFile, 'r');

belongInClass1 = 0; # CLASS1 in orig
classifiedAsClass1 = 0; # CLASS1 in prediction
correctlyClassifiedAsClass1 = 0; # match found


belongInClass2 = 0; # CLASS2 in orig
classifiedAsClass2 = 0; # CLASS2 in prediction
correctlyClassifiedAsClass2 = 0; # match found


predictedFArray = predictedF.readlines();
for lineIdx, originalLine in enumerate(originalF, start=0):
	originalLine = originalLine.rstrip('\n');
	predictedLine = predictedFArray[lineIdx].rstrip('\n');
	if originalLine == class1:
		belongInClass1 = belongInClass1 +1;
	elif originalLine == class2:
		belongInClass2 = belongInClass2 + 1;

	if predictedLine == class1:
		classifiedAsClass1 = classifiedAsClass1 + 1;
	elif predictedLine  == class2:
		classifiedAsClass2 = classifiedAsClass2 + 1;

	if originalLine == predictedLine and originalLine == class1:
		correctlyClassifiedAsClass1 = correctlyClassifiedAsClass1 + 1;
	elif originalLine == predictedLine and originalLine == class2:
		correctlyClassifiedAsClass2 = correctlyClassifiedAsClass2 + 1;

pClass1 = correctlyClassifiedAsClass1/classifiedAsClass1;
rClass1 = correctlyClassifiedAsClass1/belongInClass1;
fClass1 = 2*pClass1*rClass1/(pClass1 + rClass1);
print('Precision of ' + class1 + ' - ', pClass1);
print('Recall of ' + class1 + ' - ', rClass1);
print('F1 score of ' + class1 + ' - ', fClass1);

pClass2 = correctlyClassifiedAsClass2/classifiedAsClass2;
rClass2 = correctlyClassifiedAsClass2/belongInClass2;
fClass2 = 2*pClass2*rClass2/(pClass2 + rClass2);

print('Precision of ' + class2 + ' - ', pClass2);
print('Recall of ' + class2 + ' - ', rClass2);
print('F1 score of ' + class2 + ' - ', fClass2);


#cleanup
originalF.close();
predictedF.close();
