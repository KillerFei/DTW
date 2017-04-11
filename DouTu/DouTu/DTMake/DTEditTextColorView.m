//
//  DTEditTextColorView.m
//  DouTu
//
//  Created by 岳鹏飞 on 2017/4/5.
//  Copyright © 2017年 fly. All rights reserved.
//

#import "DTEditTextColorView.h"

@implementation DTEditTextColorView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubviews];
    }
    return self;
}
- (void)addSubviews
{
    CGFloat btnHorSpace = 45;
    CGFloat btnVerSpace = 15;
    CGFloat btnHeight   = (self.height-6*btnVerSpace-30)/5;
    for (int i = 0; i < 6; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag   = 10000+i;
        button.frame = CGRectMake(btnHorSpace, btnVerSpace*(i+1)+btnHeight*i, self.width-btnHorSpace*2, btnHeight);
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        if (i==5) {
            button.height = 30;
        }
        [self addSubview:button];
        switch (i) {
            case 0:
                [button setImage:[UIImage imageNamed:@"dt_textColor_black"] forState:UIControlStateNormal];
                break;
            case 1:
                [button setImage:[UIImage imageNamed:@"dt_textColor_white"] forState:UIControlStateNormal];
                break;
            case 2:
                [button setImage:[UIImage imageNamed:@"dt_textColor_blue"] forState:UIControlStateNormal];
                break;
            case 3:
                [button setImage:[UIImage imageNamed:@"dt_textColor_green"] forState:UIControlStateNormal];
                break;
            case 4:
                [button setImage:[UIImage imageNamed:@"dt_textColor_red"] forState:UIControlStateNormal];
                break;
            case 5:
                [button setImage:[UIImage imageNamed:@"dt_textColor_bold"] forState:UIControlStateNormal];
                break;
            default:
                break;
        }
    }
}
#pragma mark - ButtonAction
- (void)buttonAction:(UIButton *)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(didClickButton:AtIndex:)]) {
        [_delegate didClickButton:sender AtIndex:sender.tag-10000];
    }
}
@end
