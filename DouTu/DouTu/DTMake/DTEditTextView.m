//
//  DTEditTextView.m
//  DouTu
//
//  Created by 岳鹏飞 on 2017/4/6.
//  Copyright © 2017年 fly. All rights reserved.
//

#import "DTEditTextView.h"

@interface DTEditTextView ()

@property (nonatomic, strong) UIImageView *pullView;
@property (nonatomic, strong) UIImageView *rotateView;
@property (nonatomic, strong) UITextView  *inputView;
@end

@implementation DTEditTextView
- (UIImageView *)pullView
{
    if (!_pullView) {
        _pullView = [[UIImageView alloc] init];
        _pullView.image = [UIImage imageNamed:@"dt_edit_text_pull"];
    }
    return _pullView;
}
- (UIImageView *)rotateView
{
    if (!_rotateView) {
        _rotateView = [[UIImageView alloc] init];
        _rotateView.image = [UIImage imageNamed:@"dt_edit_text_rotate"];
    }
    return _rotateView;
}
- (UIView *)inputView
{
    if (!_inputView) {
        _inputView = [[UITextView alloc] init];
        _inputView.backgroundColor = [UIColor clearColor];
    }
    return _inputView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.inputView];
        [self addSubview:self.pullView];
        [self addSubview:self.rotateView];    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.pullView.frame = CGRectMake(-14.5, -14.5, 29, 29);
    self.rotateView.frame = CGRectMake(self.height-14.5, self.width-14.5, 29, 29);
}
- (void)refreshWithText:(NSString *)text
                   font:(UIFont *)font
{
    NSDictionary *attribus = @{NSFontAttributeName:font};
    CGSize textSize = [text boundingRectWithSize:CGSizeMake(self.width, MAXFLOAT) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesDeviceMetrics attributes:attribus context:nil].size;
    self.inputView.frame = CGRectMake(0, 0, textSize.width, textSize.height);
    self.size = self.inputView.size;
    self.inputView.text = text;
}
@end
