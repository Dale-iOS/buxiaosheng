//
//  BackOrderViewController.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/5/7.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  退单页面

#import "BackOrderViewController.h"
#import "SalesDemandListView.h"
#import "LZHTableView.h"
#import "TextInputCell.h"
#import "TextInputTextView.h"
#import "UITextView+Placeholder.h"
#import "LLBackOrderCotentCell.h"
#import "LLBackOrdeContentModel.h"
#import "salesDemandModel.h"
#import "LZChooseProductVC.h"

@interface BackOrderViewController ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>
@property (strong, nonatomic) UITableView *tableView;

/////销售需求列表View
//@property (nonatomic, strong) SalesDemandListView *demandListView;

///客户名字
@property (nonatomic, strong) TextInputCell *nameCell;
///客户电话
@property (nonatomic, strong) TextInputCell *phoneCell;


///入仓库
@property (nonatomic, strong) TextInputCell *putStorageCell;
///应付金额
@property (nonatomic, strong) TextInputCell *amountPayableCell;
///实收金额
@property (nonatomic, strong) TextInputCell *actualCell;

///预收金额
@property (nonatomic, strong) TextInputCell *amountPaymentCell;
///付款方式
@property (nonatomic, strong) TextInputCell *paymentMethodCell;
///备注
@property (nonatomic, strong) TextInputCell *remarkTextView;

@property (nonatomic,strong) NSMutableArray <LLBackOrdeModel*> * backOrders;


@property (nonatomic,strong) NSArray <productListModel*>* products;

@end

@implementation BackOrderViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];
    [self setupProductData];
}

- (void)setupUI
{
    self.navigationItem.titleView = [Utility navTitleView:@"退单"];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-LLAddHeight);
    }];
}

- (void)setupProductData
{
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
                             };
    [BXSHttp requestGETWithAppURL:@"product/product_list.do" param:param success:^(id response) {
        LLBaseModel *baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            return ;
        }
        self.products = [productListModel LLMJParse:baseModel.data];
        
    } failure:^(NSError *error) {
        
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (!self.backOrders.count) {
        return 1;
    }
    
    if (section ==1) {
        
    }
    
    return  self.backOrders[section].seleted ? self.backOrders.count+1 :1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.backOrders.count == indexPath.row) {
        UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"addbtnCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"addbtnCell"];
            UIButton * addBtn = [UIButton new];
            [addBtn setBackgroundImage:[UIImage imageNamed:@"addbtn"] forState:UIControlStateNormal];
            [cell.contentView addSubview: addBtn];
            [addBtn addTarget:self action:@selector(addBtnClick) forControlEvents:UIControlEventTouchUpInside];
            [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.center.equalTo(cell.contentView);
            }];
        }
        return cell;
    }
    LLBackOrderCotentCell * cell  = [tableView dequeueReusableCellWithIdentifier:@"LLBackOrderCotentCell"];
    cell.dateModels = self.backOrders[indexPath.row].backOrderContents;
    cell.indexPath = indexPath;
    cell.products = self.products;
    WEAKSELF;
    cell.block = ^(LLBackOrderCotentCell *cell) {
        weakSelf.backOrders[cell.indexPath.row].seleted =  ! weakSelf.backOrders[cell.indexPath.row].seleted;
        [weakSelf.tableView reloadData];
    };
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.backOrders.count == indexPath.row) {
        return 50;
    }
    return self.backOrders[indexPath.row].seleted ?  (10 * 60 +(20*3)) : 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.navigationController pushViewController:[LZChooseProductVC new] animated:YES];
}

 /// MARK: ---- 新增一条的点击
-(void)addBtnClick {
    
    LLBackOrdeModel * backOrder = [LLBackOrdeModel new];
    backOrder.seleted = true;
    backOrder.backOrderContents = [self contenDataSource];
    [_backOrders addObject:backOrder];
    [self.tableView reloadData];
}


