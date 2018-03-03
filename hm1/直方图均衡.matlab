I = imread('river.jpg');      %读入图片river
J = I;                        %I的副本J
imhist(I);                    %显示I的直方图
imshow(I);                    %显示I原图

[m, n] = size(I);             %获取I的总像素
A_0 = m * n;
L = 256;                      %灰度级数256

for i = 1 : 256               %统计各个灰度级的像素数目
[r, c] = find(I == i - 1);    %下标是D_A+1
H_A(i) = length(r);
end

D_B(1) = H_A(1);              %算出灰度映射函数
for i = 2 : 256
D_B(i) = D_B(i-1) + H_A(i);
end

D_B = D_B * L / A_0;

for i = 1 : m                 %直方图均衡化
for j = 1 : n                 %将I的像素灰度值映射到J
J(i, j) = D_B(I(i, j)+1);     %下标是D_A+1
end
end

imhist(J);                    %显示J的直方图
imshow(J);                    %显示J原图
