function show_setup(eventdata, avsdata)
%SHOW_SETUP This is will be used to create top down view of 
%   the arrays and the eventlocations
    l = eventdata.location(real(l)
    scatter(real(eventdata.location), imag(eventdata.location));
    hold on;
    scatter(real(avsdata.location), imag(avsdata.location));
end

