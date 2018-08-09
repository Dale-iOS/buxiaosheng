//
//  LZTypeTopModel.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/8/9.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LZTypeTopModel : NSObject
@property (nonatomic,copy)NSString * createTime;
@property (nonatomic,copy)NSString * customerMobile;
@property (nonatomic,copy)NSString * customerName;
@property (nonatomic,copy)NSString * drawerName;
@property (nonatomic,copy)NSString * orderNo;
@property (nonatomic,copy)NSString * remark;
@property (nonatomic,strong)NSNumber * arrearsPrice;
@property (nonatomic,strong)NSNumber * depositPrice;
@property (nonatomic,strong)NSNumber * labelNumber;
@property (nonatomic,strong)NSNumber * netreceiptsPrice;
@property (nonatomic,strong)NSNumber * orderDetailId;
@property (nonatomic,strong)NSNumber * outNumber;
@property (nonatomic,strong)NSNumber * receivablePrice;
@property (nonatomic,strong)NSNumber * settleNumber;
@property (nonatomic,strong)NSNumber * total;
@property (nonatomic,strong)NSNumber * trimPrice;
@property (nonatomic,strong)NSNumber * type;

+ (LZTypeTopModel *)createModelWithOriginSource:(NSDictionary *)origin;

//备注的高度
@property (nonatomic,assign)float remakeHeight;
@end
