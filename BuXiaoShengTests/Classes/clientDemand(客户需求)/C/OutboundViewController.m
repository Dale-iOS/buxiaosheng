//
//  OutboundViewController.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/4/26.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  出库页面

#import "OutboundViewController.h"
#import "LZOutboundModel.h"
#import "LZOutboundSectionView.h"
#import "LLDyeingCell.h"
#import "LLDyeingCollectionContainerCell.h"
#import "LZOutboundCell.h"
#import "LLOutboundFooterView.h"
//#import "LZOutboundSelectModel.h"//选中的model

@interface OutboundViewController ()<UITableViewDelegate,UITableViewDataSource,LZOutboundSectionViewDelegate>
@property(nonatomic,strong)LZOutboundModel *model;

@property (nonatomic,strong) UILabel * totalNumberLable;
@property (nonatomic,strong) UILabel * totalCountLable;
@property(nonatomic,strong)UIView *headView;
@property(nonatomic,strong)NSArray <LZOutboundItemListModel *>* listModels;

@end

@implementation OutboundViewController
{
    BOOL _folding[2];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.titleView = [Utility navTitleView:@"出库"];
    _rightSeleteds = [NSMutableArray array];
    [self setupDetailData];
}

//该数据源是来源右侧侧滑来的数据
-(void)setRightSeleteds:(NSMutableArray<LLOutboundRightModel *> *)rightSeleteds {
    _rightSeleteds = [NSMutableArray arrayWithArray:rightSeleteds];
    
    
    //    [_listModels enumerateObjectsUsingBlock:^(LZOutboundItemListModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
    //        if ([obj.productColorId isEqual:self.sectionModel.productColorId]) {
    //            obj.itemCellData = [NSMutableArray arrayWithArray:_rightSeleteds];
    //        }
    //    }];
    
    for (LZOutboundItemListModel *listModel in _listModels) {
        
        if ([listModel.productColorId isEqualToString:self.sectionModel.productColorId]) {
            
            listModel.itemCellData = [NSMutableArray arrayWithArray:[self addCellArray]];
            
        }
        
    }
    
    
    __block NSInteger  totalCount = 0;
    __block NSInteger totalOutCount = 0;
    //计算总出库量和总条数
    for (LLOutboundRightModel *rightModel in _rightSeleteds) {
        
        for (LLOutboundRightDetailModel *detailModel in rightModel.itemList) {
            
            if (detailModel.seleted) {
                totalCount += [detailModel.value integerValue];
                totalOutCount += [detailModel.value integerValue];
            }
            
        }
        
    }
    
    
    self.totalCountLable.text = [NSString stringWithFormat:@"总出库数量:%@",[@(totalOutCount)stringValue]] ;
    
    self.totalNumberLable.text = [NSString stringWithFormat:@"总条数:%@",[@(totalCount)stringValue]] ;
    [self.tableView reloadData];
    
}

//把返回的数据转成LLOutboundRightDetailModel
- (NSMutableArray *)addCellArray
{
    NSMutableArray *seletedArray = [NSMutableArray array];
    for (LLOutboundRightModel *rightModel in _rightSeleteds) {
        
        for (LLOutboundRightDetailModel *detailModel in rightModel.itemList) {
            
            if (detailModel.seleted) {
                [seletedArray addObject:detailModel];
            }
            
        }
        
    }
    
    return seletedArray;
}

#pragma mark ----- 网络请求 -----
- (void)setupDetailData
{
    NSDictionary *param = @{@"companyId":[BXSUser currentUser].companyId,
                            @"orderId":self.id,
                            };
    [BXSHttp requestGETWithAppURL:@"storehouse/notout_detail.do" param:param success:^(id response) {
        LLBaseModel *baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            return ;
        }
        _model = [LZOutboundModel LLMJParse:baseModel.data];
        _listModels = _model.itemList;
        [self setupUI];
    } failure:^(NSError *error) {
        
    }];
}

- (void)setupUI{
    
    if (_model.matter.length >0) {
        UIView *topView = [self setupTopView];
        UIView *bottomView = [self setupBottomView];
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.top.equalTo(topView).offset(50);
            make.bottom.equalTo(bottomView.mas_top);
        }];
    }else{
        
        UIView *bottomView = [self setupBottomView];
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self.view);
            make.bottom.equalTo(bottomView.mas_top);
        }];
    }
    
    //初始化tableview_headView
    _headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 44)];
    _headView.backgroundColor = [UIColor whiteColor];
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 10)];
    lineView.backgroundColor =LZHBackgroundColor;
    [_headView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(_headView);
        make.height.mas_offset(10);
    }];
    UILabel *orderLbl = [[UILabel alloc]init];
    orderLbl.font = FONT(13);
    orderLbl.textColor = CD_Text99;
    orderLbl.text = [NSString stringWithFormat:@"订单号 ：%@",_model.orderNo];
    [_headView addSubview:orderLbl];
    [orderLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_headView).offset(15);
        make.top.equalTo(lineView.mas_bottom);
        make.bottom.equalTo(_headView);
        make.width.mas_offset(APPWidth -15*2);
    }];
    _tableView.tableHeaderView = _headView;
    
}

