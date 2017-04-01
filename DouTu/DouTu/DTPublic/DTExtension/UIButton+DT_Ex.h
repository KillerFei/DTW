//
//  UIButton+DT_Ex.h
//  DouTu
//
//  Created by yuepengfei on 17/4/1.
//  Copyright © 2017年 fly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (DT_Ex)

+ (UIButton *)dtButtonWithTitle:(NSString *)title
                          image:(UIImage *)image
                         target:(id)target
                         action:(SEL)action;


@end
