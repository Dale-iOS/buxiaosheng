//
//  LLHomeChidVC.m
//  BuXiaoSheng
//
//  Created by lanlan on 2018/8/7.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LLHomeChidVC.h"
#import "LLHomeChildCell.h"
@interface LLHomeChidVC ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic ,strong)UITableView * tableView;
@property(nonatomic ,strong)id currentModel;
@end

@implementation LLHomeChidVC

-(void)setSelectIndex:(NSInteger)selectIndex {
    _selectIndex = selectIndex;
    switch (selectIndex) {
        case 0://本日
        {
            
        }
            break;
        case 1://本月
        {
            
        }
            break;
        case 2://季度
        {
            
        }
            break;
        case 3://全年
        {
            
        }
            break;
        default:
            break;
    }
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LLHomeChildCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LLHomeChildCell"];
    cell.model = nil;
    cell.indexPath = indexPath;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 260;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        [_tableView registerClass:[LLHomeChildCell class] forCellReuseIdentifier:@"LLHomeChildCell"];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

@end
