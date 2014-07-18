//
//  Created by Takeru Chuganji on 2014/07/19.
//  Copyright (c) 2014 Takeru Chuganji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCPopBackGestureProxy.h"

@interface RootViewController : UIViewController <HCPopBackGestureProxyDelegate>
- (NSArray *)leftBarButtonItems;
- (NSArray *)rightBarButtonItems;
- (void)leftBarButtonItemAction:(NSInteger)index;
- (void)rightBarButtonItemAction:(NSInteger)index;
@end
