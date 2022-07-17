function [N,jcob] = get_N(xe)

gauss = [-1/sqrt(3); 1/sqrt(3)];

N = zeros(2,length(gauss));
jcob = zeros(length(gauss),1);

count = 1;
for i=1:length(gauss)
    psi = gauss(i); 
    N(1,count)= (1/2)*(1-psi);
    N(2,count) = (1/2)*(1+psi);
    jcob(count,1) = 0.5*(xe(2)-xe(1));
    count = count+1;
end