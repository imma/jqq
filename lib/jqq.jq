def aws_tags:
  map_values(map_values(.Tags |= reduce (.//[])[] as $i ({}; .[$i.Key] = $i.Value)));
