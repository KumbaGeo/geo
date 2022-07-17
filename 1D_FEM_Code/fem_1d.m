clear; close all;

% specify problem domain
L = 1;
xmin = 0; xmax = L;

% create mesh
x = linspace(xmin, xmax, 101);

% assign material properties
T = 1; W = 1; f1 = -3*W; f2 = -1*W;

% create data structures to store nodal coordinates and element
% connectivity
[NODE, ELEM, PARAMS] = create_data_structures(x,T,f1,f2);

% specify boundary conditions
% specify boundary conditions on u at x = 0
NODE(1).u_is_fixed = 1;
NODE(1).u = 0;

% specify boundary conditions on u at x = 1
NODE(length(x)).u_is_fixed = 1;
NODE(length(x)).u = 0;

% assemble system
[bigk,fext] = assemble_system(ELEM,NODE,PARAMS);

% solve system
u_fem = bigk\fext;

% postprocess results
postprocess_results(x,u_fem,T);
