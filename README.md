# HCPopBackGestureProxy

[![Version](https://img.shields.io/cocoapods/v/HCPopBackGestureProxy.svg?style=flat)](http://cocoadocs.org/docsets/HCPopBackGestureProxy)
[![License](https://img.shields.io/cocoapods/l/HCPopBackGestureProxy.svg?style=flat)](http://cocoadocs.org/docsets/HCPopBackGestureProxy)
[![Platform](https://img.shields.io/cocoapods/p/HCPopBackGestureProxy.svg?style=flat)](http://cocoadocs.org/docsets/HCPopBackGestureProxy)

From iOS7, we can go back (popViewController) by swiping the view edge.
However, this doesn't work when customView is set to `navigationItem.leftBarButtonItems`.

I found a solution [here](http://keighl.com/post/ios7-interactive-pop-gesture-custom-back-button/), but it likely to crash when swiping during `popViewController` animation (I found Pinterest v.3.7 also has this bug).
Additionally, I think this solution is difficult for almost all apps to apply, because they might not have a root class of `UINavigationController`.

This library is an improvement of the solution above.

![Capture](./Example/Capture/capture.gif)

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

## Installation

HCPopBackGestureProxy is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'HCPopBackGestureProxy'
```

## Requirement

- iOS6 or later
- ARC

## License

HCPopBackGestureProxy is available under the MIT license. See the LICENSE file for more info.
