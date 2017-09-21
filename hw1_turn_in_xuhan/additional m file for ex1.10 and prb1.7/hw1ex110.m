v1 = zeros(1,100000);
vrand = zeros(1,100000);
vmin = zeros(1,100000);
%%%%% space for storage %%%%%
n = 1;   %%%set counter 
%%%%% while loop for 100000 times calculation %%%%%
while n <= 100000
    flip_coin = randi([0 1],10,1000); %% 1000 coin each 10 times
    v1(n) = (sum(flip_coin(:,1)))/10; %% first coin result 
    vrand(n) = (sum(flip_coin(:, randi([2 1000]))))/10; %% random coin result 
    index = find(sum(flip_coin) == min(sum(flip_coin))); %% FInd the minimun results' index 
    vmin(n) = (sum(flip_coin(:,index(1))))/10; %% Pick the first min index and calculate result for v_min
    n = n+1; %% counter renew
end 
%%%%% plot histogram %%%%%
%histogram (v1); 
%figure; dv1; 
%figure; histogram (vmin);
%%%%% for part d %%%%%
%%%calculate the difference%%%
e = (0:0.1:0.5);
pv1 =  [sum(v1 == 0.5),sum(v1 == 0.6) + sum(v1 == 0.4),sum(v1 == 0.7) + sum(v1 == 0.3),sum(v1 == 0.8) + sum(v1 == 0.2),sum(v1 == 0.9) + sum(v1 == 0.1),sum(v1 == 0)]/100000;
pvrand = [sum(vrand == 0.5),sum(vrand == 0.6) + sum(vrand == 0.4),sum(vrand == 0.7) + sum(vrand == 0.3),sum(vrand == 0.8) + sum(vrand == 0.2),sum(vrand == 0.9) + sum(vrand == 0.1),sum(vrand == 0)]/100000;
pvmin = [sum(vmin == 0.5),sum(vmin == 0.6) + sum(vmin == 0.4),sum(vmin == 0.7) + sum(vmin == 0.3),sum(vmin == 0.8) + sum(vmin == 0.2),sum(vmin == 0.9) + sum(vmin == 0.1),sum(vmin == 0)]/100000;;
hof = 2*exp((-2)*(e.^2)*10);
pv1_sum = [pv1(2)+pv1(3)+pv1(4)+pv1(5)+pv1(6),pv1(3)+pv1(4)+pv1(5)+pv1(6),pv1(4)+pv1(5)+pv1(6),pv1(5)+pv1(6),pv1(6),0];
pvrand_sum = [pvrand(2)+pvrand(3)+pvrand(4)+pvrand(5)+pvrand(6),pvrand(3)+pvrand(4)+pvrand(5)+pvrand(6),pvrand(4)+pvrand(5)+pvrand(6),pvrand(5)+pvrand(6),pvrand(6),0];
pvmin_sum = [pvmin(2)+pvmin(3)+pvmin(4)+pvmin(5)+pvmin(6),pvmin(3)+pvmin(4)+pvmin(5)+pvmin(6),pvmin(4)+pvmin(5)+pvmin(6),pvmin(5)+pvmin(6),pvmin(6),0];
plot(e,pv1_sum,e,hof); title('V1 vs Hoeffding Bound');
figure; plot(e,pvrand_sum,e,hof); title('Vrand vs Hoeffding Bound');
figure; plot(e,pvmin_sum,e,hof); title('Vmin vs Hoeffding Bound');