//顶部部分(注意事项)
- (UIView *)setupTopView{
    UIView *topView = [[UIView alloc]init];
    topView.backgroundColor = [UIColor colorWithHexString:@"#ff7b7b"];
    [self.view addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(LLNavViewHeight);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(50);
    }];
    
    UILabel *titlelabel = [[UILabel alloc]init];
    titlelabel.textColor = [UIColor whiteColor];
    titlelabel.font = FONT(12);
    titlelabel.text = @"告知仓库注意事项:";
    [topView addSubview:titlelabel];
    [titlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(topView).offset(15);
        make.top.equalTo(topView).offset(10);
        make.width.mas_equalTo(110);
        make.height.mas_equalTo(13);
    }];
    
    //注意事项内容
    UILabel *contentLbl = [[UILabel alloc]init];
    contentLbl.textColor = [UIColor whiteColor];
    contentLbl.font = FONT(12);
    contentLbl.numberOfLines = 2;
    contentLbl.text = _model.matter;
    [topView addSubview:contentLbl];
    [contentLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(topView).offset(15);
        make.top.equalTo(titlelabel).offset(3);
        make.width.mas_equalTo(APPWidth -30);
        make.height.mas_equalTo(40);
    }];
    
    return topView;
}

//底部部分
-(UIView *)setupBottomView {
    //底部浮框
    UIView * bottomView = [UIView new];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(50);
    }];
    self.totalNumberLable = [UILabel new];
    [bottomView addSubview:self.totalNumberLable];
    self.totalNumberLable.text = @"总出库数量: 0";
    self.totalNumberLable.textColor = [UIColor colorWithHexString:@"#333333"];
    self.totalNumberLable.font = [UIFont systemFontOfSize:14];
    [self.totalNumberLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomView).offset(15);
        make.top.equalTo(bottomView).offset(10);
    }];
    
    self.totalCountLable = [UILabel new];
    [bottomView addSubview:self.totalCountLable];
    self.totalCountLable.text = @"总条数: 0";
    self.totalCountLable.textColor = [UIColor colorWithHexString:@"#333333"];
    self.totalCountLable.font = [UIFont systemFontOfSize:14];
    [self.totalCountLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomView).offset(15);
        make.top.equalTo(self.totalNumberLable.mas_bottom).offset(2);
    }];
    
    UIButton * determineBtn = [UIButton new];
    [determineBtn addTarget:self action:@selector(determineBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [determineBtn setTitle:@"确 定" forState:UIControlStateNormal];
    determineBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [determineBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [determineBtn setBackgroundColor:[UIColor colorWithHexString:@"#3d9bfa"]];
    [bottomView addSubview:determineBtn];
    [determineBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(bottomView);
        make.width.mas_equalTo(100);
    }];
    return bottomView;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.listModels.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listModels[section].seleted ? self.listModels[section].itemCellData.count :0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    LZOutboundSectionView * sectionView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"LZOutboundSectionView"];
    sectionView.section = section;
    sectionView.foldingBtn.selected = _folding[section];
    sectionView.delegate = self;
    sectionView.model = _listModels[section];
    return sectionView;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    LLOutboundFooterView * footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"LLOutboundFooterView"];
    footerView.selteds = self.rightSeleteds;
    __block NSInteger  totalCount = 0;
    __block NSInteger totalOutCount = 0;
    
    for (LLOutboundRightModel *rightModel in _rightSeleteds) {
        
        for (LLOutboundRightDetailModel *detailModel in rightModel.itemList) {
            
            if (detailModel.seleted) {
                totalCount += [detailModel.inventory integerValue];
                totalOutCount += [detailModel.value integerValue];
            }
            
        }
        
    }
    self.totalNumberLable.text = [NSString stringWithFormat:@"总条数:%@",[@(totalCount)stringValue]] ;
    
    self.totalCountLable.text = [NSString stringWithFormat:@"总出库数量:%@",[@(totalOutCount)stringValue]] ;
    
    return footerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LZOutboundCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LZOutboundCell"];
    cell.itemsModel = self.listModels[indexPath.section].itemCellData[indexPath.row];
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return  _listModels[indexPath.section].seleted  ? 44 : 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return  _listModels[section].seleted  ? 145 : 145-39;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return   _listModels[section].seleted  ? 34 : 0;
}

