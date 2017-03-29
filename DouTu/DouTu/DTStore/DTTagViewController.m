//
//  DTTagViewController.m
//  DouTu
//
//  Created by yuepengfei on 17/3/15.
//  Copyright © 2017年 fly. All rights reserved.
//

#import "DTTagViewController.h"
#import "DTBaseCollectionViewCell.h"

@interface DTTagViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UIImageView *showView;
@property (nonatomic, strong) UIButton    *qqBtn;
@property (nonatomic, strong) UIButton    *wxBtn;
@property (nonatomic, strong) UIButton    *collectBtn;
@property (nonatomic, strong) UIButton    *saveBtn;
@property (nonatomic, strong) UIView      *lineView;
@property (nonatomic, strong) UICollectionView *myCollectionView;

@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, assign) NSInteger      pageNum;
@property (nonatomic, strong) NSIndexPath    *seleteIndexPath;
@property (nonatomic, strong) NSData         *picData;
@property (nonatomic, strong) DTBaseModel    *picModel;
@end

static NSString *const kDTTagCollectionViewCell = @"kDTTagCollectionViewCell";

@implementation DTTagViewController

- (UIImageView *)showView
{
    if (!_showView) {
        _showView = [[UIImageView alloc] init];
        _showView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _showView;
}
- (UIButton *)qqBtn
{
    if (!_qqBtn) {
        _qqBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_qqBtn setTitle:@"发送到QQ" forState:UIControlStateNormal];
        [_qqBtn addTarget:self action:@selector(sendPicToQQ) forControlEvents:UIControlEventTouchUpInside];
        [_qqBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_qqBtn setImage:[UIImage imageNamed:@"dt_logo_qq_black"] forState:UIControlStateNormal];
        _qqBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -3, 0, 3);
        _qqBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 3, 0, -3);
        _qqBtn.backgroundColor = DT_Base_EdgeColor;
        _qqBtn.titleLabel.font = DT_Base_ContentFont;
        _qqBtn.layer.masksToBounds = YES;
        _qqBtn.layer.cornerRadius  = 17.5;
    }
    return _qqBtn;
}
- (UIButton *)wxBtn
{
    if (!_wxBtn) {
        _wxBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_wxBtn setTitle:@"发送到微信" forState:UIControlStateNormal];
        [_wxBtn addTarget:self action:@selector(sendPicToWx) forControlEvents:UIControlEventTouchUpInside];
        [_wxBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_wxBtn setImage:[UIImage imageNamed:@"dt_logo_wx_black"] forState:UIControlStateNormal];
        _wxBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -3, 0, 3);
        _wxBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 3, 0, -3);
        _wxBtn.backgroundColor = DT_Base_EdgeColor;
        _wxBtn.titleLabel.font = DT_Base_ContentFont;
        _wxBtn.layer.masksToBounds = YES;
        _wxBtn.layer.cornerRadius  = 17.5;
    }
    return _wxBtn;
}
- (UIButton *)collectBtn
{
    if (!_collectBtn) {
        _collectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_collectBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_collectBtn setImage:[UIImage imageNamed:@"dt_down_em"] forState:UIControlStateNormal];
        _collectBtn.backgroundColor = DT_Base_EdgeColor;
        _collectBtn.layer.masksToBounds = YES;
        _collectBtn.layer.cornerRadius  = 17.5;
    }
    return _collectBtn;
}
- (UIButton *)saveBtn
{
    if (!_saveBtn) {
        _saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_saveBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_saveBtn setImage:[UIImage imageNamed:@"dt_favor_normal"] forState:UIControlStateNormal];
        _saveBtn.backgroundColor = DT_Base_EdgeColor;
        _saveBtn.layer.masksToBounds = YES;
        _saveBtn.layer.cornerRadius  = 17.5;
    }
    return _saveBtn;
}
- (UIView *)lineView
{
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = RGB(220, 220, 220);
    }
    return _lineView;
}
- (UICollectionView *)myCollectionView
{
    if (!_myCollectionView) {
        UICollectionViewFlowLayout *layOut = [[UICollectionViewFlowLayout alloc] init];
        layOut.itemSize = CGSizeMake((KSCREEN_WIDTH-DT_Base_Space*5)/4,(KSCREEN_WIDTH-DT_Base_Space*5)/4);
        layOut.minimumLineSpacing = DT_Base_Space;
        layOut.minimumInteritemSpacing = DT_Base_Space;
        layOut.sectionInset = UIEdgeInsetsMake(DT_Base_Space, DT_Base_Space, DT_Base_Space, DT_Base_Space);
        _myCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, self.lineView.bottom, KSCREEN_WIDTH, KSCREEN_HEIGHT-64-self.lineView.bottom) collectionViewLayout:layOut];
        _myCollectionView.backgroundColor = [UIColor whiteColor];
        [_myCollectionView registerClass:[DTBaseCollectionViewCell class] forCellWithReuseIdentifier:kDTTagCollectionViewCell];
        _myCollectionView.delegate = self;
        _myCollectionView.dataSource = self;
        [self.view addSubview:_myCollectionView];
    }
    return _myCollectionView;
}
- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] init];;
    }
    return _dataSource;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpSubViews];
    [self setLeftBackNavItem];
    [self requestData];
  
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:YES];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.tabBarController.tabBar setHidden:NO];
}
- (void)setUpSubViews
{
    _seleteIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    
    self.showView.frame = CGRectMake(15, 15, 150, 150);
    self.qqBtn.frame = CGRectMake(self.showView.right+(KSCREEN_WIDTH-165-130*DT_Base_Scale)/2, 24, 130*DT_Base_Scale, 35);
    self.wxBtn.frame = CGRectMake(self.qqBtn.left, self.qqBtn.bottom+8, 130*DT_Base_Scale, 35);
    self.collectBtn.frame = CGRectMake(self.qqBtn.left, self.wxBtn.bottom+20, (130*DT_Base_Scale-10)/2, 35);
    self.saveBtn.frame = CGRectMake(self.collectBtn.right+10, self.wxBtn.bottom+20, (130*DT_Base_Scale-10)/2, 35);
    self.lineView.frame = CGRectMake(0, 180, KSCREEN_WIDTH, 1);
    
    [self.view addSubview:self.showView];
    [self.view addSubview:self.qqBtn];
    [self.view addSubview:self.wxBtn];
    [self.view addSubview:self.collectBtn];
    [self.view addSubview:self.saveBtn];
    [self.view addSubview:self.lineView];
    [self.view addSubview:self.myCollectionView];
}
#pragma mark --- Public
- (void)addLoadMoreFooter
{
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    _myCollectionView.mj_footer = footer;
}
- (void)loadMoreData
{
    self.pageNum++;
    [self requestData];
}
- (void)requestData
{
    [DTNetManger getByTagId:_tagId pageNum:self.pageNum pageSize:60 callBack:^(NSError *error, NSArray *response) {
        
        [self endRefresh];
        if (!kArrayIsEmpty(response)) {
            if (self.pageNum == 0) {
                [self.dataSource removeAllObjects];
            }
            [self.dataSource addObjectsFromArray:response];
            [self.myCollectionView reloadData];
            if (self.pageNum == 0) {
                [self addLoadMoreFooter];
                [self refreshShowImgView:[self.dataSource firstObject]];
            }
        } else {
            [DTHudManager showMessage:@"网络错误" InView:self.view];
        }
    }];
}
- (void)endRefresh
{
    [self.myCollectionView.mj_footer endRefreshing];
}
#pragma mark - collectionView
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DTBaseCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kDTTagCollectionViewCell forIndexPath:indexPath];
    [cell configModel:self.dataSource[indexPath.item]];
    cell.nameLab.hidden = YES;
    if (_seleteIndexPath == indexPath) {
        cell.contentView.layer.borderColor = DT_Base_EdgeColor.CGColor;
        cell.contentView.layer.borderWidth   = 2.f;
    } else {
        cell.contentView.layer.borderColor = DT_Base_GrayEdgeColor.CGColor;
        cell.contentView.layer.borderWidth   = 0.5f;
    }
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    if (indexPath != _seleteIndexPath) {
        DTBaseCollectionViewCell *preSeleteCell = (DTBaseCollectionViewCell *)[collectionView cellForItemAtIndexPath:_seleteIndexPath];
        preSeleteCell.contentView.layer.borderColor = DT_Base_GrayEdgeColor.CGColor;
        preSeleteCell.contentView.layer.borderWidth   = 0.5f;
        
        _seleteIndexPath = indexPath;
        DTBaseCollectionViewCell *lastSeleteCell = (DTBaseCollectionViewCell *)[collectionView cellForItemAtIndexPath:self.seleteIndexPath];
        lastSeleteCell.contentView.layer.borderColor = DT_Base_EdgeColor.CGColor;
        lastSeleteCell.contentView.layer.borderWidth   = 2.f;
    }
    DTBaseModel *model = self.dataSource[indexPath.item];
    [self refreshShowImgView:model];
}
- (void)refreshShowImgView:(DTBaseModel *)model
{
    _picModel = model;
    if ([model.mediaType isEqualToNumber:@0]) {
        
        [self.showView sd_setImageWithURL:[NSURL safeURLWithString:model.picPath] placeholderImage:[UIImage imageNamed:@"dt_loadingImg"]];
    } else {
       [self.showView sd_setImageWithURL:[NSURL safeURLWithString:model.gifPath] placeholderImage:[UIImage imageNamed:@"dt_loadingImg"]];
    }
}
#pragma mark - 发送图片到微信
- (void)sendPicToWx
{
    [DTSendPicManager sendPic:_picModel channelType:kDTSendChannelType_Wx];
}
- (void)sendPicToQQ
{
    [DTSendPicManager sendPic:_picModel channelType:kDTSendChannelType_QQ];
}
@end
