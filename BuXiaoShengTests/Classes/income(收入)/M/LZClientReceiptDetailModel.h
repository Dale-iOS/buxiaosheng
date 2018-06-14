//
//  LZClientReceiptDetailModel.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/6/9.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LZClientReceiptDetailModel : NSObject
@property(nonatomic,strong)NSString *amount;
@property(nonatomic,strong)NSString *arrears;
@property(nonatomic,strong)NSString *bankName;
@property(nonatomic,strong)NSString *customerName;
@property(nonatomic,strong)NSString *remark;
@property(nonatomic,strong)NSString *createTime;
@property(nonatomic,strong)NSString *factoryName;
@property(nonatomic,strong)NSString *type;
@end
