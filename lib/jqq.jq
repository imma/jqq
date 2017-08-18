def aws_tags_(f):
  f | .Tags |= reduce (.//[])[] as $i ({}; .[$i.Key] = $i.Value);

def aws_tags:
  map_values(if type == "array" then [aws_tags_(.[])] else . end) |
  map_values(map_values(map_values(if type == "array" then [aws_tags_(.[])] else . end)));
