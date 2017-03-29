//
//  NSURL+DT_Ex.m
//  DouTu
//
//  Created by yuepengfei on 17/3/16.
//  Copyright © 2017年 fly. All rights reserved.
//

#import "NSURL+DT_Ex.h"

@implementation NSURL (DT_Ex)
+ (NSURL *)safeURLWithString:(NSString *)URLString
{
    if (kStringIsEmpty(URLString)) {
        return nil;
    }
    NSString *encodeStr = [URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return [NSURL URLWithString:encodeStr];
}
@end
