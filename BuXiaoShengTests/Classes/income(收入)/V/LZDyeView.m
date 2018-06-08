//
//  LZDyeView.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/6/8.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LZDyeView.h"
#import "LZHTableView.h"
#import "TextInputCell.h"
#import "TextInputTextView.h"
#import "UITextView+Placeholder.h"
#import "ArrearsNameTextInputCell.h"

@interface LZDyeView()<LZHTableViewDelegate>
@property(nonatomic,weak)LZHTableView *myTableView;
@property(nonatomic,strong)NSMutableArray *dataSource;
///名称
@property(nonatomic,strong)ArrearsNameTextInputCell *titileCell;
///收款金额
@property(nonatomic,strong)TextInputCell *collectionCell;
///现欠款
@property(nonatomic,strong)TextInputCell *arrearsCell;
///备注
@property(nonatomic,strong)TextInputTextView *remarkTextView;

@end

@implementation LZDyeView
@synthesize myTableView;

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupUI];
    }
    return self;
}

- (LZHTableView *)myTableView
{
    if (myTableView == nil) {
        
        LZHTableView *tableView = [[LZHTableView alloc]initWithFrame:self.bounds];
        tableView.backgroundColor = LZHBackgroundColor;
        [self addSubview:(myTableView = tableView)];
        
    }
    return myTableView;
}

- (void)setupUI{
    self.dataSource = [NSMutableArray array];
    [self addSubview:self.myTableView];
    [self setSectionOne];
    self.myTableView.dataSoure = self.dataSource;
}

- (void)setSectionOne{
    //    名称
    self.titileCell = [[ArrearsNameTextInputCell alloc]init];
    self.titileCell.frame = CGRectMake(0, 0, APPWidth, 75);
    self.titileCell.titleLabel.text = @"名称";
    self.titileCell.beforeLabel.text = @"前欠款:￥2500";
    self.titileCell.contentTF.text = @"李先生";
    
    //    收款金额
    self.collectionCell = [[TextInputCell alloc]init];
    self.collectionCell.frame = CGRectMake(0, 0, APPWidth, 49);
    self.collectionCell.titleLabel.text = @"收款金额";
    self.collectionCell.contentTF.text = @"￥500";
    
    //    现欠款
    self.arrearsCell = [[TextInputCell alloc]init];
    self.arrearsCell.contentTF.textColor = [UIColor redColor];
    self.arrearsCell.frame = CGRectMake(0, 0, APPWidth, 49);
    self.arrearsCell.titleLabel.text = @"现欠款";
    self.arrearsCell.contentTF.text = @"￥2000";
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 10)];
    lineView.backgroundColor = LZHBackgroundColor;
    
    //    备注textView
    self.remarkTextView = [[TextInputTextView alloc]init];
    self.remarkTextView.frame = CGRectMake(0, 0, APPWidth, 98);
    self.remarkTextView.titleLabel.text = @"备注";
    self.remarkTextView.textView.placeholder = @"请输入备注内容";
    
    LZHTableViewItem *item = [[LZHTableViewItem alloc]init];
    item.sectionRows = @[self.titileCell,self.collectionCell,self.arrearsCell,lineView,self.remarkTextView];
    item.canSelected = NO;
    [self.dataSource addObject:item];
}

@end
