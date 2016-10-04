% Preprocess the data and save it as the format that can be read by libsvmread
raw_data = importdata('training.data');
label = raw_data(:, 7);
instance = raw_data(:, 1:6);
for i = 1:6
    col_max = max(instance(:, i));
    col_min = min(instance(:, i));
    instance(:, i) = (instance(:, i) - col_min)/(col_max - col_min);
end;
instance = sparse(instance);
libsvmwrite('processed_train.data', label, instance);

% Use libsvmread and the function will treat the last coloum as the label y
% The libsvmread function is in the libsvm library created by Zhiren Lin in Taiwan University
[yTraining,xTraining] = libsvmread('processed_train.data');
[M,N] = size(xTraining);

% Train:Val:Test = 6:2:2
trainingSize = round(M*0.6);
%valSize = round(M*0.2);
testSize = round(M*0.4);

% Generate the corresponding train\val\test dataset
P = randperm(M);
newyTraining = zeros(trainingSize,1);
newxTraining = zeros(trainingSize,N);
%newyVal = zeros(valSize,1);
%newxVal = zeros(valSize,N);
newyTest = zeros(testSize,1);
newxTest = zeros(testSize,N);
for i = 1:trainingSize
    newyTraining(i) = yTraining(P(i));
    newxTraining(i,:) = xTraining(P(i),:);
end;
%for i = 1:valSize
%    newyVal(i) = yTraining(P(trainingSize+i));
%    newxVal(i,:) = xTraining(P(trainingSize+i),:);
%end;
for i = 1:testSize
    newyTest(i) = yTraining(P(trainingSize+i));
    newxTest(i,:) = xTraining(P(trainingSize+i),:);
end;

my_model = svmtrain(newyTraining,newxTraining);
% Only use the recognitionRate and throw other two outputs
[predict_label, recognitionRate, decision_values] = svmpredict(newyTest, newxTest, my_model);