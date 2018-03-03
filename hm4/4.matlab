subplot(2,2,1),imshow(result2),title('gaussion');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
K = 0.00009;
Wbb1 = zeros(p,q);
for u=1:p
	for v=1:q
		if (isnan(H(u,v)))
			Wbb1(u,v) = F(u,v);
		else
			Wbb1(u,v)=1/H(u,v)*(abs(H(u,v))^2)/(abs(H(u,v))^2+K)*Gb(u,v);
		end
	end
end

Wb1 = ifft2(Wbb1);
for u=1:p
	for v=1:q
		Wb1(u,v) = real(Wb1(u,v))*((-1)^(u+v));
	end
end

result5 = uint8(Wb1(1:m,1:n));
result5 = 255*(double(result5)-double(min(min(result5))))/(double(max(max(result5)))-double(min(min(result5))));
result5 = uint8(result5);
subplot(2,2,2),imshow(result5),title('weiner 0.00009');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
K = 0.0009;
Wbb2 = zeros(p,q);
for u=1:p
	for v=1:q
		if (isnan(H(u,v)))
			Wbb2(u,v) = F(u,v);
		else
			Wbb2(u,v)=1/H(u,v)*(abs(H(u,v))^2)/(abs(H(u,v))^2+K)*Gb(u,v);
		end
	end
end

Wb2 = ifft2(Wbb2);
for u=1:p
	for v=1:q
		Wb2(u,v) = real(Wb2(u,v))*((-1)^(u+v));
	end
end

result6 = uint8(Wb2(1:m,1:n));
result6 = 255*(double(result6)-double(min(min(result6))))/(double(max(max(result6)))-double(min(min(result6))));
result6 = uint8(result6);
subplot(2,2,3),imshow(result6),title('weiner 0.0009');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
K = 0.009;
Wbb3 = zeros(p,q);
for u=1:p
	for v=1:q
		if (isnan(H(u,v)))
			Wbb3(u,v) = F(u,v);
		else
			Wbb3(u,v)=1/H(u,v)*(abs(H(u,v))^2)/(abs(H(u,v))^2+K)*Gb(u,v);
		end
	end
end

Wb3 = ifft2(Wbb3);
for u=1:p
	for v=1:q
		Wb3(u,v) = real(Wb3(u,v))*((-1)^(u+v));
	end
end

result7 = uint8(Wb3(1:m,1:n));
result7 = 255*(double(result7)-double(min(min(result7))))/(double(max(max(result7)))-double(min(min(result7))));
result7 = uint8(result7);
subplot(2,2,4),imshow(result7),title('weiner 0.009');
