//
//  LLDyeingSectionView.h
//  BuXiaoSheng
//
//  Created by 周尊贤 on 2018/5/3.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//
#import <UIKit/UIKit.h>
@class LLDyeingSectionView;
@protocol sectionViewDelegate<NSObject>

@optional

-(void)sectionViewDelegate:(LLDyeingSectionView *)sectionView;

@end

@interface LLDyeingSectionView : UITableViewHeaderFooterView
@property (nonatomic,assign) NSInteger  section;
@property (nonatomic,weak) id<sectionViewDelegate> delegate;

@property (nonatomic,strong) UIButton * foldingBtn;
@end
