//
//  LLProcessSectionView.h
//  BuXiaoSheng
//
//  Created by 周尊贤 on 2018/5/4.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//
@class LLProcessSectionView;
@protocol sectionViewDelegate<NSObject>

@optional

-(void)sectionViewDelegate:(LLProcessSectionView *)sectionView;

@end
#import <UIKit/UIKit.h>

@interface LLProcessSectionView : UITableViewHeaderFooterView
@property (nonatomic,assign) NSInteger  section;
@property (nonatomic,weak) id<sectionViewDelegate>  delegate;

@property (nonatomic,strong) UIButton * foldingBtn;
@end
