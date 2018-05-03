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
@interface DyeingViewController ()<UITableViewDelegate,UITableViewDataSource,sectionViewDelegate>
@property (nonatomic,strong) UITableView * tableView;

@property (nonatomic,strong) NSArray <NSDictionary*> * fristRowsInSectionData;
@property (nonatomic,strong) NSArray <NSDictionary*> * secondRowsInSectionData;

@property (nonatomic,strong) NSArray <NSDictionary*> * threeRowsInSectionData;

@property (nonatomic,strong) NSArray <NSDictionary*> * fourRowsInSectionData;

@property (nonatomic,strong) UILabel * totalNumberLable;
@property (nonatomic,strong) UILabel * totalCountLable;


@end

@implementation DyeingViewController
{
    BOOL _folding[2];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.titleView = [Utility navTitleView:@"织造染色"];
    UIView * bottomView = [self setupBottomView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(64);
        make.bottom.equalTo(bottomView.mas_top);
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(UIView *)setupBottomView {
    UIView * bottomView = [UIView new];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(50);
    }];
    self.totalNumberLable = [UILabel new];
    [bottomView addSubview:self.totalNumberLable];
    self.totalNumberLable.text = @"总数量: 8487484949";
    self.totalNumberLable.textColor = [UIColor colorWithHexString:@"#333333"];
    self.totalNumberLable.font = [UIFont systemFontOfSize:14];
    [self.totalNumberLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomView).offset(15);
        make.top.equalTo(bottomView).offset(10);
    }];
    
    self.totalCountLable = [UILabel new];
    [bottomView addSubview:self.totalCountLable];
    self.totalCountLable.text = @"总条数: 8487484949";
    self.totalCountLable.textColor = [UIColor colorWithHexString:@"#333333"];
    self.totalCountLable.font = [UIFont systemFontOfSize:14];
    [self.totalCountLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomView).offset(15);
        make.top.equalTo(self.totalNumberLable.mas_bottom).offset(2);
    }];
    
    UIButton * determineBtn = [UIButton new];
    [determineBtn setTitle:@"确  定" forState:UIControlStateNormal];
    determineBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [determineBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [determineBtn setBackgroundColor:[UIColor colorWithHexString:@"#3d9bfa"]];
    [bottomView addSubview:determineBtn];
    [determineBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(bottomView);
        make.width.mas_equalTo(100);
    }];
    return bottomView;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        if (_folding[section] == true) {
            return self.fristRowsInSectionData.count+1;
        }
        return 0;
    }else if (section == 1) {
        if (_folding[section] == true) {
            return self.secondRowsInSectionData.count+1;
        }
        return 0;
    }else if (section == 2) {
        return self.threeRowsInSectionData.count;
    }else if (section == 3) {
        return self.fourRowsInSectionData.count;
    }
    return 0;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0||section == 1) {
        LLDyeingSectionView * sectionView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"LLDyeingSectionView"];
        sectionView.section = section;
        sectionView.delegate = self;
        return sectionView;
    }
    UIView * sectionView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"sectionView"];
    if (!sectionView) {
        sectionView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:@"sectionView"];
    }
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
    }else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            LLDyeingCollectionContainerCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LLDyeingCollectionContainerCell"];
            return cell;
        }
        LLDyeingCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LLDyeingCell"];
        cell.datas = self.secondRowsInSectionData;
        cell.indexPath = indexPath;
        return cell;
    }else if (indexPath.section == 2) {
        LLDyeingCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LLDyeingCell"];
        cell.datas = self.threeRowsInSectionData;
        cell.indexPath = indexPath;
        return cell;
    }else if (indexPath.section == 3) {
        LLDyeingCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LLDyeingCell"];
        cell.datas = self.fourRowsInSectionData;
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
    }else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            return 200;
        }
        return 44;
    }
    return 44;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0)  {
        
         return 75+20;
       
    }else if (section == 1) {
        return 75+20;
    }
    return 20;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001;
}

-(void)sectionViewDelegate:(LLDyeingSectionView *)sectionView {
    _folding[sectionView.section] = ! _folding[sectionView.section];
    sectionView.foldingBtn.selected  =  _folding[sectionView.section];
    [UIView animateWithDuration:0.0 animations:^{
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:sectionView.section] withRowAnimation:UITableViewRowAnimationNone];
    }];
    
    
}



 /// MARK: ---- 懒加载
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

-(NSArray<NSDictionary *> *)secondRowsInSectionData {
    if (!_secondRowsInSectionData) {
        _secondRowsInSectionData = @[
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
    return _secondRowsInSectionData;
}

-(NSArray<NSDictionary *> *)threeRowsInSectionData {
    if (!_threeRowsInSectionData) {
        _threeRowsInSectionData = @[
                                     @{@"key":@"应付金额",@"type":@"1",@"value":@""},
                                     @{@"key":@"实付金额",@"type":@"0",@"value":@"500.00"},
                                     @{@"key":@"本次欠款",@"type":@"0",@"value":@"200.00"},
                                     @{@"key":@"收款方式",@"type":@"1",@"value":@"选择收款方式"},
                                     @{@"key":@"备注",@"type":@"1",@"value":@""},
                                     ];
    }
    return _threeRowsInSectionData;
}

-(NSArray<NSDictionary *> *)fourRowsInSectionData {
    if (!_fourRowsInSectionData) {
        _fourRowsInSectionData = @[
                                   @{@"key":@"供应商单号",@"type":@"1",@"value":@""},
                                   @{@"key":@"供应商名称",@"type":@"0",@"value":@""},
                                   @{@"key":@"联系人",@"type":@"0",@"value":@"万事达"},
                                   @{@"key":@"电话",@"type":@"0",@"value":@""},
                                   @{@"key":@"地址",@"type":@"1",@"value":@""},
                                   ];
    }
    return _fourRowsInSectionData;
}



@end
