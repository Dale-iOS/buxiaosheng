//
//  ModifySubjectViewController.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/5/3.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  修改科目页面 添加科目页面

#import "ModifySubjectViewController.h"
#import "LZHTableView.h"
#import "TextInputCell.h"
#import "LZSubjectModel.h"

@interface ModifySubjectViewController ()<LZHTableViewDelegate>
@property (weak, nonatomic) LZHTableView *mainTabelView;
@property (strong, nonatomic) NSMutableArray *datasource;

///科目名称
@property (nonatomic, strong) TextInputCell *titleCell;
///所属分组
@property (nonatomic, strong) TextInputCell *groupCell;
///状态
@property (nonatomic, strong) TextInputCell *stateCell;

@end

@implementation ModifySubjectViewController
@synthesize mainTabelView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    [self setupSubjectDetailData];
}

- (LZHTableView *)mainTabelView
{
    if (!mainTabelView) {
        
        LZHTableView *tableView = [[LZHTableView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, APPHeight)];
        //        tableView.tableView.allowsSelection = YES;
        //        tableView.tableHeaderView = self.headView;
        tableView.backgroundColor = LZHBackgroundColor;
        tableView.delegate = self;
        [self.view addSubview:(mainTabelView = tableView)];
    }
    return mainTabelView;
}

- (void)setupUI
{
//    self.navigationItem.titleView = [Utility navTitleView:@"修改科目"];
    self.navigationItem.titleView = self.isFormSubjectAdd ?[Utility navTitleView:@"添加科目"] : [Utility navTitleView:@"修改科目"];
    self.navigationItem.rightBarButtonItem = [Utility navButton:self action:@selector(selectornavRightBtnClick) title:@"确认"];
    
    
    self.datasource = [NSMutableArray array];
    
    [self.view addSubview:self.mainTabelView];
    self.mainTabelView.delegate = self;
    [self setupSectionOne];
    self.mainTabelView.dataSoure = self.datasource;
}

- (void)setupSectionOne
{
    self.titleCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    self.titleCell.titleLabel.text = @"科目名称";
    self.titleCell.contentTF.placeholder = @"请输入科目名称";
    
    self.groupCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    self.groupCell.rightArrowImageVIew.hidden = NO;
    self.groupCell.titleLabel.text = @"所属分组";
    self.groupCell.contentTF.placeholder = @"请选择所属分组";
    self.groupCell.contentTF.enabled = false;
    
    self.stateCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    self.stateCell.rightArrowImageVIew.hidden = NO;
    self.stateCell.titleLabel.text = @"状态";
    self.stateCell.contentTF.placeholder = @"请选择状态";
    self.stateCell.contentTF.enabled = NO;
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 10)];
    headerView.backgroundColor = LZHBackgroundColor;
    
    LZHTableViewItem *item = [[LZHTableViewItem alloc]init];
    item.sectionRows = @[self.titleCell,self.groupCell,self.stateCell];
    item.canSelected = NO;
    item.sectionView = headerView;
    [self.datasource addObject:item];
}

- (void)setupSubjectDetailData
{
    //从添加项目过来的直接 return
    if (self.isFormSubjectAdd) {
        return;
    }
    NSDictionary * param = @{@"id":self.id};
    [BXSHttp requestGETWithAppURL:@"costsubject/detail.do" param:param success:^(id response) {
        NSLog(@"%@",response);
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue]!=200) {
            return ;
        }
        LZSubjectModel * model = [LZSubjectModel LLMJParse:baseModel.data];
        
        self.titleCell.contentTF.text = model.name;
        
        if ([model.type integerValue] == 0) {
            self.groupCell.contentTF.text = @"管理费用";
        }else if ([model.type integerValue] == 1)
        {
            self.groupCell.contentTF.text = @"销售费用";
        }else if ([model.type integerValue] == 2)
        {
            self.groupCell.contentTF.text = @"财务费用";
        }
        else if ([model.type integerValue] == 3)
        {
            self.groupCell.contentTF.text = @"其他费用";
        }
        
        self.stateCell.contentTF.text = [model.status integerValue] == 0 ? @"启用" :@"未启用";
        
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage)
    }];
}

- (void)selectornavRightBtnClick
{
    if ([BXSTools stringIsNullOrEmpty:self.titleCell.contentTF.text]) {
        BXS_Alert(@"请输入科目名称");
        return;
    }
    
    if ([BXSTools stringIsNullOrEmpty:self.titleCell.contentTF.text]) {
        BXS_Alert(@"请输入所属分组");
        return;
    }
    
    if ([BXSTools stringIsNullOrEmpty:self.stateCell.contentTF.text]) {
        BXS_Alert(@"请输入状态");
        return;
    }
    
    NSInteger status = -1;
    if ([self.stateCell.contentTF.text isEqualToString:@"启用"]) {
        status = 0;
    }else if ([self.stateCell.contentTF.text isEqualToString:@"未启用"]){
        status = 1;
    }
    
    NSInteger types = -1;
    if ([self.groupCell.contentTF.text isEqualToString:@"管理费用"]) {
        types = 0;
    }else if ([self.groupCell.contentTF.text isEqualToString:@"销售费用"]){
        types = 1;
    }else if ([self.groupCell.contentTF.text isEqualToString:@"财务费用"]){
        types = 2;
    }else if ([self.groupCell.contentTF.text isEqualToString:@"其他费用"]){
        types = 3;
    }
    
    NSString * requestUrl ;
    if (self.isFormSubjectAdd) {
        requestUrl = @"costsubject/add.do";
    }else {
        requestUrl = @"costsubject/update.do";
    }
    NSDictionary * param = nil;
    if (_isFormSubjectAdd) {
        param = @{
                  @"type":@(types),
                  @"companyId":[BXSUser currentUser].companyId,
                  @"name":self.titleCell.contentTF.text,
                  @"status":@(status)
                  };
    }else
    {
        param = @{
                  @"type":@(types),
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

-(void)LzhTableView:(LZHTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0 ) {
        return;
    }
    WEAKSELF;
    
    if (indexPath.row == 1) {
        
        UIAlertController * alterVc = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请选择该科目所属分组" preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction * manager = [UIAlertAction actionWithTitle:@"管理费用" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            weakSelf.groupCell.contentTF.text = @"管理费用";
        }];
        
        UIAlertAction * sell = [UIAlertAction actionWithTitle:@"销售费用" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            weakSelf.groupCell.contentTF.text = @"销售费用";
        }];
        
        UIAlertAction * finance = [UIAlertAction actionWithTitle:@"财务费用" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            weakSelf.groupCell.contentTF.text = @"财务费用";
        }];
        
        UIAlertAction * other = [UIAlertAction actionWithTitle:@"其他费用" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            weakSelf.groupCell.contentTF.text = @"其他费用";
        }];
        UIAlertAction * cacanle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alterVc addAction:manager];
        [alterVc addAction:sell];
        [alterVc addAction:finance];
        [alterVc addAction:other];
        [alterVc addAction:cacanle];
        [self.navigationController presentViewController:alterVc animated:true completion:nil];
    }
    
    if (indexPath.row == 2) {
        UIAlertController * alterVc = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请选用该科目启动状态" preferredStyle:UIAlertControllerStyleActionSheet];
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
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
