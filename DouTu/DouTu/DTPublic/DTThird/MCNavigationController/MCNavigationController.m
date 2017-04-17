//
//  MCNavigationController.m
//  Mike Ching
//
//  Created by chengyin on 12-4-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MCNavigationController.h"
#import <QuartzCore/QuartzCore.h>

#define KEY_WINDOW  [[UIApplication sharedApplication]keyWindow]

@interface MCNavigationController ()
{
    CGPoint _startTouch;
    NSMutableArray *_screenShotsList;
    UIView *_backView;
    
    UIImageView *_lastScreenShotView;
    UIView *_blackMask;
    
    UIPanGestureRecognizer *_pan;
    
    BOOL _isMoving;
}

@end

@implementation UINavigationBar (BackgroundImage)
- (void)setBackgroundImage:(UIImage*)backgroundImage
{
    
    float deviceVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (deviceVersion >= 5.0)
    {
        //for ios >= 5.0
        [self setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];
    }
    else
    {
        //trick for ios < 5.0
//        self.layer.contents = (id)backgroundImage.CGImage;
        UIImageView *view = [[UIImageView alloc] initWithImage:backgroundImage];
        [self insertSubview:view atIndex:0];
        [view release];
    }

}
@end

@implementation MCNavigationController
@synthesize showDragAnimation = _showDragAnimation;

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        _screenShotsList = [[NSMutableArray alloc]initWithCapacity:0];
        self.canDragBack = YES;
        _isMoving = NO;
    }
    return self;
}

- (id)initWithRootViewController:(UIViewController *)rootViewController
{
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        // Custom initialization
        _screenShotsList = [[NSMutableArray alloc]initWithCapacity:0];
        self.canDragBack = YES;
        _isMoving = NO;
    }
    return self;
}

- (void)dealloc
{
    [_screenShotsList release];_screenShotsList = nil;
    [_backView release];_backView = nil;
    [self.view removeGestureRecognizer:_pan];
    [_pan release];_pan = nil;
    [_lastScreenShotView release]; _lastScreenShotView = nil;
    [_blackMask release]; _blackMask = nil;
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

#pragma mark - property
- (void)setShowDragAnimation:(BOOL)showDragAnimation
{
    _showDragAnimation = showDragAnimation;
    if (_showDragAnimation) {
        if (self.showDragAnimation) {
            UIImageView *shadowImageView = [[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"leftside_shadow_bg"]]autorelease];
            shadowImageView.frame = CGRectMake(-10, 0, 10, self.view.frame.size.height);
            [self.view addSubview:shadowImageView];
            
            _pan = [[UIPanGestureRecognizer alloc]initWithTarget:self
                                                          action:@selector(paningGestureReceive:)];
            [_pan delaysTouchesBegan];
            [self.view addGestureRecognizer:_pan];
            
            _backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
            _backView.backgroundColor = [UIColor blackColor];
            [self.view.superview insertSubview:_backView belowSubview:self.view];
        }
    }
}

#pragma mark - popover animation
// override the push method
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (!self.showDragAnimation) {
        [super pushViewController:viewController animated:animated];
    }else{
        [_screenShotsList addObject:[self capture]];
        [super pushViewController:viewController animated:NO];
        if (animated) {
            CGRect bounds = self.view.bounds;
            
            self.view.frame = CGRectMake(bounds.size.width, 0, bounds.size.width, bounds.size.height);
            
            [self initBackView];
            
            [UIView beginAnimations:@"push" context:nil];
            [UIView setAnimationDuration:0.3f];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
            self.view.frame = CGRectMake(0, 0, bounds.size.width, bounds.size.height);
            float scale = (0/6400)+0.95;
            float alpha = 0.6 - (0/800);
            _lastScreenShotView.transform = CGAffineTransformMakeScale(scale, scale);
            _blackMask.alpha = alpha;
            [UIView commitAnimations];
        }else{
            return;
        }
    }
}

// override the pop method
- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    if (!self.showDragAnimation) {
        return [super popViewControllerAnimated:animated];
    }else{
        if (animated) {
            CGRect bounds = self.view.bounds;
            
            [self initBackView];
            float scale = (0/6400)+0.95;
            float alpha = 0.6 - (0/800);
            _lastScreenShotView.transform = CGAffineTransformMakeScale(scale, scale);
            _blackMask.alpha = alpha;
            
            UIImageView *imgView = [[UIImageView alloc]initWithFrame:bounds];
            imgView.image = [self capture];
            
            [self.view.superview insertSubview:imgView aboveSubview:self.view];
            self.view.hidden = YES;
            
            [UIView animateWithDuration:0.3f animations:^{
                imgView.frame = CGRectMake(bounds.size.width, 0, bounds.size.width, bounds.size.height);
                _lastScreenShotView.transform = CGAffineTransformMakeScale(1, 1);
                _blackMask.alpha = 0.0f;
            }completion:^(BOOL finished){
                self.view.hidden = NO;
                [_backView removeFromSuperview];
                _backView.hidden = YES;
                [imgView removeFromSuperview];
                [imgView release];
                [_screenShotsList removeLastObject];
            }];
            return [super popViewControllerAnimated:NO];
            
        }else{
            [_screenShotsList removeLastObject];
            return [super popViewControllerAnimated:NO];
        }
    }
}

