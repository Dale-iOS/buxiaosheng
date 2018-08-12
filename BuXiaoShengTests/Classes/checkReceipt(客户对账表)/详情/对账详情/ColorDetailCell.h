//
//  ColorDetailCell.h
//  对账详情
//
//  Created by 王猛 on 2018/8/8.
//  Copyright © 2018年 WM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LZCollectionCheckDetailProductModel.h"


@interface ColorDetailCell : UITableViewCell<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (weak, nonatomic) IBOutlet UILabel *productColorNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *unitNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;

@property (nonatomic, strong) NSDictionary *dataDic;
@property (nonatomic, strong) NSArray *valList;
@property (nonatomic, strong) LZInventoryListColorListModel *colorListModel;

@end
