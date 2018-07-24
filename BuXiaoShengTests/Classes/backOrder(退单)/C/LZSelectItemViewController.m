//
//  LZSelectItemViewController.m
//  BuXiaoSheng
//
//  Created by Dale on 2018/7/22.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LZSelectItemViewController.h"
#import "UIBarButtonItem+CJExtension.h"

@interface LZSelectItemViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSArray<NSMutableDictionary *> *dataSource;

@end

static NSString *cellId = @"UITableViewCell";

@implementation LZSelectItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupNavigationItem];
    [self removeExtraCellLine];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellId];
}

- (void)dealloc {
    NSLog(@"%s",__func__);
}

#pragma mark - Private Methods
//设置导航条内容
- (void)setupNavigationItem {
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTitle:@"确定" norColor:RGB(0, 99, 251) targer:self action:@selector(handleSureBtnAction)];
}

//移除多余cell的分割线
- (void)removeExtraCellLine {
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    view.opaque = NO;
    [self.tableView setTableFooterView:view];
}

#pragma mark - Events
- (void)handleSureBtnAction {
    //1.检查是否选中其中一项
    __block BOOL isSelect;
    __block NSMutableDictionary *mDic = nil;
    [self.dataSource enumerateObjectsUsingBlock:^(NSMutableDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj[@"isSelect"] boolValue]) {
            isSelect = YES;
            mDic = obj;
        };
    }];
    if (NO == isSelect) {
        [LLHudTools showWithMessage:@"请选择一项"];
        return;
    }
    if (nil == mDic) {
        [self.dataSource enumerateObjectsUsingBlock:^(NSMutableDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj[@"isSelect"] boolValue]) {
                mDic = obj;
            };
        }];
    }
    //2.把选中的一项传到上一界面
    if (_selectItemBlock) {
        _selectItemBlock(mDic[@"text"]);
    }
    //3.返回
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    NSMutableDictionary *dic = self.dataSource[indexPath.row];
    UITableViewCellAccessoryType type = [dic[@"isSelect"] boolValue] ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    cell.accessoryType = type;
    cell.textLabel.text = dic[@"text"];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //1.数据全部置为未选中
    [self.dataSource enumerateObjectsUsingBlock:^(NSMutableDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj[@"isSelect"] = @(NO);
    }];
    //2.改变选中cell的数据
    NSMutableDictionary *dic = self.dataSource[indexPath.row];
    NSMutableDictionary *tmpDic = [[dic copy] mutableCopy];
    tmpDic[@"isSelect"] = @(YES);
    [dic setDictionary:tmpDic];
    //3.刷新表格
    [tableView reloadData];
}

#pragma mark - Getter && Setter
- (NSArray *)dataSource {
    if (_dataSource == nil) {
#warning to do ...此处为假数据,应从接口获取
        NSArray *datas = @[];
        if (LZSelectItemVCSelectProduct == _type) {
            datas = @[@"品名1", @"品名2", @"品名3", @"品名4", @"品名5"];
        } else if (LZSelectItemVCSelectColor == _type) {
            datas = @[@"颜色1", @"颜色2", @"颜色3", @"颜色4", @"颜色5"];
        } else if (LZSelectItemVCSelectWarehouse == _type) {
            datas = @[@"入仓1", @"入仓2", @"入仓3", @"入仓4", @"入仓5"];
        } else if (LZSelectItemVCSelectPayMentWay == _type) {
            datas = @[@"方式1", @"方式2", @"方式3", @"方式4", @"方式5"];
        }
        
        NSMutableArray *tempArr = @[].mutableCopy;
        [datas enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSMutableDictionary *mDic = @{@"text":obj,
                                  @"isSelect":@(NO)
                                  }.mutableCopy;
            [tempArr addObject:mDic];
        }];
        _dataSource = tempArr;
    }
    return _dataSource;
}


@end
