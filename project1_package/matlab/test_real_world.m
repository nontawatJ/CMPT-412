% Network defintion
layers = get_lenet();
load lenet.mat

for i = 1:size(layers,2)
    layers{i}.batch_size = 10;
end

%loading data
img_1 = double(reshape(transpose(rgb2gray(imread('../images/img_1.png'))),784,1));
img_2 = double(reshape(transpose(rgb2gray(imread('../images/img_2.png'))),784,1));
img_3 = double(reshape(transpose(rgb2gray(imread('../images/img_3.png'))),784,1));
img_4 = double(reshape(transpose(rgb2gray(imread('../images/img_4.png'))),784,1));
img_5 = double(reshape(transpose(rgb2gray(imread('../images/img_5.png'))),784,1));
img_6 = double(reshape(transpose(rgb2gray(imread('../images/img_6.png'))),784,1));
img_7 = double(reshape(transpose(rgb2gray(imread('../images/img_7.png'))),784,1));
img_8 = double(reshape(transpose(rgb2gray(imread('../images/img_8.png'))),784,1));
img_9 = double(reshape(transpose(rgb2gray(imread('../images/img_9.png'))),784,1));
img_10 = double(reshape(transpose(rgb2gray(imread('../images/img_10.png'))),784,1));


% Testing the network
confunseMatrix = zeros(10,10);
probs = [];
ytest = 1:10;

[output, P] = convnet_forward(params, layers, [img_1,img_2,img_3,img_4,img_5,img_6,img_7,img_8,img_9,img_10]);
probs = [probs P];
[~, idx] = max(probs);

for i=1:10
    confunseMatrix(ytest(i), idx(i)-1) = 1;
end
disp(confunseMatrix);



