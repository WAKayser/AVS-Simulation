function bwEst = bwEstimate(samplePower, bwFactor, sampleSize, Fs) % maxIndex,
% BW estimation
    % this function is not used. 
    bwTest = 0;
    th1 = 0;
    bwEst = 0;

    for i = 1:ceil(sampleSize/2)
        bwTest = bwTest + samplePower(i);

        if (bwTest > sum(samplePower)/2*(1 - bwFactor)) && (th1 == 0)
            th1 = i;
        end

        if bwTest > sum(samplePower)/2 * bwFactor
            bwEst = (i - th1) * Fs/length(samplePower);
            break
        end
    end
end
