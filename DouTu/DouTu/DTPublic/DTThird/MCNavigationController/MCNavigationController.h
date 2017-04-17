//
//  MCNavigationController.h
//  Mike Ching
//
//  Created by chengyin on 12-4-10.  modify by jinkelei, 添加拖拽返回效果
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//
#import "MCBarButtonItem.h"
#import <QuartzCore/QuartzCore.h>

@interface UINavigationBar (BackgroundImage)
- (void)setBackgroundImage:(UIImage*)backgroundImage;
@end

@interface MCNavigationController : UINavigationController
{
    
}

// Enable the drag to back interaction, Defalt is YES.
@property (nonatomic,assign) BOOL canDragBack;
@property(nonatomic,assign)BOOL showDragAnimation;

- (void)setBackgroundImage:(UIImage*)backgroundImage;
- (void)canleGestureEnabled;
- (void)addGestureEnabled;
@end
