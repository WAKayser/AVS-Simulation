function show_setup(eventdata, avsdata)
%SHOW_SETUP This is will be used to create top down view of 
%   the arrays and the eventlocationsS
    for i = 1:size(eventdata,2)
        el(i) = eventdata(:,i).location;
    end
    plot(el, 'o');
    hold on;
    for i = 1:size(avsdata,2)
        for j = 1:size(avsdata,3)
            avsdata(:,i,j)
            plot(avsdata(:,i,j).location, 'x');
        end
    end
end

