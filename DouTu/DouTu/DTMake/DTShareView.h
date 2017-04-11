//
//  DTShareView.h
//  DouTu
//
//  Created by 岳鹏飞 on 2017/4/2.
//  Copyright © 2017年 fly. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DTShareViewDelegate<NSObject>

- (void)dtShareViewDidClickWXBtn;
- (void)dtShareViewDidClickQQBtn;
- (void)dtShareViewDidClickDownBtn;
- (void)dtShareViewDidClickBackBtn;
- (void)dtShareViewDidClickBackDIYBtn;
@end

@interface DTShareView : UIView

@property (nonatomic, strong) id<DTShareViewDelegate>delegate;

- (void)configPic:(NSString *)picPath;
@end
