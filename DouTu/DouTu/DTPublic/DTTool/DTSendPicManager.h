//
//  DTSendPicManager.h
//  DouTu
//
//  Created by yuepengfei on 17/3/17.
//  Copyright © 2017年 fly. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, DTSendChannelType)
{
    kDTSendChannelType_Wx,
    kDTSendChannelType_QQ
};
@interface DTSendPicManager : NSObject

+ (void)sendPic:(DTBaseModel *)pic
       channelType:(DTSendChannelType)channelType;

+ (void)sendNonGifContentToWx:(NSData *)pic;
+ (void)sendGifContentToWx:(NSData *)pic;
+ (void)sendImageMessageToQQ:(NSData *)pic;


@end
