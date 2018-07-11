//
//  LZChoosseWorkerVC.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/6/18.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LZChoosseWorkerVC : BaseViewController
@property(nonatomic,copy)NSString *navTitle;
@property(nonatomic,copy)void(^chooseBlock)(NSString *workerId,NSString *workerName);
@end
