function error = prediction_error(A, B)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
rows_A = size(A,1);
cols_A = size(A,2);
rows_B = size(B,1);
cols_B = size(B,2);

    if (rows_A ~= rows_B) && (cols_A ~= cols_B)
        disp('A and B must have some rows and cols');   
    end 
    
    for i = 1:rows_A
        for j = 1:cols_A
            error = error + (A(i,j) - B(i,j))^2;
        end
    end

end

