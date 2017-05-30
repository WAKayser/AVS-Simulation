function savesimulateddata(P, A, filename)
%SAVESIMULATEDDATA used to save the data in a format that modelsim can read. 
    Ax = floor(real(A) * 2^15);
    Ay = floor(imag(A) * 2^15);
    Pn = floor(real(P) * 2^15);
    data = [Ax, Ay, Pn]';
    plot(Pn)
    fileID = fopen(filename, 'w');
    fprintf(fileID, '%d %d %d\n', data);
    fclose(fileID);
end
    