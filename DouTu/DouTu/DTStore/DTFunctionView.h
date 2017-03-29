//
//  DTFunctionView.h
//  DouTu
//
//  Created by yuepengfei on 17/3/16.
//  Copyright © 2017年 fly. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DTFunctionViewDelegate <NSObject>

- (void)sendPicToWx;
- (void)sendPicToQQ;
- (void)collectPic;
@end

@interface DTFunctionView : UIView

@property (nonatomic, assign) id<DTFunctionViewDelegate>delegate;

- (void)configModel:(DTBaseModel *)model;

@end
