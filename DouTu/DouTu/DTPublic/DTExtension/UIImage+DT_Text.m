//
//  UIImage+DT_Text.m
//  ReDouCartoon
//
//  Created by yuepengfei on 17/3/24.
//  Copyright © 2017年 BF_Soft. All rights reserved.
//

#import "UIImage+DT_Text.h"
#import <ImageIO/ImageIO.h>

@implementation UIImage (DT_Text)

- (UIImage *)addText:(NSString *)text
            textRect:(CGRect)rect
      withAttributes:(NSDictionary *)attributes
{
    //绘制上下文
    UIGraphicsBeginImageContext(self.size);
    [self drawInRect:CGRectMake(0,0, self.size.width, self.size.height)];
    [text drawInRect:rect withAttributes:attributes];
    UIImage *newImage =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+ (NSArray *)getImagesWithData:(NSData *)data
{
    CGImageSourceRef source = CGImageSourceCreateWithData((__bridge CFDataRef)data, NULL);
    //获取帧数
    size_t count = CGImageSourceGetCount(source);
    NSMutableArray* tmpArray = [NSMutableArray array];
    for (size_t i = 0; i < count; i++)
    {
        //获取图像
        CGImageRef imageRef = CGImageSourceCreateImageAtIndex(source, i, NULL);
        //生成image
        UIImage *image = [UIImage imageWithCGImage:imageRef scale:1 orientation:UIImageOrientationUp];
        
        [tmpArray addObject:image];
        
        CGImageRelease(imageRef);
    }
    CFRelease(source);
    
    return tmpArray;
}


+ (NSData *)createDataWithImages:(NSArray<UIImage *> *)images
{
    NSMutableData *imgData = [[NSMutableData alloc] init];
    for (UIImage *img in images) {
        
        NSData *imageData = UIImagePNGRepresentation(img);
        [imgData appendData:imageData];
    }
    return imgData;
}

@end
