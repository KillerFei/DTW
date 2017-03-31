//
//  DTBaseTitleCollectionViewCell.m
//  DouTu
//
//  Created by 岳鹏飞 on 2017/3/14.
//  Copyright © 2017年 fly. All rights reserved.
//

#import "DTBaseTitleCollectionViewCell.h"

@interface DTBaseTitleCollectionViewCell ()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel     *titleLabel;
@end
@implementation DTBaseTitleCollectionViewCell

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
        _titleLabel.font = DT_Base_TitleFont;
        _titleLabel.textColor = DT_Base_TitleColor;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.imageView];
        [self.contentView addSubview:self.titleLabel];
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView).with.offset(-5);
        make.height.mas_equalTo(@15);
    }];
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.contentView);
        make.bottom.equalTo(self.titleLabel.mas_top);
    }];
}
- (void)configModel:(DTBaseModel *)model
{
    _titleLabel.text = model.name;
    [_imageView sd_setImageWithURL:[NSURL URLWithString:model.picPath]];
}
- (void)prepareForReuse
{
    [super prepareForReuse];
    _titleLabel.text = nil;
    _imageView.image = nil;
}
@end
