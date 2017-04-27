function Z = transform_multi(eventdata, avsdata, E)
%TRANSFORM_MULTI combine all events and calculate 
%   Detailed explanation goes he

    Z = zeros(size(E, 1)/17, size(avsdata, 2), size(avsdata, 3));
    for i = 1:size(avsdata, 2)
        for k = 1:size(avsdata, 3)
            for j = 1:size(eventdata, 2)
                transvec = eventdata(1,j).location - avsdata(1,i,k).location;
                avswave = loctransform(transvec, E(:,j));
                Z(:,i,k) = Z(:,i,k) + avswave;
            end
        end
    end
end

