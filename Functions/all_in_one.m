% Excludes every variable containing the terms found inside the parenthesis.
tempnames = who('-regexp','(?i)^(?=\w*(fig|exclude))\w*');
% Exclude variables not to check.
% Primarily variables not common in workspace and reference solution.
% Place variable here if you get non-existing reference error.
% Figures are not testable.
noCheck =  {'r','a','b','c','x','y',...
    'tempnames','noCheck','noCheckPat','referenceVariables','seed', 'ii'};
for ii = 1:length(tempnames)
    noCheck{end+1} = char(tempnames(ii));
end
% Combines noCheck and tempnames to a regex pattern.
noCheckPat = (['^(?!(' strjoin(noCheck, '|') ')$).']);
% Import variables from virtual workspace to a struct.
% Excluding figures and all variables with keyword exclude and some static variables.
varnames = whos('-regexp', noCheckPat);
tol = 0.001;     % Set tolerance, 0.001 = 0.1% relative tolerance.
format compact   % Set output format. Either 'compact' or 'loose'.
format shortE    % Set output format. See documentation for various types.
nodisplays = {}; % Excluding variables to not display due to length, readability etc.
counterTP = 0;   % Counter for tests passed
counterER = 0;   % Counter for errors
counterNC = 0;   % Counter for noCheck variables
for ii = 1:numel(varnames)
    if ismember(varnames(ii).name, noCheck)
        disp(['Test ' num2str(ii) ' of ' num2str(length(varnames))])
        disp(['-Not testable-'])
        counterNC = counterNC + 1;
        disp('-------------------------------------------------------- ')
        continue;
    else
        try
            % for ii = 1 -> referenceVariables.numg
            refV = ['referenceVariables.' varnames(ii).name];
            % Returns a [n m] vector where n is the number of lines the variable contains.
            n = size(eval(refV));
            ns = varnames(ii).size;
            % evalc returns character array of variable.
            % Limit output to 100 char and 3 lines.
            if (ismember(varnames(ii).name, nodisplays) || ...
                    (length(evalc(refV)) > 100) || ...
                    (n(1) > 4) || (ns(1) > 4) || ...
                    (length(evalc(varnames(ii).name)) > 100))
                disp([varnames(ii).name ' ='])
                disp(' ... answer too long to display')
            else
                eval(varnames(ii).name)
                eval(refV)
            end
            assessVariableEqual(varnames(ii).name, eval(refV), ...
                'RelativeTolerance', tol)
            disp(['Test ' num2str(ii) ' of ' num2str(length(varnames)) ...
                ': PASSED!'])
            counterTP = counterTP + 1;
            disp('-------------------------------------------------------- ')
            
        catch ME
            msg = getReport(ME, 'basic');
            if contains(msg, 'Variable')
                msgFiltered = extractAfter(msg, 'Variable');
                msg = strtrim(msgFiltered)
            else
                msg
            end
            switch ME.identifier
                case 'MATLAB:nonExistentField'
                    continue;
                case 'AssessmentToolbox:Feedback:SizeMismatch'
                    disp(['Test ' num2str(ii) ' of ' num2str(length(varnames)) ...
                        ': NOT PASSED!'])
                    disp('-------------------------------------------------------- ')
                    counterER = counterER +1;
                    continue;
                case 'AssessmentToolbox:Feedback:ValueMismatch'
                    disp(['Test ' num2str(ii) ' of ' num2str(length(varnames)) ...
                        ': NOT PASSED!'])
                    disp('-------------------------------------------------------- ')
                    counterER = counterER +1;
                    continue;
                case 'AssessmentToolbox:Feedback:DataTypeMismatch'
                    disp(['Test ' num2str(ii) ' of ' num2str(length(varnames)) ...
                        ': NOT PASSED!'])
                    disp('-------------------------------------------------------- ')
                    counterER = counterER +1;
                    continue;
                otherwise
                    msg = getReport(ME, 'extended')
                    rethrow(ME)
            end
        end
    end
end
studentScore = num2str(counterTP + counterNC);
totalScore = num2str(counterTP + counterER + counterNC);
disp('-------------------------------------------------------- ')
disp(['Total Score: ' studentScore ' / ' totalScore])
disp('-------------------------------------------------------- ')
if (studentScore == totalScore)
    disp(['All tests passed'])
else
    msgID = 'CODY:InsufficientScore';
    msg = 'Not all answers are correct';
    baseException = MException(msgID, msg);
    throw(baseException)
end