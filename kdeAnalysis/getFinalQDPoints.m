function [ finalQDPoints ] = getFinalQDPoints( controller, cellNumber )
%GETFINALQDPOINTS Summary of this function goes here
%   Detailed explanation goes here

bIsGoodPoints = find (controller.goodPoints{cellNumber} == 1);
finalQDPoints = controller.filteredQD{cellNumber} (bIsGoodPoints,:,:);
end

