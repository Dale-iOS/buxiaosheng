//
//  BackOrderViewController.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/5/7.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  退单页面

#import "BackOrderViewController.h"
#import "IQKeyboardManager.h"
#import "LZBackOrderCell.h"
#import "LZBackOrderGroup.h"
#import "LZBackOrderItem.h"
#import "LZSelectItemViewController.h"
#import "LZAddItemViewController.h"

@interface BackOrderViewController ()<UITableViewDataSource, UITableViewDelegate, LZBackOrderCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint;
@property (nonatomic,strong) NSMutableArray<LZBackOrderGroup *> *dataSource;
@property (nonatomic,strong) LZBackOrderGroup *sectionGroup;
@property (weak, nonatomic) IBOutlet UILabel *totalNumLb;
@property (weak, nonatomic) IBOutlet UILabel *totalCountLb;

@end

@implementation BackOrderViewController

#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.titleView = [Utility navTitleView:@"退单"];
    //拖动tableView回收键盘
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    if (@available(iOS 11.0, *)) {
        self.bottomConstraint.constant = self.view.safeAreaInsets.bottom;
    }
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
- (LZBackOrderGroup *)createSectionGroupItem {
    NSArray *sectionArr = @[@{@"textTitle":@"*品名",
                              @"detailTitle":@"",
                              @"placeHolder":@"选择品名",
                              @"detailColor":[UIColor blackColor],
                              @"clickType":@(1),
                              @"cellType":@(0),
                              @"canInput":@(NO),
                              @"showArrow":@(YES),
                              @"mandatoryOption":@(YES),
                              @"numericKeyboard":@(NO)
                              },
                            @{@"textTitle":@"*颜色",
                              @"detailTitle":@"",
                              @"placeHolder":@"选择颜色",
                              @"detailColor":[UIColor blackColor],
                              @"clickType":@(2),
                              @"cellType":@(0),
                              @"canInput":@(NO),
                              @"showArrow":@(YES),
                              @"mandatoryOption":@(YES),
                              @"numericKeyboard":@(NO)
                              },
                            @{@"textTitle":@"入库单位",
                              @"detailTitle":@" ",
                              @"placeHolder":@" ",
                              @"detailColor":[UIColor blackColor],
                              @"clickType":@(0),
                              @"cellType":@(0),
                              @"canInput":@(NO),
                              @"showArrow":@(NO),
                              @"mandatoryOption":@(NO),
                              @"numericKeyboard":@(NO)
                              },
                            @{@"textTitle":@"批号",
                              @"detailTitle":@"",
                              @"placeHolder":@"请输入批号",
                              @"detailColor":[UIColor blackColor],
                              @"clickType":@(0),
                              @"cellType":@(0),
                              @"canInput":@(YES),
                              @"showArrow":@(NO),
                              @"mandatoryOption":@(NO),
                              @"numericKeyboard":@(NO)
                              },
                            @{@"textTitle":@"货架",
                              @"detailTitle":@"",
                              @"placeHolder":@"请输入货架号",
                              @"detailColor":[UIColor blackColor],
                              @"clickType":@(0),
                              @"cellType":@(0),
                              @"canInput":@(YES),
                              @"showArrow":@(NO),
                              @"mandatoryOption":@(NO),
                              @"numericKeyboard":@(NO)
                              },
                            @{@"textTitle":@"*单价",
                              @"detailTitle":@"",
                              @"placeHolder":@"0",
                              @"detailColor":[UIColor blackColor],
                              @"clickType":@(0),
                              @"cellType":@(0),
                              @"canInput":@(YES),
                              @"showArrow":@(NO),
                              @"mandatoryOption":@(YES),
                              @"numericKeyboard":@(YES)
                              },
                            @{@"textTitle":@"入库数量",
                              @"detailTitle":@"0",
                              @"placeHolder":@"",
                              @"detailColor":[UIColor blackColor],
                              @"clickType":@(0),
                              @"cellType":@(0),
                              @"canInput":@(NO),
                              @"showArrow":@(NO),
                              @"mandatoryOption":@(NO),
                              @"numericKeyboard":@(NO)
                              },
                            @{@"textTitle":@"标签数量",
                              @"detailTitle":@"0",
                              @"placeHolder":@"",
                              @"detailColor":[UIColor blackColor],
                              @"clickType":@(0),
                              @"cellType":@(0),
                              @"canInput":@(NO),
                              @"showArrow":@(NO),
                              @"mandatoryOption":@(NO),
                              @"numericKeyboard":@(NO)
                              },
                            @{@"textTitle":@"结算数量",
                              @"detailTitle":@"0",
                              @"placeHolder":@"",
                              @"detailColor":[UIColor blackColor],
                              @"clickType":@(0),
                              @"cellType":@(0),
                              @"canInput":@(NO),
                              @"showArrow":@(NO),
                              @"mandatoryOption":@(NO),
                              @"numericKeyboard":@(NO)
                              },
                            @{@"textTitle":@"本单退款金额",
                              @"detailTitle":@"0",
                              @"placeHolder":@"",
                              @"detailColor":[UIColor redColor],
                              @"clickType":@(0),
                              @"cellType":@(0),
                              @"canInput":@(NO),
                              @"showArrow":@(NO),
                              @"mandatoryOption":@(NO),
                              @"numericKeyboard":@(NO)
                              },
                            @{@"textTitle":@"",
                              @"detailTitle":@"0",
                              @"placeHolder":@"",
                              @"detailColor":[UIColor redColor],
                              @"clickType":@(0),
                              @"cellType":@(1),
                              @"canInput":@(NO),
                              @"showArrow":@(NO),
                              @"mandatoryOption":@(NO),
                              @"numericKeyboard":@(NO)
                              }];
    LZBackOrderGroup *group = [LZBackOrderGroup groupWithFlod:NO items:sectionArr];
    return  group;
}

