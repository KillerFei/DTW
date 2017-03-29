//
//  DTDisclaimerVC.m
//  DouTu
//
//  Created by 岳鹏飞 on 2017/3/18.
//  Copyright © 2017年 fly. All rights reserved.
//

#import "DTDisclaimerVC.h"

@interface DTDisclaimerVC ()
{
    UITextView *_disclaimerView;
}
@end

@implementation DTDisclaimerVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLeftBackNavItem];
    [self addSubviews];
}
- (void)addSubviews
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    _disclaimerView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT-64)];
    _disclaimerView.selectable = NO;
    _disclaimerView.font = DT_Base_TitleFont;
    _disclaimerView.textColor = DT_Base_TitleColor;
    [_disclaimerView setTextContainerInset:UIEdgeInsetsMake(8, 8, 5, 8)];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = 8;
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont systemFontOfSize:13],
                                 NSParagraphStyleAttributeName:style,
                                 NSForegroundColorAttributeName:DT_Base_ContentColor
                                 };
    
    NSString *desStr = [NSString stringWithFormat:@"斗图网提供用户分享、修改等功能，所有图片和内容均来自网友分享和上传,如发现用户通过斗图王分享的内容侵犯其著作权时,请"];
    _disclaimerView.attributedText = [[NSAttributedString alloc] initWithString:desStr attributes:attributes];
    
    [self.view addSubview:_disclaimerView];
}

@end
