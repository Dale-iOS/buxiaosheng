//
//  LLHomeChidVC.m
//  BuXiaoSheng
//
//  Created by lanlan on 2018/8/7.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LLHomeChidVC.h"
#import "LLHomeChildCell.h"
#import "LLHomePieChartModel.h"
#import "LLHomeBaseTableView.h"
#import "HomeViewController.h"
@interface LLHomeChidVC ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic ,strong)NSMutableArray * models;
@end

@implementation LLHomeChidVC

-(void)setSelectIndex:(NSInteger)selectIndex {
    _selectIndex = selectIndex;
    
    if (!self.model) {
        return;
    }
    [self.models removeAllObjects];
    [self.models addObject:self.model.bigGoodsList];
    [self.models addObject:self.model.sheetClothList];
    [self.models addObject:self.model.saleList];
    [self.tableView reloadData];
//    switch (selectIndex) {
//        case 0://本日
//        {
//            [self.models addObject:self.model.bigGoodsList];
//            [self.models addObject:self.model.saleList];
//            [self.models addObject:self.model.sheetClothList];
//        }
//            break;
//        case 1://本月
//        {
//            [self.models addObject:self.model.bigGoodsList];
//        }
//            break;
//        case 2://季度
//        {
//
//        }
//            break;
//        case 3://全年
//        {
//
//        }
//            break;
//        default:
//            break;
//    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    self.models = [NSMutableArray array];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.models.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LLHomeChildCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LLHomeChildCell"];
    cell.datas = self.models[indexPath.row];
    cell.indexPath = indexPath;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 260;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (!self.vcCanScroll) {
        scrollView.contentOffset = CGPointZero;
    }
    if (scrollView.contentOffset.y <= 0) {
        self.vcCanScroll = false;
        scrollView.contentOffset = CGPointZero;
        HomeViewController * parentVc = (HomeViewController *)self.parentViewController;
        parentVc.canScroll = true;
        //parentVc.cell.cellCanScroll = false;
    }
    
}

- (LLHomeBaseTableView *)tableView {
    if (!_tableView) {
        _tableView = [[LLHomeBaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        [_tableView registerClass:[LLHomeChildCell class] forCellReuseIdentifier:@"LLHomeChildCell"];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

@end
