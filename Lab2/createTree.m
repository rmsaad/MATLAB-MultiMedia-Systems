function [code,tree] = createTree(symbol,prob_vec)
%CREATETREE Summary of this function goes here
%   Detailed explanation goes here

% find size
[a,b] = size(symbol);
inLen = a*b;
% init 2-d tree with -1
tree = -1 * ones(2*inLen-1, 4);

% fill with prob_vec
tree(1:length(prob_vec)) = transpose(prob_vec); 

len_nodes = length(prob_vec);
new_node_pos = 1;

while(len_nodes > 1)
    
    % process left node
    [left,indL]  = min(prob_vec);
    prob_vec(1,indL) = nan;
    tree(indL,2) = inLen + new_node_pos;
    
    % process right node
    [right,indR] = min(prob_vec);
    prob_vec(1,indR) = nan;
    tree(indR,2) = inLen + new_node_pos;
    
    % create new node
    tree(inLen + new_node_pos,1) = left + right;
    prob_vec = [prob_vec, left + right];
    tree(inLen + new_node_pos,3) = indL;
    tree(inLen + new_node_pos,4) = indR;
    
    % update node length & new_node_pis
    len_nodes =sum(  ~isnan(prob_vec(:)) );
    new_node_pos = new_node_pos + 1;
end


for sy = 1:length(symbol)
    % get parent
    code{sy} = getPar(sy, tree, []);
    fprintf("\n");  
end
    
end

function [c] = getPar(s,t, arr)
    
    % find parent
    par = t(s,2);
    
    % assign correct value if left or right child
    if t(par,3) == s
        arr = [arr 1];
    elseif t(par,4) == s
        arr = [arr 0];
    end
    
    % recurssion
    if par > 0 && par ~= length(t)
        c = getPar(par, t, arr);
    else 
        
        % flip vector 
        c = flip(arr); 
        fprintf('%i', c);
    end
    
end
