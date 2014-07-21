HCPopBackGestureProxy
=====================

From iOS7, we can go back (popViewController) by swiping the view edge.
However, this doesn't work when customView is set to `navigationItem.leftBarButtonItems`.

I found a solution [here](http://keighl.com/post/ios7-interactive-pop-gesture-custom-back-button/), but it likely to crash when swiping during `popViewController` animation (I found Pinterest v.3.7 also has this bug).
Additionally, I think this solution is difficult for almost all apps to apply, because they might not have a root class of `UINavigationController`.

This library is an improvement of the solution above.

## Usage

Just set viewController to sharedInstance on `viewDidAppear`.

```obj-c
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [HCPopBackGestureProxy sharedInstance].viewController = self;
}
```

and, call viewWillDisappear on `viewWillDisappear`.

```obj-c
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[HCPopBackGestureProxy sharedInstance] viewWillDisappear];
}
```

If you want to disable this gesture partly, implement the protocol method and return NO.

```
- (BOOL)hcPopBackGestureProxyShouldBegin:(UIGestureRecognizer *)recognizer {
  // do something...
  return NO;
}
```

## CocoaPods

```ruby
pod 'HCPopBackGestureProxy'
```

## License

MIT license.
