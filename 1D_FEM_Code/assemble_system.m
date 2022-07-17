function [bigk,fext] = assemble_system(ELEM,NODE,PARAMS)

% initialize stiffness and force matrices
fext = zeros(PARAMS.ndof*length(NODE),1);
elem_mat_size = (PARAMS.nlink*PARAMS.ndof)^2;
alloc_size = elem_mat_size*length(ELEM);
I = zeros(alloc_size,1); J = zeros(alloc_size,1); V = zeros(alloc_size,1);
next = 0;

% assemble system
for ielem=1:length(ELEM)

    % evaluate element stiffness matrix
    ke = ELEM(ielem).T*ELEM(ielem).gradN'*ELEM(ielem).gradN*ELEM(ielem).length;

    % evaluate element force vector
    fe = get_body_force(ELEM(ielem));

    % apply boundary conditions
    [ke,fe] = apply_bc_elem(PARAMS.ndof,PARAMS.nlink,ELEM(ielem),ke,fe,NODE);
        
    % assemble local system in global matrix
    [I,J,V,fext,next] = assemble_global(PARAMS.nlink,PARAMS.ndof,ELEM(ielem),...
        I,J,V,fext,ke,fe,next);
end
bigk = sparse(I,J,V,PARAMS.ndof*length(NODE),PARAMS.ndof*length(NODE));


end