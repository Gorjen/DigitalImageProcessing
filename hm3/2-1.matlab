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

%防止0出现
fq = zeros(p,q);
ft = zeros(p,q);
for i = 1:p
	for j = 1:q
		fq(i,j) = fp(i,j)+1;
		ft(i,j) = log(fq(i,j));
	end
end

%移到中心点
for i = 1:p
	for j = 1:q
		ft(i,j) = ft(i,j)*((-1)^(i+j));
	end
end

%计算dft
F = fft2(ft);

%中心点
cenx = p/2; 
ceny = q/2;
yh = 2.0;
yl = 0.25;
c = 1.0;

d0 = 1.25;
h = zeros(p,q);
gz = zeros(p,q);
for i = 1:p
	for j = 1:q
		h(i,j) = (yh-yl)*(1-exp((-c)*((i-cenx)^2+(j-ceny)^2)/(d0*d0)))+yl;
		gz(i,j) = h(i,j)*F(i,j);
	end
end

%dft反变换且取实部
gi = ifft2(gz);

%反中心变换
gp = zeros(p, q);
for i = 1:p
	for j = 1:q
		gp(i,j) = real(exp(gi(i,j))*((-1)^(i+j)))-1;
	end
end

%提取子矩阵获得最终结果
gd = gp(1:m,1:n);
gd = uint8(gd);
gx = zeros(m,n);
gx = 255*(double(gd)-double(min(min(gd))))/(double(max(max(gd)))-double(min(min(gd))));
g = uint8(gx);

%显示
%subplot(245),imshow(g),title('d0=40');
imshow(g);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

d0 = 3;
h = zeros(p,q);
gz = zeros(p,q);
for i = 1:p
	for j = 1:q
		h(i,j) = (yh-yl)*(1-exp((-c)*((i-cenx)^2+(j-ceny)^2)/(d0*d0)))+yl;
		gz(i,j) = h(i,j)*F(i,j);
	end
end

%dft反变换且取实部
gi = ifft2(gz);

%反中心变换
gp = zeros(p, q);
for i = 1:p
	for j = 1:q
		gp(i,j) = real(exp(gi(i,j))*((-1)^(i+j)))-1;
	end
end

%提取子矩阵获得最终结果
gd = gp(1:m,1:n);
gd = uint8(gd);
gx = zeros(m,n);
gx = 255*(double(gd)-double(min(min(gd))))/(double(max(max(gd)))-double(min(min(gd))));
g = uint8(gx);
imshow(g);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

d0 = 1.3;
h = zeros(p,q);
gz = zeros(p,q);
for i = 1:p
	for j = 1:q
		h(i,j) = (yh-yl)*(1-exp((-c)*((i-cenx)^2+(j-ceny)^2)/(d0*d0)))+yl;
		gz(i,j) = h(i,j)*F(i,j);
	end
end

%dft反变换且取实部
gi = ifft2(gz);

%反中心变换
gp = zeros(p, q);
for i = 1:p
	for j = 1:q
		gp(i,j) = real(exp(gi(i,j))*((-1)^(i+j)))-1;
	end
end

%提取子矩阵获得最终结果
gd = gp(1:m,1:n);
gd = uint8(gd);
gx = zeros(m,n);
gx = 255*(double(gd)-double(min(min(gd))))/(double(max(max(gd)))-double(min(min(gd))));
g = uint8(gx);

%显示
imshow(g);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
d0 = 1.2;
h = zeros(p,q);
gz = zeros(p,q);
for i = 1:p
	for j = 1:q
		h(i,j) = (yh-yl)*(1-exp((-c)*((i-cenx)^2+(j-ceny)^2)/(d0*d0)))+yl;
		gz(i,j) = h(i,j)*F(i,j);
	end
end

%dft反变换且取实部
gi = ifft2(gz);

%反中心变换
gp = zeros(p, q);
for i = 1:p
	for j = 1:q
		gp(i,j) = real(exp(gi(i,j))*((-1)^(i+j)))-1;
	end
end

%提取子矩阵获得最终结果
gd = gp(1:m,1:n);
gd = uint8(gd);
gx = zeros(m,n);
gx = 255*(double(gd)-double(min(min(gd))))/(double(max(max(gd)))-double(min(min(gd))));
g = uint8(gx);

%显示
imshow(g);