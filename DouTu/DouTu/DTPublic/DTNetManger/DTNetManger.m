//
//  DTNetManger.m
//  DouTu
//
//  Created by yuepengfei on 17/3/14.
//  Copyright © 2017年 fly. All rights reserved.
//

#import "DTNetManger.h"
#import "DTBaseModel.h"
#import "DTTypeModel.h"

@implementation DTNetManger

+ (void)requestFailedCallBack:(callBack)callBack
{
    if (callBack) {
        NSError *error = [[self class] errorWithCode:0 description:nil];
        callBack(error,nil);
    }
}
+ (NSError *)errorWithCode:(int)code description:(NSString *)description
{
    NSString *msg = description ? description : @"";
    NSDictionary *infoDic = [NSDictionary dictionaryWithObject:msg forKey:NSLocalizedDescriptionKey];
    NSError *error = [NSError errorWithDomain:@"BizYixinErrorDomain" code:code userInfo:infoDic];
    return error;
}
// 广场热门
+ (void)getHotListWithCallBack:(callBack)callBack
{
    [HYBNetworking getWithUrl:kDTHotListUrl refreshCache:YES success:^(id response) {
        
        NSString *code = [(NSDictionary *)response objectForKey:@"code"];
        if ([code isEqualToString:@"0"]) {
            NSArray *data = [(NSDictionary *)response objectForKey:@"data"];
            [DTBaseModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
                return @{@"pid" : @"id"};
            }];
            NSMutableArray *hots = [[NSMutableArray alloc] init];
            for (NSDictionary *hot in data) {
                DTBaseModel *model = [DTBaseModel mj_objectWithKeyValues:hot];
                [hots addObject:model];
            }
            if (callBack) {
                callBack(nil,hots);
            }
        } else {
            [DTNetManger requestFailedCallBack:callBack];
        }
    } fail:^(NSError *error) {
        [DTNetManger requestFailedCallBack:callBack];
    }];
    
}
// 广场最新列表
+ (void)getNewListWithPageNum:(NSInteger)pageNum
                     pageSize:(NSInteger)pageSize
                     callBack:(callBack)callBack
{
    [HYBNetworking getWithUrl:kDTNewListUrl refreshCache:YES params:@{@"pageNum":@(pageNum),@"pageSize":@(pageSize)} success:^(id response) {
        
        NSString *code = [(NSDictionary *)response objectForKey:@"code"];
        if ([code isEqualToString:@"0"]) {
            NSArray *data = [(NSDictionary *)response objectForKey:@"data"];
            [DTBaseModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
                return @{@"pid" : @"id"};
            }];
            NSMutableArray *pics = [[NSMutableArray alloc] init];
            for (NSDictionary *pic in data) {
                DTBaseModel *model = [DTBaseModel mj_objectWithKeyValues:pic];
                [pics addObject:model];
            }
            if (callBack) {
                callBack(nil,pics);
            }
        } else {
            [DTNetManger requestFailedCallBack:callBack];
        }
    } fail:^(NSError *error) {
        [DTNetManger requestFailedCallBack:callBack];
    }];
}
+ (void)getByTagId:(NSNumber *)tagId
         pageNum:(NSInteger)pageNum
        pageSize:(NSInteger)pageSize
        callBack:(callBack)callBack
{
    if (kObjectIsEmpty(tagId)) {
        [DTNetManger requestFailedCallBack:callBack];
        return;
    }
    [HYBNetworking getWithUrl:kDTGetByTagUrl refreshCache:YES params:@{@"tagId":tagId,@"pageNum":@(pageNum),@"pageSize":@(pageSize)} success:^(id response) {
        NSString *code = [(NSDictionary *)response objectForKey:@"code"];
        if ([code isEqualToString:@"0"]) {
            NSArray *data = [(NSDictionary *)response objectForKey:@"data"];
            [DTBaseModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
                return @{@"pid" : @"id"};
            }];
            NSMutableArray *pics = [[NSMutableArray alloc] init];
            for (NSDictionary *pic in data) {
                DTBaseModel *model = [DTBaseModel mj_objectWithKeyValues:pic];
                [pics addObject:model];
            }
            if (callBack) {
                callBack(nil,pics);
            }
        } else {
            [DTNetManger requestFailedCallBack:callBack];
        }
    } fail:^(NSError *error) {
        
        [DTNetManger requestFailedCallBack:callBack];
    }];
}
+ (void)getRecommendListWithPageNum:(NSInteger)pageNum
                           pageSize:(NSInteger)pageSize
                           callBack:(callBack)callBack
{
    [HYBNetworking getWithUrl:kDTRecommendListUrl refreshCache:YES params:@{@"pageNum":@(pageNum),@"pageSize":@(pageSize)} success:^(id response) {
        
        NSString *code = [(NSDictionary *)response objectForKey:@"code"];
        if ([code isEqualToString:@"0"]) {
            NSArray *data = [(NSDictionary *)response objectForKey:@"data"];
            [DTBaseModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
                return @{@"pid" : @"id"};
            }];
            NSMutableArray *pics = [[NSMutableArray alloc] init];
            for (NSDictionary *pic in data) {
                DTBaseModel *model = [DTBaseModel mj_objectWithKeyValues:pic];
                [pics addObject:model];
            }
            if (callBack) {
                callBack(nil,pics);
            }
        } else {
            [DTNetManger requestFailedCallBack:callBack];
        }
    } fail:^(NSError *error) {
        
        [DTNetManger requestFailedCallBack:callBack];
    }];
}

