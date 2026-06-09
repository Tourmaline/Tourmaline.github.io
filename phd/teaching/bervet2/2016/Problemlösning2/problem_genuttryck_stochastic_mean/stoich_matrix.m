function M = stoich_matrix()
% stoich_matrix returns the stoichiometry matrix

% transcription translation mRNA_decay protein_decay
M = [1 0 -1 0; % mRNA
     0 1 0  -1]; % protein
  
end