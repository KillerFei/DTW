//
//  MCBarButtonItem.m
//  Mike Ching
//
//  Created by chengyin on 12-5-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MCBarButtonItem.h"

@implementation MCBarButtonItem
- (id)initWithTitle:(NSString *)aTitle height:(CGFloat)aHeight normalImage:(UIImage *)aNormalImage highlightImage:(UIImage *)aHightlightImage target:(id)aTarget action:(SEL)aAction
{
    UIButton *button = [[UIButton alloc] init];
    button.titleLabel.font = [UIFont  systemFontOfSize:12.0f];
    [button setTitle:aTitle forState:UIControlStateNormal];
    [button setTitle:aTitle forState:UIControlStateHighlighted];
    [button setTitleColor:[UIColor colorWithHexString:@"4c1d06"] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithHexString:@"4c1d06"] forState:UIControlStateHighlighted];
    [button setBackgroundImage:aNormalImage forState:UIControlStateNormal];
    [button setBackgroundImage:aHightlightImage forState:UIControlStateHighlighted];
    [button addTarget:aTarget action:aAction forControlEvents:UIControlEventTouchUpInside];
    //CGFloat buttonWidth = [[button titleForState:UIControlStateNormal] sizeWithFont:button.titleLabel.font].width;
    button.bounds = CGRectMake(0, 0, 64/*buttonWidth + 20*/, aHeight);
    self = [super initWithCustomView:button];
    [button release];
    if (self) 
    {
        
    }
    return self;
}

- (id)initWithTitle:(NSString *)aTitle normalImage:(UIImage *)aNormalImage highlightImage:(UIImage *)aHightlightImage target:(id)aTarget action:(SEL)aAction
{
    return [self initWithTitle:aTitle height:30.0f normalImage:aNormalImage highlightImage:aHightlightImage target:aTarget action:aAction];
}

- (id)initWithWidth:(CGFloat)aWidth Height:(CGFloat)aHeight normalImage:(UIImage *)aNormalImage highlightImage:(UIImage *)aHightlightImage target:(id)aTarget action:(SEL)aAction
{
    UIButton *button = [[UIButton alloc] init];
    [button setImage:aNormalImage forState:UIControlStateNormal];
    [button setImage:aHightlightImage forState:UIControlStateHighlighted];
    [button addTarget:aTarget action:aAction forControlEvents:UIControlEventTouchUpInside];
    button.bounds = CGRectMake(0, 0, aWidth, aHeight);
    self = [super initWithCustomView:button];
    [button release];
    if (self) 
    {
        
    }
    return self;
}

- (void)setTitle:(NSString *)title
{
    UIButton *button = (UIButton *)self.customView;
    if (button && [button isKindOfClass:[UIButton class]])
    {
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitle:title forState:UIControlStateHighlighted];
        //CGFloat buttonWidth = [[button titleForState:UIControlStateNormal] sizeWithFont:button.titleLabel.font].width;
        button.bounds = CGRectMake(0, 0, 64/*buttonWidth + 20*/, 30);
    }
}

- (NSString *)title
{
    UIButton *button = (UIButton *)self.customView;
    if (button && [button isKindOfClass:[UIButton class]])
    {
        return [button titleForState:UIControlStateNormal];
    }
    return nil;
}
@end
