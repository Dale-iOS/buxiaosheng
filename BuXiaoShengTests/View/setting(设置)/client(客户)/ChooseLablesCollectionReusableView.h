//
//  ChooseLablesCollectionReusableView.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/5/17.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ChooseLablesCollectionReusableViewDelegate <NSObject>

- (void)didClickAddBtnInTextfeild:(UIView *)view withContentInTextfeild:(NSString *)contentStr;

@end

@interface ChooseLablesCollectionReusableView : UICollectionReusableView

@property (nonatomic, weak) id<ChooseLablesCollectionReusableViewDelegate> delegate;
//@property (nonatomic, strong) UILabel *titleLbl;

@property (nonatomic, strong) UITextField *tf;
@property (nonatomic, copy) NSString *tfStr;
@end
