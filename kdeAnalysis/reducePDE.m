function [reducePDE] = reducePDE (pde)

PERCENT_OF_MAX = 0.10;

reducePDE = pde - max (max (pde)) .* PERCENT_OF_MAX;

for i = 1:length (reducePDE)
    for j = 1:length (reducePDE)
        if reducePDE (i, j) < 0
            reducePDE (i, j) = 0;
        end
    end
end

end

