//
//  DTSendPicManager.m
//  DouTu
//
//  Created by yuepengfei on 17/3/17.
//  Copyright © 2017年 fly. All rights reserved.
//

#import "DTSendPicManager.h"
#import "UIImage+GIF.h"
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/QQApiInterfaceObject.h>

@implementation DTSendPicManager

+ (void)sendPic:(DTBaseModel *)pic
    channelType:(DTSendChannelType)channelType
{
    if (!pic) {
        [DTHudManager showMessage:@"发送错误" InView:[UIApplication sharedApplication].keyWindow];
        return;
    }
    NSData *picData = nil;
    if ([pic.mediaType isEqualToNumber:@0]) {
        picData = [[SDImageCache sharedImageCache] diskImageDataBySearchingAllPathsForKey:pic.picPath];
    } else {
        picData = [[SDImageCache sharedImageCache] diskImageDataBySearchingAllPathsForKey:pic.gifPath];
    }
    if (kObjectIsEmpty(picData)) {
        [DTHudManager showMessage:@"发送错误" InView:[UIApplication sharedApplication].keyWindow];
        return;
    }
    if (channelType == kDTSendChannelType_QQ) {
        [DTSendPicManager sendImageMessageToQQ:picData];
    } else {
        if ([pic.mediaType isEqualToNumber:@0]) {
            [DTSendPicManager sendNonGifContentToWx:picData];
        } else {
            [DTSendPicManager sendGifContentToWx:picData];
        }
    }
}
+ (void)sendNonGifContentToWx:(NSData *)pic
{
    WXMediaMessage *message = [WXMediaMessage message];
    [message setThumbImage:[UIImage imageWithData:pic]];
    WXEmoticonObject *ext = [WXEmoticonObject object];
    ext.emoticonData = pic;
    message.mediaObject = ext;
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    [WXApi sendReq:req];
}
+ (void)sendGifContentToWx:(NSData *)pic
{
    WXMediaMessage *message = [WXMediaMessage message];
    [message setThumbImage:[UIImage sd_animatedGIFWithData:pic]];
    WXEmoticonObject *ext = [WXEmoticonObject object];
    ext.emoticonData = pic;
    message.mediaObject = ext;
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    [WXApi sendReq:req];
}
+ (void)sendImageMessageToQQ:(NSData *)pic
{
    QQApiImageObject *imgObj = [QQApiImageObject objectWithData:pic previewImageData:pic title:@"斗图王—斗图战斗机" description:@"聊天必备，生命不息，斗图不止"];
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:imgObj];
    [QQApiInterface sendReq:req];
}
@end
