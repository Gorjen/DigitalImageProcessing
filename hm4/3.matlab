subplot(2,2,1),imshow(result),title('blurred');

for u=1:p
	for v = 1:q
		Fb1(u,v) = G(u,v)/H(u,v);
		if (isnan(Fb1(u,v)))
			Fb1(u,v) = F(u,v);
		end
	end
end

Fb=ifft2(Fb1);
for u=1:p
	for v=1:q
		Fb2(u,v)=real(Fb(u,v))*((-1)^(u+v));
	end
end

result3 = uint8(Fb2(1:m,1:n));
result3 = 255*(double(result3)-double(min(min(result3))))/(double(max(max(result3)))-double(min(min(result3))));
result3 = uint8(result3);

subplot(2,2,2),imshow(result3),title('inversed blurred');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

subplot(2,2,3),imshow(result2),title('gaussion');
%subplot(223),imhist(result);

for u=1:p
	for v=1:q
		if (sqrt((u-m)^2+(v-n)^2)<150)
			Gbb(u,v) = Gb(u,v)/H(u,v);
		else
			Gbb(u,v) = Gb(u,v);
		end
		if (isnan(Gbb(u,v)))
			Gbb(u,v) = F(u,v);
		end
	end
end

Hb = zeros(p,q);
d0 = 15;
for x=1:p
	for y=1:q
		d = (x-m)^2+(y-n)^2;
		Hb(x,y) = 1/(1+(d/d0)^20);
	end
end

for u=1:p
	for v=1:q
		Gbb(u,v) = Gbb(u,v)*Hb(u,v);
	end
end

Fbg=ifft2(Gbb);
for u=1:p
	for v=1:q
		Fbg2(u,v)=real(Fbg(u,v))*((-1)^(u+v));
	end
end

result4 = uint8(Fbg2(1:m,1:n));
result4 = 255*(double(result4)-double(min(min(result4))))/(double(max(max(result4)))-double(min(min(result3))));
result4 = uint8(result4);

subplot(2,2,4),imshow(result4),title('inversed gaussion');
%subplot(224),imhist(result4);
