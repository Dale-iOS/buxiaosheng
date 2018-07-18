//
//  SalesDemandCell.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/5/23.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "salesDemandModel.h"
@class SalesDemandCell;
@protocol SalesDemandCellDelegate <NSObject>
- (void) didClickTitleTextField:(UITextField *)titleTF andCell:(SalesDemandCell*)titleCell;
//- (void) didClickTitleBtn:(UIButton *)titleBtn;

//- (void) didClickTitleTextField:(SalesDemandCell*)titleCell;
- (void) didClickColorTextField:(SalesDemandCell*)colorCell;
- (void) didClickNumberTextField:(SalesDemandCell*)colorCell;

@end

@interface SalesDemandCell : UITableViewCell

@property (nonatomic,strong) NSIndexPath  * indexPath;
@property (nonatomic,weak) id<SalesDemandCellDelegate> delegate;
///品名
@property (nonatomic,strong)UITextField *titleTF;
///颜色
@property (nonatomic,strong)UITextField *colorTF;
///条数
@property (nonatomic,strong)UITextField *lineTF;
///数量
@property (nonatomic,strong)UITextField *numberTF;
///单价
@property (nonatomic,strong)UITextField *priceTF;

@property (nonatomic,strong) productListModel  * model;
@end
