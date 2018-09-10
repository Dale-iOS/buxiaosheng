//
//  LLProcessChildVc.m
//  BuXiaoShengTests
//
//  Created by 家朋 on 2018/6/26.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  采购页面(指派) 采购（指派）

#import "LLProcessChildVc.h"
#import "BXSMachiningBottomView.h"
#import "ConCell.h"
#import "BXSMachiningHeadCell.h"
#import "GridView.h"
#import "BXSMachiningDBCell.h"
#import "LZCompanyModel.h"
#import "LZChoosseWorkerVC.h"
#import "LLOutboundSeletedVC.h"
#import "BXSChooseProductVC.h"
#import "salesDemandModel.h"
#import "LZSearchVC.h"
#import "UITextView+Placeholder.h"
#import "UITextField+PopOver.h"

@interface LLProcessChildVc ()<UITableViewDelegate,UITableViewDataSource,ConItemDelegate,UITextFieldDelegate>
{
    NSString *_factoryId;//厂商id;
    NSString *_selectWorker;//指派人
    UITextView *_tv;//备注内容
}
/// 底部view
@property (weak,nonatomic)BXSMachiningBottomView *bottomView;
/// 底部备注
@property (weak,nonatomic)UITextView *txV;

/// 产品模型
@property (strong,nonatomic)NSArray <LZPurchaseModel*>*purchaseModelArray ;

// dise模型
@property (strong,nonatomic)NSMutableArray <BXSDSModel *>*dsModelArray;

// 加工商模型
@property (strong,nonatomic)NSMutableArray <LZCompanyModel *>*processorsModelArray;
@property (strong,nonatomic)NSMutableArray *processorsModelNameArray;

@property (strong,nonatomic)LZCompanyModel *companyModel;
@end

@implementation LLProcessChildVc


/// 懒加载

- (NSMutableArray *)dsModelArray {
    if (!_dsModelArray) {
        _dsModelArray = [NSMutableArray array];
    }
    return _dsModelArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    [self setupFooter];
    [self setupBottom];
    
    [self requestData];
    [self loadDataWithType:0];
//    [self loadDataWithType:2];
}

- (void)setup {
    
    self.mainTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 0) style:UITableViewStyleGrouped];
    [self.view addSubview:self.mainTable];
    self.mainTable.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 50, 0));
    self.mainTable.contentInset = UIEdgeInsetsZero;
    self.mainTable.separatorInset = UIEdgeInsetsZero;
    self.mainTable.separatorColor  = LZHBackgroundColor;
    
    self.mainTable.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    self.mainTable.tableFooterView = [UIView new];
    
    self.mainTable.estimatedRowHeight = 0;
    self.mainTable.estimatedSectionHeaderHeight = 0;
    self.mainTable.estimatedSectionFooterHeight = 0;
    
    self.mainTable.delegate = self;
    self.mainTable.dataSource = self;
    self.mainTable.backgroundColor = [UIColor whiteColor];
    //cell
    [self.mainTable registerClass:[ConCell class] forCellReuseIdentifier:[ConCell cellID]];
    [self.mainTable registerClass:[BXSMachiningHeadCell class] forCellReuseIdentifier:[BXSMachiningHeadCell cellID]];
    [self.mainTable registerClass:[BXSMachiningDBCell class] forCellReuseIdentifier:[BXSMachiningDBCell cellID]];
    self.mainTable.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    
}

- (void)setupFooter {
    
    UIView *footer = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 70)];
    [footer addSubview:[LineView lineViewOfHeight:10]];
    UILabel *bzL = [[UILabel alloc]initWithFrame:CGRectMake(15, 25, 50, 20)];
    bzL.text = @"备注";
    bzL.font = FONT(15);
    [footer addSubview:bzL];
    
    //textView
    _tv = [[UITextView alloc]initWithFrame:CGRectMake(bzL.right+50, 20, SCREEN_WIDTH - (bzL.right+60), 40)];
    [footer addSubview:_tv];
    _tv.placeholder = @"请输入备注内容";
    _tv.font = FONT(15);
    self.txV = _tv;
    self.mainTable.tableFooterView = footer;
}

/// 设置底部View
- (void)setupBottom {
    
    //bottomView
    BXSMachiningBottomView *bottomView = [BXSMachiningBottomView bottomView];
    
    self.bottomView = bottomView;
    [self.view addSubview:bottomView];
    bottomView.sd_layout
    .topSpaceToView(self.mainTable, 0)
    .leftEqualToView(self.view)
    .rightEqualToView(self.view)
    .bottomEqualToView(self.view);
    
//    [bottomView setupCount:@"总需求量:0" bottomCount:@"总数量:0"];
    
    //click
    WEAKSELF;
    bottomView.clickBottomTrue = ^{
        [weakSelf clickBottom];
    };
    
}

