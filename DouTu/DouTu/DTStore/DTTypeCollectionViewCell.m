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
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.contentView.layer.masksToBounds = YES;
//        self.contentView.layer.cornerRadius  = 5;
//        self.contentView.layer.borderColor   = DT_Base_GrayEdgeColor.CGColor;
//        self.contentView.layer.borderWidth   = 0.5;
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
        make.height.mas_equalTo(@12);
    }];
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(self.contentView).with.offset(5);
        make.bottom.equalTo(self.titleLabel.mas_top).with.offset(-5);
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
