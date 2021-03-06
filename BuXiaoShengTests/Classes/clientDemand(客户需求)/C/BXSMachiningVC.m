//
//  BXSMachiningVC.m
//  BuXiaoShengTests
//
//  Created by 家朋 on 2018/6/26.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  指派-加工页面

#import "BXSMachiningVC.h"
#import "BXSMachiningBottomView.h"
#import "ConCell.h"
#import "BXSMachiningProduuctCell.h"

#import "LZOutboundModel.h"
#import "LZCompanyModel.h"
#import "LZChoosseWorkerVC.h"
#import "LLOutboundSeletedVC.h"
#import "BXSChooseProductVC.h"
#import "salesDemandModel.h"
#import "BXSDSModel.h"
#import "LZSearchVC.h"
#import "UITextView+Placeholder.h"
/*
 s1产品名
 s2底布
 
 s3 底部数据
 s4 指派人
 footer备注
 */

/*
 需求修改后的结构
 每个产品对应一个table
 table.header -->产品名-->mainTable.cell
 s1.header  --> 产品名的颜色--headCell
 s1.row >0  --> 底bu--DBCell
 s1.footer -->添加底布的按钮
 
 s2...s3...
 
 sn-1 -->s4 底部conCell
 sn ---> 指派人conCell
 footer备注View
 */
@interface BXSMachiningVC ()<UITableViewDelegate,UITableViewDataSource>
/// 底部view
@property (weak,nonatomic)BXSMachiningBottomView *bottomView;
/// 底部备注
@property (weak,nonatomic)UITextView *txV;
/// 产品模型
@property (strong,nonatomic)NSArray <LZPurchaseModel*>*purchaseModelArray ;

/// 公司信息
@property (strong,nonatomic)LZCompanyModel *companyModel;
@end

@implementation BXSMachiningVC


/// 懒加载

- (void)viewDidLoad {
    self.isGrouped = YES;
    [super viewDidLoad];
    [self setup];
    [self setupFooter];
    [self setupBottom];
    
    [self requestData];
    [self loadDataWithType:0];
    [self loadDataWithType:2];
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
    [self.mainTable registerClass:[BXSMachiningProduuctCell class] forCellReuseIdentifier:[BXSMachiningProduuctCell cellID]];
    //[self.mainTable registerClass:[BXSMachiningDBCell class] forCellReuseIdentifier:[BXSMachiningDBCell cellID]];
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
    UITextView *tv = [[UITextView alloc]initWithFrame:CGRectMake(bzL.right+50, 20, SCREEN_WIDTH - (bzL.right+60), 40)];
    [footer addSubview:tv];
    tv.placeholder = @"请输入备注内容";
    self.txV = tv;
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
    
    [bottomView setupCount:@"总需求量:0" bottomCount:@"总数量:0"];
    
    //click
    WEAKSELF;
    bottomView.clickBottomTrue = ^{
        [weakSelf clickBottom];
    };
    
}

/// MARK: ----数据请求
- (void)loadDataWithType:(NSInteger )type {
    
    WEAKSELF;
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
            if (type == 2) {
                NSArray *array = [LZCompanyModel LLMJParse:baseModel.data];
                if  (array.count > 0) {
                    weakSelf.companyModel = array.firstObject;
                    [weakSelf.mainTable reloadData];
                }
                
            }
        } failure:^(NSError *error) {
            BXS_Alert(LLLoadErrorMessage);
        }];
        
    }
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
}

- (void)requestData {
    
    [self.dataSource addObject:[NSMutableArray arrayWithObject:@[]]];
    NSMutableArray *bArray = [NSMutableArray array];
    ConItem *item0 = [[ConItem alloc]initWithTitle:@"*加工类型" kpText:@"请选择加工类型" conType:ConTypeA];
    ConItem *item1 = [[ConItem alloc]initWithTitle:@"*加工商名称" kpText:@"请输入加工商名称" conType:ConTypeB];
    ConItem *item2 = [[ConItem alloc]initWithTitle:@"联系人" kpText:@"请先选择加工商" conType:ConTypeC];
    ConItem *item3 = [[ConItem alloc]initWithTitle:@"电话" kpText:@"请先选择加工商" conType:ConTypeC];
    ConItem *item4 = [[ConItem alloc]initWithTitle:@"地址" kpText:@"请先选择加工商" conType:ConTypeC];
    ConItem *item5 = [[ConItem alloc]initWithTitle:@"*指派人" kpText:@"请选择指派人" conType:ConTypeA];
    item5.titleColor = [UIColor redColor];
    
    [bArray addObjectsFromArray:@[item0,item1,item2,item3,item4]];
    [self.dataSource addObject:bArray];
    
    [self.dataSource addObject:@[item5]];
}
- (void)setComCell:(ConCell *)cell index:(NSIndexPath *)indexPath  item:(ConItem *)item {
    
}

