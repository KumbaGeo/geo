function [fg] = get_body_force(elem)

fg = zeros(2,1);
length = 0;
for i=1:elem.n_gp        
    
    N = [elem.N(1,i) elem.N(2,i)];

    fg = fg + elem.jcob(i,1)*N'*elem.body_force;

    length = length+elem.jcob(i,1);
end
err_len = elem.length - length;

if(abs(err_len)>1e-12)
    fprintf('len_chk_err: error in numerical integration\n');
    
end