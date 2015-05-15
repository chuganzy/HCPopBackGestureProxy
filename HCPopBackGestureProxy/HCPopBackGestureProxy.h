//
//  Created by Takeru Chuganji on 2014/07/19.
//  Copyright (c) 2014 Takeru Chuganji. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HCPopBackGestureProxyDelegate <UIGestureRecognizerDelegate>
@optional
- (BOOL)hcPopBackGestureProxyShouldBegin:(UIGestureRecognizer *)recognizer;
@end

@interface HCPopBackGestureProxy : NSObject <UIGestureRecognizerDelegate>
@property (nonatomic, weak) UIViewController <HCPopBackGestureProxyDelegate> *viewController;
@property (nonatomic) BOOL shouldTransmitGestures;
+ (HCPopBackGestureProxy *)sharedInstance;
- (void)viewWillDisappear;
@end
