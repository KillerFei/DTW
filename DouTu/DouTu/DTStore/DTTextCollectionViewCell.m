//
//  DTTextCollectionViewCell.m
//  DouTu
//
//  Created by yuepengfei on 17/3/28.
//  Copyright © 2017年 fly. All rights reserved.
//

#import "DTTextCollectionViewCell.h"

@interface DTTextCollectionViewCell ()

@property (nonatomic, strong) UILabel     *titleLabel;
@property (nonatomic, strong) UIImageView *cornerView;
@end
@implementation DTTextCollectionViewCell
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
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.cornerView];
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.left.bottom.right.equalTo(self.contentView);
    }];
    [_cornerView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.left.bottom.right.equalTo(self.contentView);
    }];
}
- (void)configModel:(DTBaseModel *)model
{
    _titleLabel.text = model.name;
}
- (void)prepareForReuse
{
    [super prepareForReuse];
    _titleLabel.text = nil;
}

@end
