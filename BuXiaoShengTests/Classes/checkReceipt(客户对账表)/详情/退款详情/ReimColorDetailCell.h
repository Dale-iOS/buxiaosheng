//
//  ColorDetailCell.h
//  对账详情
//
//  Created by 王猛 on 2018/8/8.
//  Copyright © 2018年 WM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LZBackOrderDetialProductModel.h"

@interface ReimColorDetailCell : UITableViewCell<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) LZBackOrderDetialProductColorListModel *colorListModel;


@property (weak, nonatomic) IBOutlet UILabel *productColorName;
@property (weak, nonatomic) IBOutlet UILabel *unitName;
@property (weak, nonatomic) IBOutlet UILabel *total;
@property (weak, nonatomic) IBOutlet UILabel *price;

@end
