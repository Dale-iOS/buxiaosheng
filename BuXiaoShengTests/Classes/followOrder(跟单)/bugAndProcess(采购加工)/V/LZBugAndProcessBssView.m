//
//  LZBugAndProcessBssView.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/6/12.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  采购加工-未处理页面（老板）

#import "LZBugAndProcessBssView.h"
#import "LZBugAndProcessUntreatedCell.h"
#import "LZBugAndProcessBssModel.h"
#import "LZPurchaseReceiptVC.h"
#import "LZPurchaseAskVC.h"
#import "DyeingViewController.h"

@interface LZBugAndProcessBssView()<UITableViewDelegate,UITableViewDataSource,LZBugAndProcessUntreatedCellDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSArray<LZBugAndProcessBssModel*> *lists;
@end

@implementation LZBugAndProcessBssView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
        [self setupList];
    }
    return self;
}

- (void)setupUI{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView .backgroundColor = LZHBackgroundColor;
    self.tableView .delegate = self;
    self.tableView .dataSource = self;
    //隐藏分割线
    self.tableView .separatorStyle = NO;
    [self addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.equalTo(self);
        make.bottom.equalTo(self).offset(-45);
    }];
}

#pragma mark ---- 网络请求 ----
//接口名称 采购加工跟踪-未处理
- (void)setupList{
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
                             @"pageNo":@"1",
                             @"pageSize":@"15",
                             @"type":@"1"
                             };
    [BXSHttp requestGETWithAppURL:@"documentary/not_handle_list.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
        _lists = [LZBugAndProcessBssModel LLMJParse:baseModel.data];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
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
    return 150;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"LZBugAndProcessUntreatedCellId";
    LZBugAndProcessUntreatedCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        cell = [[LZBugAndProcessUntreatedCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.delegate = self;
    }
    cell.model = _lists[indexPath.row];
    return cell;
}

#pragma mark ---- 点击事件 ----
- (void)didClickFirstBtnInCell:(UITableViewCell *)cell{
//    LZPurchaseReceiptVC *vc = [[LZPurchaseReceiptVC alloc]init];
//    [[self viewController].navigationController pushViewController:vc animated:YES];
    DyeingViewController *vc = [[DyeingViewController alloc]init];
    [[self viewController].navigationController pushViewController:vc animated:YES];
}

- (void)didClickSecondBtnInCell:(UITableViewCell *)cell{
//    LZPurchaseAskVC *vc = [[LZPurchaseAskVC alloc]init];
//    [[self viewController].navigationController pushViewController:vc animated:YES];
    NSIndexPath *indexP = [self.tableView indexPathForCell:cell];
    LZBugAndProcessBssModel *model = _lists[indexP.row];
    LZPurchaseAskVC *vc = [[LZPurchaseAskVC alloc]init];
    vc.bugId = model.id;
    [[self viewController].navigationController pushViewController:vc animated:YES];
}

//完成事件
- (void)didClickThirdBtnInCell:(UITableViewCell *)cell{
    NSIndexPath *indexP = [self.tableView indexPathForCell:cell];
    LZBugAndProcessBssModel *model = _lists[indexP.row];
    
    //设置警告框
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"点击完成后将无法继续收货和询问" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        NSLog(@"取消执行");
    }];
    
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        
        //        接口名称 采购完成
        NSDictionary * param = @{
                                 @"companyId":[BXSUser currentUser].companyId,
                                 @"id":model.id
                                 };
        [BXSHttp requestPOSTWithAppURL:@"documentary/update_status.do" param:param success:^(id response) {
            LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
            
            if ([baseModel.code integerValue] != 200) {
                return ;
            }
            [LLHudTools showWithMessage:@"提交成功"];
            [self setupList];
        } failure:^(NSError *error) {
            BXS_Alert(LLLoadErrorMessage);
        }];
        
    }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:otherAction];
    
    [[self viewController] presentViewController:alertController animated:YES completion:nil];
}

- (UIViewController *)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}


@end
