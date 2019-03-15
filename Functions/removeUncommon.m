function [d1] = removeUncommon(S1, S2)
% Place main structure in S1, and the elements you want ...
% removed in S2
% The function returns a new structure with a elements
% S1 != S2

%Create empty mirror structure of input struct.
g = reshape(fieldnames(S1),1,[]);
%Add a second empty line to hold values
g(2,:)={[]};
%Initialize struct  
d1 = struct(g{:})

%Initalize flag and counter
n = 0;
flag = 0;

for ii = 1:numel(S1)   
    for kk = 1:numel(S2) 
        %Flags every variable in struct which is not found in both
        %S1 and S2 and places them in a new struct.
        if~(strcmp(S1(ii).name, S2(kk).name))
           flag = 1;         
        elseif(strcmp(S1(ii).name, S2(kk).name))
            flag = 0;
            break;
        end
    end
        if (flag == 1)
         n = n+1;
         d1(n) = S1(ii); 
        end
end