function [d1] = compareStructures(S1, S2) 
%  Compares two structures, placing the uncommon elements in a
%  new structure d1.

    
    %Copy fieldnames to a cell array
    g = reshape(fieldnames(S1),1,[]);
    %Add a second empty line to hold values
    g(2,:)={[]};
    %Initialize struct to hold  
    d1 = struct(g{:});
    
    flag = [0 0];
    n = 0;
    
    if ~isstruct(S1) || ~isstruct(S2)
        error('CompareStructs:BadInputType','One or more arguments is not a structure.');
    end

    if isequal(S1,S2)
        fprintf('The structures are identical.\n');
        return;
    end
    
    %Check if number number of rows for structures
    nS1 = size(S1, 1); % number of rows struct 1
    nS2 = size(S2, 1); % number of rows struct 2
    
    % Adds placeholder fields to avoid indexing out of bounds
    if ~(isequal(nS1, nS2))
       %Create an empty structure copy of S1
       C = reshape(fieldnames(S1), 1, []);
       C(2, :) = {[]};
       b = struct(C{:});
       
       if(nS2 > nS1)
        for kk = 1:(nS2 - nS1)
           S1(end + 1) = b;
        end
       elseif(nS1 > nS2)
         for mm = 1:(nS1 - nS2)
             S2(end +1)= b;
         end
       end
    end

    try
        
    for jj = 1:max(numel(S1), numel(S2))
          for kk = 1:max(numel(S2), numel(S1))
              if~(strcmp(S1(jj).name, S2(kk).name))
                  flag = [1 0];
              elseif(strcmp(S1(jj).name, S2(kk).name))
                  flag = [0 1];
                  break;
             end
          end
          
         
          if(flag(1) && ~flag(2))
            if(isempty(S1(jj).name))
                continue;
            else
            n = n + 1;
            d1(n) = S1(jj);   
            end
          end
    end
      
      catch ME
          cause = getReport(ME, 'basic')
              switch ME.identifier
                  case'MATLAB:badsubscript'
                      throw(ME)
                  otherwise
                      rethrow(ME)
              end
    end     
end