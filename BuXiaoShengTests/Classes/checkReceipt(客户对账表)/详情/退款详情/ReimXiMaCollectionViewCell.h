//
//  XiMaCollectionViewCell.h
//  对账详情
//
//  Created by 王猛 on 2018/8/9.
//  Copyright © 2018年 WM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LZBackOrderDetialProductModel.h"

@interface ReimXiMaCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) LZBackOrderDetialProductValListModel *valListModel;
@property (weak, nonatomic) IBOutlet UILabel *value;
@end
