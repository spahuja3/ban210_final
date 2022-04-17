length IMP_node_caps $3;
format IMP_node_caps $3.;
label IMP_node_caps = 'Imputed: node_caps';
IMP_node_caps = node_caps;
if node_caps = '' then IMP_node_caps = 'no';
