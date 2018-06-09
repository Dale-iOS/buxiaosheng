//
//  LZPickerView.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/5/14.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <UIKit/UIKit.h>
///titileString 改为了compoentString对应的array的row
typedef void (^customBlock)(NSString *compoentString,NSString *titileString);

@interface LZPickerView :  UIView
@property (nonatomic ,copy)NSString *componentString;
@property (nonatomic ,copy)NSString *titleString;
@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic ,copy)customBlock getPickerValue;
@property (nonatomic ,copy)NSString *valueString;

@property (nonatomic ,strong)UIPickerView *picerView;
@property (nonatomic ,strong)UIView *toolsView;


- (instancetype)initWithComponentDataArray:(NSArray *)ComponentDataArray titleDataArray:(NSArray *)titleDataArray;
@end

