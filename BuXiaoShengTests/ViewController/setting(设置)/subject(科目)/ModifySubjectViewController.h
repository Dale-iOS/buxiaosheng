//
//  ModifySubjectViewController.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/5/3.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface ModifySubjectViewController : BaseViewController
@property (nonatomic,copy) NSString * id;
@property (nonatomic,assign) BOOL  isFormSubjectAdd;  //yes 来源添加科目 false 修改科目
@end
