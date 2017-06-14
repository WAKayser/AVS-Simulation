function [eventVec, peakMatrix, peakVector] = avsdspmodule_multi(P, A, DSPparam)
%AVSDSPMODULE_MULTI very simple and used to calculated the associated values
	% of multiple dspmodules. Mostly transparent
    
    for i = 1:size(P, 2)
        for j = 1:size(P, 3)
            [eventVec(:,i,j), peakMatrix(:,i,j), peakVector(:,i,j)] = avsdspmodule(P(:,i,j), A(:,i,j), DSPparam);
        end
    end
end

