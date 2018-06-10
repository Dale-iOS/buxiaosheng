//
//  ManagerCostViewController.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/5/12.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ManagerCostViewController : UIViewController
@property(nonatomic,assign)BOOL isFromExpendVC;
@property(nonatomic,copy)void(^didClickCostLabel)(UILabel *costLabel);
@end
