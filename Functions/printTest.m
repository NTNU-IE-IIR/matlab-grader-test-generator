function [] = printTest(commonelements, testpath, testname, cstring1, cstring2, cstring3)
% Prints code used for tests @ cody coursework to a text-file.
% commonelements -> a single structure with the variables which are to be
% tested
% testpath  -> filepath for saving textfile
% testname  -> Name of testfile

%Example test: 
%   disp('Reference Solution: ')
%   referenceVariables.numF1
%   disp('Student Solution: ')
%   numF1
%   assessVariableEqual('numF1',referenceVariables.numF1)

% Initializing text-file. 'wt' indicates writing and text-form.
% Use fullfile syntax in order to be able to select folders outside
% default matlab path
[fid, msg] = fopen(fullfile(testpath,testname), 'wt');

% If no custom strings are included, default values will be set.
if nargin < 5 || isempty(cstring1)
      cstring1 = 'disp(''Reference Solution: '')';
end
if nargin < 6 || isempty(cstring2)
    cstring2 = 'disp(''Student Solution: '')';
end

if nargin <7 || isempty(cstring3)
    cstring3 = '';
end

%fid will return -1 if unable to open
if fid < 0
  error(['Failed to open file ' testname ' for writing, because ' msg]);
end 


for ii = 1:min(numel(commonelements)) 
    % Assign an instance of student variable
    studVar = commonelements(ii).name;       
    % Assign an instance of reference variable
    refV =  ['referenceVariables.' commonelements(ii).name];

   % Creates a string object to print to file
   testPrint = ([cstring1,'\n', refV, ...
       '\n', cstring2,'\n', studVar,'\n', ...
        'assessVariableEqual(''' studVar ''','...
         refV ')', '\n', cstring3, '\n','\n']);

   fprintf(fid, testPrint);           
 end
 fclose(fid);
end
