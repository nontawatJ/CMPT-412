%% Network defintion
layers = get_lenet();



%% Loading data
fullset = false;
[xtrain, ytrain, xvalidate, yvalidate, xtest, ytest] = load_mnist(fullset);

% load the trained weights
load lenet.mat

%% Testing the network
% Modify the code to get the confusion matrix
confunseMatrix = zeros(10,10);
probs = [];
for i=1:100:size(xtest, 2)
    [~, P] = convnet_forward(params, layers, xtest(:, i:i+99));
    probs = [probs P];
end
[~, idx] = max(probs);
n = length(ytest);

for i=1:n
    confunseMatrix(idx(i), ytest(i)) = confunseMatrix(idx(i), ytest(i))+1;
end
disp(confunseMatrix);