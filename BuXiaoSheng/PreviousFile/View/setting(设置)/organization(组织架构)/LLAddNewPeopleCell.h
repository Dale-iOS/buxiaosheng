//
//  LLAddNewPeopleCell.h
//  BuXiaoSheng
//
//  Created by 周尊贤 on 2018/5/14.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//
@class LLAddNewPeopleModel;
#import <UIKit/UIKit.h>

@interface LLAddNewPeopleCell : UITableViewCell
@property (nonatomic,strong) LLAddNewPeopleModel * model;
@property (nonatomic,strong) NSIndexPath * indexPath;
@property (nonatomic, strong) UITextField * rightTextFild;
@end
