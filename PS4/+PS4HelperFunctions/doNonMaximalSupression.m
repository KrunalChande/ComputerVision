function [ posr,posc ] = doNonMaximalSupression( Rmax, R )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

cnt = 0;
result = zeros(size(R)); 
[height, width] = size(R);
for i = 2:height-1
for j = 2:width-1
if R(i,j) > 0.001*Rmax && R(i,j) > R(i-1,j-1) && R(i,j) > R(i-1,j) && R(i,j) > R(i-1,j+1) && R(i,j) > R(i,j-1) && R(i,j) > R(i,j+1) && R(i,j) > R(i+1,j-1) && R(i,j) > R(i+1,j) && R(i,j) > R(i+1,j+1)
result(i,j) = 1;
cnt = cnt+1;
end;
end;
end;
[posc, posr] = find(result == 1);
end

