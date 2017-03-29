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

        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"字体效果" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.frame = CGRectMake(ftLeft, ftTop, ftWidth, ftHeight);
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = 2;
        btn.layer.borderColor = DT_Base_LineColor.CGColor;
        btn.layer.borderWidth = 1;
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
@end
