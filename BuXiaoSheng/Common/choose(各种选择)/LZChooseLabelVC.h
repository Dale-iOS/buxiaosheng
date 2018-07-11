//
//  LZChooseLabelVC.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/6/7.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    ToSearchGroup,//搜索分组
    ToSearchLabel,//搜索标签
    ToSearchUnit,//搜索单位
} ToSearchWhat;

@interface LZChooseLabelVC : UIViewController
@property(nonatomic,assign) ToSearchWhat ToSearchWhat;
@property (nonatomic,copy) void(^LabelsArrayBlock)(NSString *labelString);
@property (nonatomic,copy) void(^LabelsDetailBlock)(NSString *labelString,NSString *labelId);
@end
