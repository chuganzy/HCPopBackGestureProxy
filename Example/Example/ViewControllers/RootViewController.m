//
//  Created by Takeru Chuganji on 2014/07/19.
//  Copyright (c) 2014 Takeru Chuganji. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

#pragma mark - superclass

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.title = NSStringFromClass([self class]);
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateNavigationItems];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)updateNavigationItems {
    [self hc_updateLeftBarButtonItems];
    [self hc_updateRightBarButtonItems];
}

- (NSArray *)leftBarButtonItems {
    if (1 < [self.navigationController.viewControllers count]) {
        return @[
                @"back"
        ];
    }
    return nil;
}

- (NSArray *)rightBarButtonItems {
    return nil;
}

- (void)leftBarButtonItemAction:(NSInteger)index {
    if (index == 0 && 1 < [self.navigationController.viewControllers count]) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)rightBarButtonItemAction:(NSInteger)index {

}

#pragma mark - protected

- (UIButton *)hc_makeNavigationButtonWithItem:(id)item {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    if ([item isKindOfClass:[NSString class]]) {
        [button setTitle:item forState:UIControlStateNormal];
    } else if ([item isKindOfClass:[UIImage class]]) {
        [button setImage:item forState:UIControlStateNormal];
    }
    [button sizeToFit];
    return button;
}

- (void)hc_updateLeftBarButtonItems {
    NSArray *items = [self leftBarButtonItems];
    NSInteger index = 0;
    NSMutableArray *array = [NSMutableArray array];
    for (id item in items) {
        UIButton *button = [self hc_makeNavigationButtonWithItem:item];
        button.tag = index;
        [button addTarget:self action:@selector(hc_leftBarButtonItemAction:) forControlEvents:UIControlEventTouchUpInside];
        [array addObject:[[UIBarButtonItem alloc] initWithCustomView:button]];
        index++;
    }
    self.navigationItem.leftBarButtonItems = array;
}

- (void)hc_updateRightBarButtonItems {
    NSArray *items = [self rightBarButtonItems];
    NSInteger index = 0;
    NSMutableArray *array = [NSMutableArray array];
    for (id item in items) {
        UIButton *button = [self hc_makeNavigationButtonWithItem:item];
        button.tag = index;
        [button addTarget:self action:@selector(hc_rightBarButtonItemAction:) forControlEvents:UIControlEventTouchUpInside];
        [array addObject:[[UIBarButtonItem alloc] initWithCustomView:button]];
        index++;
    }
    self.navigationItem.rightBarButtonItems = array;
}

- (void)hc_leftBarButtonItemAction:(UIButton *)button {
    [self leftBarButtonItemAction:button.tag];
}

- (void)hc_rightBarButtonItemAction:(UIButton *)button {
    [self rightBarButtonItemAction:button.tag];
}

@end
