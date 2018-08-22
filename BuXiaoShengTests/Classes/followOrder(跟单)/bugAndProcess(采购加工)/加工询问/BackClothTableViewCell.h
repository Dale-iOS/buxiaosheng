//
//  BackClothTableViewCell.h
//  对账详情
//
//  Created by 王猛 on 2018/8/21.
//  Copyright © 2018年 WM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PinDetailTableViewCell.h"
#import "DibuTableViewCell.h"
#import "TitleTableViewCell.h"
#import "LZPurchaseDetailModel.h"

@interface BackClothTableViewCell : UITableViewCell<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UILabel *colorLabel;
@property (weak, nonatomic) IBOutlet UILabel *demandNumberLabel;
@property (weak, nonatomic) IBOutlet UITableView *myTabelview;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *myTableViewConstrait;

@property (nonatomic, copy) LZPurchaseDetailItemListModel *listModel;

@end
