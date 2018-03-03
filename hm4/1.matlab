f = imread('book_cover.jpg');
subplot(1,2,1),imshow(f),title('original');

[m,n]=size(f);
p = 2*m;
q = 2*n;

f = 255*(double(f)-double(min(min(f))))/(double(max(max(f)))-double(min(min(f))));
%p=m;
%q=n;

fp = zeros(p,q);
for x = 1:m
	for y=1:n
		fp(x,y)=f(x,y);
	end
end

for x = 1:p
	for y = 1:q
		F1(x,y)=fp(x,y)*((-1)^(x+y));
	end
end

F = fft2(F1);
%F=fft2(fp);

T = 1;
a = 0.1;
b = 0.1;
pai = pi;
H=zeros(p,q);
for u = 1:p
	for v = 1:q
		H(u,v)=T*sin(pai*((u-m)*a+(v-n)*b))*exp(-1*i*pai*((u-m)*a+(v-n)*b))/(pai*((u-m)*a+(v-n)*b));
	end
end

G=zeros(p,q);
for u=1:p
	for v=1:q
		G(u,v)=H(u,v)*F(u,v);
		if (isnan(G(u,v)))
			G(u,v) = 0;
		end
	end
end

G1 = ifft2(G);
gp=zeros(p,q);
for x = 1:p
	for y = 1:q
		gp(x,y)=real(G1(x,y))*((-1)^(x+y));
	end
end

gr = gp(1:m,1:n);

result = uint8(gr);
result = 255*(double(result)-double(min(min(result))))/(double(max(max(result)))-double(min(min(result))));
result = uint8(result);

subplot(1,2,2),imshow(result),title('blurring filter');
