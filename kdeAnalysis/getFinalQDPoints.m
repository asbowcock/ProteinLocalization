function [ finalQDPoints ] = getFinalQDPoints( controller )
%GETFINALQDPOINTS Summary of this function goes here
%   Detailed explanation goes here

bIsGoodPoints = find (controller.goodPoints{1} == 1);
finalQDPoints = controller.filteredQD{1} (bIsGoodPoints,:,:);
end

