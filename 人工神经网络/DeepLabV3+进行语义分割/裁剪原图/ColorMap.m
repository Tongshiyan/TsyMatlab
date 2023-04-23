function cmap = ColorMap()
 
    cmap = [
    000 000 000   % Back
    255 255 255   % Cloud
           ];
 
% Normalize between [0 1].
cmap = cmap ./ 255;
end