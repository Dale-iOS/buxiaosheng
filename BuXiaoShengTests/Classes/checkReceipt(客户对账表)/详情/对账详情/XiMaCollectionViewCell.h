//
//  XiMaCollectionViewCell.h
//  对账详情
//
//  Created by 王猛 on 2018/8/9.
//  Copyright © 2018年 WM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LZCollectionCheckDetailProductModel.h"

@interface XiMaCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) LZInventoryListValListModel *valListModel;

@property (weak, nonatomic) IBOutlet UILabel *colorValue;


@end
