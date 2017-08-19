def aws_remap_o(f):
  map_values(if type == "object" then f elif type == "array" then aws_remap_o(f) else . end);

def aws_remap_a(f):
  map_values(if type == "array" then f elif type == "object" then aws_remap_o(f) else . end);

def aws_tags_:
  .Tags? |= reduce .[]? as $i ({}; .[$i.Key] = $i.Value) | map_values(if type == "object" then aws_remap_o(aws_tags_) elif type == "array" then aws_remap_o(aws_tags_) else . end);

def aws_tags:
  aws_remap_o(aws_tags_);

def aws_vpcs_:
  reduce .[]? as $i ({}; .[$i.VpcId] = $i);
#| map_values(if type == "object" then aws_remap_a(aws_vpcs_) elif type == "array" then aws_remap_a(aws_vpcs_) else . end);

def aws_vpcs:
  aws_remap_a(aws_vpcs_);
