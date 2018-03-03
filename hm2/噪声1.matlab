I = imread('sport car.pgm');
[m,n] = size(I);
t1 = round(256*rand(m,n)); %随机产生0-255的矩阵
t2 = round(256*rand(m,n)); %随机产生0-255的矩阵
t1 = double(t1);
t2 = double(t2);

output = I;  %初始化，用于存放椒盐图像

%产生椒盐图
for i = 1:m 
	for j = 1:n
		if (I(i,j)>t1(i,j)) 
			output(i,j) = 255;
		end
		if (I(i,j)<t2(i,j))
			output(i,j) = 0;
		end
	end
end
imshow(output);

p = 3;
q = 3;
pp = (1+p)/2;
qq = (1+q)/2;
outputP = zeros(m,n);

%已知J图的长和宽都是奇数个像素
for i = 1:m
	for j = 1:n
		temp = zeros(p, q);  %初始化临时矩阵
		%将存在的点改写
		temp(pp,qq) = output(i, j); %中心点一定有值
		
		%存在的点改写
		for r = 1:(pp-1)
			for s = 1:(qq-1)
				if (i-r>0 && j-s>0 && i-r>0 && j-s>0)
					temp(pp-r,qq-s) = output(i-r,j-s);
				end
				if (i-r>0 && j+s>0 && i-r>0 && j+s<=n)
					temp(pp-r,qq+s) = output(i-r,j+s);
				end
				if (i+r>0 && j+s>0 && i+r<=m && j+s<=n)
					temp(pp+r,qq+s) = output(i+r,j+s);
				end
				if (i+r>0 && j-s>0 && i+r<=m && j-s>0)
					temp(pp+r,qq-s) = output(i+r,j-s);
				end
			end
		end
		
		temp = sort(temp);
		outputP(i, j) = temp(2,2);
	end
end

%outputP %打印result

imshow(outputP);
B = medfilt2(output);
imshow(B);
