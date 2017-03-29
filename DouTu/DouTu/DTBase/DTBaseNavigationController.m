//
//  DTBaseNavigationController.m
//  DouTu
//
//  Created by yuepengfei on 17/3/14.
//  Copyright © 2017年 fly. All rights reserved.
//

#import "DTBaseNavigationController.h"

@interface DTBaseNavigationController ()

@end

@implementation DTBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor] , NSFontAttributeName:DT_Nav_TitleFont}];
    [[UINavigationBar appearance] setBackgroundImage:[[UIImage imageNamed:@"dt_nav_bg"] stretchableImageWithLeftCapWidth:3 topCapHeight:3]  forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
