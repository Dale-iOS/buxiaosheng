//
//  AlterWarehouseViewController.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/5/12.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  添加仓库页面 修改仓库页面 

#import "AlterWarehouseViewController.h"
#import "LZHTableView.h"
#import "TextInputCell.h"
#import "LLFactoryModel.h"

@interface AlterWarehouseViewController ()<LZHTableViewDelegate>
@property (weak, nonatomic) LZHTableView *mainTabelView;
@property (strong, nonatomic) NSMutableArray *datasource;

///分店名称
@property (nonatomic, strong) TextInputCell *titleCell;
///状态
@property (nonatomic, strong) TextInputCell *stateCell;

@end

@implementation AlterWarehouseViewController
@synthesize mainTabelView;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self setupWarehouseDetailData];
}

- (LZHTableView *)mainTabelView
{
    if (!mainTabelView) {
        
        LZHTableView *tableView = [[LZHTableView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, APPHeight)];
        //        tableView.tableView.allowsSelection = YES;
        //        tableView.tableHeaderView = self.headView;
        tableView.delegate = self;
        tableView.backgroundColor = LZHBackgroundColor;
        [self.view addSubview:(mainTabelView = tableView)];
    }
    return mainTabelView;
}


- (void)setupUI
{

    self.navigationItem.titleView = self.isFormWarehouseAdd ? [Utility navTitleView:@"添加分店"] : [Utility navTitleView:@"修改分店"];
    
    UIButton *navRightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    navRightBtn.titleLabel.font = FONT(15);
    [navRightBtn setTitle:@"保存" forState:UIControlStateNormal];
    [navRightBtn setTitleColor:[UIColor colorWithHexString:@"#3d9bfa"] forState:UIControlStateNormal];
    [navRightBtn addTarget:self action:@selector(saveBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:navRightBtn];
    
    self.datasource = [NSMutableArray array];
    
    [self.view addSubview:self.mainTabelView];
    self.mainTabelView.delegate = self;
    [self setupSectionOne];
    self.mainTabelView.dataSoure = self.datasource;
}

//仓库详情接口 house/detail.do
- (void)setupWarehouseDetailData
{
    //从添加仓库过来的直接return
    if (self.isFormWarehouseAdd) {
        return;
    }
    
    NSDictionary * param = @{@"id":self.id};
    [BXSHttp requestPOSTWithAppURL:@"house/detail.do" param:param success:^(id response) {
        
        NSLog(@"%@",response);
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        
        if ([baseModel.code integerValue] != 200) {
            return ;
        }
        LLFactoryModel * model = [LLFactoryModel LLMJParse:baseModel.data];
        self.titleCell.contentTF.text = [BXSTools stringIsNullOrEmpty:model.name] ? @"暂无" :model.name;
        self.stateCell.contentTF.text = [model.status integerValue] == 0 ? @"启用" :@"未启用";
        
        
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
    }];
}

- (void)setupSectionOne
{
    self.titleCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    self.titleCell.titleLabel.text = @"分店名称";
    self.titleCell.contentTF.placeholder = @"请输入分店名称";
    
    self.stateCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    self.stateCell.rightArrowImageVIew.hidden = NO;
    self.stateCell.titleLabel.text = @"状态";
    self.stateCell.contentTF.enabled = false;
    self.stateCell.contentTF.placeholder = @"请选择类型";
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 10)];
    headerView.backgroundColor = LZHBackgroundColor;
    
    LZHTableViewItem *item = [[LZHTableViewItem alloc]init];
    item.sectionRows = @[self.titleCell,self.stateCell];
    item.canSelected = NO;
    item.sectionView = headerView;
    [self.datasource addObject:item];
}

-(void)LzhTableView:(LZHTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0 ||indexPath.row == 0) {
        return;
    }
    WEAKSELF;
    UIAlertController * alterVc = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请选用该分店启动状态" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction * enabled = [UIAlertAction actionWithTitle:@"启用" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        weakSelf.stateCell.contentTF.text = @"启用";
    }];
    
    UIAlertAction * disEnabled = [UIAlertAction actionWithTitle:@"未启用" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        weakSelf.stateCell.contentTF.text = @"未启用";
    }];
    UIAlertAction * cacanle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alterVc addAction:enabled];
    [alterVc addAction:disEnabled];
    [alterVc addAction:cacanle];
    [self.navigationController presentViewController:alterVc animated:true completion:nil];
}

- (void)saveBtnClick
{
    if ([BXSTools stringIsNullOrEmpty:self.titleCell.contentTF.text]) {
        BXS_Alert(@"请输入分店名称");
        return;
        
    }

    if ([BXSTools stringIsNullOrEmpty:self.stateCell.contentTF.text]) {
        BXS_Alert(@"请选择分店状态");
        return;
    }
    
    NSInteger status = -1;
    if ([self.stateCell.contentTF.text isEqualToString:@"启用"]) {
        status = 0;
    }else if ([self.stateCell.contentTF.text isEqualToString:@"未启用"]){
        status = 1;
    }
    
    NSString * requestUrl = @"";
    NSDictionary * param = nil;
    if (self.isFormWarehouseAdd) {
        requestUrl = @"house/add.do";
       
        param = @{
                  @"companyId":[BXSUser currentUser].companyId,
                  @"name":self.titleCell.contentTF.text,
                  @"status":@(status)
                  };
    }else {
        requestUrl = @"house/update.do";
        
        param = @{
                  @"companyId":[BXSUser currentUser].companyId,
                  @"name":self.titleCell.contentTF.text,
                  @"status":@(status),
                  @"id":self.id
                  };
    }
    
    [BXSHttp requestPOSTWithAppURL:requestUrl param:param success:^(id response) {
       
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        [LLHudTools showWithMessage:baseModel.msg];
        if ([baseModel.code integerValue] != 200) {
            return ;
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:true];
        });
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
    }];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
