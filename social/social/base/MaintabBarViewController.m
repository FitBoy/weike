//
//  MaintabBarViewController.m
//  social
//
//  Created by QianYuan on 2020/8/31.
//  Copyright © 2020 QianYuan. All rights reserved.
//

#import "MaintabBarViewController.h"
#import "HomeViewController.h"
#import "messageViewController.h"
#import "FindViewController.h"
#import "MyViewController.h"

@interface MaintabBarViewController ()

@end

@implementation MaintabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}
- (instancetype)init {
   if (!(self = [super init])) {
       return nil;
   }
  
 //  UIEdgeInsets imageInsets = UIEdgeInsetsZero;//UIEdgeInsetsMake(4.5, 0, -4.5, 0);
  // UIOffset titlePositionAdjustment = UIOffsetMake(0, -3.5);
   CYLTabBarController *tabBarController = [CYLTabBarController tabBarControllerWithViewControllers:self.viewControllers
                                                                              tabBarItemsAttributes:self.tabBarItemsAttributesForController];
   //[self customizeTabBarAppearance:tabBarController];
    tabBarController.view.backgroundColor = [UIColor redColor];
   self.navigationController.navigationBar.hidden = YES;
    
    
    
   return (self = (MaintabBarViewController *)tabBarController);
}


-(NSArray*)viewControllers{
    HomeViewController *hvc = [[HomeViewController alloc]init];
    CYLBaseNavigationController  *nav_hvc = [[CYLBaseNavigationController alloc]initWithRootViewController:hvc];
    
    messageViewController *mvc = [[messageViewController alloc]init];
    CYLBaseNavigationController *nav_mvc = [[CYLBaseNavigationController alloc]initWithRootViewController:mvc];
    
    FindViewController *fvc = [[FindViewController alloc]init];
    CYLBaseNavigationController *nav_fvc = [[CYLBaseNavigationController alloc]initWithRootViewController:fvc];
    
    MyViewController *myvc = [[MyViewController alloc]init];
    CYLBaseNavigationController *nav_my = [[CYLBaseNavigationController alloc]initWithRootViewController:myvc];
    
    
    return @[nav_hvc,nav_mvc,nav_fvc,nav_my];
    
}
- (NSArray *)tabBarItemsAttributesForController {
    
    NSDictionary *dic_h = @{
        CYLTabBarItemTitle:@"首页",
        CYLTabBarItemImage:@"home",
        CYLTabBarItemSelectedImage:@"home_select"
    };
    NSDictionary *dic_m = @{
          CYLTabBarItemTitle:@" 消息",
          CYLTabBarItemImage:@"message",
          CYLTabBarItemSelectedImage:@"message_select"
      };
    NSDictionary *dic_f = @{
          CYLTabBarItemTitle:@"发现",
          CYLTabBarItemImage:@"find",
          CYLTabBarItemSelectedImage:@"find_select"
      };
    NSDictionary *dic_my = @{
          CYLTabBarItemTitle:@"我的",
          CYLTabBarItemImage:@"my",
          CYLTabBarItemSelectedImage:@"my_select"
      };
    
    return @[dic_h,dic_m,dic_f,dic_my];
}






@end
