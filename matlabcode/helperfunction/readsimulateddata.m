function data = readsimulateddata( filename )
%READSIMULATEDDATA Summary of this function goes here
%   Detailed explanation goes here
    fileID = fopen(filename, 'r');
    event = fscanf(fileID, "%d %d\n");
    data = reshape(event, [], 16000);
    fclose(fileID);
end

