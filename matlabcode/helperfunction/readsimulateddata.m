function [ detected ] = readsimulateddata( filename )
%READSIMULATEDDATA Summary of this function goes here
%   Detailed explanation goes here
    fileID = fopen(filename, 'r');
    detected = fscanf(fileID, "%d\n");
    fclose(fileID);
end

