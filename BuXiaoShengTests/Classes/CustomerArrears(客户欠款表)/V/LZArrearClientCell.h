//
//  LZArrearClientCell.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/6/15.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LZArrearClientModel;

@interface LZArrearClientCell : UITableViewCell
@property(nonatomic,strong)LZArrearClientModel *model;
@property(nonatomic,strong)UILabel *oneLbl;
@property(nonatomic,strong)UILabel *twoLbl;
@property(nonatomic,strong)UILabel *threeLbl;
@property(nonatomic,strong)UILabel *fourLbl;
@end
