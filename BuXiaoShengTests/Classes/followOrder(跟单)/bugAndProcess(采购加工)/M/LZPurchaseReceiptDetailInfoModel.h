//
//  LZPurchaseReceiptDetailInfoModel.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/8/21.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LZPurchaseReceiptDetailInfoModel : NSObject
@property (nonatomic,copy) NSString *address;//地址
@property (nonatomic,copy) NSString *arrearsPrice;//本期欠款
@property (nonatomic,copy) NSString *bankId;//支付方式id
@property (nonatomic,copy) NSString *bankName;//付款方式
@property (nonatomic,copy) NSString *companyId;//公司id
@property (nonatomic,copy) NSString *contactName;//供应商联系人
@property (nonatomic,copy) NSString *copewithPrice;//应付金额
@property (nonatomic,copy) NSString *createTime;//创建时间
@property (nonatomic,copy) NSString *factoryName;//供应商名称
@property (nonatomic,copy) NSString *factoryNo;//供应商单号
@property (nonatomic,copy) NSString *houseName;//入库仓
@property (nonatomic,copy) NSString *id;//采购单id
@property (nonatomic,copy) NSString *imgs;//图片
@property (nonatomic,copy) NSString *mobile;//手机号
@property (nonatomic,copy) NSString *orderNo;//单号
@property (nonatomic,copy) NSString *purchaserId;//采购人ID
@property (nonatomic,copy) NSString *realpayPrice;//实付金额
@property (nonatomic,copy) NSString *remark;//备注
@property (nonatomic,copy) NSString *tel;//电话    
@end
