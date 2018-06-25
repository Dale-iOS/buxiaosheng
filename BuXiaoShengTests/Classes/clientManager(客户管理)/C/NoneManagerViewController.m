//
//  NoneManagerViewController.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/4/17.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  无人负责的（客户管理）

#import "NoneManagerViewController.h"
#import "LZClientModel.h"
#import "LZClientManagerModel.h"
#import "ClientManagerTableViewCell.h"
#import "SearchClientViewController.h"
#import "LZChooseLabelVC.h"

@interface NoneManagerViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong) NSArray <LZClientManagerModel *> *clients;
@property (nonatomic, strong) UILabel *headLabel;
@end

@implementation NoneManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = LZHBackgroundColor;
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setupData];
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
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, _headLabel.bottom, APPWidth, APPHeight -LLNavViewHeight) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    //隐藏分割线
    _tableView.separatorStyle = NO;
    _tableView.tableFooterView = [UIView new];
    [self.view addSubview:_tableView];
}

- (void)setupData
{
    NSDictionary *param = @{@"companyId":[BXSUser currentUser].companyId,
                            @"memberId":@"0",
                            @"pageNo":@"1",
                            @"pageSize":@"20",
                            };
    [BXSHttp requestGETWithAppURL:@"customer/list.do" param:param success:^(id response) {
        
        LLBaseModel *baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            
            [LLHudTools showWithMessage:baseModel.msg];
        }
        
        self.clients = [LZClientManagerModel LLMJParse:baseModel.data];
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
    }];
}

#pragma mark ----- tableviewdelegate -----
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.clients.count;
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
        cell.model = self.clients[indexPath.row];
    }
    return cell;
}

//筛选点击
- (void)tapGesOnClick
{
    LZChooseLabelVC *vc = [[LZChooseLabelVC alloc]init];
    vc.ToSearchWhat = ToSearchLabel;
    
    CWLateralSlideConfiguration *conf = [CWLateralSlideConfiguration configurationWithDistance:0 maskAlpha:0.4 scaleY:1.0 direction:CWDrawerTransitionFromRight backImage:[UIImage imageNamed:@"back"]];
    [self.navigationController cw_showDrawerViewController:vc animationType:(CWDrawerAnimationTypeMask) configuration:conf];
    
    
    [vc setLabelsArrayBlock:^(NSString *labelString) {
        
        NSDictionary *param = @{@"companyId":[BXSUser currentUser].companyId,
                                @"labelName":labelString,
                                @"memberId":@"0",
                                @"pageNo":@"1",
                                @"pageSize":@"20",
                                
                                };
        [BXSHttp requestGETWithAppURL:@"customer/list.do" param:param success:^(id response) {
            
            LLBaseModel *baseModel = [LLBaseModel LLMJParse:response];
            if ([baseModel.code integerValue] != 200) {
                
                [LLHudTools showWithMessage:baseModel.msg];
            }
            
            self.clients = [LZClientManagerModel LLMJParse:baseModel.data];
            _headLabel.text = [NSString stringWithFormat:@"共%zd人",self.clients.count];
            [self.tableView reloadData];
            
        } failure:^(NSError *error) {
            BXS_Alert(LLLoadErrorMessage);
        }];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
