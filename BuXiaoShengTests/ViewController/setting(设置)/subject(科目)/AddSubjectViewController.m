//
//  AddSubjectViewController.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/5/3.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  添加科目页面

#import "AddSubjectViewController.h"
#import "LZHTableView.h"
#import "TextInputCell.h"

@interface AddSubjectViewController ()<LZHTableViewDelegate>
@property (weak, nonatomic) LZHTableView *mainTabelView;
@property (strong, nonatomic) NSMutableArray *datasource;

///科目名称
@property (nonatomic, strong) TextInputCell *titleCell;
///所属分组
@property (nonatomic, strong) TextInputCell *groupCell;
///状态
@property (nonatomic, strong) TextInputCell *stateCell;
@end

@implementation AddSubjectViewController
@synthesize mainTabelView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (LZHTableView *)mainTabelView
{
    if (!mainTabelView) {
        
        LZHTableView *tableView = [[LZHTableView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, APPHeight)];
        //        tableView.tableView.allowsSelection = YES;
        //        tableView.tableHeaderView = self.headView;
        tableView.backgroundColor = LZHBackgroundColor;
        tableView.delegate = self;
        [self.view addSubview:(mainTabelView = tableView)];
    }
    return mainTabelView;
}

- (void)setupUI
{
    self.navigationItem.titleView = [Utility navTitleView:@"添加科目"];
    
    UIButton *navRightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    navRightBtn.titleLabel.font = FONT(15);
    [navRightBtn setTitle:@"确认" forState:UIControlStateNormal];
    [navRightBtn setTitleColor:[UIColor colorWithHexString:@"#3d9bfa"] forState:UIControlStateNormal];
    [navRightBtn addTarget:self action:@selector(selectornavRightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:navRightBtn];
    
    self.datasource = [NSMutableArray array];
    
    [self.view addSubview:self.mainTabelView];
    self.mainTabelView.delegate = self;
    [self setupSectionOne];
    self.mainTabelView.dataSoure = self.datasource;
}

- (void)setupSectionOne
{
    self.titleCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    self.titleCell.titleLabel.text = @"科目名称";
    self.titleCell.contentTF.placeholder = @"请输入科目名称";
    
    self.groupCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    self.groupCell.rightArrowImageVIew.hidden = NO;
    self.groupCell.titleLabel.text = @"所属分组";
    self.groupCell.contentTF.placeholder = @"请选择所属分组";
    self.groupCell.contentTF.enabled = false;
    
    self.stateCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    self.stateCell.rightArrowImageVIew.hidden = NO;
    self.stateCell.titleLabel.text = @"状态";
    self.stateCell.contentTF.enabled = NO;
    self.stateCell.contentTF.placeholder = @"请选择状态";
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 10)];
    headerView.backgroundColor = LZHBackgroundColor;
    
    LZHTableViewItem *item = [[LZHTableViewItem alloc]init];
    item.sectionRows = @[self.titleCell,self.groupCell,self.stateCell];
    item.canSelected = NO;
    item.sectionView = headerView;
    [self.datasource addObject:item];
}

-(void)LzhTableView:(LZHTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0 ) {
        return;
    }
    WEAKSELF;
    
    if (indexPath.row == 1) {
        
        UIAlertController * alterVc = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请选择该科目所属分组" preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction * manager = [UIAlertAction actionWithTitle:@"管理费用" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            weakSelf.groupCell.contentTF.text = @"管理费用";
        }];
        
        UIAlertAction * sell = [UIAlertAction actionWithTitle:@"销售费用" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            weakSelf.groupCell.contentTF.text = @"销售费用";
        }];
        
        UIAlertAction * finance = [UIAlertAction actionWithTitle:@"财务费用" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            weakSelf.groupCell.contentTF.text = @"财务费用";
        }];
        
        UIAlertAction * other = [UIAlertAction actionWithTitle:@"其他费用" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            weakSelf.groupCell.contentTF.text = @"其他费用";
        }];
        UIAlertAction * cacanle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alterVc addAction:manager];
        [alterVc addAction:sell];
        [alterVc addAction:finance];
        [alterVc addAction:other];
        [alterVc addAction:cacanle];
        [self.navigationController presentViewController:alterVc animated:true completion:nil];
    }
    
    if (indexPath.row == 2) {
        UIAlertController * alterVc = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请选用该科目启动状态" preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction * enabled = [UIAlertAction actionWithTitle:@"启用" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            weakSelf.stateCell.contentTF.text = @"启用";
        }];
        
        UIAlertAction * disEnabled = [UIAlertAction actionWithTitle:@"未启用" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            weakSelf.stateCell.contentTF.text = @"未启用";
        }];
        UIAlertAction * cacanle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alterVc addAction:enabled];
        [alterVc addAction:disEnabled];
        [alterVc addAction:cacanle];
        [self.navigationController presentViewController:alterVc animated:true completion:nil];
    }
    
    
}

- (void)selectornavRightBtnClick
{
    NSLog(@"selectornavRightBtnClick");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
