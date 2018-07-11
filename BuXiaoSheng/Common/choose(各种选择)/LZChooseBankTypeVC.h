//
//  LZChooseBankTypeVC.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/7/3.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LZChooseBankTypeVC : UIViewController
@property (nonatomic,copy) void(^selectIDBlock)(NSString *typeId,NSString *bankId,NSString *incomeId);
@end
