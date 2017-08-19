def aws_remap_o(f):
  if type == "object" then
    f
  elif type == "array" then
    map_values(aws_remap_o(f))
  else
    .
  end
  ;

def aws_tags_:
  if (.Tags? | type) == "array" then
    .Tags? |= reduce .[]? as $i ({}; .[$i.Key] = $i.Value)
  else
    map_values(aws_remap_o(aws_tags_))
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

def aws_attrs_(by_id):
  if map(select(by_id)) | length > 0 then
    reduce .[]? as $i ({}; .[$i | by_id] = ($i | map_values(aws_remap_a(aws_attrs_(by_id)))))
  else
    map_values(aws_remap_a(aws_attrs_(by_id)))
  end
  ;

def aws_attrs(by_id):
  aws_remap_a(aws_attrs_(by_id))
  ;
