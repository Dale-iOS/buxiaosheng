//
//  LZPurchaseReceiptDetailVC.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/8/21.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LZPurchaseReceiptDetailVC : BaseTableVC
@property (nonatomic ,strong) NSString *bugId;
@property (nonatomic ,strong) NSString *Id;
/// 外界传入 是否是细码。默认NO
@property (assign,nonatomic) BOOL isFindCode;
@end
