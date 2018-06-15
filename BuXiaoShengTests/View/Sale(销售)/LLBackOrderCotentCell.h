//
//  LLBackOrderCotentCell.h
//  BuXiaoSheng
//
//  Created by 周尊贤 on 2018/6/15.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LLBackOrdeContentModel;
@interface LLBackOrderCotentCell : UITableViewCell
 @property (nonatomic,strong) NSMutableArray <NSMutableArray <LLBackOrdeContentModel*>*>* dateModels;
@end
