clc;
clear all;
close all;
t=dir('images');
%t1=struct2cell(t);
%t2=t1(1,3:end);
h=waitbar(0,'reading image');

for i=1:1:76%length(t2)
    waitbar(i/86);
    %disp(t2{i});
    if(i<10)
    im=imresize(imread(strcat('F:\DATA\mt_p\images\diaretdb1_image00',strcat(int2str(i),'.png'))),[533 720]);
    else
    im=imresize(imread(strcat('F:\DATA\mt_p\images\diaretdb1_image0',strcat(int2str(i),'.png'))),[ 533 720]);
    end
    rs_x=150;
    rs_y=120;
    I3 = imcrop(im,[80 95 rs_x rs_y]);
    subplot(2,2,1);
    imshow(im);
    subplot(2,2,2);
    imshow(I3);
    I4 = im2bw(I3,.40);
    subplot(2,2,3);
    imshow(I4);
    c(i)=0;
    for j=1:rs_y
        for k=1:rs_x
        if I4(j,k)==0
            c(i)=c(i)+1;
        end
        end
    end
    

    if c(i)>19000
    disp('Hemorrhage'),disp(int2str(i));
    %disp('c----'),disp(c);

    else
    disp('not Hemorrhage'),disp(int2str(i));    
    %disp('c----'),disp(c);
    I5=rgb2gray(I3);
    subplot(2,2,4);
    imshow(I5);
    m(i)=mean2(I5);
    s(i)=std2(I5);    
    end
    end
    close(h);
    
    p=[c;m;s];
    disp(size(p));
    p1=p';
    %1---not
    %0---suffering
    t=[0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 1 1 1 1 1 1 1 1 1 1 0 0 0 0 1 1 1 1 1 1 1 1 1 ];
    t1=t';
    net = newff(p,t,[3,1],{'tansig','purelin'});
    net.trainParam.epochs=10;
    net.trainParam.goal=.01;
    disp('----p----'),disp(p);
    disp('----t----'),disp(t);
    net=train(net,p,t);
    save('train.mat','net');
    

