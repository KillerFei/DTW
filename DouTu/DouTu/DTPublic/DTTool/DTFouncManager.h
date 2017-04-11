//
//  DTFouncManager.h
//  DouTu
//
//  Created by 岳鹏飞 on 2017/3/18.
//  Copyright © 2017年 fly. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DTFouncManager : NSObject

+ (void)downLoadPic:(NSString *)picPath;


+ (void)savePic:(DTBaseModel *)pic
          toTab:(kDTTableType)tab;


@end
