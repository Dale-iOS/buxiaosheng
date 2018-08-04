//
//  LZDirectStorageBottomView.m
//  BuXiaoSheng
//
//  Created by Dale on 2018/8/4.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LZDirectStorageBottomView.h"

@implementation LZDirectStorageBottomView

+ (instancetype)bottomView {
    UINib *nib = [UINib nibWithNibName:@"LZDirectStorageBottomView" bundle:nil];
    return [[nib instantiateWithOwner:nil options:nil] firstObject];
}

@end
