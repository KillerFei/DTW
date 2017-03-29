//
//  DTMyHeaderView.m
//  DouTu
//
//  Created by 岳鹏飞 on 2017/3/18.
//  Copyright © 2017年 fly. All rights reserved.
//

#import "DTMyHeaderView.h"

@implementation DTMyHeaderView
{
    UIImageView *_logoView;
    UILabel     *_nameLabel;
    UILabel     *_versionLabel;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _logoView = [[UIImageView alloc]init];
        _logoView.layer.masksToBounds = YES;
        _logoView.layer.cornerRadius  = 37.5;
        _logoView.image = [UIImage imageNamed:@"dt_icon"];
        [self addSubview:_logoView];
        
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.font = DT_Base_TitleFont;
        _nameLabel.text = kAppName;
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.textColor = DT_Base_TitleColor;
        [self addSubview:_nameLabel];
        
        _versionLabel = [[UILabel alloc]init];
        _versionLabel.font = DT_Base_ContentFont;
        _versionLabel.text = [NSString stringWithFormat:@"V%@", [DTOnlineManager currentVerson]];
        _versionLabel.textAlignment = NSTextAlignmentCenter;
        _versionLabel.textColor = DT_Base_ContentColor;
        [self addSubview:_versionLabel];
    }
    return self;
}
#pragma mark - layout
- (void)layoutSubviews
{
    [super layoutSubviews];
    [_logoView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self).with.offset(40);
        make.centerX.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(75, 75));
    }];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_logoView.mas_bottom).with.offset(12);
        make.left.right.equalTo(self);
        make.height.mas_equalTo(@15);
    }];
    
    [_versionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_nameLabel.mas_bottom).with.offset(10);
        make.left.right.equalTo(self);
        make.height.mas_equalTo(@13);
    }];
}
@end
