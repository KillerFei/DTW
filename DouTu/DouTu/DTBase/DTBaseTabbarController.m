//
//  DTBaseTabbarController.m
//  DouTu
//
//  Created by yuepengfei on 17/3/14.
//  Copyright © 2017年 fly. All rights reserved.
//

#import "DTBaseTabbarController.h"
#import "DTBaseNavigationController.h"
#import "DTStoreViewController.h"
#import "DTMakeViewController.h"
#import "DTMyViewController.h"

@interface DTBaseTabbarController ()

@end

@implementation DTBaseTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpChildController];
    [self setUpTabBarItems];
}
#pragma mark - add ChildControllers
- (void)setUpChildController
{
    DTStoreViewController *storeVC = [[DTStoreViewController alloc] init];
    DTBaseNavigationController *storeNav = [[DTBaseNavigationController alloc] initWithRootViewController:storeVC];
    storeNav.canDragBack = YES;
    storeNav.showDragAnimation = YES;
    storeVC.title = @"广场";
    
    DTMakeViewController *makeVC = [[DTMakeViewController alloc] init];
    DTBaseNavigationController *makeNav = [[DTBaseNavigationController alloc] initWithRootViewController:makeVC];
    makeNav.canDragBack = YES;
    makeNav.showDragAnimation = YES;
    makeVC.title = @"制作";
    
    DTMyViewController *myVC = [[DTMyViewController alloc] init];
    DTBaseNavigationController *myNav = [[DTBaseNavigationController alloc] initWithRootViewController:myVC];
    myNav.canDragBack = YES;
    myNav.showDragAnimation = YES;
    myVC.title = @"我的";
    
    self.viewControllers = @[storeNav, makeNav, myNav];
}
#pragma mark - set TabbarItems
- (void)setUpTabBarItems
{
    NSArray *itemArr    = self.tabBar.items;
    UITabBarItem *storeItem  = [itemArr objectAtIndex:0];
    UITabBarItem *makeItem   = [itemArr objectAtIndex:1];
    UITabBarItem *myItem     = [itemArr objectAtIndex:2];
    storeItem.image = [[UIImage imageNamed:@"dt_tabbar_store_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    storeItem.selectedImage = [[UIImage imageNamed:@"dt_tabbar_store_selete"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    makeItem.image = [[UIImage imageNamed:@"dt_tabbar_make_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    makeItem.selectedImage = [[UIImage imageNamed:@"dt_tabbar_make_selete"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

//    
//    searchItem.image = [[UIImage imageNamed:@"rd_tabbar_search_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    searchItem.selectedImage = [[UIImage imageNamed:@"rd_tabbar_search_selete"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    
//    setItem.image = [[UIImage imageNamed:@"rd_tabbar_setting_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    setItem.selectedImage = [[UIImage imageNamed:@"rd_tabbar_setting_selete"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    
    //改变UITabBarItem字体颜色
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:DT_TabBar_SeleteColor} forState:UIControlStateSelected];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
