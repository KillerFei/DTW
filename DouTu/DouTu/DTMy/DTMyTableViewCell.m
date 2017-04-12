//
//  DTMyTableViewCell.m
//  DouTu
//
//  Created by 岳鹏飞 on 2017/3/18.
//  Copyright © 2017年 fly. All rights reserved.
//

#import "DTMyTableViewCell.h"

@implementation DTMyTableViewCell

- (UIImageView *)iconView
{
    if (!_iconView) {
        _iconView = [[UIImageView alloc] init];
    }
    return _iconView;
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
- (UILabel *)cacheLabel
{
    if (!_cacheLabel) {
        _cacheLabel = [[UILabel alloc] init];
        _cacheLabel.text = @"0.00M";
        _cacheLabel.font = DT_Base_ContentFont;
        _cacheLabel.textColor = DT_Base_ContentColor;
        _cacheLabel.textAlignment = NSTextAlignmentRight;
    }
    return _cacheLabel;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self.contentView addSubview:self.iconView];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.cacheLabel];
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).with.offset(10);
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(19, 19));
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_iconView.mas_right).with.offset(8);
        make.top.bottom.equalTo(self.contentView);
        make.right.equalTo(self.contentView).with.offset(-32);
    }];
    
    [_cacheLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(self.contentView).with.offset(-10);
        make.top.bottom.equalTo(self.contentView);
        make.width.mas_equalTo(@100);
    }];
}
- (void)prepareForReuse
{
    [super prepareForReuse];
    _iconView.image   = nil;
    _titleLabel.text  = nil;
    _cacheLabel.text  = nil;
}
@end
