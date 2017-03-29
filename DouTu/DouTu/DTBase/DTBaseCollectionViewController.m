//
//  DTBaseCollectionViewController.m
//  DouTu
//
//  Created by yuepengfei on 17/3/14.
//  Copyright © 2017年 fly. All rights reserved.
//

#import "DTBaseCollectionViewController.h"

NSString *const kDTBaseCollectionViewCellIdentifier = @"dtBaseCollectionViewCellIdentifier";
NSString *const kDTBaseTitleCollectionViewCellIdentifier = @"dtBaseTitleCollectionViewCellIdentifier";
NSString *const kDTCollectionReusableViewIdentifier = @"dtCollectionReusableViewIdentifier";

@interface DTBaseCollectionViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@end

@implementation DTBaseCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addSubViews];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark --- SetupCollectionView
- (void)addSubViews
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _pageNum = 0;
    _layOut = [[UICollectionViewFlowLayout alloc] init];
    _myCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT-113) collectionViewLayout:_layOut];
    _myCollectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_myCollectionView];
}
#pragma mark --- ConfigCollectionView
- (void)configCollectionView
{
    _layOut.itemSize = CGSizeMake((KSCREEN_WIDTH-DT_Base_Space*5)/4,(KSCREEN_WIDTH-DT_Base_Space*5)/4);
    _layOut.minimumLineSpacing = DT_Base_Space;
    _layOut.minimumInteritemSpacing = DT_Base_Space;
    _layOut.sectionInset = UIEdgeInsetsMake(DT_Base_Space, DT_Base_Space, DT_Base_Space, DT_Base_Space);
    
    [_myCollectionView registerClass:[DTBaseCollectionViewCell class] forCellWithReuseIdentifier:kDTBaseCollectionViewCellIdentifier];
    [_myCollectionView registerClass:[DTBaseTitleCollectionViewCell class] forCellWithReuseIdentifier:kDTBaseTitleCollectionViewCellIdentifier];
    [_myCollectionView registerClass:[DTCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kDTCollectionReusableViewIdentifier];
    
    _myCollectionView.delegate = self;
    _myCollectionView.dataSource = self;
}
#pragma mark --- Public
- (void)addRefreshHeader
{
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    _myCollectionView.mj_header = header;
}
- (void)addLoadMoreFooter
{
    if (!_bFirstLoad) {
        MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
        _myCollectionView.mj_footer = footer;
        _bFirstLoad = YES;
    }
}
- (void)loadNewData
{
}
- (void)loadMoreData
{
}
- (void)requestData
{
}
- (void)endRefresh
{
    [self.myCollectionView.mj_header endRefreshing];
    [self.myCollectionView.mj_footer endRefreshing];
}
#pragma mark --- UICollectionView
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 0;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}
@end
