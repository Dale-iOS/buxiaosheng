//
//  LZSpendingListVC.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/6/10.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LZSpendingListVC.h"

@interface LZSpendingListVC ()
//顶部试图
@property(nonatomic,strong)UIView *headView;
@property(nonatomic,strong)UILabel *dateText;
@property(nonatomic,strong)UIView *rigthHeadView;
@property(nonatomic,strong)UILabel *dateLbl;
@end

@implementation LZSpendingListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI{
    self.navigationItem.titleView = [Utility navTitleView:@"日出支出列表"];
    
    //设置顶部时间筛选
    _headView = [[UIView alloc]init];
    _headView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_headView];
    [_headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(LLNavViewHeight);
        make.left.and.right.equalTo(self.view);
        make.height.mas_offset(39);
    }];
    
    _dateText = [[UILabel alloc]init];
    _dateText.textColor = CD_Text33;
    _dateText.font = FONT(14);
    _dateText.text = @"本月";
    [_headView addSubview:_dateText];
    [_dateText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_headView).offset(15);
        make.centerY.equalTo(_headView);
        make.width.mas_offset(100);
    }];
    _rigthHeadView = [[UIView alloc]init];
    _rigthHeadView.backgroundColor = [UIColor whiteColor];
    _rigthHeadView.userInteractionEnabled = YES;
    UITapGestureRecognizer *headerTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headerTapClick)];
    [_rigthHeadView addGestureRecognizer:headerTap];
    [_headView addSubview:_rigthHeadView];
    [_rigthHeadView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_headView);
        make.top.and.bottom.equalTo(_headView);
        make.width.mas_offset(140);
    }];
    UIImageView *dateImageView = [[UIImageView alloc]init];
    dateImageView.image = IMAGE(@"bankdate");
    [_rigthHeadView addSubview:dateImageView];
    [dateImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(16);
        make.height.mas_offset(15);
        make.right.equalTo(_rigthHeadView).offset(-15);
        make.centerY.equalTo(_rigthHeadView);
    }];
    _dateLbl = [[UILabel alloc]init];
    _dateLbl.textColor = CD_Text66;
    _dateLbl.font = FONT(14);
    _dateLbl.text = @"2018-04-12";
    _dateLbl.textAlignment = NSTextAlignmentRight;
    [_rigthHeadView addSubview:_dateLbl];
    [_dateLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(100);
        make.height.mas_offset(15);
        make.right.equalTo(dateImageView.mas_left).offset(-10);
        make.centerY.equalTo(dateImageView);
    }];
}

#pragma mark ----- 点击事件 ------
- (void)headerTapClick{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
