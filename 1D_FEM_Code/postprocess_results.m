function  postprocess_results(x,u_fem,T)

plot(x, u_fem, 'LineWidth', 2, 'Color', 'blue');
hold on

% plot exact solution
xmin = min(x); xmax = max(x);
x_ex = linspace(xmin,xmax,201);
L = xmax-xmin;
u_ex =  zeros(length(x_ex),1);
for inod=1:length(x_ex)
    if(x_ex(inod)<mean([xmin, xmax]))
        u_ex(inod) = (L*L)/(T)*(1.5*(x_ex(inod)/L)*(x_ex(inod)/L)-(5/4)*(x_ex(inod)/L));
    else
        u_ex(inod) = (L*L)/(T)*(0.5*(x_ex(inod)/L)*(x_ex(inod)/L)-(1/4)*(x_ex(inod)/L) - (1/4));
    end
end
plot(x_ex, u_ex,'LineWidth', 2, 'Color', 'red')

legend('u_{fem}', 'u_{ex}', 'FontSize', 12);

end