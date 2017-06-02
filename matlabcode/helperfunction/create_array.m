function avsdata = create_array(start, step, number, orientation, change)
%CREATE_ARRAY This will be used to creat a vector array

	% generate a position for every sensor. 
    for i = 1:number
    	% Calculate the position, which is a complex value. 
        avsdata(i).location = complex(real(start), imag(start)) + step * (i-1);
        % Calculate the orientation based on startvalue and the change. 
        avsdata(i).orientation = orientation + change * (i-1);
        avsdata(i).bitdepth = 16; % this is a guess
        avsdata(i).scalepres = 1;
        avsdata(i).scalevec = 420; % this is used to offset Z
    end
end

