% Experiment - 1 and 2 (Plottting Histogram and Validating Zipf's Law)
% IT-309 Lab Work
% Author- Vishal Gaur
% ID    - 201752043
%
%
% Here, file =   wordcountres.txt   contains output for the WordCount
% Program.
% 

filename = 'wordcountres.txt';
% importing data
B = importdata(filename);
o = [B.textdata num2cell(B.data)];

% sorting according to rank - most frequent = Rank  -1
r = sortrows(o,2,'descend');

% plotting histogram for top 50 most frequent words.
fiftyrows = r(1:50,:);
hy = cell2mat(fiftyrows(:,2));
hx = categorical(fiftyrows(:,1));
hx = reordercats(hx, fiftyrows(:,1));

% figure-1 for histogram
figure(1);
bar(hy);
% to get what is word corresponding to the bar
% bar(hx,hy);
title("Top 50 most frequent words");
xlabel('Words');
ylabel('Count');

% zipf's law
% For less computation, we have choose top 10000 ranks. Because, The code
% was taking lot of time for computation.

y = cell2mat(r(1:10000,2));
y = y.';
l = length(y);
zy = zeros(1,l);
zx = zeros(1,l);

% get slope intercept, least square fit
sumx=0.0;
sumy=0.0;
sumxy=0.0;
sumx2=0.0;
sumy2=0.0;
numOfRanks=l;

for i = 1:10000
    sumx =sumx+ log(i);
    sumy =sumy+ log(y(1,i));
    sumxy =sumxy+ log(i) * log(y(1,i));
    sumx2 =sumx2+ log(i)*log(i);
    sumy2 =sumy2+ log(y(1,i))*log(y(1,i));
end

% Calculating SLOPE
if ((numOfRanks*sumx2)-(sumx*sumx)) == 0.0
    slp=0.0;
else
    slp = ((numOfRanks*sumxy)-(sumx*sumy)) / ((numOfRanks*sumx2)-(sumx*sumx));
end

% Calculating Least Square fit
if sqrt(((numOfRanks * sumx2) - (sumx * sumx)) * ((numOfRanks * sumy2) - (sumy * sumy))) == 0.0
    r2 = 0.0;
else
    r = ((numOfRanks * sumxy) - (sumx * sumy)) / sqrt(((numOfRanks * sumx2) - (sumx * sumx)) * ((numOfRanks * sumy2) - (sumy * sumy)));
    r2 = r * r;
end

% Calculating INTERCEPT
yint = (sumy-(slp*sumx))/numOfRanks;

% plot the curve for zipf's law

for i = 1:10000
    zx(1,i) = log(i);
    zy(1,i) = log(y(1,i));
end

% figure-2 for zipf's law
figure(2);
plot(zx,zy);
title("Zipf's Law");
xlabel('log10 rank');
ylabel('log10 cf');
hold on
plot(zx, (yint-zx));
legend({'Original Curve','Curve with slope -1'}, 'Location', 'best')
hold off
