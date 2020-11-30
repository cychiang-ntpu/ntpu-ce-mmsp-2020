clear;
system('rm -f *.bmp');
W = 8;
H = 8;
% x = zeros(H,W);
% w = 0:1:(W-1);
% for k=0:1:(W/2)
%     x = zeros(H,W);
%     for h=1:1:H
%         x(h,:) = round(127.5 + 127.5*cos(2*pi*k*w/W));
%     end
%     bmp_x = uint8(x);
%     fn = sprintf('cos(2pikx_W)_k=%d.bmp', k);
%     imwrite(bmp_x, fn);
% end


% x = zeros(H,W);
% h = 0:1:(H-1);
% for k=0:1:(H/2)
%     x = zeros(H,W);
%     for w=1:1:W
%         x(:,w) = round(127.5 + 127.5*cos(2*pi*k*h/W))';
%     end
%     bmp_x = uint8(x);
%     fn = sprintf('cos(2piky_W)_k=%d.bmp', k);
%     imwrite(bmp_x, fn);
% end


x = zeros(H,W);
basis_vector = zeros(H,W,H,W);
for u=0:1:(H-1)
    for v=0:1:(W-1)
        x = zeros(H,W);
        for r=0:1:(H-1)
            for c=0:1:(W-1)
                basis_vector(r+1, c+1, u+1, v+1) = cos(pi*u*(2*r+1)/2/H) * cos(pi*v*(2*c+1)/2/W);
                x(r+1, c+1) = 127.5 + 127.5 * basis_vector(r+1, c+1, u+1, v+1);
            end
            bmp_x = uint8(x);
            fn = sprintf('basis(u=%d,v=%d).bmp', u, v);
            imwrite(bmp_x, fn);
        end        
    end    
end

houses = imread('../houses.bmp');
f = houses(:,:,1);
figure(1);
imshow(f);
M = 512/H;
N = 512/W;

F = zeros(H,W,M,N);
beta = ones(H,1);
beta(1,1) = 1/sqrt(2);
for m=1:1:M
    for n=1:1:N
        target_8x8 = double(f(((m-1)*H+1):(m*H),((n-1)*W+1):(n*W)));
        for u=0:1:(H-1)
            for v=0:1:(W-1)
                F(u+1, v+1, m, n) = 2 / sqrt(H*W) * beta(u+1) * beta(v+1) ...
                    * sum(sum((target_8x8 .* basis_vector(:,:,u+1, v+1))));
            end
        end
%         figure(3);
%         subplot(9,8,1);
%         imshow(target_8x8, [0 255]);
%         for u=1:1:8
%             for v = 1:1:8
%                 basis_img = round(2 / sqrt(H*W) * beta(u) * beta(v) * basis_vector(:,:,u, v)*F(u, v, m, n));
%                 basis_img = uint8(basis_img);
%                 subplot(9,8,u*8+v);
%                 if u==1 && v==1
%                     imshow(basis_img, [0 255]);
%                 else
%                     imshow(basis_img, [-128 127]);
%                 end
%             end
%         end
%         
%         figure(4);
%         subplot(9,8,1);
%         imshow(target_8x8, [0 255]);
%         for u=1:1:8
%             for v = 1:1:8
%                 basis_img = round(2 / sqrt(H*W) * beta(u) * beta(v) * basis_vector(:,:,u, v)*F(u, v, m, n));
%                 basis_img = uint8(basis_img);
%                 subplot(9,8,u*8+v);
%                 if u==1 && v==1
%                     imshow(basis_img, [0 255]);
%                 else
%                     imshow(basis_img, [min(min(basis_img)) max(max(basis_img))]);
%                 end
%             end
%         end
        
        
        
        
    end
end

Q = zeros(8,8);
Q = [16 11 10 16 24 40 51 61;
     12 12 14 19 26 58 60 55;
     14 13 16 24 40 57 69 56;
     14 17 22 29 51 87 80 62;
     18 22 37 56 68 109 103 77;
     24 35 55 64 81 104 113 92;
     49 64 78 87 103 121 120 101;
     72 92 95 98 112 100 103 99];
 
 for m=1:1:M
    for n=1:1:N
        F(:,:,m,n) = round(F(:,:,m,n) ./ Q);
        F(:,:,m,n) = F(:,:,m,n) .* Q;
    end
 end

f_hat = zeros(512,512);
H_max = 8;
W_max = 8;
for m=1:1:M
    for n=1:1:N
        for u=0:1:(H_max-1)
            for v=0:1:(W_max-1)
                f_hat(((m-1)*H+1):(m*H),((n-1)*W+1):(n*W)) = ...
                    f_hat(((m-1)*H+1):(m*H),((n-1)*W+1):(n*W)) + ...
                    2 / sqrt(H*W) * beta(u+1) * beta(v+1) * ...
                    F(u+1, v+1, m, n) * basis_vector(:,:,u+1, v+1);
            end
        end
    end
end
f_hat = uint8(f_hat);
figure(2);
imshow(f_hat);

