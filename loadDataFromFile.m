% Author    : Saurabh Singh, Ashish Kumar %
% Date      : 19-Nov-2015 %
% Version   : 1.0v %
% This function loads feature data and class details from the data files %
function [data, class] = loadDataFromFile(fileName)
warning off;
data = char.empty(0, 19);
class = char.empty(0, 1);
fid = fopen(fileName, 'r');
tline = fgets(fid);
while ischar(tline)
    rowData = strsplit(tline, ' ');
    data = [data; rowData(1:18)];
    class = [class; rowData(19)];
    tline = fgets(fid);
end

