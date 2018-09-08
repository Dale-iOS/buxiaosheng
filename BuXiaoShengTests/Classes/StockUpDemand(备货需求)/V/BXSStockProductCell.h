//
//  BXSStockProductCell.h
//  BuXiaoSheng
//
//  Created by 家朋 on 2018/8/10.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
// 备货需求-采购头部cell
// 请输入产品名称--请选择颜色--请输入数量

#import "BaseTableCell.h"
#import "LZPurchaseModel.h"
//#import "salesDemandModel.h"
@class BXSStockProductCell;

@protocol BXSStockProductCellDelegate <NSObject>
- (void) clickEditorProductName:(UITextField *)nameTF andCell:(BXSStockProductCell*)titleCell;
- (void) clickSelectColor:(BXSStockProductCell*)colorCell;
- (void) clickNeedGetBottomData:(BXSStockProductCell*)colorCell;

@end

@interface BXSStockProductCell : BaseTableCell


@property (strong,nonatomic)LZPurchaseModel *model;
@property (nonatomic,strong) NSIndexPath  * indexPath;
//@property (copy,nonatomic)void (^clickEditorProductNameDataBlock)(void);
@property (copy,nonatomic)void (^clickSelectColorBlock)(void);
@property (copy,nonatomic)void (^clickNeedGetBottomDataBlock)(void);
@property (nonatomic,weak) id<BXSStockProductCellDelegate> delegate;
@property (nonatomic, strong) UITextField *nameTF;//品名
@property (nonatomic, strong) UITextField *colorTF;//颜色
@property (nonatomic, strong) UITextField *needCountTF;//需求量
//@property (nonatomic,strong) productListModel  *productModel;
@end
