//
//  DTShareView.m
//  DouTu
//
//  Created by 岳鹏飞 on 2017/4/2.
//  Copyright © 2017年 fly. All rights reserved.
//

#import "DTShareView.h"

@interface DTShareView ()

@property (nonatomic, strong) UIImageView *showView;
@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel     *saveLabel;
@property (nonatomic, strong) UILabel     *sendLabel;
@property (nonatomic, strong) UIButton    *wxBtn;
@property (nonatomic, strong) UIButton    *qqBtn;
@property (nonatomic, strong) UIButton    *downBtn;
@property (nonatomic, strong) UIButton    *backBtn;
@property (nonatomic, strong) UIButton    *backDIYBtn;
@end

@implementation DTShareView

- (UIImageView *)showView
{
    if (!_showView) {
        _showView = [[UIImageView alloc] init];
        _showView.contentMode = UIViewContentModeScaleAspectFit;
        _showView.backgroundColor = DT_Base_EdgeColor;
    }
    return _showView;
}
- (UIImageView *)iconView
{
    if (!_iconView) {
        _iconView = [[UIImageView alloc] init];
        _iconView.image = [UIImage imageNamed:@"dt_share_save"];
    }
    return _iconView;
}
- (UILabel *)saveLabel
{
    if (!_saveLabel) {
        _saveLabel = [[UILabel alloc] init];
        _saveLabel.textColor = [UIColor whiteColor];
        _saveLabel.font      = DT_Base_TitleFont;
        _saveLabel.text      = @"已保存至收藏—DIY";
    }
    return _saveLabel;
}
- (UILabel *)sendLabel
{
    if (!_sendLabel) {
        _sendLabel = [[UILabel alloc] init];
        _sendLabel.textColor = [UIColor whiteColor];
        _sendLabel.font      = DT_Base_TitleFont;
        _sendLabel.text      = @"发送到:";
    }
    return _sendLabel;
}
- (UIButton *)wxBtn
{
    if (!_wxBtn) {
        _wxBtn = [UIButton dtNormalButtonWithTitle:@"微信" titleFont:DT_Base_ContentFont titleColor:[UIColor whiteColor] image:[UIImage imageNamed:@"dt_share_wx"] bgColor:[UIColor clearColor] bgImg:nil target:self action:@selector(wxBtnAction)];
        [self configHorBtn:_wxBtn];
    }
    return _wxBtn;
}
- (UIButton *)qqBtn
{
    if (!_qqBtn) {
        _qqBtn = [UIButton dtNormalButtonWithTitle:@"QQ" titleFont:DT_Base_ContentFont titleColor:[UIColor whiteColor] image:[UIImage imageNamed:@"dt_share_qq"] bgColor:[UIColor clearColor] bgImg:nil target:self action:@selector(qqBtnAction)];
        [self configHorBtn:_qqBtn];
    }
    return _qqBtn;
}
- (UIButton *)downBtn
{
    if (!_downBtn) {
        _downBtn = [UIButton dtNormalButtonWithTitle:@"下载" titleFont:DT_Base_ContentFont titleColor:[UIColor whiteColor] image:[UIImage imageNamed:@"dt_share_down"] bgColor:[UIColor clearColor] bgImg:nil target:self action:@selector(downBtnAction)];
        [self configHorBtn:_downBtn];
    }
    return _downBtn;
}
- (void)configHorBtn:(UIButton *)btn
{
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    btn.titleEdgeInsets = UIEdgeInsetsMake(53, -45.5, 0, 0);
    btn.imageEdgeInsets = UIEdgeInsetsMake(-16.5, 0, 0, 0);
}
- (UIButton *)backBtn
{
    if (!_backBtn) {
        _backBtn = [UIButton dtNormalButtonWithTitle:@"返回上级" titleFont:DT_Base_TitleFont titleColor:[UIColor blackColor] image:nil bgColor:nil bgImg:[UIImage imageNamed:@"dt_share_back"] target:self action:@selector(backBtnAction)];
    }
    return _backBtn;
}
- (UIButton *)backDIYBtn
{
    if (!_backDIYBtn) {
        _backDIYBtn = [UIButton dtNormalButtonWithTitle:@"返回DIY广场" titleFont:DT_Base_TitleFont titleColor:[UIColor blackColor] image:nil bgColor:nil bgImg:[UIImage imageNamed:@"dt_share_back"] target:self action:@selector(backDIYBtnAction)];
    }
    return _backDIYBtn;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
        [self addSubview:self.showView];
        [self addSubview:self.iconView];
        [self addSubview:self.saveLabel];
        [self addSubview:self.sendLabel];
        [self addSubview:self.wxBtn];
        [self addSubview:self.qqBtn];
        [self addSubview:self.downBtn];
        [self addSubview:self.backBtn];
        [self addSubview:self.backDIYBtn];
    }
    return self;
}

