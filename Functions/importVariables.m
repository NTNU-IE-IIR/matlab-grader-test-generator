function[Solutions, Student] = importVariables(F1, F2, ignVar)
%Imports variables from workspace created by a .mat script.
% ignVar is an optional variables that 
% adds objects to cell array to be ignored when creating the list of 
% imported variables.


%Example use:
% Given a solution template and a learner template
% listToIgnore = {'K', 'numstep'};
% [Solutions, Student] = importVariables('lab1_2solution.m','lab1_2template.m',...
% listToIgnore);
% Will return two structures   
% Solutions (n x 1) struct
% Student   (n x 1) struct
% listToIgnore contains the names of the variables that
% will be excluded from the structure

   %Accept maximum four inputs
   if nargin > 3
        error('myfunc:importVariables:TooManyInputs', ...
        'requires minimum two inputs, maximum Three');
   end
   
   %Initializes empty fields unless specified otherwise by input
   if nargin <= 2
       ignVar = {};
   end
   
   run(F1); % Import Solution 
  
   %Place variable here to exlude it from Solution variable list.
   %The following entires are static and should always be included: 
   % exSol = {'F1', 'F2', 'exSol','exSolStr', 'exSolPat','ignSol','ii'...
   %    'ignStud'};
   %to avoid being carried over from local variables in the function.
   exSol = {'F1', 'F2', 'exSol','exSolStr', 'exSolPat','ignSol','ii'...
       'ignStud'};
   
   %Adds input from ignSol to the cell array exSol
   
   if(nargin >= 3)
       if ~(iscell(ignVar))
         error('myfunc:importVaribles:notCellInput',...
              'ignVar is not a cell array');
       end
 
       for ii = 1:length(ignVar)
           exSol{end+1} = char(ignVar(ii));
       end
   end
   
   
   %Creats a string from exSol cell array, e.g exSolStr = 'F1|F2|...'
   exSolStr = strjoin(exSol, '|');
   %Create a Regular expression pattern with variables from previous list.
   exSolPat = (['^(?!(' exSolStr ')$).']);
 
   %Load variables from workspace exluding contents of regexp pattern.
   Solutions = whos('-regexp', exSolPat);
   clearvars -except Solutions F2 ignStud;
    
   run(F2); % Import Template
   
   %Place variable here to exlude it from Student variable list.
   %The following entires are static and should always be included:
   %{exStud = {'Solutions','F1','F2','exStud', 'exStudStr','exStudPat',...
   %   'ii', 'ignStud'};
   % to avoid being carried over from local variables in the function.
   exStud = {'Solutions','F1','F2','exStud', 'exStudStr','exStudPat',...
       'ii', 'ignStud'};
 
   %Creats a string from exSol cell array, e.g exSolStr = 'Solutions|F2|...'
   exStudStr = strjoin(exStud, '|');
   exStudPat = (['^(?!(' exStudStr ')$).']);
   
   %Load variables from workspace exluding contents of regexp pattern.
   Student = whos('-regexp', exStudPat);
   clearvars -except Solutions Student;
   
   %Finds the handles of all figures, and closes all except GUI ('TestGenerator').
   delete(setdiff(findall(0, 'type', 'figure'), findall(0,'type','figure',...
       'Name','TestGenerator')));
end

