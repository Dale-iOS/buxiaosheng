//
//  AlterBankViewController.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/5/11.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface AlterBankViewController : BaseViewController
@property (nonatomic,copy) NSString * id;
@property (nonatomic,assign) BOOL  isFormBankAdd;  //yes 来源添加银行  false 更新银行
@end
