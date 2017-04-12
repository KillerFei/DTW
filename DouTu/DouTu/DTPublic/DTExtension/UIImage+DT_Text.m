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
    UIGraphicsBeginImageContext(CGSizeMake(210, 210));
    [self drawInRect:CGRectMake(0,0, 210, 210)];
 
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 5.0);
    CGContextSetLineJoin(context, kCGLineJoinRound);
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextSetTextDrawingMode(context, kCGTextStroke);
    [@"公司：北京中软科技股份有限公司\n部门：ERP事业部\n姓名：McLiang" drawInRect:CGRectMake(20, 40, 280, 300) withAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    CGContextSetTextDrawingMode(context, kCGTextFill);
    CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);;
    [@"公司：北京中软科技股份有限公司\n部门：ERP事业部\n姓名：McLiang" drawInRect:CGRectMake(20, 40, 280, 300) withAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
    
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
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


+ (NSString *)pathWithImages:(NSArray<UIImage *>*)images
                         gifPath:(NSString *)path
                         durtion:(CGFloat)durtion;
{
    NSString *documentStr = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *gifName =  [NSString stringWithFormat:@"%@%lu.gif", [NSDate date], (unsigned long)[path hash]];
    NSString *gifPath = [documentStr stringByAppendingPathComponent:gifName];
    CFURLRef url = CFURLCreateWithFileSystemPath (
                                                  kCFAllocatorDefault,
                                                  (CFStringRef)gifPath,
                                                  kCFURLPOSIXPathStyle,
                                                  false);
    CGImageDestinationRef destination = CGImageDestinationCreateWithURL(url, kUTTypeGIF, images.count, NULL);
    NSMutableDictionary *picInterval= [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithFloat:durtion],(NSString *)kCGImagePropertyGIFDelayTime,nil];
    NSDictionary *frameProperties = [NSDictionary dictionaryWithObject:picInterval forKey:(NSString *)kCGImagePropertyGIFDictionary];
    //设置gif信息
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:2];
    [dict setObject:[NSNumber numberWithBool:YES] forKey:(NSString*)kCGImagePropertyGIFHasGlobalColorMap];
    [dict setObject:(NSString *)kCGImagePropertyColorModelRGB forKey:(NSString *)kCGImagePropertyColorModel];
    [dict setObject:[NSNumber numberWithInt:8] forKey:(NSString*)kCGImagePropertyDepth];
    [dict setObject:[NSNumber numberWithInt:0] forKey:(NSString *)kCGImagePropertyGIFLoopCount];
    NSDictionary *gifProperties = [NSDictionary dictionaryWithObject:dict
                                                    forKey:(NSString *)kCGImagePropertyGIFDictionary];
    //合成gif
    for (UIImage *dImg in images)
    {
        CGImageDestinationAddImage(destination, dImg.CGImage, (__bridge CFDictionaryRef)frameProperties);
    }
    CGImageDestinationSetProperties(destination, (__bridge CFDictionaryRef)gifProperties);
    CGImageDestinationFinalize(destination);
    CFRelease(destination);
    return gifPath;
}

@end
