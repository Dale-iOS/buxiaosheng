//
//  BackOrderViewController.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/5/7.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "BaseViewController.h"

@interface BackOrderViewController : BaseViewController
//存放客户姓名
@property (nonatomic,strong) NSArray *nameArray;
//存放模糊匹配的客户姓名
@property (nonatomic,strong) NSArray *tempNameArray;
//客户数组
@property(nonatomic,strong)NSMutableArray *customerNameAry;
@property(nonatomic,strong)NSMutableArray *customerIdAry;
@property(nonatomic,strong)NSMutableArray *customerMobileAry;
//仓库方式数组
@property (nonatomic, strong) NSMutableArray *warehouseNameAry;
@property (nonatomic, strong) NSMutableArray *warehouseIdAry;
@property (nonatomic, copy) NSString *warehouseIdStr;//选中的仓库id
//付款方式数组
@property (nonatomic, strong) NSMutableArray *payNameAry;
@property (nonatomic, strong) NSMutableArray *payIdAry;
@property (nonatomic, copy) NSString *payIdStr;//选中的付款方式id
//审批人
@property(nonatomic,strong)NSMutableArray *approverList;
@property(nonatomic,strong)NSMutableArray *approverNameAry;
@property(nonatomic,strong)NSMutableArray *approverIdAry;
@property(nonatomic,copy)NSString *approverId;
@end