//先要设Cell可编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
//修改编辑按钮文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}

//设置进入编辑状态时，Cell不会缩进
- (BOOL)tableView: (UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}
//点击删除
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    //在这里实现删除操作
    //删除数据，和删除动画
    
    //删除其实就是将模型的selected设为NO
    for (LLOutboundRightModel *rModel in self.rightSeleteds) {
        
        for (LLOutboundRightDetailModel *dModel in rModel.itemList) {
            if ([dModel isEqual:self.listModels[indexPath.section].itemCellData[indexPath.row]]) {
                dModel.seleted = NO;
            }
        }
        
    }
    
    [self.listModels[indexPath.section].itemCellData removeObjectAtIndex:indexPath.row];
    
    [tableView reloadData];
    __block NSInteger  totalCount = 0;
    __block NSInteger totalOutCount = 0;
    [_rightSeleteds enumerateObjectsUsingBlock:^(LLOutboundRightModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        totalCount += [obj.total integerValue];
        totalOutCount += [obj.outgoingCount integerValue];
    }];
    
    
    self.totalNumberLable.text = [NSString stringWithFormat:@"总条数:%@",[@(totalCount)stringValue]] ;
    
    self.totalCountLable.text = [NSString stringWithFormat:@"总出库数量:%@",[@(totalOutCount)stringValue]] ;
}


-(void)sectionViewDelegate:(LZOutboundSectionView *)sectionView {
    _listModels[sectionView.section].seleted = ! _listModels[sectionView.section].seleted;
    [UIView animateWithDuration:0.0 animations:^{
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:sectionView.section] withRowAnimation:UITableViewRowAnimationNone];
    }];
    
}

#pragma mark -- 保存
-(void)determineBtnClick {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"checkOut==1"];
    
    NSArray <LZOutboundItemListModel*> *filterArray = [_listModels filteredArrayUsingPredicate:predicate];
    NSMutableArray <LZOutboundItemListModel*> *seleteds = [NSMutableArray array];
    for (LZOutboundItemListModel * ItemListModel  in filterArray) {
        if (ItemListModel.itemCellData.count) {
            [seleteds addObject:ItemListModel];
        }
    }
    
    if (!seleteds.count) {
        [LLHudTools showWithMessage:@"请至少选择一个"];
        return;
    }
    NSMutableArray <NSDictionary *> * orderHouseItems = [NSMutableArray array];
    
    /****/
    
    for (LZOutboundItemListModel *itemModel in seleteds) {
        
        for (LLOutboundRightDetailModel *detailModel in itemModel.itemCellData) {
            
            NSDictionary * param = @{
                                     @"productId":itemModel.productId,
                                     @"productColorId":itemModel.productColorId,
                                     @"price":itemModel.price,
                                     @"stock":itemModel.stock,
                                     @"stockId":detailModel.stockId,
                                     @"batchNumber":detailModel.batcNumber,
                                     @"number":detailModel.value,
                                     @"houseId":detailModel.houseId,
                                     @"houseName":detailModel.houseName,
                                     @"needId":itemModel.needId,
                                     @"needTotal":itemModel.number,
                                     @"total":detailModel.total,
                                     };
            [orderHouseItems addObject:param];
            
        }
        
        
        
    }
    
    /****/
    
    
    
    NSDictionary * param = @{
                             @"companyId":[BXSUser currentUser].companyId,
                             @"orderId":self.model.orderId,
                             @"orderHouseItems":[orderHouseItems mj_JSONString],
                             };
    [BXSHttp requestPOSTWithAppURL:@"settle/create_order_house.do" param:param
                           success:^(id response) {
                               LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
                               if ([baseModel.code integerValue]!=200) {
                                   [LLHudTools showWithMessage:baseModel.msg];
                                   return ;
                               }
                               dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                   [self.navigationController popViewControllerAnimated:true];
                               });

                           } failure:^(NSError *error) {
                               
                           }];
}

/// MARK: ---- 懒加载
-(UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
        [_tableView registerClass:[LZOutboundSectionView class] forHeaderFooterViewReuseIdentifier:@"LZOutboundSectionView"];
        [_tableView registerClass:[LZOutboundCell class] forCellReuseIdentifier:@"LZOutboundCell"];
        [_tableView registerClass:[LLOutboundFooterView class] forHeaderFooterViewReuseIdentifier:@"LLOutboundFooterView"];
    }
    return _tableView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