#pragma mark - Utility Methods -
- (void)initBackView
{
    [_backView removeFromSuperview];
    [self.view.superview insertSubview:_backView belowSubview:self.view];
    
    if (_blackMask) {
        [_blackMask removeFromSuperview];
        [_blackMask release];_blackMask = nil;
    }
    _blackMask = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width , self.view.bounds.size.height)];
    _blackMask.backgroundColor = [UIColor blackColor];
    _blackMask.alpha = 0.0;
    [_backView addSubview:_blackMask];
    _backView.hidden = NO;
    
    if (_lastScreenShotView){
        [_lastScreenShotView removeFromSuperview];
        [_lastScreenShotView release];_lastScreenShotView = nil;
    }
    UIImage *lastScreenShot = [_screenShotsList lastObject];
    _lastScreenShotView = [[UIImageView alloc]initWithImage:lastScreenShot];
    [_backView insertSubview:_lastScreenShotView belowSubview:_blackMask];
}

// get the current view screen shot
- (UIImage *)capture
{
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, self.view.opaque, 0.0);
    [[UIApplication sharedApplication].keyWindow.layer  renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
}

// set lastScreenShotView 's position and alpha when paning
- (void)moveViewWithX:(float)x
{
    x = x>320?320:x;
    x = x<0?0:x;
    
    CGRect frame = self.view.frame;
    frame.origin.x = x;
    self.view.frame = frame;
    
    float scale = (x/6400)+0.95;
    float alpha = 0.6 - (x/533);
    
    _lastScreenShotView.transform = CGAffineTransformMakeScale(scale, scale);
    _blackMask.alpha = alpha;
    
}

#pragma mark - Gesture Recognizer -

- (void)paningGestureReceive:(UIPanGestureRecognizer *)recoginzer
{
    // If the viewControllers has only one vc or disable the interaction, then return.
    if (self.viewControllers.count <= 1 || !self.canDragBack) return;

    // we get the touch position by the window's coordinate
    CGPoint touchPoint = [recoginzer locationInView:KEY_WINDOW];
    
    // begin paning, show the backgroundView(last screenshot),if not exist, create it.
    if (recoginzer.state == UIGestureRecognizerStateBegan) {
        
        _isMoving = YES;
        _startTouch = touchPoint;
        
        [self initBackView];
        
        //End paning, always check that if it should move right or move left automatically
    }else if (recoginzer.state == UIGestureRecognizerStateEnded){
        
        if (touchPoint.x - _startTouch.x > 50)
        {
            [UIView animateWithDuration:0.3 animations:^{
                [self moveViewWithX:320];
            } completion:^(BOOL finished) {
                [self popViewControllerAnimated:NO];
                CGRect frame = self.view.frame;
                frame.origin.x = 0;
                self.view.frame = frame;
                [_backView removeFromSuperview];
                _backView.hidden = YES;
                _isMoving = NO;
            }];
        }
        else
        {
            [UIView animateWithDuration:0.3 animations:^{
                [self moveViewWithX:0];
            } completion:^(BOOL finished) {
                _isMoving = NO;
                _backView.hidden = YES;
            }];
            
        }
        return;
        
        // cancal panning, alway move to left side automatically
    }else if (recoginzer.state == UIGestureRecognizerStateCancelled){
        
        [UIView animateWithDuration:0.3 animations:^{
            [self moveViewWithX:0];
        } completion:^(BOOL finished) {
            _isMoving = NO;
            _backView.hidden = YES;
        }];
        
        return;
    }
    
    // it keeps move with touch
    if (_isMoving) {
        [self moveViewWithX:touchPoint.x - _startTouch.x];
    }
}


#pragma mark - background Img
- (void)setBackgroundImage:(UIImage*)backgroundImage
{
    float deviceVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (deviceVersion >= 5.0)
    {
        //for ios >= 5.0
        [self.navigationBar setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];
    }
    else
    {
        //trick for ios < 5.0
        [self.navigationBar setBackgroundImage:backgroundImage];
//        UIImageView *view = [[UIImageView alloc] initWithImage:backgroundImage];
//        [self.navigationBar insertSubview:view atIndex:0];
//        [view release];
    }
}
- (void)canleGestureEnabled
{
    _pan.enabled = NO;
}
- (void)addGestureEnabled
{
    _pan.enabled = YES;
}
@end
