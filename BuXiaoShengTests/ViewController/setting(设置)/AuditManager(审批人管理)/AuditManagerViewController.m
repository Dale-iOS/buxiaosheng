//
//  AuditManagerViewController.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/5/2.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  审批人管理页面

#import "AuditManagerViewController.h"
#import "AuditManagerTableViewCell.h"
#import "AddAuditManagerViewController.h"
#import "LLAuditMangerModel.h"
@interface AuditManagerViewController ()<UITableViewDelegate,UITableViewDataSource,AuditManagerTableViewCellDelegate>

@property (nonatomic, strong)UITableView *tableView;

@property (nonatomic,strong) NSArray <NSDictionary*> * names;

@end

@implementation AuditManagerViewController

-(void)setModel:(LLAuditMangerItemModel *)model {
    _model = model;
    if (_model) {
        NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
                                 @"memberId":_model.id
                                 };
        [BXSHttp requestGETWithAppURL:@"approver/add.do" param:param success:^(id response) {
            LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
            if ([baseModel.code integerValue] != 200) {
                BXS_Alert(baseModel.msg)
                return ;
            }
            [LLHudTools showWithMessage:@"操作成功"];
            [self setupData];
        } failure:^(NSError *error) {
            [LLHudTools showWithMessage:LLLoadErrorMessage];
        }];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setupData];
}

- (void)setupUI
{
    self.navigationItem.titleView = [Utility navTitleView:@"审批人管理"];
    
    self.navigationItem.rightBarButtonItem = [Utility navButton:self action:@selector(navigationAddClick) image:IMAGE(@"add1")];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, APPHeight) style:UITableViewStylePlain];
    self.tableView.backgroundColor = LZHBackgroundColor;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
   
    //隐藏分割线
    //    self.tableView.separatorStyle = NO;

    [self.view addSubview:self.tableView];
}

-(void)setupData {
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId};
    [BXSHttp requestGETWithAppURL:@"approver/list.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue]!=200) {
            return ;
        }
        self.names = baseModel.data;
        if (!self.names.count) {
            [LLHudTools showWithMessage:@"暂无数据"];
        }
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark ----- tableviewdelegate -----
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.names.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 85;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"AuditManagerTableViewCell";
    AuditManagerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        cell = [[AuditManagerTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.delegate = self;
    }
    NSString *nameStr = self.names[indexPath.row][@"memberName"];
    if (nameStr.length > 3) {
        cell.iconNameLabel.text = [nameStr substringToIndex:3];
    }else{
        cell.iconNameLabel.text = nameStr;
    }
//    cell.iconNameLabel.text = self.names[indexPath.row][@"memberName"];
     cell.titleLabel.text = self.names[indexPath.row][@"memberName"];
    
    return cell;
}

- (void)navigationAddClick
{
    AddAuditManagerViewController *vc = [[AddAuditManagerViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didClickDeletBtnInCell:(UITableViewCell *)cell
{
    NSIndexPath *indexP = [self.tableView indexPathForCell:cell];
    
    //设置警告框
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"确定删除该审批人？" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
        NSLog(@"取消执行");
        
    }];

    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        
        NSDictionary * param = @{
                                 @"companyId":[BXSUser currentUser].companyId,
                                 @"id":self.names[indexP.row][@"id"]
                                 };
        [BXSHttp requestPOSTWithAppURL:@"approver/delete.do" param:param success:^(id response) {
            LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
           
            if ([baseModel.code integerValue] != 200) {
                return ;
            }
             [LLHudTools showWithMessage:@"删除成功"];
            [self setupData];
            
        } failure:^(NSError *error) {
            BXS_Alert(LLLoadErrorMessage);
        }];
        
    }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:otherAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)deleteManager
{
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
