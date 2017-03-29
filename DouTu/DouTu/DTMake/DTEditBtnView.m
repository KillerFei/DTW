//
//  DTEditBtnView.m
//  DouTu
//
//  Created by yuepengfei on 17/3/21.
//  Copyright © 2017年 fly. All rights reserved.
//

#import "DTEditBtnView.h"

@interface DTEditBtnView ()

@property (nonatomic, strong) UIView    *lineView;
@property (nonatomic, strong) UIButton  *seletBtn;

@end
@implementation DTEditBtnView

- (UIView *)lineView
{
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = DT_Base_EdgeColor;
    }
    return _lineView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubviews];
    }
    return self;
}
- (void)addSubviews
{
    self.backgroundColor = [UIColor whiteColor];
    CGFloat btnWidth = KSCREEN_WIDTH/4;
    for (int i = 0; i<4; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitleColor:DT_Base_TitleColor forState:UIControlStateNormal];
        [btn setTitleColor:DT_Base_EdgeColor forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 1000+i;
        btn.titleLabel.font = DT_Base_TitleFont;
        btn.frame = CGRectMake(0+btnWidth*i, 0, btnWidth, self.height);
        switch (i) {
            case 0:
                [btn setTitle:@"热门配文" forState:UIControlStateNormal];
                btn.selected = YES;
                _seletBtn = btn;
                break;
            case 1:
                [btn setTitle:@"文字色" forState:UIControlStateNormal];
                break;
            case 2:
                [btn setTitle:@"背景色" forState:UIControlStateNormal];
                break;
            case 3:
                [btn setTitle:@"字体" forState:UIControlStateNormal];
                break;
            default:
                break;
        }
        [self addSubview:btn];
    }
    self.lineView.frame = CGRectMake(0, self.height-2, 65, 2);
    self.lineView.centerX = self.seletBtn.centerX;
    [self addSubview:self.lineView];
}
#pragma mark -------- btnAction
- (void)btnAction:(UIButton *)sender
{
    if (sender == _seletBtn) {
        return;
    }
    [self startAnimatWithBtn:sender];
    if (_delegate && [_delegate respondsToSelector:@selector(seleteBtnAtIndex:)]) {
        [_delegate seleteBtnAtIndex:sender.tag-1000];
    }
}
#pragma mark - refresh seleteBtn
- (void)refreshSeleteBtnAtIndex:(NSInteger)index
{
    for (UIButton *btn in self.subviews) {
        
        if (btn.tag == 1000+index) {
            [self startAnimatWithBtn:btn];
        }
    }
}
- (void)startAnimatWithBtn:(UIButton *)sender
{
    _seletBtn.selected = NO;
    _seletBtn = sender;
    [UIView animateWithDuration:0.3 animations:^{
        _lineView.centerX = sender.centerX;
        _seletBtn.selected = YES;
    }];
}
@end
