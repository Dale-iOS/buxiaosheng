//
//  ResponsibleViewController.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/4/17.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  我负责的(客户管理)

#import "ResponsibleViewController.h"
#import "LZClientModel.h"
#import "LZClientManagerModel.h"
#import "ClientManagerTableViewCell.h"
#import "SearchClientViewController.h"

@interface ResponsibleViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
}
@property (nonatomic, strong) NSArray <LZClientManagerModel *> *clients;
@property (nonatomic, strong) UILabel *headLabel;
@end

@implementation ResponsibleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setupData];
}

- (void)setupData
{
    NSDictionary *param = @{@"companyId":[BXSUser currentUser].companyId,
                            @"labelName":@"",
                            @"memberId":[BXSUser currentUser].userId,
                            @"pageNo":@"1",
                            @"pageSize":@"20",
                            @"searchName":@"",
//                            @"status":@""
                            
                            };
    [BXSHttp requestGETWithAppURL:@"customer/list.do" param:param success:^(id response) {
       
        LLBaseModel *baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            
            [LLHudTools showWithMessage:baseModel.msg];
        }
        
    } failure:^(NSError *error) {
        
    }];
}

- (void)setupUI
{

    //    筛选蓝色底图View
    UIView *screenView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 34)];
    screenView.backgroundColor = [UIColor colorWithHexString:@"#3d9bfa"];
    screenView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesOnClick)];
    [screenView addGestureRecognizer:tapGes];
    [self.view addSubview:screenView];
    
    UILabel *label = [[UILabel alloc]init];
    label.text = @"筛选";
    label.font = FONT(13);
    label.textColor = [UIColor whiteColor];
    
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.image = IMAGE(@"screenwihte");
    
    UIView *headBgView = [[UIView alloc]init];
    headBgView.backgroundColor = [UIColor clearColor];
    [screenView addSubview:headBgView];
    [headBgView addSubview:imageView];
    [headBgView addSubview:label];
    
    headBgView.sd_layout
    .centerXEqualToView(screenView)
    .centerYEqualToView(screenView)
    .widthIs(45)
    .heightIs(14);
    
    label.sd_layout
    .leftSpaceToView(headBgView, 0)
    .centerYEqualToView(headBgView)
    .widthIs(27)
    .heightIs(14);
    
    imageView.sd_layout
    .rightSpaceToView(headBgView, 0)
    .centerYEqualToView(headBgView)
    .widthIs(14)
    .heightIs(12);
    
    
    _headLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, screenView.bottom, APPWidth -15, 25)];
    _headLabel.text = @"共0人";
    _headLabel.textColor = CD_Text99;
    _headLabel.font = FONT(13);
    _headLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_headLabel];
    
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, screenView.bottom, APPWidth, APPHeight) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    //隐藏分割线
    _tableView.separatorStyle = NO;
    [self.view addSubview:_tableView];
}

#pragma mark ----- tableviewdelegate -----
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"ClientManagerTableViewCell";
    ClientManagerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[ClientManagerTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    return cell;
}

//筛选点击
- (void)tapGesOnClick
{
    SearchClientViewController *vc = [[SearchClientViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
