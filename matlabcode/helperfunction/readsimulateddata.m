function data = readsimulateddata( filename )
%READSIMULATEDDATA opens the datadfile that from matlabdata.v
    fileID = fopen(filename, 'r');
    event = fscanf(fileID, "%d %d\n");
    % reshape die nu nog hand gebeund moet worden. 
    data = reshape(event, [], 16000);
    fclose(fileID);
end