#pragma mark ---- 点击事件 ----
/// 点击底部确定
- (void)clickBottom {
    
    /*
     1 提交的数据在 purchaseModelArray
     2 底色的数据在 purchaseModelArray-->purchaseModelArray(产品数据)-->LZPurchaseItemList（颜色数据）-->dsArray(底布数据)
     */
    ConItem *item5 = [[self.dataSource objectAtIndex:2] objectAtIndex:5];
    ConItem *item0 = [[self.dataSource objectAtIndex:2] objectAtIndex:0];
    NSMutableArray *itemList = [NSMutableArray array];
    for (LZPurchaseModel *aItem in self.purchaseModelArray) {
        NSMutableArray*kArr = [LZOutboundItemListModel mj_keyValuesArrayWithObjectArray:aItem.itemList ignoredKeys:@[@"productColorName"]];
        if (kArr.count >0) {
            NSDictionary *dict = @{@"itemList":kArr};
            [itemList addObject:dict];
        }
        
    }
    
    NSMutableArray *productArray = [NSMutableArray array];
    //{productId:3,productColorId:5,stockId:8,number:50,houseId:2,total:1,batchNumber:'20180509'}
    
    return;
    for (BXSDSModel *aItem in  @[]) {
        if (aItem.boundModelList.count >0) {
            LLOutboundRightModel *model  = aItem.boundModelList.firstObject;
            LLOutboundRightDetailModel *rModel = safeObjectAtIndex(model.itemList, 0);
            NSDictionary *dict = @{
                                   @"productId":aItem.productId,
                                   @"productColorId":aItem.productColorId,
                                   @"stockId":HandleNilString(rModel.stockId),
                                   @"number":model.number,
                                   @"houseId":model.leftModel.houseId,
                                   @"total":aItem.total,
                                   @"batchNumber":model.batcNumber,
                                   
                                   };
            [productArray addObject:dict];
        }
    }
    
    
    
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
                             @"factoryId":self.companyModel.id,//factoryId
                             @"initiatorId":HandleNilString(item5.id),//指派人
                             @"machiningType":HandleNilString(item0.id),//加工类型
                             @"orderId":self.orderId,
                             @"purchaserId":[BXSUser currentUser].userId,
                             @"remark":HandleNilString(_txV.text),
                             @"type":[BXSUser currentUser].type,
                             
                             @"productItems":HandleNilString([itemList mj_JSONString]),
                             
                             @"orderHouseItems":HandleNilString([productArray mj_JSONString]),
                             };
    [BXSHttp requestGETWithAppURL:@"storehouse/product_list.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
        [self.navigationController popViewControllerAnimated:YES];
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
            [weakSelf.mainTable reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        };
        return;
    }
    switch (indexPath.row) {
        case 0: {
            // 加工类型
            BYAlertHeadView *head = [BYAlertHeadView alertHeaderTitle:@"选择加工类型"];
            head.clickCancleBlock = ^{
                [BYAlertHelper hideAlert];
            };
            AlertSheet *sheet = [[AlertSheet alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 0)];
            sheet.rowHeight = 44;
            sheet.dataSource = @[@"印花",@"复合",@"洗水",@"烫金"];
            [sheet reloadData];
            sheet.didSelectAtRow = ^(NSInteger row, NSString *title) {
                [BYAlertHelper hideAlert];
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    ConItem *item = weakSelf.dataSource[2][indexPath.row];
                    item.contenText = [NSString stringWithFormat:@"%@",title];
                    item.kpText = title;
                    item.id = [NSString stringWithFormat:@"%ld",indexPath.row];
                    [UIView setAnimationsEnabled:NO];
                    [weakSelf.mainTable reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                    [UIView setAnimationsEnabled:YES];
                });
            };
            //show
            [BYAlertHelper sharedBYAlertHelper].addSubviews(@[head,sheet]).showInWindow();
        }break;
            
        default:
            break;
    }
}

#pragma mark ---- UITableViewDataSource ----
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return self.purchaseModelArray.count;
    }else {
        NSArray *arry = self.dataSource[section];
        return arry.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WEAKSELF;
    switch (indexPath.section) {
        case 0:{
            BXSMachiningProduuctCell *cell = [tableView dequeueReusableCellWithIdentifier:[BXSMachiningProduuctCell cellID]];
            LZPurchaseModel *pModel = self.purchaseModelArray[indexPath.row];
            cell.productModel = pModel;
            cell.getBottomDataBlock = ^{
                [weakSelf getBottomData];
            };
            cell.contentVC = self;
            return cell;
        }break;
        case 1:
        case 2:{
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
            return  pModel.isShow?pModel.cellHeight:50;
        }break;
        case 1:
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
    return 0.1f;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10.f;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [LineView lineViewOfHeight:10];;;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1||indexPath.section == 2) {
        [self clickColIndex:indexPath];
    }
}

#pragma mark ---- private ----
/// 计算底部的数量
- (void)getBottomData {
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSString *allTotle = [NSString stringWithFormat:@"%@",[[self.purchaseModelArray valueForKey:@"totalNumber"] valueForKeyPath:@"@sum.integerValue"]];
        NSMutableArray *allDSArray = [NSMutableArray array];
        for (LZPurchaseModel *pModel in self.purchaseModelArray) {
            for (LZPurchaseItemListModel *item in pModel.itemList) {
                [allDSArray addObjectsFromArray:item.dsArray];
            }
        }
        NSString *allCKTotle = [NSString stringWithFormat:@"%@",[[allDSArray valueForKey:@"ckTotal"] valueForKeyPath:@"@sum.integerValue"]];
        
        [self.bottomView setupCount:[NSString stringWithFormat:@"总需求量:%@",allTotle]
                        bottomCount:[NSString stringWithFormat:@"总数量:%@",allCKTotle]];
    });
}
@end
