A = imread('/media/fernando/DATA/PhD/00 Edge aware filter/Image Fusion/ours/results/MFF_Kid_I1.png');
B = imread('/media/fernando/DATA/PhD/00 Edge aware filter/Image Fusion/ours/results/MFF_kid_I2.png');
GFF = imread('/media/fernando/DATA/PhD/00 Edge aware filter/Image Fusion/ours/results/MFF_kid_GFF.png');
GFDF = imread('/media/fernando/DATA/PhD/00 Edge aware filter/Image Fusion/ours/results/MFF_kid_GFDF.png');
GDIF = imread('/media/fernando/DATA/PhD/00 Edge aware filter/Image Fusion/ours/results/MFF_kid_GDIF.png');
Ours = imread('/media/fernando/DATA/PhD/00 Edge aware filter/Image Fusion/ours/results/MFF_kid_ours.png');

Eval(1,:)=EvalFusion(A,B,GFF);
Eval(2,:)=EvalFusion(A,B,GFDF);
Eval(3,:)=EvalFusion(A,B,GDIF);
Eval(4,:)=EvalFusion(A,B,Ours);
Eval
A = imread('/media/fernando/DATA/PhD/00 Edge aware filter/Image Fusion/ours/results/MFF_book_I1.png');
B = imread('/media/fernando/DATA/PhD/00 Edge aware filter/Image Fusion/ours/results/MFF_book_I2.png');
GFF = imread('/media/fernando/DATA/PhD/00 Edge aware filter/Image Fusion/ours/results/MFF_book_GFF.png');
GFDF = imread('/media/fernando/DATA/PhD/00 Edge aware filter/Image Fusion/ours/results/MFF_book_GFDF.png');
GDIF = imread('/media/fernando/DATA/PhD/00 Edge aware filter/Image Fusion/ours/results/MFF_book_GDIF.png');
Ours = imread('/media/fernando/DATA/PhD/00 Edge aware filter/Image Fusion/ours/results/MFF_book_ours.png');

Eval(5,:)=EvalFusion(A,B,GFF);
Eval(6,:)=EvalFusion(A,B,GFDF);
Eval(7,:)=EvalFusion(A,B,GDIF);
Eval(8,:)=EvalFusion(A,B,Ours);
Eval
A = imread('/media/fernando/DATA/PhD/00 Edge aware filter/Image Fusion/ours/results/MFF_flower_I1.png');
B = imread('/media/fernando/DATA/PhD/00 Edge aware filter/Image Fusion/ours/results/MFF_flower_I2.png');
GFF = imread('/media/fernando/DATA/PhD/00 Edge aware filter/Image Fusion/ours/results/MFF_flower_GFF.png');
GFDF = imread('/media/fernando/DATA/PhD/00 Edge aware filter/Image Fusion/ours/results/MFF_flower_GFDF.png');
GDIF = imread('/media/fernando/DATA/PhD/00 Edge aware filter/Image Fusion/ours/results/MFF_flower_GDIF.png');
Ours = imread('/media/fernando/DATA/PhD/00 Edge aware filter/Image Fusion/ours/results/MFF_flower_ours.png');

Eval(9,:)=EvalFusion(A,B,GFF );
Eval(10,:)=EvalFusion(A,B,GFDF);
Eval(11,:)=EvalFusion(A,B,GDIF );
Eval(12,:)=EvalFusion(A,B,Ours);

Eval