-(UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [self tableFooterView];
        [self.view addSubview:_tableView];
        [_tableView registerClass:[LLBackOrderCotentCell class] forCellReuseIdentifier:@"LLBackOrderCotentCell"];
        _tableView.tableHeaderView = [self tableHeaderView];
    }
    return _tableView;
}
-(UIView *)tableHeaderView {
    UIView * headerView  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 140)];
    headerView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.nameCell = [[TextInputCell alloc] init];
    self.nameCell.backgroundColor = [UIColor whiteColor];
    [headerView addSubview:self.nameCell];
    self.nameCell.titleLabel.text = @"客户姓名";
    self.nameCell.contentTF.placeholder = @"请输入客户姓名";
    [self.nameCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(headerView);
        make.height.mas_equalTo(60);
        make.top.equalTo(headerView).offset(20);
    }];
    
    self.phoneCell = [[TextInputCell alloc] init];
     self.phoneCell.backgroundColor = [UIColor whiteColor];
    [headerView addSubview:self.phoneCell];
    self.phoneCell.titleLabel.text = @"客户电话";
    self.phoneCell.contentTF.userInteractionEnabled = false;
    [self.phoneCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(headerView);
        make.height.mas_equalTo(60);
        make.top.equalTo(self.nameCell.mas_bottom);
    }];
    return headerView;
}

-(UIView *)tableFooterView {
    UIView * footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 5*60+20+100)];
    footView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    self.putStorageCell = [[TextInputCell alloc] init];
    self.putStorageCell.backgroundColor = [UIColor whiteColor];
    [footView addSubview:self.putStorageCell];
    self.putStorageCell.titleLabel.text = @"入库仓";
    self.putStorageCell.contentTF.placeholder = @"请选择入库仓";
    self.putStorageCell.rightArrowImageVIew.hidden = false;
    self.putStorageCell.contentTF.userInteractionEnabled = false;
    [self.putStorageCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(footView);
        make.height.mas_equalTo(60);
        make.top.equalTo(footView).offset(20);
    }];
    
    
    self.amountPayableCell = [[TextInputCell alloc] init];
    self.amountPayableCell.backgroundColor = [UIColor whiteColor];
    [footView addSubview:self.amountPayableCell];
    self.amountPayableCell.titleLabel.text = @"应付金额";
    self.amountPayableCell.contentTF.text = @"0.0";
    self.amountPayableCell.contentTF.userInteractionEnabled = false;
    [self.amountPayableCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(footView);
        make.height.mas_equalTo(60);
        make.top.equalTo(self.putStorageCell.mas_bottom);
    }];
    
    self.actualCell = [[TextInputCell alloc] init];
    self.actualCell.backgroundColor = [UIColor whiteColor];
    [footView addSubview:self.actualCell];
    self.actualCell.titleLabel.text = @"实付金额";
    self.actualCell.contentTF.placeholder = @"请输入实付金额";
    [self.actualCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(footView);
        make.height.mas_equalTo(60);
        make.top.equalTo(self.amountPayableCell.mas_bottom);
    }];
    
    self.actualCell = [[TextInputCell alloc] init];
    self.actualCell.backgroundColor = [UIColor whiteColor];
    [footView addSubview:self.actualCell];
    self.actualCell.titleLabel.text = @"实付金额";
    self.actualCell.contentTF.placeholder = @"请输入实付金额";
    [self.actualCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(footView);
        make.height.mas_equalTo(60);
        make.top.equalTo(self.amountPayableCell.mas_bottom);
    }];
    
    self.amountPaymentCell = [[TextInputCell alloc] init];
    self.amountPaymentCell.backgroundColor = [UIColor whiteColor];
    [footView addSubview:self.amountPaymentCell];
    self.amountPaymentCell.titleLabel.text = @"预收金额";
    self.amountPaymentCell.contentTF.text = @"0.0";
    [self.amountPaymentCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(footView);
        make.height.mas_equalTo(60);
        make.top.equalTo(self.actualCell.mas_bottom);
    }];
    
    self.paymentMethodCell = [[TextInputCell alloc] init];
    self.paymentMethodCell.backgroundColor = [UIColor whiteColor];
    [footView addSubview:self.paymentMethodCell];
    self.paymentMethodCell.titleLabel.text = @"付款方式";
    self.paymentMethodCell.contentTF.placeholder = @"请选择付款方式";
    self.paymentMethodCell.rightArrowImageVIew.hidden = false;
    self.paymentMethodCell.contentTF.userInteractionEnabled = false;
    [self.paymentMethodCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(footView);
        make.height.mas_equalTo(60);
        make.top.equalTo(self.amountPaymentCell.mas_bottom);
    }];
    
    
    self.remarkTextView = [[TextInputCell alloc] init];
    self.remarkTextView.backgroundColor = [UIColor whiteColor];
    [footView addSubview:self.remarkTextView];
    self.remarkTextView.titleLabel.text = @"备注";
    self.remarkTextView.contentTF.placeholder = @"请输入备注内容";
    [self.remarkTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(footView);
        make.height.mas_equalTo(100);
        make.top.equalTo(self.paymentMethodCell.mas_bottom);
    }];
    
    return footView;
}


