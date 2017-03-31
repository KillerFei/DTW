//
//  DTNetManger.h
//  DouTu
//
//  Created by yuepengfei on 17/3/14.
//  Copyright © 2017年 fly. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DTBaseModel;

typedef void(^callBack)(NSError *error, NSArray *response);
typedef void(^detailCallBack) (NSError *error, NSArray *response, DTBaseModel *detailModel);

@interface DTNetManger : NSObject

+ (void)getHotListWithCallBack:(callBack)callBack;

+ (void)getNewListWithPageNum:(NSInteger)pageNum
                     pageSize:(NSInteger)pageSize
                     callBack:(callBack)callBack;

+ (void)getByTagId:(NSNumber *)tagId
           pageNum:(NSInteger)pageNum
          pageSize:(NSInteger)pageSize
          callBack:(callBack)callBack;

+ (void)getRecommendListWithPageNum:(NSInteger)pageNum
                           pageSize:(NSInteger)pageSize
                           callBack:(callBack)callBack;

+ (void)getDetailWithItemId:(NSNumber *)itemId
                   callBack:(detailCallBack)callBack;

+ (void)getTagAllLisWithCallBack:(callBack)callBack;

@end
