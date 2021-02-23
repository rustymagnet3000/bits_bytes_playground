    UIView *emptyView = [[UIView alloc] initWithFrame:CGRectMake(0,0,343,90)];
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = emptyView.bounds;
    gradient.colors = @[(id)[UIColor blueColor].CGColor, (id)[UIColor greenColor].CGColor];
    [emptyView.layer insertSublayer:gradient atIndex:0];
