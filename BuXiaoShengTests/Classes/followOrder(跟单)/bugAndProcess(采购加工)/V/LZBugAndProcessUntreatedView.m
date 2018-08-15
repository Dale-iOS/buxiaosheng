//
//  LZBugAndProcessUntreatedView.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/6/11.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  采购加工-未处理页面（销售）

#import "LZBugAndProcessUntreatedView.h"
#import "LZBugAndProcessUntreatedCell.h"
#import "LZBugAndProcessBssModel.h"
#import "LZPurchaseReceiptVC.h"
#import "LZPurchaseAskVC.h"
#import "DyeingViewController.h"
#import "LZPurchaseReceiptVC.h"
#import "LZProcessReceiptVC.h"
#import "LZProcessAskVC.h"

static NSInteger const pageSize = 15;
@interface LZBugAndProcessUntreatedView()<UITableViewDelegate,UITableViewDataSource,LZBugAndProcessUntreatedCellDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray<LZBugAndProcessBssModel*> *lists;
@property (nonatomic,assign) NSInteger pageIndex;//页数
@end

@implementation LZBugAndProcessUntreatedView

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
    WEAKSELF;
    self.tableView.mj_header = [MJRefreshStateHeader headerWithRefreshingBlock:^{
        weakSelf.pageIndex = 1;
        [weakSelf setupList];
    }];
}

- (MJRefreshFooter *)reloadMoreData {
    WEAKSELF;
    MJRefreshFooter *footer = [MJRefreshAutoGifFooter footerWithRefreshingBlock:^{
        weakSelf.pageIndex +=1;
        [weakSelf setupList];
    }];
    return footer;
}

#pragma mark ---- 网络请求 ----
//接口名称 采购加工跟踪-未处理
- (void)setupList{
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
                             @"pageNo":@(self.pageIndex),
                             @"pageSize":@(pageSize),
                             @"type":@"0"
                             };
    [BXSHttp requestGETWithAppURL:@"documentary/not_handle_list.do" param:param success:^(id response) {
        
        if ([response isKindOfClass:[NSDictionary class]] && [response objectForKey:@"data"]) {
            if (1 == self.pageIndex) {
                [self.lists removeAllObjects];
            }
            
            NSArray *itemList = [response objectForKey:@"data"];
            if (itemList && itemList.count > 0) {
                for (NSDictionary *dic in itemList) {
                    LZBugAndProcessBssModel *model = [LZBugAndProcessBssModel mj_objectWithKeyValues:dic];
                    [self.lists addObject:model];
                }
                if (self.lists.count % pageSize) {
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                } else {
                    [self.tableView.mj_footer endRefreshing];
                }
            } else {
                //                [LLHudTools showWithMessage:@"暂无更多数据"];
            }
            if (self.pageIndex == 1) {
                if (self.lists.count >= pageSize) {
                    self.tableView.mj_footer = [self reloadMoreData];
                } else {
                    self.tableView.mj_footer = nil;
                }
            }
            [self.tableView.mj_header endRefreshing];
            [self.tableView reloadData];
            
        } else {
            [LLHudTools showWithMessage:[response objectForKey:@"msg"]];
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
        }
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
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
//采购收货事件
- (void)didClickFirstBtnInCell:(UITableViewCell *)cell{
    NSIndexPath *indexP = [self.tableView indexPathForCell:cell];
    
    LZBugAndProcessBssModel *model = _lists[indexP.row];
    if ([model.purchaseType integerValue] == 0) {
        //采购类型
        LZPurchaseReceiptVC *vc = [[LZPurchaseReceiptVC alloc]init];
        vc.bugId = model.id;
#warning 测试数据--这个有问题 很奇怪 - 没有数据区别细码和总吗类型
        vc.isFindCode = 1;
        [[self viewController].navigationController pushViewController:vc animated:YES];
    }else{
        //加工类型
        LZProcessReceiptVC *vc = [[LZProcessReceiptVC alloc]init];
        vc.bugId = model.id;
#warning 测试数据--这个有问题 很奇怪 - 没有数据区别细码和总吗类型
        vc.isFindCode = indexP.row %2 >0;
        [[self viewController].navigationController pushViewController:vc animated:YES];
    }
    
}
//采购询问事件
- (void)didClickSecondBtnInCell:(UITableViewCell *)cell{
    NSIndexPath *indexP = [self.tableView indexPathForCell:cell];
    LZBugAndProcessBssModel *model = _lists[indexP.row];
    if ([model.purchaseType integerValue] == 0) {
        //采购类型
        LZPurchaseAskVC *vc = [[LZPurchaseAskVC alloc]init];
        vc.bugId = model.id;
        [[self viewController].navigationController pushViewController:vc animated:YES];
    }else{
        //加工类型
        LZProcessAskVC *vc = [[LZProcessAskVC alloc]init];
        vc.bugId = model.id;
        [[self viewController].navigationController pushViewController:vc animated:YES];
    }
    
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

#pragma mark - Getter && Setter
- (NSMutableArray<LZBugAndProcessBssModel *> *)lists {
    if (_lists == nil) {
        _lists = @[].mutableCopy;
    }
    return _lists;
}

@end
