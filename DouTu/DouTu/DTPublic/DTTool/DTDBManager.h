//
//  DTDBManager.h
//  DouTu
//
//  Created by yuepengfei on 17/3/18.
//  Copyright © 2017年 fly. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, kDTTableType) {
    
    kDTTableType_Send,    //发送
    kDTTableType_Make,    //制作
    kDTTableType_Collect  //收藏
};

@interface DTDBManager : NSObject

+ (instancetype)shareInstance;
// 保存
- (BOOL)savePic:(DTBaseModel *)pic
          table:(kDTTableType)tab;
// 删除
- (BOOL)deletePic:(DTBaseModel *)pic
            table:(kDTTableType)tab;
// 获取
- (NSArray *)getPicsFromTable:(kDTTableType)tab;


+ (void)runBlockInBackground:(void (^)())block;

@end
