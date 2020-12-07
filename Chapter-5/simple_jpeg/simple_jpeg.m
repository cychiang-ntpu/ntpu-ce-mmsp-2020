clear;
system('rm -f *.bmp');

W = 8; % dimension of basis vector (width)
H = 8; % dimension of basis vector (height)

%% generate basis vector for 2D-DCT
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

%% read image
houses = imread('../houses.bmp');
f = houses(:,:,1); % spatial domain 
figure(1);
imshow(f);
M = 512/H;
N = 512/W;


%% ------- Encoder ------- %% 

%% 2D-DCT
F = zeros(H,W,M,N); % frequnecy domain. M: # of blocks vertically.
                    % N: # of blocks horizontallly
beta = ones(H,1);
beta(1,1) = 1/sqrt(2);
for m=1:1:M % loop for # of blocks vertically
    for n=1:1:N % loop for # of blocks horizontally
        target_8x8 = double(f(((m-1)*H+1):(m*H),((n-1)*W+1):(n*W)));
        target_8x8 = target_8x8 - 128; % substract 128
        for u=0:1:(H-1) % loop for frequencies regarding vertical direction
            for v=0:1:(W-1) % loop for frequencies regarding horizontal direction
                F(u+1, v+1, m, n) = 2 / sqrt(H*W) * beta(u+1) * beta(v+1) ...
                    * sum(sum((target_8x8 .* basis_vector(:,:,u+1, v+1))));
                % projection on orthogonal basis vectors
            end
        end       
    end
end

%% show stats (statisitics) of block in spatial domain
% mean (average)
mu_of_blcok_spatial = zeros(8,8);
for m=1:1:M % loop for # of blocks vertically
    for n=1:1:N % loop for # of blocks horizontally
        target_8x8 = double(f(((m-1)*H+1):(m*H),((n-1)*W+1):(n*W)));
        mu_of_blcok_spatial = mu_of_blcok_spatial + target_8x8;
    end
end
mu_of_blcok_spatial = mu_of_blcok_spatial / M / N;

% variance 
var_of_block_spatial = zeros(8,8);
for m=1:1:M % loop for # of blocks vertically
    for n=1:1:N % loop for # of blocks horizontally
        target_8x8 = double(f(((m-1)*H+1):(m*H),((n-1)*W+1):(n*W)));
        var_of_block_spatial = var_of_block_spatial + target_8x8.*target_8x8;
    end
end
var_of_block_spatial = var_of_block_spatial / M / N;
var_of_block_spatial = var_of_block_spatial - mu_of_blcok_spatial.*mu_of_blcok_spatial;


%% show stats (statisitics) of block in frequency domain
% mean (average)
mu_of_blcok_freq = zeros(8,8);
for m=1:1:M % loop for # of blocks vertically
    for n=1:1:N % loop for # of blocks horizontally
        target_8x8 = F(:,:,m,n);
        mu_of_blcok_freq = mu_of_blcok_freq + target_8x8;
    end
end
mu_of_blcok_freq = mu_of_blcok_freq / M / N;

% variance 
var_of_block_freq = zeros(8,8);
for m=1:1:M % loop for # of blocks vertically
    for n=1:1:N % loop for # of blocks horizontally
        target_8x8 = F(:,:,m,n);
        var_of_block_freq = var_of_block_freq + target_8x8.*target_8x8;
    end
end
var_of_block_freq = var_of_block_freq / M / N;
var_of_block_freq = var_of_block_freq - mu_of_blcok_freq.*mu_of_blcok_freq;

%% quantization
Q = [16 11 10 16 24 40 51 61;
     12 12 14 19 26 58 60 55;
     14 13 16 24 40 57 69 56;
     14 17 22 29 51 87 80 62;
     18 22 37 56 68 109 103 77;
     24 35 55 64 81 104 113 92;
     49 64 78 87 103 121 120 101;
     72 92 95 98 112 100 103 99]; % quantization table
 
 F_q = F; % F_q is used to save the reconstructed frequency domain blocks
 for m=1:1:M
    for n=1:1:N
        F_q(:,:,m,n) = round(F(:,:,m,n) ./ Q);
    end
 end
 
%% show stats (statisitics) of block in quantized frequency domain
% mean (average)
mu_of_blcok_freq_quan = zeros(8,8);
for m=1:1:M % loop for # of blocks vertically
    for n=1:1:N % loop for # of blocks horizontally
        target_8x8 = F_q(:,:,m,n);
        mu_of_blcok_freq_quan = mu_of_blcok_freq_quan + target_8x8;
    end
end
mu_of_blcok_freq_quan = mu_of_blcok_freq_quan / M / N;

% variance 
var_of_block_freq_quan = zeros(8,8);
for m=1:1:M % loop for # of blocks vertically
    for n=1:1:N % loop for # of blocks horizontally
        target_8x8 = F_q(:,:,m,n);
        var_of_block_freq_quan = var_of_block_freq_quan + target_8x8.*target_8x8;
    end
end
var_of_block_freq_quan = var_of_block_freq_quan / M / N;
var_of_block_freq_quan = var_of_block_freq_quan - mu_of_blcok_freq_quan.*mu_of_blcok_freq_quan;
 
%% differential pulse code modulation (DPCM)
for m=1:1:M % loop for # of blocks vertically
    for n=N:(-1):2 % loop for # of blocks horizontally
        F_q(1,1,m,n) = F_q(1,1,m,n) - F_q(1,1,m,n-1);
    end
end
for m=M:(-1):2 % loop for # of blocks vertically
    F_q(1,1,m,1) = F_q(1,1,m,1) - F_q(1,1,m-1,1);
end



