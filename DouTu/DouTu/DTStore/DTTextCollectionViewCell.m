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
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.contentView.layer.masksToBounds = YES;
//        self.contentView.layer.cornerRadius  = 5;
//        self.contentView.layer.borderColor   = DT_Base_GrayEdgeColor.CGColor;
//        self.contentView.layer.borderWidth   = 0.5;
        [self.contentView addSubview:self.titleLabel];
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
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