//计算底部总数量 总条数
- (void)calculateTotal {
    NSInteger total = 0;
    NSInteger count = 0;
    //应付金额 预收金额
    NSInteger totalNum = 0;
    for (int i = 1; i < self.dataSource.count - 1; i++) {
        LZBackOrderGroup *group = self.dataSource[i];
        NSInteger totalCount = group.items.count;
        LZBackOrderItem *item = group.items[totalCount - 2];
        totalNum += item.detailTitle.integerValue;
        for (NSString *itemStr in group.itemStrings) {
            total += itemStr.integerValue;
            count += 1;
        }
    }
    //应付金额
    LZBackOrderGroup *lastGroup = self.dataSource.lastObject;
    [lastGroup.items[1] setDetailTitle:[NSString stringWithFormat:@"%ld", totalNum]];
    if ([BXSTools isEmptyString:[lastGroup.items[2] detailTitle]]) {
        //预收付款
        [lastGroup.items[3] setDetailTitle:[NSString stringWithFormat:@"%ld", totalNum]];
    } else {
        NSInteger realPay = lastGroup.items[2].detailTitle.integerValue;
        [lastGroup.items[3] setDetailTitle:[NSString stringWithFormat:@"%ld", totalNum - realPay]];
    }
    
    _totalNumLb.text = [NSString stringWithFormat:@"总数量: %ld", total];
    _totalCountLb.text = [NSString stringWithFormat:@"总条数: %ld", count];
}

