//
//  DTHudManager.h
//  DouTu
//
//  Created by yuepengfei on 17/3/16.
//  Copyright © 2017年 fly. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DTHudManager : NSObject

+ (void)showHudInView:(UIView *)view;
+ (void)showMessage:(NSString *)message InView:(UIView *)view;

+ (void)hideHudInView:(UIView *)view;

@end
