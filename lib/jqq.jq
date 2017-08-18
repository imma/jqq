def aws_tags:
  .Tags |= reduce (.//[])[] as $i ({}; .[$i.Key] = $i.Value);
