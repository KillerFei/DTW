//
//  DTCustomSegmentedControl.h
//  DouTu
//
//  Created by yuepengfei on 17/3/29.
//  Copyright © 2017年 fly. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DTCustomSegmentedControlDelegate<NSObject>

- (void)didSeleteSegmentedControlAtIndex:(NSInteger)index;

@end
@interface DTCustomSegmentedControl : UIImageView

@property (nonatomic, assign) id<DTCustomSegmentedControlDelegate>delegate;

@end
