//
//  LZFineCodeVC.m
//  BuXiaoShengTests
//
//  Created by 家朋 on 2018/6/24.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
// 添加／修改细码的页面

#import "LZFineCodeVC.h"
#import "LZFineCodeCell.h"

@interface LZFineCodeVC ()<UITableViewDelegate,UITableViewDataSource>
/// 是否是修改细码 默认非
@property (assign,nonatomic) BOOL isChangeFindCode;
@end

@implementation LZFineCodeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
 
}

- (void)setup {
    //item
    self.navigationItem.titleView = [Utility navTitleView:@"添加细码"];
    self.navigationItem.rightBarButtonItem = [Utility navButton:self action:@selector(clickTrue) title:@"确认"]; ;
    
    
    [self.mainTable registerClass:[LZFineCodeCell class] forCellReuseIdentifier:[LZFineCodeCell cellID]];
    self.mainTable.delegate = self;
    self.mainTable.dataSource = self;
    
    if (!self.isChangeFindCode) {
        //data
        NSMutableArray *array1 = [NSMutableArray array];
        for (int i=0; i<4; i++) {
            NSString *title = [NSString stringWithFormat:@"细码%d",i+1];
            LZFindCodeModel *model = [LZFindCodeModel initModelTitle:title code:@""];
            [array1 addObject:model];
        }
        
        NSMutableArray *array2 = [NSMutableArray array];
        for (int i=4; i<8; i++) {
            NSString *title = [NSString stringWithFormat:@"细码%d",i+1];
            LZFindCodeModel *model = [LZFindCodeModel initModelTitle:title code:@""];
            [array2 addObject:model];
        }
        
        [self.dataSource addObject:array1];
        [self.dataSource addObject:array2];
    }

    [self.mainTable reloadData];
}

- (void)changeCodeLeftTitle:(NSString *)title rightCode:(NSString *)code {
    
    self.isChangeFindCode = YES;
    LZFindCodeModel *model = [LZFindCodeModel initModelTitle:title code:code];
    NSArray *codeArr = @[model];
    [self.dataSource addObject:codeArr];
}

- (void)changeCodeWithModel:(LZFindCodeModel *)model {
    self.isChangeFindCode = YES;
    NSArray *codeArr = @[model];
    [self.dataSource addObject:codeArr];
    [self.mainTable reloadData];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - click
- (void)clickTrue {
    
    [self.view endEditing:YES];
    
    if (self.isChangeFindCode) {
        LZFindCodeModel *model = self.dataSource[0][0];
        !_changeCodeBlock?:_changeCodeBlock(model);
    }else{
        NSMutableArray *array = [NSMutableArray array];
        [array addObjectsFromArray:self.dataSource[0]];
        [array addObjectsFromArray:self.dataSource[1]];
        
        !_addCodeBlock?:_addCodeBlock([array mutableCopy]);
    }

    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
     return self.dataSource.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *arr = self.dataSource[section];
    return arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LZFineCodeCell *cell = [tableView dequeueReusableCellWithIdentifier:[LZFineCodeCell cellID]];
    
    NSArray *arr = self.dataSource[indexPath.section];
    LZFindCodeModel *model = arr[indexPath.row];
    if (_isChangeFindCode) {
        model.title = @"细码";
    }
    cell.model = model;
  
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10.f;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    view.backgroundColor = LZHBackgroundColor;
    return view;
    
}



@end
