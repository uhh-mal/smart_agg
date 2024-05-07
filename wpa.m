clc
clear

files=ls;
files([1,2,89],:)=[];

filea=[];
op=[];

for i=1:1:86
    fprintf("File being processed: %i",i);
    % Specify the file path
    file_path = convertCharsToStrings(files(i,:));
    filea=[filea;file_path];

     % Read the DAT file into a table
    data_table = readtable(file_path);
    data_table(1:3,:) = [];

    level=3;
    ai1=table2array(data_table(:,2));
    ai2=table2array(data_table(:,3));
    [c1, l1]=wavedec(ai1,level,'db6');
    [c2, l2]=wavedec(ai2,level,'db6');
    approx1= appcoef(c1,l1,'db6');
    approx2= appcoef(c2,l2,'db6');
    [d11 d21 d31]=detcoef(c1,l1,[1 2 3]);
    [d12 d22 d32]=detcoef(c2,l2,[1 2 3]);

    eap1=sum(abs(approx1).^2);
    e11=sum(abs(d11).^2);
    e21=sum(abs(d21).^2);
    e31=sum(abs(d31).^2);

    eap2=sum(abs(approx2).^2);
    e12=sum(abs(d12).^2);
    e22=sum(abs(d22).^2);
    e32=sum(abs(d32).^2);

    en1=sum(abs(ai1).^2);
    en2=sum(abs(ai2).^2);

    row=[eap1 e11 e21 e31 eap2 e12 e22 e32 en1 en2]; 
    op=[op;row];
end

filea=replace(filea,'4_16_','');
filea=replace(filea,'.dat','');
filea=replace(filea,'_',':');
t=seconds(duration(filea));
t=t-min(t);
op=sortrows([t op]);
optable=array2table(op);

writetable(optable,'..\dwt tables\utm\UTMEnergy1.txt')
