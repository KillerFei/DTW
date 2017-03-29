//
//  DTMakeHeaderCell.m
//  DouTu
//
//  Created by 岳鹏飞 on 2017/3/19.
//  Copyright © 2017年 fly. All rights reserved.
//

#import "DTMakeHeaderCell.h"

@interface DTMakeHeaderCell ()

@property (nonatomic, strong) UIView      *topLineView;
@property (nonatomic, strong) UIImageView *iconImg;
@property (nonatomic, strong) UILabel     *titleLab;
@property (nonatomic, strong) UIView      *bottomLineView;
@property (nonatomic, strong) UIView      *rightLineView;
@end
@implementation DTMakeHeaderCell

- (UIView *)topLineView
{
    if (!_topLineView) {
        _topLineView = [[UIView alloc] init];
        _topLineView.backgroundColor = DT_Base_LineColor;
    }
    return _topLineView;
}
- (UIImageView *)iconImg
{
    if (!_iconImg) {
        _iconImg = [[UIImageView alloc] init];
    }
    return _iconImg;
}
- (UILabel *)titleLab
{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.font = DT_Base_TitleFont;
        _titleLab.textColor = DT_Base_TitleColor;
        _titleLab.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLab;
}
- (UIView *)bottomLineView
{
    if (!_bottomLineView) {
        _bottomLineView = [[UIView alloc] init];
        _bottomLineView.backgroundColor = DT_Base_LineColor;
    }
    return _bottomLineView;
}
- (UIView *)rightLineView
{
    if (!_rightLineView) {
        _rightLineView = [[UIView alloc] init];
        _rightLineView.backgroundColor = DT_Base_LineColor;
    }
    return _rightLineView;
}
#pragma mark - init
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self.contentView addSubview:self.topLineView];
        [self.contentView addSubview:self.iconImg];
        [self.contentView addSubview:self.titleLab];
        [self.contentView addSubview:self.bottomLineView];
        [self.contentView addSubview:self.rightLineView];
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    [_topLineView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.left.right.equalTo(self.contentView);
        make.height.mas_equalTo(@1);
    }];
    
    [_bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.bottom.right.equalTo(self.contentView);
        make.height.mas_equalTo(@1);
    }];
    
    [_iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.contentView).with.offset(11);
        make.centerX.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(29, 29));
    }];
    
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView).with.offset(-5);
        make.height.mas_equalTo(@15);
    }];
    
   [_rightLineView mas_makeConstraints:^(MASConstraintMaker *make) {
      
       make.left.equalTo(self.contentView.mas_right).with.offset(-.5);
       make.centerY.equalTo(self.contentView);
       make.size.mas_equalTo(CGSizeMake(1, 44));
   }];
}
#pragma mark ----- configModel
- (void)configModel:(DTBaseModel *)model
{
    _titleLab.text = model.name;
    _iconImg.image = model.defaultImg;
}
- (void)prepareForReuse
{
    [super prepareForReuse];
    _titleLab.text = nil;
    _iconImg.image = nil;
}
@end
