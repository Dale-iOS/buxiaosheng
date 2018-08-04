//
//  LZAddItemViewController.m
//  BuXiaoSheng
//
//  Created by Dale on 2018/7/22.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  添加细码页面

#import "LZAddItemViewController.h"
#import "UIBarButtonItem+CJExtension.h"
#import "IQKeyboardManager.h"
#import "LZBackOrderCell.h"
#import "LZBackOrderGroup.h"
#import "LZBackOrderItem.h"
#import "NSObject+YYModel.h"

@interface LZAddItemViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSMutableArray<LZBackOrderGroup *> *dataSource;

@end

@implementation LZAddItemViewController

#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupNavigationItem];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [IQKeyboardManager sharedManager].shouldShowToolbarPlaceholder = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [IQKeyboardManager sharedManager].shouldShowToolbarPlaceholder = YES;
}

- (void)dealloc {
    NSLog(@"%s",__func__);
}
                                     
#pragma mark - Private Methods
  //设置导航条内容
- (void)setupNavigationItem {
    self.navigationItem.titleView = [Utility navTitleView:@"添加细码"];
    self.navigationItem.rightBarButtonItem = [Utility navButton:self action:@selector(handleSureBtnAction) title:@"确定"];
}

- (void)handleSureBtnAction {
    [self.view endEditing:YES];
    LZBackOrderGroup *group = self.dataSource.firstObject;
    NSMutableArray *items = @[].mutableCopy;
    [group.items enumerateObjectsUsingBlock:^(LZBackOrderItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (![BXSTools isEmptyString:obj.detailTitle]) {
            [items addObject:obj.detailTitle];
        }
    }];
    if (items.count) {
        if (_selectItems) {
            _selectItems(items);
        }
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    LZBackOrderGroup *group = self.dataSource[section];
    return group.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LZBackOrderGroup *group = self.dataSource[indexPath.section];
    LZBackOrderItem *item = group.items[indexPath.row];
    LZBackOrderCell *cell = [LZBackOrderCell cellWithTableView:tableView cellType:item.cellType];
    cell.inputCell = YES;
    cell.group = group;
    cell.item = item;
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView sd_clearSubviewsAutoLayoutFrameCaches];
    return [tableView cellHeightForIndexPath:indexPath cellContentViewWidth:SCREEN_WIDTH tableView:tableView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 15;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = RGBColor(223, 224, 231);
    return view;
}

#pragma mark - Getter && Setter
- (NSMutableArray *)dataSource {
    if (_dataSource == nil) {
        _dataSource = @[].mutableCopy;
        NSMutableArray *dicArray = @[].mutableCopy;
        NSMutableArray *sectionArray = @[].mutableCopy;
        int count = 11;
        if (self.isModifyItem) {
            count = 2;
        }
        
        for (int i = 1; i < count; i++) {
            NSString *textTitle = [NSString stringWithFormat:@"细码%d", i];
            NSString *detailTitle = @"";
            if (self.isModifyItem) {
                textTitle = [textTitle substringToIndex:2];
                detailTitle = self.itemDetail;
            }
            NSDictionary *dic = @{@"textTitle":textTitle,
                                  @"detailTitle":detailTitle,
                                  @"placeHolder":@"请输入细码",
                                  @"detailColor":@"0",
                                  @"clickType":@(0),
                                  @"cellType":@(0),
                                  @"canInput":@(YES),
                                  @"showArrow":@(NO),
                                  @"mandatoryOption":@(NO),
                                  @"numericKeyboard":@(YES)
                                  };
            [sectionArray addObject:dic];
        }
        [dicArray addObject:sectionArray];
        
        NSDictionary *groupDict = @{@"fold":@(NO),
                                    @"hiddenAddYard":@"",
                                    @"itemStrings":@[],
                                    @"storageType":@"",
                                    @"items":dicArray.firstObject};
        
        LZBackOrderGroup *group = [LZBackOrderGroup modelWithDictionary:groupDict];
        [_dataSource addObject:group];
    }
    return _dataSource;
}

@end
