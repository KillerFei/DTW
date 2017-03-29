//
//  DTCollectionReusableView.m
//  DouTu
//
//  Created by 岳鹏飞 on 2017/3/14.
//  Copyright © 2017年 fly. All rights reserved.
//

#import "DTCollectionReusableView.h"

@implementation DTCollectionReusableView
- (UIImageView *)iconImg
{
    if (!_iconImg) {
        _iconImg = [[UIImageView alloc] init];
        _iconImg.image = [UIImage imageNamed:@"dt_square"];
    }
    return _iconImg;
}
- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = DT_Base_TitleFont;
        _titleLabel.textColor = DT_Base_TitleColor;
    }
    return _titleLabel;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.iconImg];
        [self addSubview:self.titleLabel];
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    [_iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
    
        make.centerY.equalTo(self);
        make.left.equalTo(self).with.offset(DT_Base_Space);
        make.size.mas_equalTo(CGSizeMake(6, 15));
    }];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.bottom.right.equalTo(self);
        make.left.equalTo(_iconImg.mas_right).with.offset(8);
    }];
}
@end
