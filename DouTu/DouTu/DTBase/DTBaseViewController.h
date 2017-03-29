//
//  DTBaseViewController.h
//  DouTu
//
//  Created by yuepengfei on 17/3/14.
//  Copyright © 2017年 fly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DTBaseViewController : UIViewController

@property (nonatomic, strong) NSString *navTitle;

- (void)hideNavBar:(BOOL)isHide;
- (void)setLeftBackNavItem;
@end
