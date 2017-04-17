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
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
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
    [_disclaimerView setTextContainerInset:UIEdgeInsetsMake(20, 10, 5, 10)];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = 8;
    NSDictionary *attributes = @{
                                 NSFontAttributeName:DT_Base_TitleFont,
                                 NSParagraphStyleAttributeName:style,
                                 NSForegroundColorAttributeName:DT_Base_TitleColor
                                 };
    
    NSString *desStr = [NSString stringWithFormat:@"  斗图王部分表情来自网络，其版权归原作者所有，如有侵权，请及时联系，我们会尽快处理。欢迎表情制作者与我们联系，把您的表情分享给更多的用户。\n\n联系方式:\n邮箱:1468407663@qq.com"];
    _disclaimerView.attributedText = [[NSAttributedString alloc] initWithString:desStr attributes:attributes];
    
    [self.view addSubview:_disclaimerView];
}

@end
