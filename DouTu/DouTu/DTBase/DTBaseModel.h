//
//  DTBaseModel.h
//  DouTu
//
//  Created by yuepengfei on 17/3/14.
//  Copyright © 2017年 fly. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DTBaseModel : NSObject

@property (nonatomic, strong) NSNumber *bisDelete;
@property (nonatomic, strong) NSNumber *clickNum;
@property (nonatomic, strong) NSNumber *clickWeight;
@property (nonatomic, strong) NSNumber *createTime;
@property (nonatomic, strong) NSString *gifPath;
@property (nonatomic, strong) NSNumber *pid;
@property (nonatomic, strong) NSNumber *itemId;
@property (nonatomic, strong) NSNumber *likeNum;
@property (nonatomic, strong) NSNumber *likeWeight;
@property (nonatomic, strong) NSNumber *mediaType;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *picPath;
@property (nonatomic, strong) NSNumber *shareNum;
@property (nonatomic, strong) NSNumber *shareWeight;
@property (nonatomic, strong) NSNumber *ts;
@property (nonatomic, strong) NSNumber *uuid;

// hot
@property (nonatomic, strong) NSNumber *bisLock;
@property (nonatomic, strong) NSNumber *bisRecommend;
@property (nonatomic, strong) NSNumber *recommendTime;
@property (nonatomic, strong) NSNumber *typeId;
@property (nonatomic, strong) NSNumber *weight;

@property (nonatomic, strong) UIImage  *defaultImg;

// 缓存
@property (nonatomic, strong) NSDate   *joinDate;
@property (nonatomic, strong) NSData   *imgData;
@property (nonatomic, strong) NSString *reserve;

// detail
@property (nonatomic, strong) NSNumber *type;
@property (nonatomic, strong) NSString *word;

// 穿插模拟数据
@property (nonatomic, assign) BOOL     insert;
@end

