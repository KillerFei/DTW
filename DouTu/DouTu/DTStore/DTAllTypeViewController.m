//
//  DTAllTypeViewController.m
//  DouTu
//
//  Created by 岳鹏飞 on 2017/3/27.
//  Copyright © 2017年 fly. All rights reserved.
//

#import "DTAllTypeViewController.h"
#import "DTTagViewController.h"
#import "DTTypeCollectionViewCell.h"
#import "DTTextCollectionViewCell.h"
#import "DTTypeModel.h"

@interface DTAllTypeViewController ()<UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation DTAllTypeViewController

- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLeftBackNavItem];
    [self configCollectionView];
    [self requestData];
}
- (void)configCollectionView
{
    [self.myCollectionView registerClass:[DTTypeCollectionViewCell class] forCellWithReuseIdentifier:kDTBaseTitleCollectionViewCellIdentifier];
    [self.myCollectionView registerClass:[DTTextCollectionViewCell class] forCellWithReuseIdentifier:kDTBaseCollectionViewCellIdentifier];
    [self.myCollectionView registerClass:[DTCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kDTCollectionReusableViewIdentifier];
    self.myCollectionView.delegate = self;
    self.myCollectionView.dataSource = self;
}
- (void)requestData
{
    [DTNetManger getTagAllLisWithCallBack:^(NSError *error, NSArray *response) {
        
        if (!kArrayIsEmpty(response)) {
            [self.dataSource removeAllObjects];
            [self.dataSource addObjectsFromArray:response];
            [self.myCollectionView reloadData];
        } else {
            [DTHudManager showMessage:@"网络错误" InView:self.view];
        }
    }];
}
#pragma mark - CollectionView Delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.dataSource.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    DTTypeModel *typeModel = self.dataSource[section];
    return typeModel.types.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DTTypeModel *typeModel = self.dataSource[indexPath.section];
    if (indexPath.section < self.dataSource.count-1) {
        DTTypeCollectionViewCell *baseCell = [collectionView dequeueReusableCellWithReuseIdentifier:kDTBaseTitleCollectionViewCellIdentifier forIndexPath:indexPath];
        [baseCell configModel:typeModel.types[indexPath.item]];
        return baseCell;
    }
    DTTextCollectionViewCell *textCell = [collectionView dequeueReusableCellWithReuseIdentifier:kDTBaseCollectionViewCellIdentifier forIndexPath:indexPath];
    [textCell configModel:typeModel.types[indexPath.item]];
    return textCell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section < self.dataSource.count-1) {
        
         return CGSizeMake((KSCREEN_WIDTH-DT_Base_Space*5)/4,(KSCREEN_WIDTH-DT_Base_Space*5)/4);
    }
    return CGSizeMake((KSCREEN_WIDTH-DT_Base_Space*5)/4,40);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return DT_Base_Space;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return DT_Base_Space;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(DT_Base_Space, DT_Base_Space, DT_Base_Space, DT_Base_Space);
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    DTCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader  withReuseIdentifier:kDTCollectionReusableViewIdentifier forIndexPath:indexPath];
    headerView.titleLabel.text = [self.dataSource[indexPath.section] name];;
    return headerView;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(KSCREEN_WIDTH, 40);
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    DTTypeModel *typeModel = self.dataSource[indexPath.section];
    DTBaseModel *baseModel = [typeModel.types objectAtIndex:indexPath.item];
    DTTagViewController *tagVC = [[DTTagViewController alloc] init];
    tagVC.navTitle = typeModel.name;
    tagVC.tagId    = baseModel.pid;
    [self.navigationController pushViewController:tagVC animated:YES];
}
@end
