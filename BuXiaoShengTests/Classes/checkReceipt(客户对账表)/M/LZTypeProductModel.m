//
//  LZTypeProductModel.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/8/8.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LZTypeProductModel.h"
#import <UIKit/UIKit.h>

@implementation LZtypeInnerModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

- (void)setTotalHeightAndConHeight {
    NSString *heightStr = @"";
    for (NSDictionary *tmp in self.valList) {
        heightStr = [heightStr stringByAppendingString:[NSString stringWithFormat:@" %@",tmp[@"value"]]];
    }
    heightStr = [heightStr substringFromIndex:1];
    self.xiMaName = heightStr;
    float stringHeight = [heightStr boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 20 - 240, MAXFLOAT) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13.0]} context:nil].size.height + 1;
    
    if (stringHeight < 30) {
        stringHeight = 30;
    }
    self.xiMaHeight = stringHeight;
}

@end

@implementation LZTypeProductModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

+ (NSArray *)setOriginSource:(NSArray <NSDictionary *>*)source {
    
    NSMutableArray *models = [NSMutableArray arrayWithCapacity:0];
    
    for (NSDictionary *tmpDic in source) {
        
        LZTypeProductModel *model = [[LZTypeProductModel alloc] init];
        
        [model setValuesForKeysWithDictionary:tmpDic];
        
        model.innerModels = [NSMutableArray arrayWithCapacity:0];
        
        NSArray *colorList = model.colorList;
        
        for (NSDictionary *inner in colorList) {
            LZtypeInnerModel *innerModel = [[LZtypeInnerModel alloc] init];
            [innerModel setValuesForKeysWithDictionary:inner];
            [innerModel setTotalHeightAndConHeight];
            [model.innerModels addObject:innerModel];
        }
        
        float totalHeight = 0;
        
        for (LZtypeInnerModel *innerModel in model.innerModels) {
            
            totalHeight += innerModel.xiMaHeight;
        }
        
        totalHeight += (140 + model.innerModels.count * 5);
        
        model.totalHeight = totalHeight;
        
        [models addObject:model];
    }
    
    return models;
}


@end
