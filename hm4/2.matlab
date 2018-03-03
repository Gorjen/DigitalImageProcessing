subplot(1,2,1),imshow(result),title('blurred');
%tp = imnoise(result, 'gaussian',0, 500/(m*n));
%subplot(1,2,1),imshow(tp),title('blurred');

va = 500/(m*n);
noise = va.*randn(m,n);

noise1=zeros(p,q);
for x=1:m
	for y=1:n
		noise1(x,y)=noise(x,y);
	end
end
for x=1:p
	for y=1:q
		noise1(x,y)=noise1(x,y)*((-1)^(x+y));
	end
end

N=fft2(noise1);
%subplot(1,1,1),hist(noise),title('gaussian noise');

Gb=zeros(p,q);
for u=1:p
	for v=1:q
		Gb(u,v)=F(u,v)*H(u,v)+N(u,v);
	%	Gb(u,v)=F(u,v)+N(u,v);
		if (isnan(Gb(u,v)))
			Gb(u,v)=F(u,v);
		end
	end
end

Gb3 = ifft2(Gb);
Gb4=zeros(p,q);
for x=1:p
	for y = 1:q
		Gb4(x,y)=real(Gb3(x,y))*((-1)^(x+y));
	end
end
Gb5=Gb4(1:m,1:n);

result2 = uint8(Gb5);

result2 = 255*(double(result2)-double(min(min(result2))))/(double(max(max(result2)))-double(min(min(result2))));
result2 = uint8(result2);

subplot(1,2,2),imshow(result2),title('gaussian noise');
