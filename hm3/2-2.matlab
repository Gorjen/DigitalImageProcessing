f = imread('office.jpg'); %读入图像
%subplot(241),imshow(f),title('original');

f = rgb2gray(f);
%subplot(242),imshow(f),title('gray');

[m,n] = size(f); %求像素
p = 2*m;
q = 2*n;

f = 255*(double(f)-double(min(min(f))))/(double(max(max(f)))-double(min(min(f))));

%填充0
fp = zeros(p, q);
for i = 1:m
	for j = 1:n
		fp(i,j) = f(i,j);
	end
end

%移到中心点
for i = 1:p
	for j = 1:q
		fp(i,j) = fp(i,j)*((-1)^(i+j));
	end
end

%计算dft
F = fft2(fp);

%中心点
cenx = p/2; 
ceny = q/2;

d0 = 0.5;
h = zeros(p,q);
gx = zeros(p,q);
for i = 1:p
	for j = 1:q
		h(i,j) = 1/(1+(d0*d0)/((i-cenx)^2+(j-ceny)^2));
		gx(i,j) = h(i,j)*F(i,j);
	end
end

%dft反变换且取实部
gi = ifft2(gx);

%反中心变换
gp = zeros(p, q);
for i = 1:p
	for j = 1:q
		gp(i,j) = real(gi(i,j))*((-1)^(i+j));
	end
end

%提取子矩阵获得最终结果
gz = gp(1:m,1:n);
g = zeros(m,n);
gz = uint8(gz);
g = 255*(double(gz)-double(min(min(gz))))/(double(max(max(gz)))-double(min(min(gz))));
g = uint8(g);

%显示
%subplot(245),imshow(g),title('d0=40');
imshow(g);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

d0 = 0.4;
h = zeros(p,q);
gx = zeros(p,q);
for i = 1:p
	for j = 1:q
		h(i,j) = 1/(1+(d0*d0)/((i-cenx)^2+(j-ceny)^2));
		gx(i,j) = h(i,j)*F(i,j);
	end
end

%dft反变换且取实部
gi = ifft2(gx);

%反中心变换
gp = zeros(p, q);
for i = 1:p
	for j = 1:q
		gp(i,j) = real(gi(i,j))*((-1)^(i+j));
	end
end

%提取子矩阵获得最终结果
gz = gp(1:m,1:n);
g = zeros(m,n);
gz = uint8(gz);
g = 255*(double(gz)-double(min(min(gz))))/(double(max(max(gz)))-double(min(min(gz))));
g = uint8(g);

%显示
%subplot(245),imshow(g),title('d0=40');
imshow(g);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

d0 = 0.8;
h = zeros(p,q);
gx = zeros(p,q);
for i = 1:p
	for j = 1:q
		h(i,j) = 1/(1+(d0*d0)/((i-cenx)^2+(j-ceny)^2));
		gx(i,j) = h(i,j)*F(i,j);
	end
end

%dft反变换且取实部
gi = ifft2(gx);

%反中心变换
gp = zeros(p, q);
for i = 1:p
	for j = 1:q
		gp(i,j) = real(gi(i,j))*((-1)^(i+j));
	end
end

%提取子矩阵获得最终结果
gz = gp(1:m,1:n);
g = zeros(m,n);
gz = uint8(gz);
g = 255*(double(gz)-double(min(min(gz))))/(double(max(max(gz)))-double(min(min(gz))));
g = uint8(g);

%显示
%subplot(245),imshow(g),title('d0=40');
imshow(g);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

d0 = 1;
h = zeros(p,q);
gx = zeros(p,q);
for i = 1:p
	for j = 1:q
		h(i,j) = 1/(1+(d0*d0)/((i-cenx)^2+(j-ceny)^2));
		gx(i,j) = h(i,j)*F(i,j);
	end
end

%dft反变换且取实部
gi = ifft2(gx);

%反中心变换
gp = zeros(p, q);
for i = 1:p
	for j = 1:q
		gp(i,j) = real(gi(i,j))*((-1)^(i+j));
	end
end

%提取子矩阵获得最终结果
gz = gp(1:m,1:n);
g = zeros(m,n);
gz = uint8(gz);
g = 255*(double(gz)-double(min(min(gz))))/(double(max(max(gz)))-double(min(min(gz))));
g = uint8(g);

%显示
%subplot(245),imshow(g),title('d0=40');
imshow(g);