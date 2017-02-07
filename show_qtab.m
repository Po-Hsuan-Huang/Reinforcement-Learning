%%
% NO CHANGES NEED TO BE MADE!
% 
% Author: Nicolas Ludolph (06/2015)
% Edited By:
function show_qtab( Q, episode )
    q_array = zeros(4*3,12*3);
    for y=1:4
        for x=1:12
            for a=1:4
                xIdx = round(-cos( (a-1)*pi/2 ));
                yIdx = round(sin( (a-1)*pi/2 ));
                q_array((y-1)*3 + 2 + yIdx, (x-1)*3 + 2 + xIdx) = Q((y-1)*12+x, a, episode);
            end
        end
    end
    
    imagesc(((1:(12*3))+1)/3,((1:(4*3))+1)/3, q_array );
    colormap(jet(256));
    set(gca,'Ydir','normal', 'XTick', 1:12, 'YTick', 1:4);
    hold on;
    
    for y=1:3
        plot([0.5 12+0.5], [1 1]*y+0.5, 'k-', 'LineWidth', 2.0);
    end
    
    for x=1:11
        plot([1 1]*x+0.5, [0.5 4+0.5], 'k-', 'LineWidth', 2.0);
    end
    
    for y=1:4
        for x=1:12
            [q,a] = max( Q((y-1)*12+x, :, episode) );
            actionsSameQ =  find(Q((y-1)*12+x, :, episode) == q);
            for ai = 1:length(actionsSameQ)
                a = actionsSameQ(ai);
                xIdx = round(-cos( (a-1)*pi/2 ));
                yIdx = round(sin( (a-1)*pi/2 ));
                plot(x+xIdx/3, y+yIdx/3, 'ko', 'MarkerFaceColor','k', 'MarkerEdgeColor','none');
            end
        end
    end
end

