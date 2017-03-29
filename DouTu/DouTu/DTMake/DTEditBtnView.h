//
//  DTEditBtnView.h
//  DouTu
//
//  Created by yuepengfei on 17/3/21.
//  Copyright © 2017年 fly. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol DTEditBtnViewDelegate<NSObject>

- (void)seleteBtnAtIndex:(NSInteger)index;
@end

@interface DTEditBtnView : UIView

@property (nonatomic, assign) id<DTEditBtnViewDelegate>delegate;

- (void)refreshSeleteBtnAtIndex:(NSInteger)index;

@end
