//
//  DTMakeViewController.m
//  DouTu
//
//  Created by yuepengfei on 17/3/14.
//  Copyright © 2017年 fly. All rights reserved.
//

#import "DTMakeViewController.h"
#import "DTMakeHotViewController.h"
#import "DTAllTypeViewController.h"
#import "DTCustomSegmentedControl.h"

@interface DTMakeViewController ()<DTCustomSegmentedControlDelegate>
{
    DTAllTypeViewController *_typeVC;
    DTMakeHotViewController *_hotVC;
}
@end
@implementation DTMakeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpTitleView];
    [self setUpChildVC];
}
- (void)setUpTitleView
{
    DTCustomSegmentedControl *titleView = [[DTCustomSegmentedControl alloc] initWithFrame:CGRectMake(0, 0, 150, 30)];
    titleView.delegate = self;
    self.navigationItem.titleView = titleView;
}
- (void)setUpChildVC
{
    _typeVC = [[DTAllTypeViewController alloc] init];
    [self addChildViewController:_typeVC];
    [self.view addSubview:_typeVC.view];
    
    _hotVC = [[DTMakeHotViewController alloc] init];
    [self addChildViewController:_hotVC];
    [self.view addSubview:_hotVC.view];
}
#pragma mark - DTCustomSegmentedControlDelegate
- (void)didSeleteSegmentedControlAtIndex:(NSInteger)index
{
    if (index == 0) {
        
        [self.view bringSubviewToFront:_hotVC.view];
    } else {
        [self.view bringSubviewToFront:_typeVC.view];
    }
}
@end
