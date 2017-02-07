%%
% NO CHANGES NEED TO BE MADE!
% 
% Author: Nicolas Ludolph (06/2015)
% Edited By:
function show_satab( sa )
    q_array = zeros(4,12);
    for y=1:4
        for x=1:12
            q_array(y,x) = sa((y-1)*12+x,1);
        end
    end
    
    imagesc(q_array);
    set(gca,'Ydir','normal');
end

