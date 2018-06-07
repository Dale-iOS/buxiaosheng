//
//  LZChooseLabelVC.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/6/7.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LZChooseLabelVC : UIViewController
@property (nonatomic,copy) void(^LabelsArrayBlock)(NSString *labelString);
@end
