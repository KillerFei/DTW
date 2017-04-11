//
//  DTEditTextColorView.h
//  DouTu
//
//  Created by 岳鹏飞 on 2017/4/5.
//  Copyright © 2017年 fly. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DTEditTextColorViewDelegate<NSObject>

- (void)didClickButtonAtIndex:(NSInteger)index;
- (void)didSeletColor:(UIColor *)color;
@end

@interface DTEditTextColorView : UIView

@property (nonatomic, assign) id<DTEditTextColorViewDelegate>delegate;

@end
