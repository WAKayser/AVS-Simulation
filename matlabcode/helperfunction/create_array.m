function avsdata = create_array(start, step, number, orientation, change)
%CREATE_ARRAY This will be used to creat a vector array
%   Detailed explanation goes here
    for i = 1:number
        avsdata(i).location = start + step * (i-1);
        avsdata(i).orientation = orientation + change * (i-1);
        avsdata(i).bitdepth = 16;
        avsdata(i).scalepres = 1;
        avsdata(i).scalevec = 1;
    end
end

