//
//  DTBaseCollectionViewController.h
//  DouTu
//
//  Created by yuepengfei on 17/3/14.
//  Copyright © 2017年 fly. All rights reserved.
//

#import "DTBaseViewController.h"

extern NSString *const kDTBaseCollectionViewCellIdentifier;
extern NSString *const kDTBaseTitleCollectionViewCellIdentifier;
extern NSString *const kDTCollectionReusableViewIdentifier;
@interface DTBaseCollectionViewController : DTBaseViewController

@property (nonatomic, assign) NSInteger        pageNum;
@property (nonatomic, assign) BOOL             bFirstLoad;
@property (nonatomic, strong) UICollectionView *myCollectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *layOut;


- (void)configCollectionView;

- (void)addRefreshHeader;
- (void)addLoadMoreFooter;

- (void)loadNewData;
- (void)loadMoreData;
- (void)requestData;
- (void)endRefresh;
@end
