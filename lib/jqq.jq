def aws_tags_(f):
  f | .Tags |= reduce (.//[])[] as $i ({}; .[$i.Key] = $i.Value);

def aws_tags:
  aws_tags_(.);
