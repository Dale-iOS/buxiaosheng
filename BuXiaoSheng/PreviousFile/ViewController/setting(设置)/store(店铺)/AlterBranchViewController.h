//
//  AlterBranchViewController.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/5/12.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface AlterBranchViewController : BaseViewController

@property (nonatomic,copy) NSString * id;
@property (nonatomic,assign) BOOL  isFormBranchAdd;  //yes 来源添加分店  false 更新分店

@end
