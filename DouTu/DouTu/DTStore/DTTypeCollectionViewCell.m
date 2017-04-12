//
//  DTTypeCollectionViewCell.m
//  DouTu
//
//  Created by yuepengfei on 17/3/28.
//  Copyright © 2017年 fly. All rights reserved.
//

#import "DTTypeCollectionViewCell.h"

@interface DTTypeCollectionViewCell ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel     *titleLabel;
@property (nonatomic, strong) UIImageView *cornerView;
@end

@implementation DTTypeCollectionViewCell

- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imageView;
}
- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = DT_Base_ContentFont;
        _titleLabel.textColor = DT_Base_ContentColor;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}
- (UIImageView *)cornerView
{
    if (!_cornerView) {
        _cornerView = [[UIImageView alloc] init];
        _cornerView.image = [[UIImage imageNamed:@"dt_base_corner_bg"] stretchableImageWithLeftCapWidth:12.5 topCapHeight:12.5];
    }
    return _cornerView;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.imageView];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.cornerView];
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView).with.offset(-5);
        make.height.mas_equalTo(@12);
    }];
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(self.contentView).with.offset(5);
        make.bottom.equalTo(self.titleLabel.mas_top).with.offset(-5);
    }];
    [_cornerView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.left.bottom.right.equalTo(self.contentView);
    }];
}
- (void)configModel:(DTBaseModel *)model
{
    _titleLabel.text = model.name;
    if (model.insert) {
        
    } else {
        [_imageView sd_setImageWithURL:[NSURL URLWithString:model.picPath]];
    }
}
- (void)prepareForReuse
{
    [super prepareForReuse];
    _titleLabel.text = nil;
    _imageView.image = nil;
}
@end
