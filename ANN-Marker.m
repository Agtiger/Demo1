

clc
clear all

%****************************%
%****************************%
%****************************%

[Model_CMC,PathName] = uigetfile('*.m','Select path for the main program:');
addname='flat';
filepath=strcat(PathName,addname);
%文件中只有txt文件才行
file_structure = dir(filepath);
MAT=size(file_structure);
N=MAT(1);
STR=cell(N-2,1);

% mkdir normalizedata
% ProcessData='normalizedata';
% fileoutpath=strcat(PathName,ProcessData);

for i=3:N
    filename = file_structure(i).name;                 % stract 连接字符串
    STR{i-2,1}=filename(1:end-4);
   
    STR{i-2,1}=strcat(STR{i-2,1});
end
    
    
[NN,mm]=size(cellstr(STR));
input=[];
output=[];
for i=1:NN

  file=char(STR(i)); 
  filetype='.xls';
  filename=strcat(file,filetype);
  cd (filepath)
  Da=xlsread(filename,1);  
 a=Da(:,1:6);
 b=Da(:,16:20);
 [M,N]=size(a);


input=[input;a];
output=[output;b];
%  NUM2(:,j-1)=A;   
end

input11=input';
output22=output';

input111=input11(:,1:101);
output111=output22(1,1:101);

% a=1:1:3131;
% plot(a,output22);
% hold on
% plot(a,output11111);

% ANN
net = fitnet(10,'trainbr');
view(net)
net = train(net,input11,output22);
save net
P=input11(:,1:101);
R=output22(1,1:101);
A=sim(net,P)

figure(1)
plot(A','b');
hold on 
plot(R,'r')
