//
//  DTTypeModel.h
//  DouTu
//
//  Created by 岳鹏飞 on 2017/3/27.
//  Copyright © 2017年 fly. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DTTypeModel : NSObject

@property (nonatomic, strong) NSNumber *bisDelete;
@property (nonatomic, strong) NSNumber *bisShowImg;
@property (nonatomic, strong) NSNumber *createTime;
@property (nonatomic, strong) NSNumber *typeId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSNumber *ts;
@property (nonatomic, strong) NSNumber *weight;

@property (nonatomic, strong) NSArray  *types;
@end
