%设置文件名
num=['1' '2' '3' '4' '5' '6' '7' '8' '9' '0'];
file='att_faces/s';
sla='/';
post='.pgm';

%像素值
filename=[file num(1) sla num(1) post];
tp=imread(filename);
[m,n]=size(tp); 

total=40;
%total=1;
%total=37;
N=7;
M=3;

trainpict=zeros(N*total,m,n);%训练图矩阵
testpict=zeros(M*total,m,n);%测试图矩阵

%读入图片
for i=1:total
	%生成一维矩阵确定训练图和测试图编号
	temp=randperm(10);
	trainp=temp(1:7); %训练
	testp=temp(8:10); %测试
	for j=1:N
        %att_faces/sx中x大于等于10
		if (i/10>1)&&(mod(i,10)>0)
			sx=[num(int8(floor(i/10))) num(mod(i,10))];
		end
		if mod(i,10)==0
			sx=[num(int8(floor(i/10))) num(10)];
		end
		if i/10<1
			sx=num(i);
		end
		filename=[file sx sla num(trainp(j)) post];
        %att_faces/sx/y.pgm中y超过9
		if trainp(j)>9
			px=[num(1) num(10)];
		else
			px=num(trainp(j));
		end
		filename=[file sx sla px post];
		tp=imread(filename);
		trainpict((i-1)*N+j,:,:)=tp;
	end

	for j=1:M
		%att_faces/sx中x大于等于10
		if (i/10>1)&&(mod(i,10)>0)
			sx=[num(int8(floor(i/10))) num(mod(i,10))];
		end
		if mod(i,10)==0
			sx=[num(int8(floor(i/10))) num(10)];
		end
		if i/10<1
			sx=num(i);
		end
		filename=[file sx sla num(testp(j)) post];
        %att_faces/sx/y.pgm中y超过9
		if testp(j)>9
			px=[num(1) num(10)];
		else
			px=num(testp(j));
		end
		filename=[file sx sla px post];
		tp=imread(filename);
		testpict((i-1)*M+j,:,:)=tp;
	end
end

%total=1;

%均值
xmean=zeros(total,m,n);
for i=1:total
	for j=1:N
		xmean(i,:,:)=xmean(i,:,:)+trainpict((i-1)*N+j,:,:)/N;
	end
end
%xmeanp(:,:)=xmean(1,:,:);


%xi均值
ximean=zeros(N*total,m,n);
for i=1:total*N
	ximean(i,:,:)=trainpict(i,:,:)-xmean(int8(ceil(i/N)));
	%ximeanp(:,:)=ximean(i,:,:);
end


%协方差
c=zeros(total,m,m);
for i=1:total
	for j=1:N
		tpp(:,:)=trainpict((i-1)*N+j,:,:); %xi
		xmeanp(:,:)=xmean(i,:,:); %xmean
		midp(i,:,:)=(tpp-xmeanp)*transpose(tpp-xmeanp)/(N-1); %(xi-xmean)*(xi-xmean)T/(N-1)
		c(i,:,:)=c(i,:,:)+midp(i,:,:);
	end
end


%特征维数50-100
k=73;

%特征值特征向量
v=zeros(total,m,m);
d=zeros(total,m,m);
tpp=zeros(m,m);
for i=1:total
	cp(:,:)=c(i,:,:);
    [vp,dp]=eig(cp,'nobalance'); 
    v(i,:,:)=vp(:,:); %特征向量
    d(i,:,:)=dp(:,:); %特征值
end


%前k个最大特征向量
vk=zeros(total,m,k);
for i=1:total
	dp(:,:)=d(i,:,:);
	diad=diag(dp); %对角矩阵对角线元素
	te=sort(diad); 
	maxk=te(m-k); %元素排序找出第k+1个最大的
	index=1;
	for j=1:n
		if diad(j)>maxk
			vkp(:,index)=v(i,:,j); %竖排标号列向量
			index=index+1;
		end
	end
	vk(i,:,:)=vkp(:,:);
end


%aik和ai
aik=zeros(total*N,k,n);
ai=zeros(total*N,m,n);
for i=1:total
	vkp(:,:)=vk(i,:,:);
	vp(:,:)=v(i,:,:);
	for j=1:N
		ximeanp(:,:)=ximean((i-1)*N+j,:,:);
		aikp=transpose(vkp)*ximeanp; %vkT*ximean
		aip=transpose(vp)*ximeanp; %vT*ximean
		aik((i-1)*N+j,:,:)=aikp;
	    ai((i-1)*N+j,:,:)=aip;
	end
end


%特征脸库复原重建
dximean=zeros(total*N,m,n);
for i=1:total
	xmeanp(:,:)=xmean(i,:,:);
	for j=1:N
		%重建ximean
		for t=1:k
			vkp(:,1)=vk(i,:,t); %vk(:,t)
			aikp(1,:)=aik((i-1)*N+j,t,:); %aik(t)
			dximeanp=vkp(:,1)*aikp(1,:);
		end
		dximean((i-1)*N+j,:,:)=dximeanp+xmeanp; %加上减掉的xmean
	end
end

%ddximeanp(:,:)=dximean(1,:,:);
%ddximeanp=uint8(ddximeanp);
%imshow(ddximeanp);


%zpmean
zpmean=zeros(M*total,m,n);
for i=1:total*M
	zpmean(i,:,:)=testpict(i,:,:)-xmean(int8(ceil(i/M)));
	%zpmeanp(:,:)=zpmean(i,:,:);
end


%ap
ap=zeros(total*M,k,n);
for i=1:total
	vkp(:,:)=vk(i,:,:);
	for j=1:M
		zpmeanp(:,:)=zpmean((i-1)*M+j,:,:);
		app=transpose(vkp)*zpmeanp; %vkT*zpmean
		ap((i-1)*M+j,:,:)=app;
	end
end

answer=zeros(M*total,1);


%二范数最小匹配
count=0;
aikk(:,:)=aik(1,:,:);
apk(:,:)=ap(1,:,:);
dif=aikk-apk;
jp=norm(dif)*norm(dif);
jpi=1;
for i=1:M*total
	apk(:,:)=ap(i,:,:);
	for j=1:N*total
		aikk(:,:)=aik(j,:,:);
		dif=aikk-apk;
		tjp=norm(dif)*norm(dif);
		%取最小值
		if tjp<jp
			jp=tjp;
			jpi=j; %最小值的组号
		end
	end
	if int8(ceil(i/M))==int8(ceil(jpi/N)) %组号是否匹配
		count=count+1;
		answer(i)=jpi;
	end
end

%打印正确率
success=count/(M*total);
sprintf('%f',success);
