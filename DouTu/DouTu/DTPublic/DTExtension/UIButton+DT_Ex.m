//
//  UIButton+DT_Ex.m
//  DouTu
//
//  Created by yuepengfei on 17/4/1.
//  Copyright © 2017年 fly. All rights reserved.
//

#import "UIButton+DT_Ex.h"

@implementation UIButton (DT_Ex)

+ (UIButton *)dtFuncButtonWithTitle:(NSString *)title
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

+ (UIButton *)dtNormalButtonWithTitle:(NSString *)title
                            titleFont:(UIFont *)titleFont
                           titleColor:(UIColor *)titleColor
                                image:(UIImage *)image
                              bgColor:(UIColor *)bgColor
                                bgImg:(UIImage *)bgImg
                               target:(id)target
                               action:(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = bgColor;
    btn.titleLabel.font = titleFont;
    [btn setImage:image forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    [btn setBackgroundImage:[bgImg stretchableImageWithLeftCapWidth:bgImg.size.width/2 topCapHeight:bgImg.size.height/2] forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

+ (UIButton *)dtCornerButtonWithTitle:(NSString *)title
                            titleFont:(UIFont *)titleFont
                           titleColor:(UIColor *)titleColor
                                image:(UIImage *)image
                              bgColor:(UIColor *)bgColor
                                bgImg:(UIImage *)bgImg
                                masks:(BOOL)mask
                               radius:(CGFloat)radius
                          borderColor:(UIColor *)borderColor
                          borderWidth:(CGFloat)borderWidth
                               target:(id)target
                               action:(SEL)action;
{
    UIButton *btn = [UIButton dtNormalButtonWithTitle:title titleFont:titleFont titleColor:titleColor image:image bgColor:bgColor bgImg:bgImg target:self action:action];
    btn.layer.masksToBounds = mask;
    btn.layer.cornerRadius  = radius;
    btn.layer.borderColor   = borderColor.CGColor;
    btn.layer.borderWidth   = borderWidth;
    
    return btn;
}

@end
