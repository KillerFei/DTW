//
//  DTBaseCollectionViewCell.h
//  DouTu
//
//  Created by yuepengfei on 17/3/14.
//  Copyright © 2017年 fly. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface DTBaseCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UILabel   *nameLab;

- (void)configModel:(DTBaseModel *)model;

@end
