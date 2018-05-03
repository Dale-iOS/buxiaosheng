//
//  DyeingViewController.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/4/27.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  织造染色页面

#import "DyeingViewController.h"
#import "LLDyeingSectionView.h"
#import "LLDyeingCell.h"
#import "LLDyeingCollectionContainerCell.h"
@interface DyeingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView * tableView;

@property (nonatomic,strong) NSArray <NSDictionary*> * fristRowsInSectionData;
@end

@implementation DyeingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.titleView = [Utility navTitleView:@"织造染色"];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.fristRowsInSectionData.count+1;
    }
    return self.fristRowsInSectionData.count+1;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    LLDyeingSectionView * sectionView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"LLDyeingSectionView"];
    return sectionView;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            LLDyeingCollectionContainerCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LLDyeingCollectionContainerCell"];
            return cell;
        }
        LLDyeingCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LLDyeingCell"];
        cell.datas = self.fristRowsInSectionData;
        cell.indexPath = indexPath;
        return cell;
    }
    return [UITableViewCell new];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 200;
        }
         return 44;
    }
    return 44;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 75;
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
        [self.view addSubview:_tableView];
        [_tableView registerClass:[LLDyeingSectionView class] forHeaderFooterViewReuseIdentifier:@"LLDyeingSectionView"];
        [_tableView registerClass:[LLDyeingCell class] forCellReuseIdentifier:@"LLDyeingCell"];
        [_tableView registerClass:[LLDyeingCollectionContainerCell class] forCellReuseIdentifier:@"LLDyeingCollectionContainerCell"];
    }
    return _tableView;
}

-(NSArray *)fristRowsInSectionData {
    if (!_fristRowsInSectionData) {
        ///注: 所表type 0 代表文字黑   1 代表文字灰色 2 代表文字红色
        _fristRowsInSectionData = @[
                                    @{@"key":@"结算单位",@"type":@"0",@"value":@""},
                                    @{@"key":@"批号",@"type":@"0",@"value":@""},
                                    @{@"key":@"货架",@"type":@"0",@"value":@""},
                                    @{@"key":@"单价",@"type":@"0",@"value":@"10"},
                                    @{@"key":@"出库数量",@"type":@"1",@"value":@"2800"},
                                    @{@"key":@"标签数量",@"type":@"0",@"value":@"2900"},
                                    @{@"key":@"结算数量",@"type":@"0",@"value":@"3000"},
                                    @{@"key":@"本单应收金额",@"type":@"2",@"value":@"25689.00"},
                                    ];
    }
    return _fristRowsInSectionData;
}



@end
