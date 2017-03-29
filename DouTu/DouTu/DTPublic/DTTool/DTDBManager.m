//
//  DTDBManager.m
//  DouTu
//
//  Created by yuepengfei on 17/3/18.
//  Copyright © 2017年 fly. All rights reserved.
//

#import "DTDBManager.h"

@interface DTDBManager ()
@property (nonatomic, strong) FMDatabaseQueue *cacheDBQueque;
@end

static NSString *const cacheDBPath                = @"dtCache.db";

@implementation DTDBManager

+ (instancetype)shareInstance
{
    static DTDBManager *dbManger = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        dbManger = [[DTDBManager alloc] init];
    });
    return dbManger;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self configDB];
    }
    return self;
}
- (void)configDB
{
    NSString *libraryPath = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).firstObject;
    NSString *dbDir       = [libraryPath stringByAppendingString:@"/DuTou"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:dbDir]) {
        
        [[NSFileManager defaultManager] createDirectoryAtPath:dbDir withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSString *dbPath      = [dbDir stringByAppendingString:[NSString stringWithFormat:@"/%@", cacheDBPath]];
    _cacheDBQueque = [FMDatabaseQueue databaseQueueWithPath:dbPath];
    if (!_cacheDBQueque) return;
    
    [_cacheDBQueque inDatabase:^(FMDatabase *db) {
        
        NSString *sendTable = @"create table if not exists sendPics(joinDate dateTime UNSIGNED NOT NULL PRIMARY KEY, pic blob, mediaType integer, reserve text);";
        BOOL sendResult = [db executeUpdate:sendTable];
        if (sendResult) {
            NSLog(@"---------发送库创建成功");
        }
        NSString *makeTable = @"create table if not exists makePics(joinDate dateTime UNSIGNED NOT NULL PRIMARY KEY, pic blob, mediaType integer, reserve text);";
        BOOL makeResult = [db executeUpdate:makeTable];
        if (makeResult) {
            NSLog(@"---------制作库创建成功");
        }
        NSString *collectTable = @"create table if not exists collectPics(joinDate dateTime UNSIGNED NOT NULL PRIMARY KEY, pic blob, mediaType integer, reserve text);";
        BOOL collectResult = [db executeUpdate:collectTable];
        if (collectResult) {
            NSLog(@"---------收藏库创建成功");
        }
    }];
}
#pragma mark -------- action
// 保存
- (BOOL)savePic:(DTBaseModel *)pic
          table:(kDTTableType)tab
{
    __block BOOL reslut = NO;
    NSString *insertSql = nil;
    switch (tab) {
        case kDTTableType_Send:
            insertSql = @"insert or replace into sendPics(joinDate,pic,mediaType,reserve) values(?,?,?,?)";
            break;
        case kDTTableType_Make:
            insertSql = @"insert or replace into makePics(joinDate,pic,mediaTypereserve) values(?,?,?,?)";
            break;
        case kDTTableType_Collect:
            insertSql = @"insert or replace into collectPics(joinDate,pic,mediaType,reserve) values(?,?,?,?)";
            break;
        default:
            break;
    }
    [_cacheDBQueque inDatabase:^(FMDatabase *db) {
        
        reslut = [db executeUpdate:insertSql,pic.joinDate,pic.imgData,pic.mediaType,pic.reserve];
    }];
    return reslut;
}
// 删除
- (BOOL)deletePic:(DTBaseModel *)pic
            table:(kDTTableType)tab
{
    __block BOOL reslut = NO;
    NSString *deleteSql = nil;
    switch (tab) {
        case kDTTableType_Send:
            deleteSql = @"delete from sendPics where joinDate = ?";
            break;
        case kDTTableType_Make:
            deleteSql = @"delete from makePics where joinDate = ?";
            break;
        case kDTTableType_Collect:
            deleteSql = @"delete from collectPics where joinDate = ?";
        default:
            break;
    }
    [_cacheDBQueque inTransaction:^(FMDatabase *db, BOOL *rollback) {
        
       reslut = [db executeUpdate:deleteSql,pic.joinDate];
    }];
    return reslut;
}
// 获取
- (NSArray *)getPicsFromTable:(kDTTableType)tab
{
    NSMutableArray *pics = [NSMutableArray array];
    NSString *selectSql = nil;
    switch (tab) {
        case kDTTableType_Send:
            selectSql = @"select * from sendPics";
            break;
        case kDTTableType_Make:
            selectSql = @"select * from makePics";
            break;
        case kDTTableType_Collect:
            selectSql = @"select * from collectPics";
            break;
        default:
            break;
    }
    [_cacheDBQueque inDatabase:^(FMDatabase *db) {
        
        FMResultSet * data = [db executeQuery:selectSql];
        while (data.next) {
            DTBaseModel *pic = [[DTBaseModel alloc] init];
            pic.joinDate     = [data dateForColumn:@"joinDate"];
            pic.imgData      = [data objectForColumnName:@"pic"];
            pic.mediaType    = [data objectForColumnName:@"mediaType"];
            pic.reserve      = [data objectForColumnName:@"reserve"];
            [pics addObject:pic];
        }
        [data close];
    }];
    return pics;
}
+ (void)runBlockInBackground:(void (^)())block
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if (block)
        {
            block();
        }
    });
}
@end
