% merger cell column in different .mat file

fileName = {'A.mat' 'B.mat'}; % merge file name
saveFileName = 'merge.mat'; % file name for saving
vName = {'a' 'b' 'c'}; % variable name

[dump frag] = size(fileName);

for i = 1:frag
    eval(sprintf('m%d = matfile(char(fileName(i)));', i));
end;

[dump vSize] = size(vName);
vList = cell(vSize, frag);

for vI = 1:vSize
    for i = 1:frag
        eval(sprintf('%s%d = m%d.amp;', char(vName(vI)), i, i));
        eval(sprintf('vList{vI, i} = %s%d;', char(vName(vI)), i));
    end;
    eval(sprintf('%s = [vList{vI,:}];', char(vName(vI))));
    if exist(saveFileName, 'file')
        eval(sprintf('save(saveFileName,''%s'',''-append'')', vName{vI}));
    else
        eval(sprintf('save(saveFileName,''%s'')', vName{vI}));
        sprintf('Generating .mat file: %s', saveFileName)
    end;
end;
clear all;
