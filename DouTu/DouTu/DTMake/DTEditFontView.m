//
//  DTEditFontView.m
//  DouTu
//
//  Created by yuepengfei on 17/3/21.
//  Copyright © 2017年 fly. All rights reserved.
//

#import "DTEditFontView.h"

@implementation DTEditFontView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self addSubviews];
    }
    return self;
}
- (void)addSubviews
{
    // 字体：方正兰亭
    CGFloat ftLeft   = 30;
    CGFloat ftTop    = 30;
    CGFloat ftHeight = 35;
    CGFloat ftWidth  = 120;
    CGFloat verSpace = KSCREEN_WIDTH-ftLeft*2-ftWidth*2;
    CGFloat horSpace = (self.height-ftTop*2-ftHeight*4)/3;
    for (int i = 1; i < 9; i++) {
        UIButton *btn = [UIButton dtNormalButtonWithTitle:@"字体效果" titleFont:nil titleColor:[UIColor blackColor] image:nil bgColor:nil bgImg:[UIImage imageNamed:@"dt_base_corner_bg"] target:self action:@selector(btnAction:)];
        btn.frame = CGRectMake(ftLeft, ftTop, ftWidth, ftHeight);
        
        if (i%2) {
            ftLeft = ftLeft+ftWidth+verSpace;
        } else {
            ftLeft = 30;
            ftTop = ftTop+ftHeight+horSpace;
        }
        [self addSubview:btn];
        
        switch (i) {
            case 1:
                btn.titleLabel.font = [UIFont fontWithName:@"FZLTXHK--GBK1-0"size:15];
                break;
            case 2:
                btn.titleLabel.font = [UIFont fontWithName:@"MComicHK-Medium" size:15];
                break;
            case 3:
                
                break;
            case 4:
                
                break;
            case 5:
                
                break;
            case 6:
                
                break;
            case 7:
                
                break;
            case 8:
                
                break;
            default:
                break;
        }
    }
}
#pragma mark - setDelegate
- (void)setDelegate:(id<DTEditFontViewDelegate>)delegate
{
    _delegate = delegate;
}
#pragma mark - btnAction
- (void)btnAction:(UIButton *)btn
{
    if (_delegate && [_delegate respondsToSelector:@selector(useThisFont:)]) {
        
        [_delegate useThisFont:btn.titleLabel.font];
    }
}
@end
