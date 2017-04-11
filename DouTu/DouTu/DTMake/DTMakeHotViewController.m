//
//  DTMakeHotViewController.m
//  DouTu
//
//  Created by yuepengfei on 17/3/28.
//  Copyright © 2017年 fly. All rights reserved.
//

#import "DTMakeHotViewController.h"

@interface DTMakeHotViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSMutableArray *dataSource;
@end
static NSString *kDTMakeHeaderCellIdentifier = @"dtMakeHeaderCellIdentifier";
static NSString *kDTReusableViewIdentifier   = @"dtReusableViewIdentifier";

@implementation DTMakeHotViewController

- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self configCollectionView];
    [self requestData];
    [self addRefreshHeader];
}
#pragma mark -------- RequestData
- (void)requestData
{
    [DTNetManger getRecommendListWithPageNum:self.pageNum pageSize:64 callBack:^(NSError *error, NSArray *response) {
        
        [self endRefresh];
        if (!kArrayIsEmpty(response)) {
            if (self.pageNum == 0) {
                [self.dataSource removeAllObjects];
            }
            [self.dataSource addObjectsFromArray:response];
            [self.myCollectionView reloadData];
            [self addLoadMoreFooter];
        } else {
            [DTHudManager showMessage:@"网络错误" InView:self.view];
        }
    }];;
}
- (void)loadNewData
{
    self.pageNum = 0;
    [self requestData];
}
- (void)loadMoreData
{
    self.pageNum++;
    [self requestData];
}
#pragma mark -------- Collect Delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DTBaseCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kDTBaseCollectionViewCellIdentifier forIndexPath:indexPath];
    [cell configModel:self.dataSource[indexPath.item]];
    return cell;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    DTCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader  withReuseIdentifier:kDTCollectionReusableViewIdentifier forIndexPath:indexPath];
    headerView.titleLabel.text = @"推荐模板";
    return headerView;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(KSCREEN_WIDTH, 40);
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    DTEditViewController *editVC = [[DTEditViewController alloc] init];
    editVC.navTitle = @"改图";
    editVC.itemId = [self.dataSource[indexPath.item] pid];
    [self.navigationController pushViewController:editVC animated:YES];
}
@end
