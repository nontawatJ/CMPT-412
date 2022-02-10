%define network
layers = get_lenet(); 
load lenet.mat;
layer{1}.batch_size = 1;
    
%loading data (change to gray and remove background)
img_1 = im2bw(rgb2gray(imread('../images/image1.JPG')));
img_2 = im2bw(rgb2gray(imread('../images/image2.JPG')));
img_3 = im2bw(rgb2gray(imread('../images/image3.png')));
img_4 = im2bw(rgb2gray(imread('../images/image4.jpg')));


%getting conected component and create boundary box
[L1, num_1] = bwlabel(1.-img_1); 
bboxes_1 = regionprops(L1,'BoundingBox');
figure; imshow(img_1);
hold on 
    for k = 1: length(bboxes_1)
        CurrBB_1 = bboxes_1(k).BoundingBox;
        rectangle('Position',[CurrBB_1(1),CurrBB_1(2),CurrBB_1(3),CurrBB_1(4)], 'EdgeColor', 'r', 'LineWidth',2)
    end
hold off

[L2, num_2] = bwlabel(1.-img_2); 
bboxes_2 = regionprops(L2,'BoundingBox');
figure; imshow(img_2);
hold on 
    for k = 1: length(bboxes_2)
        CurrBB_2 = bboxes_2(k).BoundingBox;
        rectangle('Position',[CurrBB_2(1),CurrBB_2(2),CurrBB_2(3),CurrBB_2(4)], 'EdgeColor', 'r', 'LineWidth',2)
    end
hold off

[L3, num_3] = bwlabel(1.-img_3); 
bboxes_3 = regionprops(L3,'BoundingBox');
figure; imshow(img_3);
hold on 
    for k = 1: length(bboxes_3)
        CurrBB_3 = bboxes_3(k).BoundingBox;
        rectangle('Position',[CurrBB_3(1),CurrBB_3(2),CurrBB_3(3),CurrBB_3(4)], 'EdgeColor', 'r', 'LineWidth',2)
    end
hold off

[L4, num_4] = bwlabel(1.-img_4); 
bboxes_4 = regionprops(L4,'BoundingBox');
figure; imshow(img_4);
hold on 
    for k = 1: length(bboxes_4)
        CurrBB_4 = bboxes_4(k).BoundingBox;
        rectangle('Position',[CurrBB_4(1),CurrBB_4(2),CurrBB_4(3),CurrBB_4(4)], 'EdgeColor', 'r', 'LineWidth',2)
    end
hold off






    
   
    
    




    
    
    

