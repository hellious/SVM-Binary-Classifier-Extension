% Author    : Saurabh Singh, Ashish Kumar %
% Date      : 19-Nov-2015 %
% Version   : 1.0v %
% This program laods the vehicle data and creates performs %
% a one vs one multiclass conversion from the binary SVM %
% created in the process %
function[] = problemStep2(C) % C soft margin parameter for tuning classifier
% load data from the data files %
[xaaD, xaaC] = loadDataFromFile('xaa.dat');
[xabD, xabC] = loadDataFromFile('xab.dat');
[xacD, xacC] = loadDataFromFile('xac.dat');
[xadD, xadC] = loadDataFromFile('xad.dat');
[xaeD, xaeC] = loadDataFromFile('xae.dat');
[xafD, xafC] = loadDataFromFile('xaf.dat');
[xagD, xagC] = loadDataFromFile('xag.dat');
[xahD, xahC] = loadDataFromFile('xah.dat');
[xaiD, xaiC] = loadDataFromFile('xai.dat');

finalX = [xaaD; xabD; xacD; xadD; xaeD; xafD; xagD];
finalY = [xaaC; xabC; xacC; xadC; xaeC; xafC; xagC];
classes = unique(finalY);
Xtest = [xahD; xaiD];
Ytest = [xahC; xaiC];

% loop through the classes matrix for one vs one conversion %
totalCombinationSize = (size(classes, 1) * (size(classes, 1) - 1)) / 2;
w = zeros(totalCombinationSize, size(finalX, 2));
b = zeros(totalCombinationSize, 1);
k = 1;
XtrainTemp = rand(0, 18);
YtrainTemp = rand(0, 1);
pairs = zeros(6, 2);
for i = 1:size(classes, 1)
    for j = i + 1: size(classes, 1)
        for counter = 1: size(finalY, 1)
            if strcmp(finalY(counter), classes(i)) || strcmp(finalY(counter), classes(j))
                XtrainTemp = [XtrainTemp; finalX(counter, :)];
                if strcmp(finalY(counter), classes(i))
                    YtrainTemp = [YtrainTemp; 1];
                else
                    YtrainTemp = [YtrainTemp; - 1];
                end
            end
        end
        z = binarySVMTrain(str2double(XtrainTemp), YtrainTemp, C);
        w(k, :) = z(1:18);
        b(k, :) = z(19);
        pairs(k, :) = [i, j];
        k = k + 1;
        XtrainTemp = rand(0, 18);
        YtrainTemp = rand(0, 1);
    end
end

% test against the test data %
[comparisonMatrix, result] = multiClassSVMTestOVO(Xtest, Ytest, classes, w, b, pairs);
disp(strcat('Total test data matched is : ', num2str(result)));
disp(strcat('The comparison report is : ', comparisonMatrix));


