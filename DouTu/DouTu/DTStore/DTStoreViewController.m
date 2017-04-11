//
//  DTStoreViewController.m
//  DouTu
//
//  Created by yuepengfei on 17/3/14.
//  Copyright © 2017年 fly. All rights reserved.
//

#import "DTStoreViewController.h"
#import "DTTagViewController.h"
#import "DTAllTypeViewController.h"
#import "DTEditViewController.h"
#import "DTFunctionView.h"

@interface DTStoreViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,DTFunctionViewDelegate>

@property (nonatomic, strong) DTFunctionView      *functionView;
@property (nonatomic, strong) NSMutableDictionary *dataSource;
@property (nonatomic, strong) NSIndexPath         *seleteIndexPath;
@property (nonatomic, assign) BOOL                bFirst;
@property (nonatomic, assign) BOOL                bShow;
@property (nonatomic, strong) DTBaseModel         *picModel;
@end
@implementation DTStoreViewController

- (NSMutableDictionary *)dataSource
{
    if (!_dataSource) {
        _dataSource = [[NSMutableDictionary alloc] init];
        NSMutableArray *hots = [[NSMutableArray alloc] init];
        [_dataSource setObject:hots forKey:@"hots"];
        NSMutableArray *news = [[NSMutableArray alloc] init];
        [_dataSource setObject:news forKey:@"news"];
    }
    return _dataSource;
}
- (DTFunctionView *)functionView
{
    if (!_functionView) {
        _functionView = [[DTFunctionView alloc] initWithFrame:CGRectMake(0, KSCREEN_HEIGHT-64, KSCREEN_WIDTH, 153)];
        _functionView.backgroundColor = DT_Base_EdgeColor;
        _functionView.delegate = self;
    }
    return _functionView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addSubviews];
    [self configCollectionView];
    [self requestData];
    [self addRefreshHeader];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (_bFirst && ![[self.dataSource objectForKey:@"hots"] count]) {
        [self requestHotList];
    }
    if (_bFirst && ![[self.dataSource objectForKey:@"news"] count]) {
        self.pageNum = 0;
        [self requestNewList];
    }
    _bFirst = YES;
}
- (void)addSubviews
{
    [self.view addSubview:self.functionView];
}
#pragma mark - request
- (void)loadNewData
{
    self.pageNum = 0;
    
    if (![[self.dataSource objectForKey:@"hots"] count]) {
        [self requestHotList];
    }
    [self requestNewList];
}
- (void)loadMoreData
{
    self.pageNum++;
    [self requestNewList];
}
- (void)requestData
{
    [self requestHotList];
    [self requestNewList];
}
// 请求热门表情
- (void)requestHotList
{
    [DTNetManger getHotListWithCallBack:^(NSError *error, NSArray *response) {
        if (!kObjectIsEmpty(response)) {
            NSMutableArray *hots = [self.dataSource objectForKey:@"hots"];
            [hots removeAllObjects];
            [hots addObjectsFromArray:response];
            [self.myCollectionView reloadData];
        }
    }];
}
// 请求最新表情
- (void)requestNewList
{
    [DTNetManger getNewListWithPageNum:self.pageNum pageSize:60 callBack:^(NSError *error, NSArray *response) {
        
        [self endRefresh];
        if (!kObjectIsEmpty(response)) {
            NSMutableArray *news = [self.dataSource objectForKey:@"news"];
            if (!self.pageNum) {
                [news removeAllObjects];
            }
            [news addObjectsFromArray:response];
            [self.myCollectionView reloadData];
            [self addLoadMoreFooter];
        } else {
            [DTHudManager showMessage:@"网络错误" InView:self.view];
        }
    }];
}
#pragma mark - collectionView
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.dataSource.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        
        NSInteger number = [[self.dataSource objectForKey:@"hots"] count] > 8 ? 8 :[[self.dataSource objectForKey:@"hots"] count];
        return number;
    }
    return [[self.dataSource objectForKey:@"news"] count];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        DTBaseTitleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kDTBaseTitleCollectionViewCellIdentifier forIndexPath:indexPath];
        NSArray *pics = [self.dataSource objectForKey:@"hots"];
        [cell configModel:pics[indexPath.item]];
        return cell;
    }
    DTBaseCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kDTBaseCollectionViewCellIdentifier forIndexPath:indexPath];
    cell.nameLab.hidden = YES;
    NSArray *pics = [self.dataSource objectForKey:@"news"];
    [cell configModel:pics[indexPath.item]];
    if (_seleteIndexPath == indexPath && _bShow) {
//        cell.contentView.layer.borderColor = DT_Base_EdgeColor.CGColor;
//        cell.contentView.layer.borderWidth   = 2.f;
    } else {
//        cell.contentView.layer.borderColor = DT_Base_GrayEdgeColor.CGColor;
//        cell.contentView.layer.borderWidth   = 0.5f;
    }
    return cell;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([[self.dataSource objectForKey:@"news"] count] && indexPath.section == 1) {
        DTCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader  withReuseIdentifier:kDTCollectionReusableViewIdentifier forIndexPath:indexPath];
        headerView.titleLabel.text = @"今日最新表情";
        return headerView;
    }
    return nil;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if ([[self.dataSource objectForKey:@"news"] count] && section == 1) {
        return CGSizeMake(KSCREEN_WIDTH, 40);
    }
    return CGSizeZero;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        NSArray *hots = [self.dataSource objectForKey:@"hots"];
        if (indexPath.item < hots.count-1) {
            
            DTTagViewController *tagVC = [[DTTagViewController alloc] init];
            tagVC.tagId = [hots[indexPath.item] pid];
            tagVC.navTitle = [hots[indexPath.item] name];
            [self.navigationController pushViewController:tagVC animated:YES];
        } else {
            
            DTAllTypeViewController *typeVC = [[DTAllTypeViewController alloc] init];
            typeVC.navTitle = @"更多表情";
            [self.navigationController pushViewController:typeVC animated:YES];
        }
        return;
    }
    if (_seleteIndexPath == indexPath && _bShow) {
        [self hidenFouncView];
    } else {
        if (_bShow) {
            [self hideShowFouncViewWithIndexPath:indexPath];
        } else {
            [self showFouncViewWithIndexPath:indexPath];
        }
        NSArray *news = [self.dataSource objectForKey:@"news"];
        _picModel = news[indexPath.item];
        [self.functionView configModel:news[indexPath.item]] ;
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self hidenFouncView];
}
#pragma mark ---- FouncView Animation
- (void)hidenFouncView
{
    DTBaseCollectionViewCell *cell = (DTBaseCollectionViewCell *)[self.myCollectionView cellForItemAtIndexPath:_seleteIndexPath];
    [UIView animateWithDuration:0.2 animations:^{
        self.tabBarController.tabBar.top = KSCREEN_HEIGHT-self.tabBarController.tabBar.height;
        self.functionView.top = KSCREEN_HEIGHT-64;
        cell.contentView.layer.borderColor = DT_Base_GrayEdgeColor.CGColor;
        cell.contentView.layer.borderWidth = 0.5f;
        _bShow = NO;
    }];
}
- (void)showFouncViewWithIndexPath:(NSIndexPath *)indexPath
{
    DTBaseCollectionViewCell *preCell = (DTBaseCollectionViewCell *)[self.myCollectionView cellForItemAtIndexPath:_seleteIndexPath];
    DTBaseCollectionViewCell *lastCell = (DTBaseCollectionViewCell *)[self.myCollectionView cellForItemAtIndexPath:indexPath];
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:2.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.functionView.hidden = NO;
        self.tabBarController.tabBar.top = KSCREEN_HEIGHT;
        self.functionView.top = KSCREEN_HEIGHT-64-150;
        preCell.contentView.layer.borderColor = DT_Base_GrayEdgeColor.CGColor;
        preCell.contentView.layer.borderWidth = 0.5f;
        lastCell.contentView.layer.borderColor = DT_Base_EdgeColor.CGColor;
        lastCell.contentView.layer.borderWidth = 2.f;
        self.seleteIndexPath = indexPath;
    } completion:^(BOOL finished) {
        _bShow = YES;
    }];
}
- (void)hideShowFouncViewWithIndexPath:(NSIndexPath *)indexPath
{
    [UIView animateWithDuration:0.2 animations:^{
        self.functionView.top = KSCREEN_HEIGHT-64;
    } completion:^(BOOL finished) {
        [self showFouncViewWithIndexPath:indexPath];
    }];
}
#pragma mark ---------- DTFunctionViewDelegate
- (void)sendPicToWx
{
    [DTSendPicManager sendPic:_picModel channelType:kDTSendChannelType_Wx];
}
- (void)sendPicToQQ
{
    [DTSendPicManager sendPic:_picModel channelType:kDTSendChannelType_QQ];
}
- (void)collectPic
{
    [DTFouncManager savePic:_picModel toTab:kDTTableType_Collect];
}
- (void)savePic
{
    
}
- (void)editPic
{
    DTEditViewController *editVC = [[DTEditViewController alloc] init];
    editVC.itemId = _picModel.itemId;
    [self.navigationController pushViewController:editVC animated:YES];
}
@end