%% zigzag
zz_matrix = [...
     1  2  6  7 15 16 28 29;
     3  5  8 14 17 27 30 43;
     4  9 13 18 26 31 42 44;
    10 12 19 25 32 41 45 54;
    11 20 24 33 40 46 53 55;
    21 23 34 39 47 52 56 61;
    22 35 38 48 51 57 60 62;
    36 37 49 50 58 59 64 64];
    
F_q_zigzag = zeros(H*W, M, N);
for m=1:1:M % loop for # of blocks vertically
    for n=1:1:N % loop for # of blocks horizontally
        for r=1:1:H
            for c=1:1:W
                F_q_zigzag(zz_matrix(r,c),m,n) = F_q(r,c,m,n);
            end
        end
    end
end

%% stats of F_q_zigzag
% mean
mu_of_F_q_zigzag = zeros(64,1);
for m=1:1:M % loop for # of blocks vertically
    for n=1:1:N % loop for # of blocks horizontally
        mu_of_F_q_zigzag = mu_of_F_q_zigzag + F_q_zigzag(:,m,n);
    end
end
mu_of_F_q_zigzag = mu_of_F_q_zigzag / M / N;

% var
var_of_F_q_zigzag = zeros(64,1);
for m=1:1:M % loop for # of blocks vertically
    for n=1:1:N % loop for # of blocks horizontally
        var_of_F_q_zigzag = var_of_F_q_zigzag + F_q_zigzag(:,m,n).*F_q_zigzag(:,m,n);
    end
end
var_of_F_q_zigzag = var_of_F_q_zigzag / M / N;
var_of_F_q_zigzag = var_of_F_q_zigzag - mu_of_F_q_zigzag.*mu_of_F_q_zigzag;

%% Run Length Encoding (RLE)
rle = cell(M,N);
for m=1:1:M % loop for # of blocks vertically
    for n=1:1:N % loop for # of blocks horizontally
        nzero = 0; % # of consecutive zeros
        i = 1;
        while i<=(H*W)
            if F_q_zigzag(i,m,n)~=0
                rle{m,n} = [rle{m,n} nzero F_q_zigzag(i,m,n)];
                nzero = 0;
            end
            if F_q_zigzag(i,m,n)==0
                nzero = nzero + 1;
            end
            i = i + 1;
        end
        rle{m,n} = [rle{m,n} 0 0]; % add end of block
    end
end

rle_code = [];
for m=1:1:M % loop for # of blocks vertically
    for n=1:1:N % loop for # of blocks horizontally
        rle_code = [rle_code rle{m,n}];
    end
end

% count size of rle result in byte
total_byte_by_rle = length(rle_code);
fprintf(1, 'The size of the original bmp is %d bytes\n', H*W*M*N);
fprintf(1, 'The size of RLE-encoded bmp is  %d bytes\n', total_byte_by_rle);

%% huffman encoding
max_rle_code = max(rle_code);
min_rle_code = min(rle_code);

[c, symbols] = hist(rle_code, [min_rle_code:1:max_rle_code]);
p = c / sum(c);


figure(2);
bar(symbols, p);
xlabel('symbol');
ylabel('# of symbols');
title('histogram of RLE codes');


dict = huffmandict(symbols,p);
huffman_code = huffmanenco(rle_code,dict);


fprintf(1, 'The size of Huffman-encoded bmp is  %d bytes\n', int32(length(huffman_code)/8));
 
%% ------- Decoder ------- %% 

%% huffman decode
rle_code_hat = huffmandeco(huffman_code,dict);

%% un-rle
F_q_zigzag_hat = zeros(H*W,M,N);
i=1;
ofs = 1;
m = 1;
n = 1;
while m<=M && n<=N
    ofs = 1;
    while ~(rle_code_hat(i)==0 && rle_code_hat(i+1)==0)
        ofs = ofs + rle_code_hat(i);
        i = i + 1;
        F_q_zigzag_hat(ofs,m,n) = rle_code_hat(i);
        ofs = ofs + 1;
        i = i + 1;
    end
    i = i + 2; % skip end of block
    n = n + 1;
    if n>N
        n = 1;
        m = m + 1;
    end
end

%% un-zigzag
F_q_hat = zeros(H, W, M, N);
for m=1:1:M
    for n=1:1:N
        for r=1:1:H
            for c=1:1:W
                F_q_hat(r,c,m,n) = F_q_zigzag_hat(zz_matrix(r,c),m,n);
            end
        end
    end
end

%% un-DPCM
for m=2:(1):M % loop for # of blocks vertically
    F_q_hat(1,1,m,1) = F_q_hat(1,1,m,1) + F_q_hat(1,1,m-1,1);
end
for m=1:1:M % loop for # of blocks vertically
    for n=2:1:N % loop for # of blocks horizontally
        F_q_hat(1,1,m,n) = F_q_hat(1,1,m,n) + F_q_hat(1,1,m,n-1);
    end
end

 
%% unquantization
 F_hat = zeros(H,W,M,N); % F_hat is to save unquantized frequnecy domain blocks
 for m=1:1:M
    for n=1:1:N
        F_hat(:,:,m,n) = F_q_hat(:,:,m,n) .* Q;
    end
 end

%% reconstruct spatial domain blocks
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
                    F_hat(u+1, v+1, m, n) * basis_vector(:,:,u+1, v+1);
            end
        end
        f_hat(((m-1)*H+1):(m*H),((n-1)*W+1):(n*W)) = f_hat(((m-1)*H+1):(m*H),((n-1)*W+1):(n*W)) + 128;
    end
end

%% add 128
f_hat = uint8(f_hat);
figure(3);
imshow(f_hat);

