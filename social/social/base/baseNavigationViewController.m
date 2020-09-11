//
//  baseNavigationViewController.m
//  social
//
//  Created by QianYuan on 2020/9/1.
//  Copyright © 2020 QianYuan. All rights reserved.
//

#import "baseNavigationViewController.h"

@interface baseNavigationViewController ()

@end

@implementation baseNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    } else {
        viewController.hidesBottomBarWhenPushed = NO;
    }
    [super pushViewController:viewController animated:animated];
}

@end
