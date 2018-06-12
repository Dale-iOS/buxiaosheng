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


@interface LZBugAndProcessBssView()<UITableViewDelegate,UITableViewDataSource,LZBugAndProcessUntreatedCellDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSArray<LZBugAndProcessBssModel*> *lists;
@end

@implementation LZBugAndProcessBssView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
//        [self setupList];
    }
    return self;
}

- (void)setupUI{
    self.tableView = [[UITableView alloc]initWithFrame:self.bounds style:UITableViewStylePlain];
    self.tableView .backgroundColor = LZHBackgroundColor;
    self.tableView .delegate = self;
    self.tableView .dataSource = self;
    //隐藏分割线
    self.tableView .separatorStyle = NO;
    [self addSubview:self.tableView];
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
//    [[self viewController].navigationController pushViewController:[[LZBugAndProcessListVC alloc]init] animated:YES];
}

- (void)didClickSecondBtnInCell:(UITableViewCell *)cell{
    
}

- (void)didClickThirdBtnInCell:(UITableViewCell *)cell{
    
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
