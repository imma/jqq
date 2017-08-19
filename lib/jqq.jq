def aws_remap_o(f):
  map_values(if type == "object" then f elif type == "array" then aws_remap_o(f) else . end)
  ;

def aws_tags_:
  if type == "object" then
    if (.Tags? | type) == "array" then
      .Tags? |= reduce .[]? as $i ({}; .[$i.Key] = $i.Value) | map_values(if . != null and (type == "object" or type == "array") then aws_remap_o(aws_tags_) else . end)
    else
      aws_remap_o(aws_tags_)
    end
  else
    aws_remap_o(aws_tags_)
  end
  ;

def aws_tags:
  aws_remap_o(aws_tags_)
  ;

def aws_remap_a(f):
  if type == "array" then
    if map(select(type == "object")) | length > 0 then
      f
    else
      map_values(aws_remap_a(f))
    end
  elif type == "object" then
    map_values(aws_remap_a(f))
  else
    .
  end
  ;

def aws_attrs_(meh):
  if map(select(meh)) | length > 0 then
    reduce .[]? as $i ({}; .[$i | meh] = ($i | map_values(aws_remap_a(aws_attrs_(meh)))))
  else
    map_values(aws_remap_a(aws_attrs_(meh)))
  end
  ;

def aws_attrs(attr):
  aws_remap_a(aws_attrs_(attr))
  ;
