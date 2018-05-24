//
//  SalesDemandCell.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/5/23.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "salesDemandModel.h"

@protocol SalesDemandCellDelegate <NSObject>
- (void) didClickTitleTextField:(NSString *)titleTFInfo;
@end

@interface SalesDemandCell : UITableViewCell
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

-(void)settitleTFContent:(NSString *)title WithColorTFContent:(NSString *)color WithlineTFContent:(NSString *)line WithNumberTFContent:(NSString *)number WithPriceTFContent:(NSString *)price WithReturnBlock:(void (^)(salesDemandModel *model))textFieldBlock;
@end
