I = imread('car.png');  %开car
imhist(I);
imshow(I);
I = double(I); %类型转换，防止后面乘出来只有255

J = imread('wheel.png');  %开wheel
imhist(J);
imshow(J);
J = double(J); %类型转换，防止后面乘出来只有255

[m, n] = size(I);  %获取car总像素
[p, q] = size(J);  %获取wheel总像素

temp = zeros(p, q);  %初始化临时矩阵
result = zeros(m, n);  %初始化结果矩阵
pp = (1+p)/2;
qq = (1+q)/2;

%已知J图的长和宽都是奇数个像素
for i = 1:m
	for j = 1:n
		%将存在的点改写
		temp(pp,qq) = I(i, j); %中心点一定有值
		
		%存在的点改写
		for r = 1:(pp-1)
			for s = 1:(qq-1)
				if (i-r>0 && j-s>0 && i-r>0 && j-s>0)
					temp(pp-r,qq-s) = I(i-r,j-s);
				end
				if (i-r>0 && j+s>0 && i-r>0 && j+s<=n)
					temp(pp-r,qq+s) = I(i-r,j+s);
				end
				if (i+r>0 && j+s>0 && i+r<=m && j+s<=n)
					temp(pp+r,qq+s) = I(i+r,j+s);
				end
				if (i+r>0 && j-s>0 && i+r<=m && j-s>0)
					temp(pp+r,qq-s) = I(i+r,j-s);
				end
			end
		end
		
		%计算相关值
		for x = 1:p
			for y = 1:q
				result(i,j) = result(i,j) + temp(x,y)*J(x,y);
			end
		end
		temp = zeros(p, q);  %初始化临时矩阵
	end
end

result %打印result
[a,b] = find(result==max(result(:)));  %找最大相关值
a   %打印a
b   %打印b
