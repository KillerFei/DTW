//
//  UIImage+DT_Text.h
//  ReDouCartoon
//
//  Created by yuepengfei on 17/3/24.
//  Copyright © 2017年 BF_Soft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (DT_Text)

// 文字绘制图片上
- (UIImage *)addText:(NSString *)text
            textRect:(CGRect)rect
      withAttributes:(NSDictionary *)attributes;


+ (NSArray *)getImagesWithData:(NSData *)data;

+ (NSData *)createDataWithImages:(NSArray<UIImage *>*)images;



@end
