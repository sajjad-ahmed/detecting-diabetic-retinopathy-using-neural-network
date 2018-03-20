clear;
clc;
close all;
load('train.mat');
%I2=imresize(imread('F:\DATA\mt_p\neg.png'),[ 533 720]);
I2=imresize(imread('F:\DATA\mt_p\pos.png'),[ 533 720]);


rs_x=150;
rs_y=120;
I3 = imcrop(I2,[50 45 rs_x rs_y]);
subplot(2,2,1);
imshow(I2)
subplot(2,2,2);
imshow(I3)
I4=im2bw(I3,.40);
subplot(2,2,3);
imshow(I4)
[j,k]=size(I4);
c=0;
    for j=1:rs_y
        for k=1:rs_x
        if I4(j,k)==0
            c=c+1;
        end
        end
    end
    
    if c>19000
    disp('Hemorrhage');
    %disp('c----'),disp(c);

    else
    disp('not Hemorrhage');    
    %disp('c----'),disp(c);
    I5=rgb2gray(I3);
    subplot(2,2,4);
    imshow(I5);
    m=mean2(I5);
    s=std2(I5); 
    p=[c;m;s];
    y=sim(net,p);
    A=10.*y;
    round(A);
    disp(A);
    
    if A<5.8
        disp('not normal')
    else
        disp('normal')
        
    end
    end