//
//  Created by Takeru Chuganji on 2014/07/19.
//  Copyright (c) 2014 Takeru Chuganji. All rights reserved.
//

#import "HCPopBackGestureProxy.h"

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

#pragma mark - delegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if ([self.viewController respondsToSelector:@selector(hcPopBackGestureProxyShouldBegin:)] &&
        ![self.viewController hcPopBackGestureProxyShouldBegin:gestureRecognizer]) {
        return NO;
    }
    return 1 < [self.viewController.navigationController.viewControllers count];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return NO;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if ([self.viewController respondsToSelector:@selector(gestureRecognizer:shouldRequireFailureOfGestureRecognizer:)]) {
        return [self.viewController gestureRecognizer:gestureRecognizer shouldRequireFailureOfGestureRecognizer:otherGestureRecognizer];
    }
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if ([self.viewController respondsToSelector:@selector(gestureRecognizer:shouldBeRequiredToFailByGestureRecognizer:)]) {
        return [self.viewController gestureRecognizer:gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:otherGestureRecognizer];
    }
    return NO;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([self.viewController respondsToSelector:@selector(gestureRecognizer:shouldReceiveTouch:)]) {
        return [self.viewController gestureRecognizer:gestureRecognizer shouldReceiveTouch:touch];
    }
    return YES;
}


@end
