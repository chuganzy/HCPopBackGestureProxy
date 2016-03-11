//
//  Created by Takeru Chuganji on 2014/07/19.
//  Copyright (c) 2014 Takeru Chuganji. All rights reserved.
//

#import "HCPopBackGestureProxy.h"

@interface HCPopBackGestureProxy ()
@property (nonatomic) NSUInteger viewControllerCountWhenSet;
@property (nonatomic, getter=isRocked) BOOL rocked;
@end

@implementation HCPopBackGestureProxy

#pragma mark - public

+ (HCPopBackGestureProxy *)sharedInstance {
    static HCPopBackGestureProxy *_instance = nil;
    @synchronized (self) {
        if (_instance == nil) {
            _instance = [[self alloc] init];
        }
    }
    return _instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.shouldTransmitGestures = NO;
    }
    return self;
}

- (void)dealloc {
    if (self.viewController.navigationController.interactivePopGestureRecognizer.delegate == self) {
        self.viewController.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
}

- (void)setViewController:(UIViewController <HCPopBackGestureProxyDelegate> *)viewController {
    if (![viewController.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        return;
    }
    if (_viewController == viewController) {
        return;
    }
    if (viewController.isViewLoaded && viewController.view.window) {
        self.rocked = NO;
        _viewController = viewController;
        viewController.navigationController.interactivePopGestureRecognizer.delegate = self;
        viewController.navigationController.interactivePopGestureRecognizer.delaysTouchesBegan = NO;
        self.viewControllerCountWhenSet = [viewController.navigationController.viewControllers count];
    }
}

- (void)viewWillDisappear {
    if (self.viewControllerCountWhenSet < [self.viewController.navigationController.viewControllers count]) {
        self.rocked = YES;
    }
}

#pragma mark - delegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (self.shouldTransmitGestures && [self.viewController respondsToSelector:_cmd]) {
        return [self.viewController gestureRecognizerShouldBegin:gestureRecognizer];
    }
    if (self.isRocked) {
        return NO;
    }
    if ([self.viewController respondsToSelector:@selector(hcPopBackGestureProxyShouldBegin:)] &&
        ![self.viewController hcPopBackGestureProxyShouldBegin:gestureRecognizer]) {
        return NO;
    }
    return 1 < [self.viewController.navigationController.viewControllers count];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if (self.shouldTransmitGestures && [self.viewController respondsToSelector:_cmd]) {
        return [self.viewController gestureRecognizer:gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:otherGestureRecognizer];
    }
    return NO;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if (self.shouldTransmitGestures && [self.viewController respondsToSelector:_cmd]) {
        return [self.viewController gestureRecognizer:gestureRecognizer shouldRequireFailureOfGestureRecognizer:otherGestureRecognizer];
    }
    return NO;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if (self.shouldTransmitGestures && [self.viewController respondsToSelector:_cmd]) {
        return [self.viewController gestureRecognizer:gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:otherGestureRecognizer];
    }
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if (self.shouldTransmitGestures && [self.viewController respondsToSelector:_cmd]) {
        return [self.viewController gestureRecognizer:gestureRecognizer shouldReceiveTouch:touch];
    }
    return YES;
}

@end
