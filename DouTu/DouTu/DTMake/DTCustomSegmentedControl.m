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
        _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _seleteBtn = _leftBtn;
        _leftBtn.tag = 10001;
        _leftBtn.selected = YES;
        _leftBtn.userInteractionEnabled = NO;
        _leftBtn.titleLabel.font = DT_Nav_TitleFont;
        [_leftBtn setTitle:@"最新" forState:UIControlStateNormal];
        [_leftBtn setTitleColor:DT_Nav_TitleColor forState:UIControlStateNormal];
        [_leftBtn setBackgroundImage:[UIImage imageNamed:@"dt_make_seg_btn_left"] forState:UIControlStateSelected];
        [_leftBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftBtn;
}
- (UIButton *)rightBtn
{
    if (!_rightBtn) {
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightBtn.tag = 10002;
        _rightBtn.titleLabel.font = DT_Nav_TitleFont;
        [_rightBtn setTitle:@"分类" forState:UIControlStateNormal];
        [_rightBtn setTitleColor:DT_Nav_TitleColor forState:UIControlStateNormal];
        [_rightBtn setBackgroundImage:[UIImage imageNamed:@"dt_make_seg_btn_right"] forState:UIControlStateSelected];
        [_rightBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
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
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius  = 5;
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