-(NSMutableArray<LLBackOrdeModel *> *)backOrders {
    if (!_backOrders) {
        _backOrders = [NSMutableArray array];
    }
    return _backOrders;
}

-(NSMutableArray *)contenDataSource {
       NSMutableArray * _contenDataSource = [NSMutableArray array];
        NSMutableArray * sectionOneModel = [NSMutableArray array];
        for (int i = 0; i< 3; i++) {
            LLBackOrdeContentModel * model = [LLBackOrdeContentModel new];
            switch (i) {
                case 0:
                    model.leftTitle = @"品名";
                    model.rightArrowHidden = false;
                    model.placeholder = @"选择品名";
                    break;
                case 1:
                    model.leftTitle = @"颜色";
                    model.rightArrowHidden = false;
                    model.placeholder = @"选择颜色";
                    break;
                case 2:
                    model.leftTitle = @"入库单位";
                    model.rightArrowHidden = true;
                    model.placeholder = @"";
                    model.content = @"";
                    break;
                default:
                    break;
            }
              [sectionOneModel addObject:model];
        }
        [_contenDataSource addObject:sectionOneModel];
        
         NSMutableArray * sectionTwoModel = [NSMutableArray array];
        for (int i = 0; i< 2; i++) {
            LLBackOrdeContentModel * model = [LLBackOrdeContentModel new];
            switch (i) {
                case 0:
                    model.leftTitle = @"批号";
                    model.rightArrowHidden = true;
                    model.placeholder = @"请输入批号";
                    break;
                case 1:
                    model.leftTitle = @"货架";
                    model.rightArrowHidden = true;
                    model.placeholder = @"请输入货架";
                    break;
                default:
                    break;
            }
            [sectionTwoModel addObject:model];
        }
        [_contenDataSource addObject:sectionTwoModel];
        
        NSMutableArray * sectionThreeModel = [NSMutableArray array];
        for (int i = 0; i< 5; i++) {
            LLBackOrdeContentModel * model = [LLBackOrdeContentModel new];
            switch (i) {
                case 0:
                    model.leftTitle = @"单价";
                    model.rightArrowHidden = true;
                    model.placeholder = @"";
                    model.content = @"0.0";
                    break;
                case 1:
                    model.leftTitle = @"入库数量";
                    model.rightArrowHidden = true;
                    model.placeholder = @"";
                    model.content = @"0.0";
                    break;
                case 2:
                    model.leftTitle = @"入库数量";
                    model.rightArrowHidden = true;
                    model.placeholder = @"";
                    model.content = @"0.0";
                    break;
                case 3:
                    model.leftTitle = @"标签数量";
                    model.rightArrowHidden = true;
                    model.placeholder = @"";
                    model.content = @"0.0";
                    break;
                case 4:
                    model.leftTitle = @"结算数量";
                    model.rightArrowHidden = true;
                    model.placeholder = @"";
                    model.content = @"0.0";
                    break;
                case 5:
                    model.leftTitle = @"本单退款金额";
                    model.rightArrowHidden = true;
                    model.placeholder = @"";
                    model.content = @"0.0";
                    break;
                default:
                    break;
            }
            [sectionThreeModel addObject:model];
        }
        [_contenDataSource addObject:sectionThreeModel];
    return _contenDataSource;
}

@end
