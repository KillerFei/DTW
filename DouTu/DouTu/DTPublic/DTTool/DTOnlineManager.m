//
//  DTOnlineManager.m
//  DouTu
//
//  Created by 岳鹏飞 on 2017/3/18.
//  Copyright © 2017年 fly. All rights reserved.
//

#import "DTOnlineManager.h"

@implementation DTOnlineManager
//检查更新
+ (BOOL)bUpdate
{
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:kDTLastVersionKey];
    if (!lastVersion) {
        return NO;
    }
    NSString *currentVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    if ([lastVersion isEqualToString:currentVersion]) {
        return NO;
    }
    return YES;
}

+ (NSString *)currentVerson
{
    NSString *currentVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    return currentVersion;
}
@end
