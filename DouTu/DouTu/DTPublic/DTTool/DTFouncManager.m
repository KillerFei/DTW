//
//  DTFouncManager.m
//  DouTu
//
//  Created by 岳鹏飞 on 2017/3/18.
//  Copyright © 2017年 fly. All rights reserved.
//

#import "DTFouncManager.h"

@implementation DTFouncManager

+ (void)downLoadPic:(NSString *)picPath
{
    UIImage *image = [UIImage imageWithContentsOfFile:picPath];
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
}
+ (void)savePic:(DTBaseModel *)pic
          toTab:(kDTTableType)tab
{
    if (!pic) {
        if (tab == kDTTableType_Collect) {
            [DTHudManager showMessage:@"图片错误,请重试" InView:[UIApplication sharedApplication].keyWindow];
        }
        return;
    }
    pic.joinDate = [NSDate date];
    NSData *picData = nil;
    if ([pic.mediaType isEqualToNumber:@0]) {
        picData = [[SDImageCache sharedImageCache] diskImageDataBySearchingAllPathsForKey:pic.picPath];
    } else {
        picData = [[SDImageCache sharedImageCache] diskImageDataBySearchingAllPathsForKey:pic.gifPath];
    }
    if (kObjectIsEmpty(picData)) {
        if (tab == kDTTableType_Collect) {
            [DTHudManager showMessage:@"图片错误,请重试" InView:[UIApplication sharedApplication].keyWindow];
        }
        return;
    }
    pic.imgData = picData;
    switch (tab) {
        case kDTTableType_Send:
            [[DTDBManager shareInstance] savePic:pic table:kDTTableType_Send];
            break;
        case kDTTableType_Make:
            [[DTDBManager shareInstance] savePic:pic table:kDTTableType_Make];
            break;
        case kDTTableType_Collect: {
            BOOL reslut = [[DTDBManager shareInstance] savePic:pic table:kDTTableType_Collect];
            if (reslut) {
                [DTHudManager showMessage:@"收藏成功" InView:[UIApplication sharedApplication].keyWindow];
            } else {
                [DTHudManager showMessage:@"图片错误,请稍后重试" InView:[UIApplication sharedApplication].keyWindow];
            }
        }
            break;
        default:
            break;
    }
}

@end
