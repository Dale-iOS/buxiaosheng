//
//  ColorsCell.h
//  对账详情
//
//  Created by 王猛 on 2018/8/8.
//  Copyright © 2018年 WM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LZBackOrderDetialProductModel.h"

@interface ReimColorsCell : UITableViewCell<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) LZBackOrderDetialProductModel *productModel;
@property (nonatomic, strong) NSMutableArray *colorArray;

@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewContant;

- (void)loadContactData;

@end
