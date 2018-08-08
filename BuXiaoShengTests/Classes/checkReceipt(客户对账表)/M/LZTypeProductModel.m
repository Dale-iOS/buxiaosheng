//
//  LZTypeProductModel.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/8/8.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LZTypeProductModel.h"
#import <UIKit/UIKit.h>

@implementation LZTypeProductModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

+ (NSArray *)setOriginSource:(NSArray <NSDictionary *>*)source {
    
    NSMutableArray *models = [NSMutableArray arrayWithCapacity:0];
    
    for (NSDictionary *tmpDic in source) {
        
        LZTypeProductModel *model = [[LZTypeProductModel alloc] init];
        
        [model setValuesForKeysWithDictionary:tmpDic];
        
        NSDictionary *colorList = model.colorList;
        
        model.price = colorList[@"price"];
        model.productColorName = colorList[@"productColorName"];
        model.unitName = colorList[@"unitName"];
        model.valList = colorList[@"valList"];
        
        model.conHeight = [NSMutableArray arrayWithCapacity:0];
        
        float totalHeight = 0;
        
        for (int i = 0;i <model.valList.count;i++) {
            
            NSString *string = model.valList[i][@"value"];
            
            float stringHeight = [string boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 20 - 240, MAXFLOAT) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13.0]} context:nil].size.height + 1;
            
            if (stringHeight < 30) {
                stringHeight = 30;
            }
            
            [model.conHeight addObject:@(stringHeight)];
            
            totalHeight += stringHeight;
        }
        
        totalHeight += (140 + model.valList.count * 5);
        
        model.totalHeight = totalHeight;
        
        [models addObject:model];
    }
    
    return models;
}

@end
