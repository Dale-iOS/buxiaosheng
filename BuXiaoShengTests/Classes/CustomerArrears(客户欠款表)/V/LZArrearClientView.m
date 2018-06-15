//
//  LZArrearClientView.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/6/14.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  客户（欠款表）

#import "LZArrearClientView.h"
#import "LZArrearClientModel.h"
#import "LZArrearClientCell.h"


@interface LZArrearClientView()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property(nonatomic,strong)NSArray<LZArrearClientModel*> *lists;
@property(nonatomic,strong)UIView *headView;
@end

@implementation LZArrearClientView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupListData];
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    self.backgroundColor = [UIColor greenColor];
    
    //设置tableviewHeadView
    _headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 39)];
    _headView.backgroundColor = [UIColor grayColor];
    UILabel *oneLbl = [[UILabel alloc]init];
    oneLbl.font = FONT(14);
    oneLbl.textColor = CD_Text33;
    oneLbl.textAlignment = NSTextAlignmentCenter;
    oneLbl.text = @"客户名称";
    oneLbl.backgroundColor = [UIColor colorWithHexString:@"#f9f9f9"];
    [_headView addSubview:oneLbl];
    [oneLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.equalTo(_headView);
        make.width.mas_offset(APPWidth *0.2);
        make.height.mas_offset(39);
    }];
    UILabel *twoLbl = [[UILabel alloc]init];
    twoLbl.font = FONT(14);
    twoLbl.textColor = CD_Text33;
    twoLbl.textAlignment = NSTextAlignmentCenter;
    twoLbl.text = @"应收借欠";
    twoLbl.backgroundColor = [UIColor colorWithHexString:@"#f9f9f9"];
    [_headView addSubview:twoLbl];
    [twoLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(oneLbl.mas_right);
        make.top.equalTo(_headView);
        make.width.mas_offset(APPWidth *0.3);
        make.height.mas_offset(39);
    }];
    UILabel *threeLbl = [[UILabel alloc]init];
    threeLbl.font = FONT(14);
    threeLbl.textColor = CD_Text33;
    threeLbl.textAlignment = NSTextAlignmentCenter;
    threeLbl.text = @"最后还款日期";
    threeLbl.backgroundColor = [UIColor colorWithHexString:@"#f9f9f9"];
    [_headView addSubview:threeLbl];
    [threeLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(twoLbl.mas_right);
        make.top.equalTo(_headView);
        make.width.mas_offset(APPWidth *0.3);
        make.height.mas_offset(39);
    }];
    UILabel *fourLbl = [[UILabel alloc]init];
    fourLbl.font = FONT(14);
    fourLbl.textColor = CD_Text33;
    fourLbl.textAlignment = NSTextAlignmentCenter;
    fourLbl.text = @"业务员";
    fourLbl.backgroundColor = [UIColor colorWithHexString:@"#f9f9f9"];
    [_headView addSubview:fourLbl];
    [fourLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(threeLbl .mas_right);
        make.top.equalTo(_headView);
        make.width.mas_offset(APPWidth *0.2);
        make.height.mas_offset(39);
    }];
    
    _tableView = [[UITableView alloc]initWithFrame:self.bounds style:UITableViewStylePlain];
    _tableView.backgroundColor = LZHBackgroundColor;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableHeaderView = _headView;
    _tableView.tableFooterView = [UIView new];
    [self addSubview:_tableView];
//    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.and.right.equalTo(self);
//        make.top.equalTo()
//    }];
}

#pragma mark ------- 网络请求 --------
//接口名称 客户欠款列表
- (void)setupListData
{
    //    DESC：从高到低 ASC：从低到高）
    NSDictionary *param = @{@"companyId":[BXSUser currentUser].companyId,
                            @"pageNo":@"1",
                            @"pageSize":@"15",
                            @"amountSort":@"DESC",
                            @"dateSort":@"DESC"
                            };
    [BXSHttp requestGETWithAppURL:@"finance_data/coustomer_arrear_list.do" param:param success:^(id response) {
        LLBaseModel *baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
        _lists = [LZArrearClientModel LLMJParse:baseModel.data];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark ----- tableviewdelegate -----
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _lists.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"LZArrearClientCell";
    LZArrearClientCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        cell = [[LZArrearClientCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.model = _lists[indexPath.row];
    return cell;
}


@end
