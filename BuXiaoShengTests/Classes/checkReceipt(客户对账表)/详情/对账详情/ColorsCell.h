//
//  ColorsCell.h
//  对账详情
//
//  Created by 王猛 on 2018/8/8.
//  Copyright © 2018年 WM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ColorsCell : UITableViewCell<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSDictionary *colorDic;

@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewContant;
@property (weak, nonatomic) IBOutlet UILabel *productNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalNumber;

- (void)loadContactData;
- (void)showColorData:(NSDictionary *)colorDic;
@end
