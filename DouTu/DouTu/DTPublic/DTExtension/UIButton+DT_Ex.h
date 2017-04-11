//
//  UIButton+DT_Ex.h
//  DouTu
//
//  Created by yuepengfei on 17/4/1.
//  Copyright © 2017年 fly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (DT_Ex)

+ (UIButton *)dtFuncButtonWithTitle:(NSString *)title
                          image:(UIImage *)image
                         target:(id)target
                         action:(SEL)action;

+ (UIButton *)dtNormalButtonWithTitle:(NSString *)title
                            titleFont:(UIFont *)titleFont
                           titleColor:(UIColor *)titleColor
                                image:(UIImage *)image
                              bgColor:(UIColor *)bgColor
                                bgImg:(UIImage *)bgImg
                               target:(id)target
                               action:(SEL)action;

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




@end
