//
//  PurchaseDetailCell.h
//  BuXiaoSheng
//
//  Created by 王猛 on 2018/9/4.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LZPurchasingInfoDetailModel.h"
#import "JGPurchaseCollectionViewCell.h"

@protocol WMRefreshCellDelegate <NSObject>

- (void)refreshCell:(NSIndexPath *)indexPath;

@end

@interface JGPurchaseDetailCell : UITableViewCell<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *productNameLB;
@property (weak, nonatomic) IBOutlet UILabel *totalNumberLB;
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (weak, nonatomic) IBOutlet UICollectionView *myCollectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionViewHConstraint;
@property (nonatomic, strong) LZPurchasingInfoDetailModel *detailModel;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (nonatomic, strong) NSArray *itemList;
@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, weak) id<WMRefreshCellDelegate>delegate;

@end
