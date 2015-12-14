% Author    : Saurabh Singh, Ashish Kumar %
% Date      : 15-Nov-2015 %
% Version   : 1.0v %
% This program creates a binary SVM for the heart data and tests %
% against the test data %
function[] = problemStep0(C) % C soft margin parameter for tuning classifier
load HeartDataSet.mat
z = binarySVMTrain(Xtrain, Ytrain, C);
widthTrainData = size(Xtrain, 2);
lengthTrainData = size(Xtrain, 1);
w = z(1:widthTrainData);
b = z(widthTrainData + 1);
slack = z(widthTrainData + 2:lengthTrainData + widthTrainData + 1);
sizeTestData = size(Xtest, 1);
[comparisonMatrix, result] = binarySVMTest(Xtest, Ytest, z, w, b, sizeTestData);
disp(strcat('Total test data matched is : ', num2str(result)));
disp(strcat('The comparison report is : ', comparisonMatrix));


