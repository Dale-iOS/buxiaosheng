//
//  ConsultViewController.m
//  对账详情
//
//  Created by 王猛 on 2018/8/21.
//  Copyright © 2018年 WM. All rights reserved.
//

#import "ConsultViewController.h"
#import "PinNameTableViewCell.h"
#import "BackClothTableViewCell.h"
#import "ConsultOtherTableViewCell.h"
#import "LZPurchaseDetailModel.h"

@interface ConsultViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)LZPurchaseDetailModel *model;

@property(nonatomic,strong)NSArray <LZPurchaseDetailItemListModel*> *lists;

@end

@implementation ConsultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.title = @"加工咨询";
    self.navigationItem.titleView = [Utility navTitleView:@"加工询问"];
    [self setupData];
}

#pragma mark ---- 网络请求 ----
//采购加工跟踪-未处理详情
- (void)setupData{
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
                             @"buyId":self.bugId};
    [BXSHttp requestGETWithAppURL:@"documentary/not_handle_detail.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
        _model = [LZPurchaseDetailModel LLMJParse:baseModel.data];
        _lists = _model.itemList;
        
        
        [self.myTableView reloadData];
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
    }];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2+_lists.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        
        return 48;
        
    }else if(indexPath.row == _lists.count + 1)
    {
        return 378;
        
    }else
    {
        LZPurchaseDetailItemListModel *listModel = _lists[indexPath.row-1];
        if (listModel.bottomList.count == 0) {
            return 60;
        }else
        {
            return 60 + 80 + 20 + 40*listModel.bottomList.count;
        }
        
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (indexPath.row == 0) {
        PinNameTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PinNameTableViewCell"];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"PinNameTableViewCell" owner:self options:nil] lastObject];
            
        }
        cell.detailModel = _model;
        return cell;
    }else if (indexPath.row == _lists.count + 1){
        
        ConsultOtherTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ConsultOtherTableViewCell"];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"ConsultOtherTableViewCell" owner:self options:nil] lastObject];
            
        }
        cell.detailModel = _model;
        return cell;
        
    }
    else
    {
        BackClothTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BackClothTableViewCell"];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"BackClothTableViewCell" owner:self options:nil] lastObject];
            
        }
        if (_lists.count > 0) {
            
            cell.listModel = _lists[indexPath.row-1];
        }
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark -- 确认
- (IBAction)clickSureBtn:(UIButton *)sender {
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
