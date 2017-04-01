//
//  UIButton+DT_Ex.m
//  DouTu
//
//  Created by yuepengfei on 17/4/1.
//  Copyright © 2017年 fly. All rights reserved.
//

#import "UIButton+DT_Ex.h"

@implementation UIButton (DT_Ex)

+ (UIButton *)dtButtonWithTitle:(NSString *)title
                          image:(UIImage *)image
                         target:(id)target
                         action:(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.backgroundColor = DT_Base_EdgeColor;
    btn.titleLabel.font = DT_Base_ContentFont;
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius  = 17.5;
    return btn;
}
@end
