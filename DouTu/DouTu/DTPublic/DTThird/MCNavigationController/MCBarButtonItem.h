//
//  MCBarButtonItem.h
//  Mike Ching
//
//  Created by chengyin on 12-5-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MCBarButtonItem : UIBarButtonItem
- (id)initWithWidth:(CGFloat)aWidth Height:(CGFloat)aHeight normalImage:(UIImage *)aNormalImage highlightImage:(UIImage *)aHightlightImage target:(id)aTarget action:(SEL)aAction;
- (id)initWithTitle:(NSString *)aTitle normalImage:(UIImage *)aNormalImage highlightImage:(UIImage *)aHightlightImage target:(id)aTarget action:(SEL)aAction;
- (id)initWithTitle:(NSString *)aTitle height:(CGFloat)aHeight normalImage:(UIImage *)aNormalImage highlightImage:(UIImage *)aHightlightImage target:(id)aTarget action:(SEL)aAction;
@end