/// MARK: ----数据请求
- (void)loadDataWithType:(NSInteger )type {

    WEAKSELF;
//    接口名称 销售需求采购的产品的列表
    {
        NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
                                 @"orderId":self.orderId
                                 };
        [BXSHttp requestGETWithAppURL:@"storehouse/product_list.do" param:param success:^(id response) {
            LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
            if ([baseModel.code integerValue] != 200) {
                [LLHudTools showWithMessage:baseModel.msg];
                return ;
            }
            weakSelf.purchaseModelArray = [LZPurchaseModel LLMJParse:baseModel.data];
            if (weakSelf.purchaseModelArray.count > 0) {
                [weakSelf.purchaseModelArray setValue:@(YES) forKey:@"isShow"];
            }
            [weakSelf getBottomData];
            [weakSelf.mainTable reloadData];
        } failure:^(NSError *error) {
            BXS_Alert(LLLoadErrorMessage);
        }];
    }
    
    //    接口名称 功能用到厂商列表
    {
        ///类型（0：供货商 1：生产商 2：加工商）
        NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
                                 //@"orderId":self.orderId,
                                 @"type":@(type)
                                 };
        [BXSHttp requestGETWithAppURL:@"factory/search_list.do" param:param success:^(id response) {
            LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
            if ([baseModel.code integerValue] != 200) {
                [LLHudTools showWithMessage:baseModel.msg];
                return ;
            }
//            if (type == 2) {
//                NSArray *array = [LZCompanyModel LLMJParse:baseModel.data];
//                if  (array.count > 0) {
//                    weakSelf.companyModel = array.firstObject;
//                    [weakSelf.mainTable reloadData];
//                }
//
//            }
            
            if (type == 0) {
                //加载加工商模型
                _processorsModelArray = [LZCompanyModel LLMJParse:baseModel.data];
                _processorsModelNameArray = [NSMutableArray array];
                [_processorsModelArray enumerateObjectsUsingBlock:^(LZCompanyModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    [_processorsModelNameArray addObject:obj.name];
                }];
            }
            
        } failure:^(NSError *error) {
            BXS_Alert(LLLoadErrorMessage);
        }];
        
    }
    
}

#pragma mark ---- ConItem ----
- (void)requestData {
    
    [self.dataSource addObject:[NSMutableArray array]];
    [self.dataSource addObject:[NSMutableArray arrayWithObject:@[]]];
    NSMutableArray *bArray = [NSMutableArray array];
    // ConItem *item0 = [[ConItem alloc]initWithTitle:@"*加工类型" kpText:@"请选择加工类型" conType:ConTypeA];
    ConItem *item1 = [[ConItem alloc]initWithTitle:@"*采购商名称" kpText:@"请输入加工商名称" conType:ConTypeB];
    item1.delegate = self;
    ConItem *item2 = [[ConItem alloc]initWithTitle:@"联系人" kpText:@"请先选择加工商" conType:ConTypeC];
    ConItem *item3 = [[ConItem alloc]initWithTitle:@"电话" kpText:@"请先选择加工商" conType:ConTypeC];
    ConItem *item4 = [[ConItem alloc]initWithTitle:@"地址" kpText:@"请先选择加工商" conType:ConTypeC];
    ConItem *item5 = [[ConItem alloc]initWithTitle:@"*指派人" kpText:@"请选择指派人" conType:ConTypeA];
    item5.titleColor = [UIColor redColor];
    
    [bArray addObjectsFromArray:@[item1,item2,item3,item4]];
    [self.dataSource addObject:bArray];
    
    [self.dataSource addObject:@[item5]];
}

- (void)setComCell:(ConCell *)cell index:(NSIndexPath *)indexPath  item:(ConItem *)item {
    
}

//加工商名称点击事件
- (void)didClickItemInTextField:(UITextField *)tf{

    tf.delegate = self;
    tf.scrollView = (UIScrollView *)self.view;
    tf.positionType = ZJPositionBottomTwo;
    WEAKSELF;
    [tf popOverSource:_processorsModelNameArray index:^(NSInteger index) {
        LZCompanyModel *companyModel = weakSelf.processorsModelArray[index];
        //加工商
        ConItem *item1 = [[self.dataSource objectAtIndex:2] objectAtIndex:0];
        item1.contenText = companyModel.name;
        //联系人
        ConItem *item2 = [[self.dataSource objectAtIndex:2] objectAtIndex:1];
        item2.contenText = companyModel.contactName;
        //电话
        ConItem *item3 = [[self.dataSource objectAtIndex:2] objectAtIndex:2];
        item3.contenText = companyModel.mobile;
        //电话
        ConItem *item4 = [[self.dataSource objectAtIndex:2] objectAtIndex:3];
        item4.contenText = companyModel.address;
        //厂商id
        _factoryId = companyModel.id;
        [weakSelf.mainTable reloadData];

    }];
}

