//
//  AddClienViewController.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/5/16.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface AddClienViewController : BaseViewController

@property (nonatomic,copy) NSString * id;
@property (nonatomic,assign) BOOL  isFormSelect;  //yes 来源添加客户  false 更新客户
@property(nonatomic,copy)void(^didClickBlock)(BOOL isFormSelect);
@end