//计算分区的相关数据
- (void)caculateSectionDataWithGroup:(LZBackOrderGroup *)group indexPath:(NSIndexPath *)indexPath {
    NSInteger total = 0;
    for (NSString *string in group.itemStrings) {
        total += string.integerValue;
    }
    if (group.items.count > 11 && group.itemStrings.count > 0) {
        if (indexPath.row == 3) {
            LZBackOrderItem *item = group.items[indexPath.row];
            item.textTitle = [NSString stringWithFormat:@"细码 (总条数: %ld )", group.itemStrings.count];
        }
        
        NSInteger itemCount = group.items.count;
        //单价
        NSInteger price = [[group.items[itemCount - 6] detailTitle] integerValue];
        //入库数量
        group.items[itemCount - 5].detailTitle = [NSString stringWithFormat:@"%ld", total];
        //标签数量
        group.items[itemCount - 4].detailTitle = [NSString stringWithFormat:@"%ld", total];
        //结算数量
        group.items[itemCount - 3].detailTitle = [NSString stringWithFormat:@"%ld", total];
        //本单退款金额
        group.items[itemCount - 2].detailTitle = [NSString stringWithFormat:@"%ld", price * total];
    }
    [self calculateTotal];
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    LZBackOrderGroup *group = self.dataSource[section];
    if (group.fold) return 4;
    return group.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LZBackOrderGroup *group = self.dataSource[indexPath.section];
    LZBackOrderItem *item = group.items[indexPath.row];
    LZBackOrderCell *cell = [LZBackOrderCell cellWithTableView:tableView cellType:item.cellType];
    cell.group = group;
    cell.item = item;
    cell.indexPath = indexPath;
    cell.delegate = self;
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

#pragma mark - LZBackOrderCellDelegate
- (void)backOrderCell:(LZBackOrderCell *)backOrderCell btnClickType:(BtnClickType)type forIndexPath:(NSIndexPath *)indexPath {
    LZBackOrderGroup *group = self.dataSource[indexPath.section];
    switch (type) {
        case BtnClickTypeFold:
            {
                group.fold = !group.isFold;
                [group.items exchangeObjectAtIndex:3 withObjectAtIndex:(group.items.count - 1)];
                [self.tableView reloadDataWithInsertingDataAtTheBeginingOfSection:indexPath.section newDataCount:group.items.count];
            }
            break;
        case BtnClickTypeAddYard:
        {
            [self.dataSource enumerateObjectsUsingBlock:^(LZBackOrderGroup * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                obj.hiddenAddYard = YES;
            }];
            [self.dataSource insertObject:[self createSectionGroupItem] atIndex:(indexPath.section + 1)];
            [self.tableView reloadData];
        }
            break;
        case BtnClickTypeAddItem:
        {
            LZAddItemViewController *vc = [[LZAddItemViewController alloc] init];
            vc.selectItems = ^(NSArray *items) {
                for (NSString *string in items) {
                    [group.itemStrings addObject:string];
                }
                [self caculateSectionDataWithGroup:group indexPath:indexPath];
            };
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        default:
            break;
    }
}

- (void)backOrderCell:(LZBackOrderCell *)backOrderCell selectItemForIndexPath:(NSIndexPath *)indexPath {
    LZBackOrderGroup *group = self.dataSource[indexPath.section];
    LZBackOrderItem *item = group.items[indexPath.row];
    
    LZSelectItemViewController *vc = [[LZSelectItemViewController alloc] init];
    vc.type = (LZSelectItemVCSelectType)item.clickType;
    vc.title = item.placeHolder;
    __weak typeof(self) weakSelf = self;
    vc.selectItemBlock = ^(NSString *itemStr) {
        if (ClickTypeProduct == item.clickType && [BXSTools isEmptyString:item.detailTitle]) {
            
            LZBackOrderItem *threeItem = group.items[2];
            threeItem.detailTitle = @"公斤";
            
            NSDictionary *dic = @{@"textTitle":@"细码 (总条数: 0 )",
                                  @"detailTitle":@" ",
                                  @"placeHolder":@"",
                                  @"detailColor":[UIColor blackColor],
                                  @"clickType":@(0),
                                  @"cellType":@(2),
                                  @"canInput":@(NO),
                                  @"showArrow":@(NO),
                                  @"mandatoryOption":@(NO),
                                  @"numericKeyboard":@(NO)
                                  };
            LZBackOrderItem *tmpItem = [[LZBackOrderItem alloc] init];
            [tmpItem setValuesForKeysWithDictionary:dic];
            [group.items insertObject:tmpItem atIndex:3];
            
            if (group.isFold) {
                NSInteger rowCount = [weakSelf tableView:weakSelf.tableView numberOfRowsInSection:indexPath.section];
                [group.items exchangeObjectAtIndex:(group.items.count - 1) withObjectAtIndex:(rowCount - 1)];
                [group.items exchangeObjectAtIndex:3 withObjectAtIndex:rowCount];
            }
        }
        item.detailTitle = itemStr;
        NSInteger section = [weakSelf.dataSource indexOfObject:group];
        [weakSelf.tableView reloadDataWithInsertingDataAtTheBeginingOfSection:section newDataCount:group.items.count];
    };
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)backOrderCell:(LZBackOrderCell *)backOrderCell reloadForIndexPath:(NSIndexPath *)indexPath {
    LZBackOrderGroup *group = self.dataSource[indexPath.section];
    NSInteger count = group.items.count;
    //单价
    NSInteger price = [[group.items[count - 6] detailTitle] integerValue];
    //入库数量
    NSInteger storage = [[group.items[count - 5] detailTitle] integerValue];
    
    group.items[count - 2].detailTitle = [NSString stringWithFormat:@"%ld", price * storage];
    [self caculateSectionDataWithGroup:group indexPath:indexPath];
    [self.tableView reloadData];
//    [self.tableView reloadDataWithInsertingDataAtTheBeginingOfSection:indexPath.section newDataCount:group.items.count];
}

//修改细码
-(void)backOrderCell:(LZBackOrderCell *)backOrderCell modifyItemForIndexPath:(NSIndexPath *)indexPath index:(NSInteger)index {
    LZBackOrderGroup *group = self.dataSource[indexPath.section];
    LZAddItemViewController *vc = [[LZAddItemViewController alloc] init];
    vc.itemDetail = group.itemStrings[index];
    vc.modifyItem = YES;
    vc.selectItems = ^(NSArray *items) {
        [group.itemStrings replaceObjectAtIndex:index withObject:items.firstObject];
        [self caculateSectionDataWithGroup:group indexPath:indexPath];
    };
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Getter && Setter
- (NSMutableArray *)dataSource {
    if (_dataSource == nil) {
        _dataSource = @[].mutableCopy;
        NSArray *tempArr = @[
                             @[@{@"textTitle":@"*客户名字",
                                 @"detailTitle":@"",
                                 @"placeHolder":@"请输入客户名称",
                                 @"detailColor":[UIColor blackColor],
                                 @"clickType":@(0),
                                 @"cellType":@(0),
                                 @"canInput":@(YES),
                                 @"showArrow":@(NO),
                                 @"mandatoryOption":@(YES),
                                 @"numericKeyboard":@(NO)
                                 },
                               @{@"textTitle":@"客户电话",
                                 @"detailTitle":@" ",
                                 @"placeHolder":@"",
                                 @"detailColor":[UIColor blackColor],
                                 @"clickType":@(0),
                                 @"cellType":@(0),
                                 @"canInput":@(NO),
                                 @"showArrow":@(NO),
                                 @"mandatoryOption":@(NO),
                                 @"numericKeyboard":@(NO)
                                 }],
                             @[@{@"textTitle":@"*品名",
                                 @"detailTitle":@"",
                                 @"placeHolder":@"选择品名",
                                 @"detailColor":[UIColor blackColor],
                                 @"clickType":@(1),
                                 @"cellType":@(0),
                                 @"canInput":@(NO),
                                 @"showArrow":@(YES),
                                 @"mandatoryOption":@(YES),
                                 @"numericKeyboard":@(NO)
                                 },
                               @{@"textTitle":@"*颜色",
                                 @"detailTitle":@"",
                                 @"placeHolder":@"选择颜色",
                                 @"detailColor":[UIColor blackColor],
                                 @"clickType":@(2),
                                 @"cellType":@(0),
                                 @"canInput":@(NO),
                                 @"showArrow":@(YES),
                                 @"mandatoryOption":@(YES),
                                 @"numericKeyboard":@(NO)
                                 },
                               @{@"textTitle":@"入库单位",
                                 @"detailTitle":@" ",
                                 @"placeHolder":@" ",
                                 @"detailColor":[UIColor blackColor],
                                 @"clickType":@(0),
                                 @"cellType":@(0),
                                 @"canInput":@(NO),
                                 @"showArrow":@(NO),
                                 @"mandatoryOption":@(NO),
                                 @"numericKeyboard":@(NO)
                                 },
                               @{@"textTitle":@"批号",
                                 @"detailTitle":@"",
                                 @"placeHolder":@"请输入批号",
                                 @"detailColor":[UIColor blackColor],
                                 @"clickType":@(0),
                                 @"cellType":@(0),
                                 @"canInput":@(YES),
                                 @"showArrow":@(NO),
                                 @"mandatoryOption":@(NO),
                                 @"numericKeyboard":@(NO)
                                 },
                               @{@"textTitle":@"货架",
                                 @"detailTitle":@"",
                                 @"placeHolder":@"请输入货架号",
                                 @"detailColor":[UIColor blackColor],
                                 @"clickType":@(0),
                                 @"cellType":@(0),
                                 @"canInput":@(YES),
                                 @"showArrow":@(NO),
                                 @"mandatoryOption":@(NO),
                                 @"numericKeyboard":@(NO)
                                 },
                               @{@"textTitle":@"*单价",
                                 @"detailTitle":@"",
                                 @"placeHolder":@"0",
                                 @"detailColor":[UIColor blackColor],
                                 @"clickType":@(0),
                                 @"cellType":@(0),
                                 @"canInput":@(YES),
                                 @"showArrow":@(NO),
                                 @"mandatoryOption":@(YES),
                                 @"numericKeyboard":@(YES)
                                 },
                               @{@"textTitle":@"入库数量",
                                 @"detailTitle":@"0",
                                 @"placeHolder":@"",
                                 @"detailColor":[UIColor blackColor],
                                 @"clickType":@(0),
                                 @"cellType":@(0),
                                 @"canInput":@(NO),
                                 @"showArrow":@(NO),
                                 @"mandatoryOption":@(NO),
                                 @"numericKeyboard":@(NO)
                                 },
                               @{@"textTitle":@"标签数量",
                                 @"detailTitle":@"0",
                                 @"placeHolder":@"",
                                 @"detailColor":[UIColor blackColor],
                                 @"clickType":@(0),
                                 @"cellType":@(0),
                                 @"canInput":@(NO),
                                 @"showArrow":@(NO),
                                 @"mandatoryOption":@(NO),
                                 @"numericKeyboard":@(NO)
                                 },
                               @{@"textTitle":@"结算数量",
                                 @"detailTitle":@"0",
                                 @"placeHolder":@"",
                                 @"detailColor":[UIColor blackColor],
                                 @"clickType":@(0),
                                 @"cellType":@(0),
                                 @"canInput":@(NO),
                                 @"showArrow":@(NO),
                                 @"mandatoryOption":@(NO),
                                 @"numericKeyboard":@(NO)
                                 },
                               @{@"textTitle":@"本单退款金额",
                                 @"detailTitle":@"0",
                                 @"placeHolder":@"",
                                 @"detailColor":[UIColor redColor],
                                 @"clickType":@(0),
                                 @"cellType":@(0),
                                 @"canInput":@(NO),
                                 @"showArrow":@(NO),
                                 @"mandatoryOption":@(NO),
                                 @"numericKeyboard":@(NO)
                                 },
                               @{@"textTitle":@"",
                                 @"detailTitle":@"0",
                                 @"placeHolder":@"",
                                 @"detailColor":[UIColor redColor],
                                 @"clickType":@(0),
                                 @"cellType":@(1),
                                 @"canInput":@(NO),
                                 @"showArrow":@(NO),
                                 @"mandatoryOption":@(NO),
                                 @"numericKeyboard":@(NO)
                                 }],
                             @[@{@"textTitle":@"*入仓库",
                                 @"detailTitle":@"",
                                 @"placeHolder":@"请选择入仓库",
                                 @"detailColor":[UIColor blackColor],
                                 @"clickType":@(3),
                                 @"canInput":@(NO),
                                 @"showArrow":@(YES),
                                 @"mandatoryOption":@(YES),
                                 @"numericKeyboard":@(NO)
                                 },
                               @{@"textTitle":@"应付金额",
                                 @"detailTitle":@" ",
                                 @"placeHolder":@" ",
                                 @"detailColor":[UIColor blackColor],
                                 @"clickType":@(0),
                                 @"canInput":@(NO),
                                 @"showArrow":@(NO),
                                 @"mandatoryOption":@(NO),
                                 @"numericKeyboard":@(NO)
                                 },
                               @{@"textTitle":@"实付金额",
                                 @"detailTitle":@"",
                                 @"placeHolder":@"输入实付金额",
                                 @"detailColor":[UIColor blackColor],
                                 @"clickType":@(0),
                                 @"canInput":@(YES),
                                 @"showArrow":@(NO),
                                 @"mandatoryOption":@(NO),
                                 @"numericKeyboard":@(YES)
                                 },
                               @{@"textTitle":@"预收付款",
                                 @"detailTitle":@" ",
                                 @"placeHolder":@"",
                                 @"detailColor":[UIColor blackColor],
                                 @"clickType":@(0),
                                 @"canInput":@(NO),
                                 @"showArrow":@(NO),
                                 @"mandatoryOption":@(NO),
                                 @"numericKeyboard":@(NO)
                                 },
                               @{@"textTitle":@"付款方式",
                                 @"detailTitle":@"",
                                 @"placeHolder":@"请选择付款方式",
                                 @"detailColor":[UIColor blackColor],
                                 @"clickType":@(4),
                                 @"canInput":@(NO),
                                 @"showArrow":@(YES),
                                 @"mandatoryOption":@(NO),
                                 @"numericKeyboard":@(NO)
                                 },
                               @{@"textTitle":@"备注",
                                 @"detailTitle":@"",
                                 @"placeHolder":@"请输入备注内容",
                                 @"detailColor":[UIColor blackColor],
                                 @"clickType":@(0),
                                 @"canInput":@(YES),
                                 @"showArrow":@(NO),
                                 @"mandatoryOption":@(NO),
                                 @"numericKeyboard":@(NO)
                                 }]
                             ];
        for (NSArray *array in tempArr) {
            LZBackOrderGroup *group = [LZBackOrderGroup groupWithFlod:NO items:array];
            [_dataSource addObject:group];
        }
    }
    return _dataSource;
}

@end
