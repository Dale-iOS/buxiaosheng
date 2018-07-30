//
//  LZFineCodeCell.h
//  BuXiaoShengTests
//
//  Created by 家朋 on 2018/6/24.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
// 添加细码的cell

#import <UIKit/UIKit.h>


#import "LZFindCodeModel.h"

@interface LZFineCodeCell : UITableViewCell<UITextFieldDelegate>



@property (strong,nonatomic)LZFindCodeModel*model;
@end
