I = imread('EightAm.png');              %读入图片8am
J = I;                                  %I的副本J
imhist(I);                              %显示I的直方图
imshow(I);                              %显示I原图

[m, n] = size(I);                       %获取I的总像素
A_0 = m * n;
L = 256;                                %灰度级数256

for i = 1 : 256                         %统计各个灰度级的像素数目
[r, c] = find(I == i - 1);              %下标是D_A+1
H_A(i) = length(r); 
end

D_B(1) = H_A(1);                        %算出灰度映射函数
for i = 2 : 256
D_B(i) = D_B(i-1) + H_A(i);
end

D_B = D_B * L / A_0;

for i = 1 : m                           %直方图均衡化
for j = 1 : n                           %将I的像素灰度值映射到J
J(i, j) = D_B(I(i, j)+1);               %下标是D_A+1
end
end

imhist(J);                              %显示J的直方图
imshow(J);                              %显示J原图

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

P = imread('LENA.png');                 %读入图片LENA
Q = P;                                  %P的副本J
imhist(P);                              %显示P的直方图
imshow(P);                              %显示P原图

[a, b] = size(P);                       %获取P的总像素
A_p = a * b;
L = 256;                                %灰度级数256

for i = 1 : 256                         %统计各个灰度级的像素数目
[k, y] = find(P == i - 1);
H_p(i) = length(k);
end

D_p(1) = 0;                             %算出灰度映射函数
for i = 2 : 256
D_p(i) = D_p(i-1) + H_p(i);
end

D_p = D_p * L / A_p;
     
for i = 1 : a                           %直方图均衡化
for j = 1 : b                           %将P的像素灰度值映射到J
Q(i, j) = D_p(P(i, j)+1);
end
end

imhist(Q);                              %显示Q的直方图
imshow(Q);                              %显示Q原图

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i = 1:256                           %从D_p中找出与D_B最相近的数
[temp, index] = min(abs(D_B(i)-D_p));
Xp(i) = index-1;                        %反向映射找到对应灰度值
end

X = I;

for i = 1:m
for j = 1:n
X(i, j) = Xp(I(i, j)+1);                %直方图匹配
end
end

imshow(X);
imhist(X);