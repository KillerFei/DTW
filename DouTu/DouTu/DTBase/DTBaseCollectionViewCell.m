//
//  DTBaseCollectionViewCell.m
//  DouTu
//
//  Created by yuepengfei on 17/3/14.
//  Copyright © 2017年 fly. All rights reserved.
//

#import "DTBaseCollectionViewCell.h"

@interface DTBaseCollectionViewCell ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImageView *cornerView;
@end
@implementation DTBaseCollectionViewCell
- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
    }
    return _imageView;
}
- (UIImageView *)cornerView
{
    if (!_cornerView) {
        _cornerView = [[UIImageView alloc] init];
        _cornerView.image = [[UIImage imageNamed:@"dt_base_corner_bg"] stretchableImageWithLeftCapWidth:12.5 topCapHeight:12.5];
    }
    return _cornerView;
}

- (UILabel *)nameLab
{
    if (!_nameLab) {
        _nameLab = [[UILabel alloc] init];
        _nameLab.font = [UIFont systemFontOfSize:9];
        _nameLab.textAlignment =NSTextAlignmentCenter;
        _nameLab.shadowColor = [UIColor whiteColor];
        _nameLab.shadowOffset = CGSizeMake(1, 1);
        _nameLab.textColor = [UIColor blackColor];
    }
    return _nameLab;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.imageView];
        [self.contentView addSubview:self.nameLab];
        [self.contentView addSubview:self.cornerView];
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.contentView);
    }];
    [_nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).with.offset(5);
        make.bottom.right.equalTo(self.contentView).with.offset(-5);
        make.height.mas_equalTo(@9);
    }];
    [_cornerView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.left.bottom.right.equalTo(self.contentView);
    }];
}
- (void)configModel:(DTBaseModel *)model
{
    if ([model.mediaType isEqualToNumber:@0]) {
        
        [_imageView sd_setImageWithURL:[NSURL safeURLWithString:model.picPath] placeholderImage:[UIImage imageNamed:@"dt_loadingImg"]];
    } else {
        [_imageView sd_setImageWithURL:[NSURL safeURLWithString:model.gifPath] placeholderImage:[UIImage imageNamed:@"dt_loadingImg"]];
    }
    _nameLab.text = model.name;
}
- (void)resetCornerView
{
    _cornerView.image = [[UIImage imageNamed:@"dt_base_corner_bg"] stretchableImageWithLeftCapWidth:12.5 topCapHeight:12.5];
}
- (void)seleteCornerView
{
    _cornerView.image = [[UIImage imageNamed:@"dt_base_corner_bg_ye"] stretchableImageWithLeftCapWidth:12.5 topCapHeight:12.5];
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    _imageView.image = nil;
    _nameLab.text = nil;
}
@end
