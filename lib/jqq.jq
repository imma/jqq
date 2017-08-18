def aws_remap(f):
  map_values(if type == "array" then [f] else . end) |
  map_values(map_values(map_values(if type == "array" then [f] else . end)));

def aws_tags_:
  .[]?.Tags |= reduce .[]? as $i ({}; .[$i.Key] = $i.Value);

def aws_tags:
  aws_remap(aws_tags_);
