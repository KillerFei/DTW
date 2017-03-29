//
//  DTFunctionView.m
//  DouTu
//
//  Created by yuepengfei on 17/3/16.
//  Copyright © 2017年 fly. All rights reserved.
//

#import "DTFunctionView.h"

@interface DTFunctionView ()
@property (nonatomic, strong) UIView      *contentView;
@property (nonatomic, strong) UIImageView *showView;
@property (nonatomic, strong) UIButton    *qqBtn;
@property (nonatomic, strong) UIButton    *wxBtn;
@property (nonatomic, strong) UIButton    *collectBtn;
@property (nonatomic, strong) UIButton    *saveBtn;
@end

@implementation DTFunctionView

- (UIView *)contentView
{
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = [UIColor whiteColor];
    }
    return _contentView;
}

- (UIImageView *)showView
{
    if (!_showView) {
        _showView = [[UIImageView alloc] init];
        _showView.contentMode = UIViewContentModeScaleAspectFit;
        _showView.layer.masksToBounds = YES;
        _showView.layer.cornerRadius  = 5;
        _showView.layer.borderWidth   = .5;
        _showView.layer.borderColor   = DT_Base_GrayEdgeColor.CGColor;
    }
    return _showView;
}
- (UIButton *)qqBtn
{
    if (!_qqBtn) {
        _qqBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_qqBtn setTitle:@"QQ" forState:UIControlStateNormal];
        [_qqBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_qqBtn setImage:[UIImage imageNamed:@"dt_logo_qq_black"] forState:UIControlStateNormal];
        _qqBtn.backgroundColor = DT_Base_EdgeColor;
        _qqBtn.titleLabel.font = DT_Base_ContentFont;
        _qqBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -3, 0, 3);
        _qqBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 3, 0, -3);
        _qqBtn.layer.masksToBounds = YES;
        _qqBtn.layer.cornerRadius  = 17.5;
        [_qqBtn addTarget:self action:@selector(qqBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _qqBtn;
}
- (UIButton *)wxBtn
{
    if (!_wxBtn) {
        _wxBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_wxBtn setTitle:@"微信" forState:UIControlStateNormal];
        [_wxBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_wxBtn setImage:[UIImage imageNamed:@"dt_logo_wx_black"] forState:UIControlStateNormal];
        _wxBtn.backgroundColor = DT_Base_EdgeColor;
        _wxBtn.titleLabel.font = DT_Base_ContentFont;
        _wxBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -3, 0, 3);
        _wxBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 3, 0, -3);
        _wxBtn.layer.masksToBounds = YES;
        _wxBtn.layer.cornerRadius  = 17.5;
        [_wxBtn addTarget:self action:@selector(wxBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _wxBtn;
}
- (UIButton *)collectBtn
{
    if (!_collectBtn) {
        _collectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_collectBtn setTitle:@"收藏" forState:UIControlStateNormal];
        [_collectBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_collectBtn setImage:[UIImage imageNamed:@"dt_down_em"] forState:UIControlStateNormal];
        _collectBtn.titleLabel.font = DT_Base_ContentFont;
        _collectBtn.backgroundColor = DT_Base_EdgeColor;
        _collectBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -3, 0, 3);
        _collectBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 3, 0, -3);
        _collectBtn.layer.masksToBounds = YES;
        _collectBtn.layer.cornerRadius  = 17.5;
        [_collectBtn addTarget:self action:@selector(collectBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _collectBtn;
}
- (UIButton *)saveBtn
{
    if (!_saveBtn) {
        _saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_saveBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_saveBtn setTitle:@"下载" forState:UIControlStateNormal];
        [_saveBtn setImage:[UIImage imageNamed:@"dt_favor_normal"] forState:UIControlStateNormal];
        _saveBtn.backgroundColor = DT_Base_EdgeColor;
        _saveBtn.titleLabel.font = DT_Base_ContentFont;
        _saveBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -3, 0, 3);
        _saveBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 3, 0, -3);
        _saveBtn.layer.masksToBounds = YES;
        _saveBtn.layer.cornerRadius  = 17.5;
    }
    return _saveBtn;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    
        [self addSubview:self.contentView];
        [self.contentView addSubview:self.showView];
        [self.contentView addSubview:self.qqBtn];
        [self.contentView addSubview:self.wxBtn];
        [self.contentView addSubview:self.collectBtn];
        [self.contentView addSubview:self.saveBtn];
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self).with.offset(3);
        make.left.bottom.right.equalTo(self);
    }];
    
        [_showView mas_makeConstraints:^(MASConstraintMaker *make) {
    
            make.left.top.equalTo(_contentView).with.offset(15);
            make.size.mas_equalTo(CGSizeMake(120, 120));
        }];
    
        CGFloat btnWidth = (KSCREEN_WIDTH-60-120)/2;
        [_collectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    
            make.left.equalTo(self.showView.mas_right).with.offset(15);
            make.bottom.equalTo(self.showView);
            make.size.mas_equalTo(CGSizeMake(btnWidth, 40));
        }];
        [_saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    
            make.left.equalTo(self.collectBtn.mas_right).with.offset(15);
            make.bottom.equalTo(self.collectBtn);
            make.size.mas_equalTo(CGSizeMake(btnWidth, 40));
        }];
        [_qqBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    
            make.left.equalTo(self.collectBtn.mas_left);
            make.bottom.equalTo(self.collectBtn.mas_top).with.offset(-15);
            make.size.mas_equalTo(CGSizeMake(btnWidth, 40));
        }];
        [_wxBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    
            make.left.equalTo(self.qqBtn.mas_right).with.offset(15);
            make.bottom.equalTo(self.collectBtn.mas_top).with.offset(-15);
            make.size.mas_equalTo(CGSizeMake(btnWidth, 40));
        }];
}
- (void)configModel:(DTBaseModel *)model
{
    if (!model) return;
    [_showView sd_setImageWithURL:[NSURL safeURLWithString:model.gifPath] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (error) {
            [_showView sd_setImageWithURL:[NSURL safeURLWithString:model.picPath]];
        }
    }];
}
#pragma mark - qqBtnAction
- (void)qqBtnAction
{
    if (_delegate && [_delegate respondsToSelector:@selector(sendPicToQQ)]) {
        [_delegate sendPicToQQ];
    }
}
- (void)wxBtnAction
{
    if (_delegate && [_delegate respondsToSelector:@selector(sendPicToWx)]) {
        [_delegate sendPicToWx];
    }
}
- (void)collectBtnAction
{
    if (_delegate && [_delegate respondsToSelector:@selector(collectPic)]) {
        [_delegate collectPic];
    }
}
@end