- (void)layoutSubviews
{
    [self.showView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self);
        make.top.equalTo(self).with.offset(139);
        make.size.mas_equalTo(CGSizeMake(140, 140));
    }];
    
    CGSize saveSize = [@"已保存至收藏—DIY" boundingRectWithSize:CGSizeMake(MAXFLOAT, 15) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:DT_Base_TitleFont} context:nil].size;
    CGFloat space = (KSCREEN_WIDTH-saveSize.width-34)/2;
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_showView.mas_bottom).with.offset(13);
        make.left.equalTo(self).with.offset(space);
        make.size.mas_equalTo(CGSizeMake(24, 24));
    }];
    
    [self.saveLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_iconView.mas_right).with.offset(10);
        make.centerY.equalTo(_iconView);
        make.size.mas_equalTo(CGSizeMake(saveSize.width, 15));
    }];
    
    [self.sendLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).with.offset(45);
        make.top.equalTo(_iconView.mas_bottom).with.offset(18);
        make.size.mas_equalTo(CGSizeMake(KSCREEN_WIDTH-40*2, 15));
    }];
    [self.wxBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_sendLabel.mas_bottom).with.offset(20);
        make.left.equalTo(_sendLabel).with.offset(20);
        make.size.mas_equalTo(CGSizeMake(45.5, 66));
    }];
    
    [self.qqBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_wxBtn);
        make.size.mas_equalTo(CGSizeMake(45.5, 66));
        make.left.equalTo(_wxBtn.mas_right).with.offset((KSCREEN_WIDTH-255.5)/2);
    }];
    
    [self.downBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_wxBtn);
        make.size.mas_equalTo(CGSizeMake(45.5, 66));
        make.left.equalTo(_qqBtn.mas_right).with.offset((KSCREEN_WIDTH-255.5)/2);
    }];
    
    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_wxBtn.mas_bottom).with.offset(60);
        make.left.equalTo(self).with.offset(40);
        make.size.mas_equalTo(CGSizeMake(120, 36));
    }];
    
    [self.backDIYBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_backBtn);
        make.right.equalTo(self).with.offset(-40);
        make.size.mas_equalTo(CGSizeMake(120, 36));
    }];
}
#pragma mark - Button Action
- (void)wxBtnAction
{
    if (_delegate && [_delegate respondsToSelector:@selector(dtShareViewDidClickWXBtn)]) {
        
        [_delegate dtShareViewDidClickWXBtn];
    }
}
- (void)qqBtnAction
{
    if (_delegate && [_delegate respondsToSelector:@selector(dtShareViewDidClickQQBtn)]) {
        
        [_delegate dtShareViewDidClickQQBtn];
    }
}
- (void)downBtnAction
{
    if (_delegate && [_delegate respondsToSelector:@selector(dtShareViewDidClickDownBtn)]) {
        
        [_delegate dtShareViewDidClickDownBtn];
    }
}
- (void)backBtnAction
{
    if (_delegate && [_delegate respondsToSelector:@selector(dtShareViewDidClickBackBtn)]) {
        
        [_delegate dtShareViewDidClickBackBtn];
    }
}
- (void)backDIYBtnAction
{
    if (_delegate && [_delegate respondsToSelector:@selector(dtShareViewDidClickBackDIYBtn)]) {
        
        [_delegate dtShareViewDidClickBackDIYBtn];
    }
}
#pragma mark - Model
- (void)configPic:(NSString *)picPath
{
    if (!picPath) {
        return;
    }
    NSData *imgData = [NSData dataWithContentsOfFile:picPath];
    _showView.image = [UIImage sd_animatedGIFWithData:imgData];
}
@end
