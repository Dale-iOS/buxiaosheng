//
//  RecipeViewController.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/5/5.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  配方表页面

#import "RecipeViewController.h"
#import "AddRecipeViewController.h"
#import "AddDyeRecipeViewController.h"

@interface RecipeViewController ()<UITableViewDelegate,UITableViewDataSource>

///分段选择器背景
@property (nonatomic, strong) UIView *SegmentedBgView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UISegmentedControl *SegmentedControl;

@end

@implementation RecipeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];
}

- (void)setupUI
{
    self.navigationItem.titleView = [Utility navTitleView:@"配方表"];
    
    self.navigationItem.rightBarButtonItem = [Utility navButton:self action:@selector(navigationAddClick) image:IMAGE(@"add1")];
    
    self.SegmentedBgView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, APPWidth, 40)];
    self.SegmentedBgView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.SegmentedBgView];
    
    self.SegmentedControl = [[UISegmentedControl alloc]initWithItems:@[@"织布",@"染色"]];
    self.SegmentedControl.selectedSegmentIndex = 0;
    self.SegmentedControl.tintColor = [UIColor colorWithRed:61.0f/255.0f green:155.0f/255.0f blue:250.0f/255.0f alpha:1.0f];
    [self.SegmentedControl addTarget:self action:@selector(segClick:) forControlEvents:UIControlEventValueChanged];
    [self.SegmentedBgView addSubview:self.SegmentedControl];
    
    self.SegmentedControl.sd_layout
    .centerYEqualToView(self.SegmentedBgView)
    .centerXEqualToView(self.SegmentedBgView)
    .widthIs(180)
    .heightIs(30);
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.SegmentedBgView.bottom, APPWidth, APPHeight) style:UITableViewStylePlain];
    self.tableView.backgroundColor = LZHBackgroundColor;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    
    [self.view addSubview:_tableView];
}

#pragma mark ----- tableviewdelegate -----
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"Cellid";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.textLabel.text = [NSString stringWithFormat:@"蛋炒饭 %ld",(long)indexPath.row];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }
    return cell;
}

//点击cell触发此方法
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //获取cell
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSLog(@"cell.textLabel.text = %@",cell.textLabel.text);
    
}

#pragma mark ------- 点击事件 --------
- (void)navigationAddClick
{
    if (self.SegmentedControl.selectedSegmentIndex == 0) {
        AddRecipeViewController *vc = [[AddRecipeViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (self.SegmentedControl.selectedSegmentIndex == 1)
    {
        AddDyeRecipeViewController *vc = [[AddDyeRecipeViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
}

- (void)segClick:(UISegmentedControl *)sgc
{
//    LZHTableViewItem *item = [[LZHTableViewItem alloc]init];
//    item.canSelected = NO;
//    item.sectionView = self.headerView1;
//
//    if (sgc.selectedSegmentIndex == 0) {
//
//        //        LZHTableViewItem *item = [[LZHTableViewItem alloc]init];
//        item.sectionRows = @[self.titileCell,self.collectionCell,self.arrearsCell,self.headerView2,self.remarkTextView];
//        [self.datasource replaceObjectAtIndex:0 withObject:item];
//        [self.mainTabelView reloadData];
//
//    }else if (sgc.selectedSegmentIndex == 1)
//    {
//        //        LZHTableViewItem *item = [[LZHTableViewItem alloc]init];
//        item.sectionRows = @[self.titileCell,self.collectionCell,self.arrearsCell,self.accountCell,self.headerView2,self.remarkTextView];
//        [self.datasource replaceObjectAtIndex:0 withObject:item];
//        [self.mainTabelView reloadData];
//        //        NSLog(@"213143");
//    }
    
    //    switch (sgc.selectedSegmentIndex) {
    //        case 0:
    //            NSLog(@"00000");
    //
    //            LZHTableViewItem *item = [[LZHTableViewItem alloc]init];
    //            item.sectionRows = @[self.titileCell,self.collectionCell,self.arrearsCell,self.accountCell,self.headerView2,self.remarkTextView];
    //            [self.datasource replaceObjectAtIndex:0 withObject:item];
    //            [self.mainTabelView reloadData];
    //
    //            break;
    //        case 1:
    //
    //            NSLog(@"111111");
    //
    //            LZHTableViewItem *item = [[LZHTableViewItem alloc]init];
    //            item.sectionRows = @[self.titileCell,self.collectionCell,self.arrearsCell,self.remarkTextView];
    //            [self.datasource replaceObjectAtIndex:0 withObject:item];
    //            [self.mainTabelView reloadData];
    //
    //            break;
    
    //        default:
    //            break;
    //    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}



@end