+ (void)getDetailWithItemId:(NSNumber *)itemId callBack:(callBack)callBack
{
    [HYBNetworking getWithUrl:kDTGetDetailUrl refreshCache:YES params:@{@"itemId":itemId} success:^(id response) {
        NSString *code = [(NSDictionary *)response objectForKey:@"code"];
        if ([code isEqualToString:@"0"]) {
            NSDictionary *data = [(NSDictionary *)response objectForKey:@"data"];
            NSArray      *list = data[@"list"];
            [DTBaseModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
                return @{@"pid" : @"id"};
            }];
            NSMutableArray *pics = [[NSMutableArray alloc] init];
            for (NSDictionary *pic in list) {
                DTBaseModel *model = [DTBaseModel mj_objectWithKeyValues:pic];
                [pics addObject:model];
            }
            if (callBack) {
                callBack(nil,pics);
            }
        } else {
            [DTNetManger requestFailedCallBack:callBack];
        }
    } fail:^(NSError *error) {
        [DTNetManger requestFailedCallBack:callBack];
    }];
}

+ (void)getTagAllLisWithCallBack:(callBack)callBack
{
    [HYBNetworking getWithUrl:kDTAllListUrl refreshCache:YES success:^(id response) {
        NSString *code = [(NSDictionary *)response objectForKey:@"code"];
        if ([code isEqualToString:@"0"]) {
            NSArray *data = [(NSDictionary *)response objectForKey:@"data"];
            [DTTypeModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
               
                return @{@"typeId":@"id"};
            }];
            [DTBaseModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
                return @{@"pid" : @"id"};
            }];
            NSMutableArray *types = [[NSMutableArray alloc] init];
            for (NSDictionary *type in data) {
                NSDictionary *dict = type[@"dtTypeModel"];
                DTTypeModel *typeModel = [DTTypeModel mj_objectWithKeyValues:dict];
                NSDictionary *list = type[@"tagList"];
                NSMutableArray *arr = [[NSMutableArray alloc] init];
                for (NSDictionary *tag in list) {
                    DTBaseModel *baseModel = [DTBaseModel mj_objectWithKeyValues:tag];
                    [arr addObject:baseModel];
                }
                typeModel.types = arr;
                [types addObject:typeModel];
            }
            if (callBack) {
                callBack(nil,types);
            }
        } else {
            [DTNetManger requestFailedCallBack:callBack];
        }
    } fail:^(NSError *error) {
        
        [DTNetManger requestFailedCallBack:callBack];
    }];
}
@end
