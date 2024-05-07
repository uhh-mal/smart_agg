clc
clear

op=readtable('UTMEnergy1.txt');    %nklk';
op=table2array(op);


for i=1:1:86
    energy_h1=op(i,2:5);
    energy_h2=op(i,6:9);
    en_h3=op(5,10);
    en_h4=op(5,11);
    
    damage_index1=sqrt(sum((energy_h1-op(i,2:5)).^2,2)/sum(energy_h1.^2));
    damage_index2=sqrt(sum((energy_h2-op(i,6:9)).^2,2)/sum(energy_h2.^2));
    d3=sqrt((en_h3-op(i,10)).^2/en_h3.^2);
    d4=sqrt((en_h4-op(i,11)).^2/en_h4.^2);
    
    final=[op(i,1) damage_index1 damage_index2 d3 d4];
    % final(1:4,i)=[];

end

subplot(4,1,1)
plot(final(:,1),final(:,2))
title("Damage Index between ai1 and actuator")
xlabel("Time")
ylabel("Damage Index")

subplot(4,1,2)
plot(final(:,1),final(:,3))
title("Damage Index between ai2 and actuator")
xlabel("Time")
ylabel("Damage Index")

subplot(4,1,3)
plot(final(:,1),final(:,4))
title("Raw Damage Index between ai1 and actuator")
xlabel("Time")
ylabel("Damage Index")

subplot(4,1,4)
plot(final(:,1),final(:,5))
title("Raw Damage Index between ai2 and actuator")
xlabel("Time")
ylabel("Damage Index")