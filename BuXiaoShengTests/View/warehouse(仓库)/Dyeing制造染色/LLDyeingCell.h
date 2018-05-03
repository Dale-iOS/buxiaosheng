//
//  LLDyeingCell.h
//  BuXiaoSheng
//
//  Created by 周尊贤 on 2018/5/3.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LLDyeingCell : UITableViewCell
@property (nonatomic,strong) UITextField * textField;
@property (nonatomic,strong) NSIndexPath * indexPath;
@property (nonatomic,strong) NSArray <NSDictionary*>* datas;
@end