#pragma mark ---- 点击事件 ----
/// 点击底部确定
- (void)clickBottom {
    
    if (_factoryId == nil) {
        BXS_Alert(@"请选择加工商名称");
        return;
    }
    if (_selectWorker == nil) {
        BXS_Alert(@"请选择指派人");
        return;
    }

//    NSMutableArray *itemList = [NSMutableArray array];
//    for (LZPurchaseModel *aItem in self.purchaseModelArray) {
//        NSMutableArray*kArr = [LZPurchaseModel mj_keyValuesArrayWithObjectArray:aItem.itemList ignoredKeys:@[@"itemList"]];
//        if (kArr.count >0) {
//            NSDictionary *dict = @{@"itemList":kArr};
//            [itemList addObject:dict];
//        }
//
//    }
    
    NSMutableArray <NSDictionary *> * itemModel = [NSMutableArray array];
    
    [self.purchaseModelArray enumerateObjectsUsingBlock:^(LZPurchaseModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSMutableArray *itemListMuAry = [NSMutableArray array];
        
        [obj.itemList enumerateObjectsUsingBlock:^(LZPurchaseItemListModel * _Nonnull itemListObj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSDictionary *itemListParam = @{
                                    @"number":itemListObj.number,
                                    @"productColorId":itemListObj.productColorId
                                    };
            [itemListMuAry addObject:itemListParam];
        }];
        
        NSDictionary *param = @{
                                @"itemList":itemListMuAry,
                                @"productId":obj.productId
                                };
        [itemModel addObject:param];
    }];
    
    
    //    接口名称 新增采购单
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
                             @"factoryId":_factoryId,
                             @"orderId":self.orderId,
                             @"productItems":[itemModel mj_JSONString],
                             @"purchaserId":_selectWorker,
                             @"remark":_tv.text,
                             @"type":@(0)
                                 };
    [BXSHttp requestGETWithAppURL:@"storehouse/add_buy.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:true];
        });
        
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
    }];
    
}

- (void)clickColIndex:(NSIndexPath *)indexPath {
    
    WEAKSELF;
    if (indexPath.section == 3 && indexPath.row == 0) {
        
        LZChoosseWorkerVC * VC = [LZChoosseWorkerVC new];
        VC.navTitle = @"选择指派人";
        [self.navigationController pushViewController:VC animated:YES];
        VC.chooseBlock = ^(NSString *workerId, NSString *workerName) {
            ConItem *item = weakSelf.dataSource[3][indexPath.row];
            item.id = workerId;
            item.contenText = workerName;
            _selectWorker = workerId;
            [weakSelf.mainTable reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        };
        return;
    }

}


#pragma mark ---- UITableViewDataSource ----
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return self.purchaseModelArray.count;
    }else if (section == 1) {
        return self.dsModelArray.count;
    }else {
        NSArray *arry = self.dataSource[section];
        return arry.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WEAKSELF;
    switch (indexPath.section) {
        case 0:{
            BXSMachiningHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:[BXSMachiningHeadCell cellID]];
            cell.clickShowBlock = ^(BOOL isShowing) {
                
                [weakSelf.mainTable reloadData];
            };
            LZPurchaseModel *pModel = self.purchaseModelArray[indexPath.row];
            cell.purchaseModel = pModel;
            return cell;
        }break;
        case 1:{
            
            BXSMachiningDBCell *cell = [tableView dequeueReusableCellWithIdentifier:[BXSMachiningDBCell cellID]];
            BXSDSModel *model = self.dsModelArray[indexPath.row];
            cell.model = model;
            
            cell.needGetBottomDataBlock = ^{
                [weakSelf getBottomData];
            };
            return cell;
        }break;
        case 2:
        case 3:{
            ConCell *cell = [tableView dequeueReusableCellWithIdentifier:[ConCell cellID]];
            ConItem *item = self.dataSource[indexPath.section][indexPath.row];
            cell.k_titlewWidth = 120;
            cell.item = item;
            cell.clickCellBlock = ^{
                [weakSelf clickColIndex:indexPath];
            };
            [self setComCell:cell index:indexPath item:item];
            return cell;
            
        }break;
            
        default:
            break;
    }
    return nil;
}

#pragma mark ---- UITableViewDelegate ----
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:{
            LZPurchaseModel *pModel = self.purchaseModelArray[indexPath.row];
            return pModel.isShow?pModel.cellHeight:50;
        }break;
        case 1:{
            BXSDSModel *model = self.dsModelArray[indexPath.row];
            return model.cellHeight;
        }break;
        case 2:
        case 3:{
            return 50.f;
        }break;
            
        default:
            break;
    }
    return 0;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 3) {
        return 10.f;
    }
    return 0.1f;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 3) {
        return [LineView lineViewOfHeight:10];
    }
    return [LineView lineViewOfHeight:10];;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.1f;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2||indexPath.section == 3) {
        [self clickColIndex:indexPath];
    }
}

#pragma mark ---- private ----
/// 计算底部的数量
- (void)getBottomData {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSString *allTotle = [NSString stringWithFormat:@"%@",[[self.purchaseModelArray valueForKey:@"totalNumber"] valueForKeyPath:@"@sum.integerValue"]];
        
        //NSString *allCKTotle = [NSString stringWithFormat:@"%@",[[self.dsModelArray valueForKey:@"ckTotal"] valueForKeyPath:@"@sum.integerValue"]];
        
        [self.bottomView setupCoun:[NSString stringWithFormat:@"总需求量:%@",allTotle]];
    });
    
}


@end

