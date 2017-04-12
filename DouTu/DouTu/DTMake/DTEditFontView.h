//
//  DTEditFontView.h
//  DouTu
//
//  Created by yuepengfei on 17/3/21.
//  Copyright © 2017年 fly. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DTEditFontViewDelegate <NSObject>

- (void)useThisFont:(UIFont *)font;

@end
@interface DTEditFontView : UIView

@property (nonatomic, assign) id<DTEditFontViewDelegate> delegate;

@end
