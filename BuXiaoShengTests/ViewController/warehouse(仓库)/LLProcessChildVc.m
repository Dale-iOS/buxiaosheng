//
//  LLProcessChildVc.m
//  BuXiaoSheng
//
//  Created by 周尊贤 on 2018/5/4.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LLProcessChildVc.h"
#import "ProcessViewController.h"
#import "LLProcessSectionView.h"
@interface LLProcessChildVc ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView * tableView;
@end

@implementation LLProcessChildVc

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    ProcessViewController * parentVc = (ProcessViewController*)self.parentViewController;
//    if ([self.title isEqualToString:parentVc.segmentedTitles.firstObject]) {
//        self.view.backgroundColor = [UIColor redColor];
//    }else {
//        self.view.backgroundColor = [UIColor orangeColor];
//    }
    
    // Do any additional setup after loading the view.
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 100;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0 || section == 1) {
        LLProcessSectionView * sectionView  = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"LLProcessSectionView"];
        return sectionView;
    }
   
    return [UIView new];
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return  [UIView new];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    cell.textLabel.text = self.title;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 54+20;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001;
}


-(UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        [_tableView registerClass:[LLProcessSectionView class] forHeaderFooterViewReuseIdentifier:@"LLProcessSectionView"];
        [self.view addSubview:_tableView];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    }
    return _tableView;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
