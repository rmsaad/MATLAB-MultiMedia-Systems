d = [139 139 161 156; 
     139 161 161 156;
     161 161 161 156;
     161 161 161 0 ];
 
%%
d = [5 11 3 32];
q = [4 7 27 35];

b = dct2(d);
qd = b ./ q;

an = [24, -14, 0 , 0];
t = idct2(an);
%%

d = [5 11 3 32];

a = 0.0;
for x = 0:3
        a = (sqrt(2/4)) * (cos((((2*x)+1)*1*pi)/8) * d(x+1));
        fprintf('%f \n', a);
end

%%



i1 = [127 125 128 129;
         128 126 130 131;
         129 127 131 133;
         130 129 132 135];
     
% i1 = [127 125 128 129;
%          127 125 128 129;
%          132 118 117 114;
%          132 138 113 113];
     
 % init mode 4 array 
mode4 = uint8(zeros(4, 4));
mode4(:, 1) =  i1(:, 1);
mode4(1, :) =  i1(1, :);



% perform DCPM mode 4

for y = 2:4
    for x = 2:4
        mode4(x, y) = double(i1(x, y)) - double(i1(x, y-1)) + double(i1(x-1, y)) - double(i1(x-1, y-1));
        %mode4(x, y) = double(i1(x, y)) - double(i1(x-1, y)); 
    end
end


mode4_entropy = 0;

    [sym,prob,mode4_entropy] = myEntropy(mode4);
