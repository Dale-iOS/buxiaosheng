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
#import "LZPickerView.h"
#import "LZSearchVC.h"
#import "LZChooseProductsVC.h"
#import "LZChangeNumVC.h"
#import "LZBackOrderListsVC.h"
#import "ZWCustomPopView.h"

@interface BackOrderViewController ()<UITableViewDataSource, UITableViewDelegate, LZBackOrderCellDelegate, ZWCustomPopViewDelegate>
{
    NSString *_productId;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint;
@property (weak, nonatomic) IBOutlet UILabel *totalNumLb;
@property (weak, nonatomic) IBOutlet UILabel *totalCountLb;
@property (weak, nonatomic) ZWCustomPopView *popView;
@property (nonatomic,strong) NSMutableArray<LZBackOrderGroup *> *dataSource;
@property (nonatomic,strong) LZBackOrderGroup *sectionGroup;
//存放客户姓名
@property (nonatomic,strong) NSArray *nameArray;
//存放模糊匹配的客户姓名
@property (nonatomic,strong) NSArray *tempNameArray;
//客户数组
@property(nonatomic,strong)NSMutableArray *customerNameAry;
@property(nonatomic,strong)NSMutableArray *customerIdAry;
@property(nonatomic,strong)NSMutableArray *customerMobileAry;
//仓库方式数组
@property (nonatomic, strong) NSMutableArray *warehouseNameAry;
@property (nonatomic, strong) NSMutableArray *warehouseIdAry;
@property (nonatomic, copy) NSString *warehouseIdStr;///选中的仓库id
//付款方式数组
@property (nonatomic, strong) NSMutableArray *payNameAry;
@property (nonatomic, strong) NSMutableArray *payIdAry;
@property (nonatomic, copy) NSString *payIdStr;///选中的付款方式id

@end

@implementation BackOrderViewController

#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.titleView = [Utility navTitleView:@"退单"];
    self.navigationItem.rightBarButtonItem = [Utility navButton:self action:@selector(toListClisk) image:IMAGE(@"new_lists")];
    //拖动tableView回收键盘
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    
    //网络请求
    [self setupCustomerList];
    [self setupWarehouseLists];
    [self setupPayList];
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
                              @"detailColor":CD_Text33,
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
                              @"detailColor":CD_Text33,
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
                              @"detailColor":CD_Text33,
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
                              @"detailColor":CD_Text33,
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
                              @"detailColor":CD_Text33,
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
                              @"detailColor":CD_Text33,
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
                              @"detailColor":CD_Text33,
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
                              @"detailColor":CD_Text33,
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
                              @"detailColor":CD_Text33,
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
                              @"detailColor":LZAppRedColor,
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
                              @"detailColor":LZAppRedColor,
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

// 点击事件
- (void)backOrderCell:(LZBackOrderCell *)backOrderCell selectItemForIndexPath:(NSIndexPath *)indexPath {
    LZBackOrderGroup *group = self.dataSource[indexPath.section];
    LZBackOrderItem *item = group.items[indexPath.row];
    WEAKSELF;
    
//    LZSelectItemViewController *vc = [[LZSelectItemViewController alloc] init];
//    vc.type = (LZSelectItemVCSelectType)item.clickType;
//    vc.title = item.placeHolder;
//    vc.selectItemBlock = ^(NSString *itemStr) {
//        if (ClickTypeProduct == item.clickType && [BXSTools isEmptyString:item.detailTitle]) {
//
//            LZBackOrderItem *threeItem = group.items[2];
//            threeItem.detailTitle = @"公斤";
//
//            NSDictionary *dic = @{@"textTitle":@"细码 (总条数: 0 )",
//                                  @"detailTitle":@" ",
//                                  @"placeHolder":@"",
//                                  @"detailColor":[UIColor blackColor],
//                                  @"clickType":@(0),
//                                  @"cellType":@(2),
//                                  @"canInput":@(NO),
//                                  @"showArrow":@(NO),
//                                  @"mandatoryOption":@(NO),
//                                  @"numericKeyboard":@(NO)
//                                  };
//            LZBackOrderItem *tmpItem = [[LZBackOrderItem alloc] init];
//            [tmpItem setValuesForKeysWithDictionary:dic];
//            [group.items insertObject:tmpItem atIndex:3];
//
//            if (group.isFold) {
//                NSInteger rowCount = [weakSelf tableView:weakSelf.tableView numberOfRowsInSection:indexPath.section];
//                [group.items exchangeObjectAtIndex:(group.items.count - 1) withObjectAtIndex:(rowCount - 1)];
//                [group.items exchangeObjectAtIndex:3 withObjectAtIndex:rowCount];
//            }
//        }
//        item.detailTitle = itemStr;
//        NSInteger section = [weakSelf.dataSource indexOfObject:group];
//        [weakSelf.tableView reloadDataWithInsertingDataAtTheBeginingOfSection:section newDataCount:group.items.count];
//    };
//
//    [self.navigationController pushViewController:vc animated:YES];
    
    if ((LZSelectItemVCSelectType)item.clickType == ClickTypeProduct) {
        
        //选择产品
        LZChooseProductsVC * vc = [LZChooseProductsVC new];
        [vc setSelectVCBlock:^(LZProductDetailModel *seletedModel) {
            item.detailTitle = seletedModel.name;
            _productId = seletedModel.id;
//            seletedModel.unitName 产品单位
//            seletedModel.unitId 产品id
//            seletedModel.storageType 为0是总码 为1是细码
            [weakSelf.tableView reloadData];
        }];
        CWLateralSlideConfiguration *conf = [CWLateralSlideConfiguration configurationWithDistance:0 maskAlpha:0.4 scaleY:1.0 direction:CWDrawerTransitionFromRight backImage:[UIImage imageNamed:@"back"]];
        [self.navigationController cw_showDrawerViewController:vc animationType:(CWDrawerAnimationTypeMask) configuration:conf];
        
    }else if ((LZSelectItemVCSelectType)item.clickType == ClickTypeColor){
        
        //选择颜色
        if ([BXSTools isEmptyString:_productId]) {
            [LLHudTools showWithMessage:@"请选择品名"];
            return;
        }
        LZSearchVC * colorVC = [LZSearchVC new];
        colorVC.productId = _productId;
        colorVC.SearchVCBlock = ^(LLSalesColorListModel *seletedModel) {
            item.detailTitle = seletedModel.name;
            [weakSelf.tableView reloadData];
        };
        CWLateralSlideConfiguration *conf = [CWLateralSlideConfiguration configurationWithDistance:0 maskAlpha:0.4 scaleY:1.0 direction:CWDrawerTransitionFromRight backImage:[UIImage imageNamed:@"back"]];
        [self.navigationController cw_showDrawerViewController:colorVC animationType:(CWDrawerAnimationTypeMask) configuration:conf];
        
    }else if ((LZSelectItemVCSelectType)item.clickType == ClickTypeWarehouse){
        
        //选择仓库
        if (_warehouseNameAry.count <1) {
            [LLHudTools showWithMessage:@"暂无仓库，请在“设置 - 仓库”中添加"];
            return;
        }
        LZPickerView *pickerView =[[LZPickerView alloc] initWithComponentDataArray:_warehouseNameAry titleDataArray:nil];
        
        pickerView.getPickerValue = ^(NSString *compoentString, NSString *titileString) {
            item.detailTitle = compoentString;
            NSInteger row = [titileString integerValue];
            _warehouseIdStr = _payIdAry[row];
            [weakSelf.tableView reloadData];
        };
        [self.view addSubview:pickerView];
        
    }else if ((LZSelectItemVCSelectType)item.clickType == ClickTypePayMentWay){
        
        //选择支付方式
        if (_payNameAry.count <1) {
            [LLHudTools showWithMessage:@"暂无收款方式，请在“设置 - 现金银行”中添加"];
            return;
        }
        LZPickerView *pickerView =[[LZPickerView alloc] initWithComponentDataArray:_payNameAry titleDataArray:nil];
        
        pickerView.getPickerValue = ^(NSString *compoentString, NSString *titileString) {
            item.detailTitle = compoentString;
            NSInteger row = [titileString integerValue];
            _payIdStr = _payIdAry[row];
            [weakSelf.tableView reloadData];
        };
         [self.view addSubview:pickerView];
    }else if ((LZSelectItemVCSelectType)item.clickType == ClickTypeChangeNum){
        
        //标签数量
        LZChangeNumVC *vc = [LZChangeNumVC new];
        vc.originalValue = [item.detailTitle integerValue];
//        vc.lineValue = 细码条数
        [vc setNumValueBlock:^(NSString *ValueStr) {
            item.detailTitle = ValueStr;
            [weakSelf.tableView reloadData];
            //假如有5条细码，加减就是加减5，然后每条细码各加减1。
        }];
        CWLateralSlideConfiguration *conf = [CWLateralSlideConfiguration configurationWithDistance:0 maskAlpha:0.4 scaleY:1.0 direction:CWDrawerTransitionFromRight backImage:[UIImage imageNamed:@"back"]];
        [self.navigationController cw_showDrawerViewController:vc animationType:(CWDrawerAnimationTypeMask) configuration:conf];
    }

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

- (void)backOrderCell:(LZBackOrderCell *)backOrderCell popViewForIndexPath:(NSIndexPath *)indexPath textField:(UITextField *)textField {
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS %@", textField.text];
    _tempNameArray = [self.nameArray filteredArrayUsingPredicate:predicate];
    NSLog(@"%@", _tempNameArray);
    NSInteger count = _tempNameArray.count;
    if (_popView) {
        if (count == 0) {
            [_popView dismiss];
            return;
        }
        CGFloat height = count * 44;
        if (count >= 4) height = 4 * 44;
        _popView.table.height = height;
        _popView.containerView.height = height;
        _popView.height = height;
        [_popView.table reloadData];
    } else {
        if (count == 0) return;
        CGFloat height = count * 44;
        if (count >= 4) height = 4 * 44;
        ZWCustomPopView *popView = [[ZWCustomPopView alloc]initWithBounds:CGRectMake(0, 0, 120, height) titleMenus:_tempNameArray maskAlpha:0.0];
        popView.delegate = self;
        popView.containerBackgroudColor = [UIColor whiteColor];
        [popView showFrom:textField alignStyle:CPAlignStyleCenter];
        _popView = popView;
    }
}

#pragma mark - ZWCustomPopViewDelegate
- (void)popOverView:(ZWCustomPopView *)pView didClickMenuIndex:(NSInteger)index {
    NSString *name = _tempNameArray[index];
    LZBackOrderGroup *group = self.dataSource.firstObject;
    LZBackOrderItem *item = group.items.firstObject;
    item.detailTitle = name;
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:0];
    [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark - Getter && Setter
- (NSMutableArray *)dataSource {
    if (_dataSource == nil) {
        _dataSource = @[].mutableCopy;
        NSArray *tempArr = @[
                             @[@{@"textTitle":@"*客户名字",
                                 @"detailTitle":@"",
                                 @"placeHolder":@"请输入客户名称",
                                 @"detailColor":CD_Text33,
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
                                 @"detailColor":CD_Text33,
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
                                 @"detailColor":CD_Text33,
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
                                 @"detailColor":CD_Text33,
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
                                 @"detailColor":CD_Text33,
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
                                 @"detailColor":CD_Text33,
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
                                 @"detailColor":CD_Text33,
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
                                 @"detailColor":CD_Text33,
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
                                 @"detailColor":CD_Text33,
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
                                 @"detailColor":CD_Text33,
                                 @"clickType":@(5),
                                 @"cellType":@(0),
                                 @"canInput":@(NO),
                                 @"showArrow":@(YES),
                                 @"mandatoryOption":@(NO),
                                 @"numericKeyboard":@(NO)
                                 },
                               @{@"textTitle":@"结算数量",
                                 @"detailTitle":@"0",
                                 @"placeHolder":@"",
                                 @"detailColor":CD_Text33,
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
                                 @"detailColor":LZAppRedColor,
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
                                 @"detailColor":LZAppRedColor,
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
                                 @"detailColor":CD_Text33,
                                 @"clickType":@(3),
                                 @"canInput":@(NO),
                                 @"showArrow":@(YES),
                                 @"mandatoryOption":@(YES),
                                 @"numericKeyboard":@(NO)
                                 },
                               @{@"textTitle":@"应付金额",
                                 @"detailTitle":@" ",
                                 @"placeHolder":@" ",
                                 @"detailColor":CD_Text33,
                                 @"clickType":@(0),
                                 @"canInput":@(NO),
                                 @"showArrow":@(NO),
                                 @"mandatoryOption":@(NO),
                                 @"numericKeyboard":@(NO)
                                 },
                               @{@"textTitle":@"实付金额",
                                 @"detailTitle":@"",
                                 @"placeHolder":@"输入实付金额",
                                 @"detailColor":CD_Text33,
                                 @"clickType":@(0),
                                 @"canInput":@(YES),
                                 @"showArrow":@(NO),
                                 @"mandatoryOption":@(NO),
                                 @"numericKeyboard":@(YES)
                                 },
                               @{@"textTitle":@"预收付款",
                                 @"detailTitle":@" ",
                                 @"placeHolder":@"",
                                 @"detailColor":CD_Text33,
                                 @"clickType":@(0),
                                 @"canInput":@(NO),
                                 @"showArrow":@(NO),
                                 @"mandatoryOption":@(NO),
                                 @"numericKeyboard":@(NO)
                                 },
                               @{@"textTitle":@"付款方式",
                                 @"detailTitle":@"",
                                 @"placeHolder":@"请选择付款方式",
                                 @"detailColor":CD_Text33,
                                 @"clickType":@(4),
                                 @"canInput":@(NO),
                                 @"showArrow":@(YES),
                                 @"mandatoryOption":@(NO),
                                 @"numericKeyboard":@(NO)
                                 },
                               @{@"textTitle":@"备注",
                                 @"detailTitle":@"",
                                 @"placeHolder":@"请输入备注内容",
                                 @"detailColor":CD_Text33,
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

- (NSArray *)nameArray {
    if (_nameArray == nil) {
        _nameArray = @[];
    }
    return _nameArray;
}

#pragma mark --- 网络请求 ---
//接口名称 功能用到客户列表
- (void)setupCustomerList{
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId};
    [BXSHttp requestGETWithAppURL:@"customer/customer_list.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
        NSArray *customerListAry = baseModel.data;
        _customerNameAry = [NSMutableArray array];
        _customerIdAry = [NSMutableArray array];
        for (int i = 0 ; i <customerListAry.count; i++) {
            [_customerNameAry addObject:customerListAry[i][@"name"]];
            [_customerIdAry addObject:customerListAry[i][@"id"]];
            [_customerMobileAry addObject:customerListAry[i][@"mobile"]];
        }
        self.nameArray = [_customerNameAry copy];
        
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
    }];
}

//接口名称 仓库列表
- (void)setupWarehouseLists
{
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId};
    [BXSHttp requestPOSTWithAppURL:@"house/list.do" param:param success:^(id response) {
        
        LLBaseModel *baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
        NSMutableArray *tempAry = baseModel.data;
        _warehouseNameAry = [NSMutableArray array];
        _warehouseIdAry = [NSMutableArray array];
        for (int i = 0; i <tempAry.count; i++) {
            [_warehouseIdAry addObject:tempAry[i][@"id"]];
            [_warehouseNameAry addObject:tempAry[i][@"name"]];
        }
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
    }];
}

//接口名称 付款方式
- (void)setupPayList{
    
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId};
    [BXSHttp requestGETWithAppURL:@"bank/pay_list.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
        NSMutableArray *tempAry = baseModel.data;
        _payNameAry = [NSMutableArray array];
        _payIdAry = [NSMutableArray array];
        for (int i = 0; i <tempAry.count; i++) {
            [_payIdAry addObject:tempAry[i][@"id"]];
            [_payNameAry addObject:tempAry[i][@"name"]];
        }
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
    }];
}

#pragma mark ---- ActionClick ----
- (void)toListClisk{
    [self.navigationController pushViewController:[LZBackOrderListsVC new] animated:YES];
}

@end
