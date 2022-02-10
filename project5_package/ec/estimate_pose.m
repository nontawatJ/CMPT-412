function P = estimate_pose(x, X)
% ESTIMATE_POSE computes the pose matrix (camera matrix) P given 2D and 3D
% points.
%   Args:
%       x: 2D points with shape [2, N]
%       X: 3D points with shape [3, N]

N = size(x, 2);
N_min = 4;
xT = x.';
XT = X.';
XHomo = [XT ones(N, 1)].';
inlierIndsBest = [];
ite = 100;
maxErr = 20; 

for i=1:ite
    randI = randperm(N, N_min);
    P = computeP(xT(randI, :), XT(randI, :));
    xProj = P * XHomo;
    xProj = xProj(1:2,:)./repmat(xProj(3,:), 2, 1);
    err = sqrt(sum((xProj-x).^2)).'; 
    inlierInds = find(err <= maxErr);
    if length(inlierInds) > length(inlierIndsBest)
        inlierIndsBest = inlierInds;
    end
end

P = computeP(xT(inlierIndsBest, :), XT(inlierIndsBest, :));

end

function P = computeP(xT, XT)

N = size(xT, 1);

%normalize 2d
N2d = size(xT, 1);
mu2d = mean(xT);
sigma2d = std(xT - repmat(mu2d, N2d, 1));
T2d = [1/sigma2d(1) 0 mu2d(1)/sigma2d(1); 0 1/sigma2d(2) mu2d(2)/sigma2d(2); 0 0 1];
xNorm = [xT ones(N2d, 1)] * T2d.';
xNorm = xNorm(:, 1:2);

%normalize 3d
N3d = size(XT, 1);
mu3d = mean(XT);
sigma3d = std(XT - repmat(mu3d, N3d, 1));
T3d = [1/sigma3d(1) 0 0 mu3d(1)/sigma3d(1); 0 1/sigma3d(2) 0 mu3d(2)/sigma3d(2); 0 0 1/sigma3d(3) mu3d(3)/sigma3d(3); 0 0 0 1];
XNorm = [XT ones(N3d, 1)] * T3d.';
XNorm = XNorm(:, 1:3);

x1 = xNorm(:,1);
y1 = xNorm(:,2);

%get P
A1 = [zeros(N, 4) -XNorm -ones(N, 1) y1.*XNorm y1.*ones(N, 1)];
A2 = [XNorm ones(N, 1) zeros(N, 4) -x1.*XNorm -x1.*ones(N, 1)];
A = [A1; A2];
[~, ~, V] = svd(A);
P = reshape(V(:,end),4,3).';
P = P/P(end);
P = inv(T2d) * P * T3d;

end
