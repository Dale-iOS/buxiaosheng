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
#import "LLProcessTitleCell.h"
#import "LLProcessTitleDetailCell.h"
#import "LLProcessCell.h"
@interface LLProcessChildVc ()<UITableViewDelegate,UITableViewDataSource,sectionViewDelegate>
@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) NSArray <NSDictionary *> * threeRowsInSectionData;

@property (nonatomic,strong) NSArray <NSDictionary *> * fourRowsInSectionData;

@property (nonatomic,strong) NSArray <NSDictionary *> * fiveRowsInSectionData;
@end

@implementation LLProcessChildVc
{
    BOOL _folding[2];
}
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
        make.left.right.top.equalTo(self.view);
        make.height.mas_equalTo(SCREEN_HEIGHT - LLNavViewHeight - 45-50);
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
    if (section == 0 || section == 1) {
        if (_folding[section]) {
             return 11;
        }
        return 0;
    }else  if(section == 2){
        return self.threeRowsInSectionData.count;
    }else if (section == 3) {
        return self.fourRowsInSectionData.count;
    }else {
        return self.fiveRowsInSectionData.count;
    }
 
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0 || section == 1) {
        LLProcessSectionView * sectionView  = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"LLProcessSectionView"];
        sectionView.section = section;
        sectionView.delegate = self;
        sectionView.foldingBtn.selected = _folding[section];
        return sectionView;
    }else {
        UITableViewHeaderFooterView * sectionView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"UITableViewHeaderFooterView"];
        if (!sectionView) {
            sectionView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:@"UITableViewHeaderFooterView"];
        }
        return sectionView;
    }
   
    return [UIView new];
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return  [UIView new];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0|| indexPath.section == 1) {
        if (indexPath.row == 0) {
            LLProcessTitleCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LLProcessTitleCell"];
            return cell;
        }
        LLProcessTitleDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LLProcessTitleDetailCell"];
        return cell;
    }else if (indexPath.section == 2) {
        LLProcessCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LLProcessCell"];
         cell.datas = self.threeRowsInSectionData;
        cell.indexPath = indexPath;
       
        return cell;
    }else if (indexPath.section == 3) {
        LLProcessCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LLProcessCell"];
        cell.datas = self.fourRowsInSectionData;
        cell.indexPath = indexPath;
        return cell;
    }else {
        LLProcessCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LLProcessCell"];
        cell.datas = self.fiveRowsInSectionData;
        cell.indexPath = indexPath;
        return cell;
    }
   
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0 || indexPath.section==1) {
        if (_folding[indexPath.section]) {
            return 44;
        }
        return 0;
    }
    return 44;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0|| section == 1) {
         return 54+20;
    }else {
        return 20;
    }
   
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001;
}

-(void)sectionViewDelegate:(LLProcessSectionView *)sectionView {
    _folding[sectionView.section] = ! _folding[sectionView.section];
    [UIView animateWithDuration:0.0 animations:^{
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:sectionView.section] withRowAnimation:UITableViewRowAnimationNone];
    }];
}


-(UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        [_tableView registerClass:[LLProcessSectionView class] forHeaderFooterViewReuseIdentifier:@"LLProcessSectionView"];
        [self.view addSubview:_tableView];
        [_tableView registerClass:[LLProcessTitleCell class] forCellReuseIdentifier:@"LLProcessTitleCell"];
        [_tableView registerClass:[LLProcessTitleDetailCell class] forCellReuseIdentifier:@"LLProcessTitleDetailCell"];
        [_tableView registerClass:[LLProcessCell class] forCellReuseIdentifier:@"LLProcessCell"];
    }
    return _tableView;
}

-(NSArray<NSDictionary *> *)threeRowsInSectionData {
    if (!_threeRowsInSectionData) {
        ///注: 所表type 0 代表文字黑   1 代表文字灰色 2 代表文字红色
        _threeRowsInSectionData = @[
                                    @{@"key":@"厂商信息",@"type":@"1",@"value":@""},
                                    @{@"key":@"联系人",@"type":@"0",@"value":@"万事达"},
                                    @{@"key":@"电话",@"type":@"0",@"value":@""},
                                    @{@"key":@"地址",@"type":@"1",@"value":@""},
                                    ];
    }
    return _threeRowsInSectionData;
}

-(NSArray<NSDictionary *> *)fourRowsInSectionData {
    if (!_fourRowsInSectionData) {
        ///注: 所表type 0 代表文字黑   1 代表文字灰色 2 代表文字红色
        _fourRowsInSectionData = @[
                                    @{@"key":@"指派人",@"type":@"1",@"value":@"请选择指派人"},
                                    ];
    }
    return _fourRowsInSectionData;
}

-(NSArray<NSDictionary *> *)fiveRowsInSectionData {
    if (!_fiveRowsInSectionData) {
        ///注: 所表type 0 代表文字黑   1 代表文字灰色 2 代表文字红色
        _fiveRowsInSectionData = @[
                                   @{@"key":@"备注",@"type":@"1",@"value":@""},
                                   ];
    }
    return _fiveRowsInSectionData;
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
