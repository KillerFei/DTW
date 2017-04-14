//
//  DTCustomSegmentedControl.m
//  DouTu
//
//  Created by yuepengfei on 17/3/29.
//  Copyright © 2017年 fly. All rights reserved.
//

#import "DTCustomSegmentedControl.h"

@interface DTCustomSegmentedControl ()

@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic, strong) UIButton *seleteBtn;
@end

@implementation DTCustomSegmentedControl

- (UIButton *)leftBtn
{
    if (!_leftBtn) {
        _leftBtn = [UIButton dtNormalButtonWithTitle:@"最新" titleFont:DT_Nav_TitleFont titleColor:DT_Nav_TitleColor image:nil bgColor:nil bgImg:nil target:self action:@selector(btnAction:)];
        [_leftBtn setBackgroundImage:[UIImage imageNamed:@"dt_make_seg_btn_left"] forState:UIControlStateSelected];
        _leftBtn.userInteractionEnabled = NO;
        _leftBtn.selected = YES;
        _leftBtn.tag      = 10001;
        _seleteBtn        = _leftBtn;
    }
    return _leftBtn;
}
- (UIButton *)rightBtn
{
    if (!_rightBtn) {
        
        _rightBtn = [UIButton dtNormalButtonWithTitle:@"分类" titleFont:DT_Nav_TitleFont titleColor:DT_Nav_TitleColor image:nil bgColor:nil bgImg:nil target:self action:@selector(btnAction:)];
        [_rightBtn setBackgroundImage:[UIImage imageNamed:@"dt_make_seg_btn_right"] forState:UIControlStateSelected];
        _rightBtn.tag = 10002;
        
    }
    return _rightBtn;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubViews];
    }
    return self;
}
- (void)addSubViews
{
    self.image = [UIImage imageNamed:@"dt_make_seg_bg"];
    self.userInteractionEnabled = YES;
    [self addSubview:self.leftBtn];
    [self addSubview:self.rightBtn];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.top.bottom.equalTo(self);
        make.width.mas_equalTo(@(self.width/2));
    }];
    
    [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.top.bottom.equalTo(self);
        make.left.equalTo(_leftBtn.mas_right);
    }];
}
#pragma mark - btnAction:
- (void)btnAction:(UIButton *)sender
{
    _seleteBtn.selected = NO;
    _seleteBtn.userInteractionEnabled = YES;
    _seleteBtn = sender;
    _seleteBtn.selected = YES;
    _seleteBtn.userInteractionEnabled = NO;    
    if (_delegate && [_delegate respondsToSelector:@selector(didSeleteSegmentedControlAtIndex:)]) {
        
        [_delegate didSeleteSegmentedControlAtIndex:sender.tag-10001];
    }
    
}
@end
