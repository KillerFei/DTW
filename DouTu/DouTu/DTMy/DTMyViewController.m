//
//  DTMyViewController.m
//  DouTu
//
//  Created by yuepengfei on 17/3/14.
//  Copyright © 2017年 fly. All rights reserved.
//

#import "DTMyViewController.h"
#import "DTMyTableViewCell.h"
#import "DTMyHeaderView.h"
#import "DTDisclaimerVC.h"

@interface DTMyViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView    *myTableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

static NSString *const kDTMyCellIdentifier = @"myCellIdentifier";
@implementation DTMyViewController
- (UITableView *)myTableView
{
    if (!_myTableView) {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT-64-49) style:UITableViewStyleGrouped];
        _myTableView.rowHeight = 52;
        _myTableView.delegate   = self;
        _myTableView.dataSource = self;
        _myTableView.backgroundColor = RGB(249, 249, 249);
        _myTableView.separatorColor = DT_Base_LineColor;
        [_myTableView registerClass:[DTMyTableViewCell class] forCellReuseIdentifier:kDTMyCellIdentifier];
        _myTableView.tableHeaderView = [[DTMyHeaderView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 165)];
    }
    return _myTableView;
}
- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initItemMenu];
    [self.view addSubview:self.myTableView];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.myTableView reloadData];
}

- (void)initItemMenu
{
    NSMutableArray *section = [[NSMutableArray alloc] init];
    NSNumber *number = [NSNumber numberWithInteger:kDTMyType_Help];
    [section addObject:number];
 
    number = [NSNumber numberWithInteger:kDTMyType_Judge];
    [section addObject:number];
    number = [NSNumber numberWithInteger:kDTMyType_Declaration];
    [section addObject:number];
    [self.dataSource addObject:section];
    
    section = [[NSMutableArray alloc] init];
    number = [NSNumber numberWithInteger:kDTMyType_Clear];
    [section addObject:number];
    [self.dataSource addObject:section];
}
#pragma mark - tableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource[section] count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DTMyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kDTMyCellIdentifier];
    return cell;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    DTMyTableViewCell *myCell = (DTMyTableViewCell *)cell;
    myCell.titleLabel.textColor = DT_Base_TitleColor;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    myCell.cacheLabel.hidden = YES;
    NSArray *items = self.dataSource[indexPath.section];
    NSInteger item = [items[indexPath.row] integerValue];
    switch (item) {
        case kDTMyType_Help:
            myCell.iconView.image = [UIImage imageNamed:@"dt_my_help"];
            myCell.titleLabel.text = @"使用帮助";
            break;
        case kDTMyType_Clear:
            myCell.accessoryType = UITableViewCellAccessoryNone;
            myCell.iconView.image = [UIImage imageNamed:@"dt_tabbar_make_selete"];
            myCell.titleLabel.text = @"清除缓存";
            myCell.titleLabel.textColor = RGB(255, 47, 57);
            myCell.cacheLabel.hidden = NO;
            myCell.cacheLabel.text = [NSString stringWithFormat:@"%.02fM",[[SDImageCache sharedImageCache] getSize]/1024.f/1024];
            break;
        case kDTMyType_Judge:
            myCell.iconView.image = [UIImage imageNamed:@"dt_my_judge"];
            myCell.titleLabel.text = @"给我们支持";
            break;
        case kDTMyType_Declaration:
            myCell.iconView.image = [UIImage imageNamed:@"dt_my_declaration"];
            myCell.titleLabel.text = @"免责声明";
            break;
        default:
            break;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSArray *items = self.dataSource[indexPath.section];
    NSInteger item = [items[indexPath.row] integerValue];
    switch (item) {
        case kDTMyType_Help:
            break;
        case kDTMyType_Clear:
            [self clearCachesAtIndexPath:indexPath];
            break;
        case kDTMyType_Judge:
            [self doJudge];
            break;
        case kDTMyType_Declaration:
            [self showDeclaration];
            break;
        default:
            break;
    }
}
#pragma mark - private action
// 免责声明
- (void)showDeclaration
{
    DTDisclaimerVC *disVC = [[DTDisclaimerVC alloc] init];
    disVC.navTitle = @"免责声明";
    [self.navigationController pushViewController:disVC animated:YES];
}
// 清楚缓存
- (void)clearCachesAtIndexPath:(NSIndexPath *)indexpath
{
    [[SDImageCache sharedImageCache] clearDisk];
    DTMyTableViewCell *myCell = [self.myTableView cellForRowAtIndexPath:indexpath];
    myCell.cacheLabel.text = @"0.00M";
    [DTHudManager showMessage:@"清除成功" InView:self.view];
}
// 给好评
- (void)doJudge
{
    NSURL *commentUrl = [NSURL URLWithString:kAppUrl];
    [[UIApplication sharedApplication] openURL:commentUrl];
    NSString *version = [DTOnlineManager currentVerson];
    [[NSUserDefaults standardUserDefaults] setObject:version forKey:KDTVersionCommentKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
