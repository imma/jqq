def aws_remap(f):
  map_values(if type == "object" then f elif type == "array" then aws_remap(f) else .  end);

def aws_tags_:
  .Tags? |= reduce .[]? as $i ({}; .[$i.Key] = $i.Value) | map_values(if type == "object" then aws_remap(aws_tags_) elif type == "array" then aws_remap(aws_tags_) else .  end);

def aws_tags:
  aws_remap(aws_tags_);
