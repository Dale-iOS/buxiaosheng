//
//  LZPurchaseAskVC.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/6/19.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  采购询问页面

#import "LZPurchaseAskVC.h"
#import "LZPurchaseDetailModel.h"
#import "LZPurchaseAskCell.h"
#import "TextInputCell.h"
#import "UITextView+Placeholder.h"
#import "TextInputTextView.h"
#import "BRPickerView.h"
#import "NSDate+BRPickerView.h"

@interface LZPurchaseAskVC ()<UICollectionViewDataSource,UICollectionViewDelegate>
{
    NSString *_dateStr;
}
@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)LZPurchaseDetailModel *model;
@property(nonatomic,strong)NSArray <LZPurchaseDetailItemListModel*> *lists;
@property(nonatomic,strong)UIView *headerView;
@property(nonatomic,strong)UIView *footerView;
@property(nonatomic,strong)UILabel *nameLbl;//品名
///供货商
@property (nonatomic, strong) TextInputCell *supplierCell;
///联系人
@property (nonatomic, strong) TextInputCell *contactsCell;
///电话
@property (nonatomic, strong) TextInputCell *phoneCell;
///地址
@property (nonatomic, strong) TextInputCell *addressCell;
///预计到货数量
@property (nonatomic, strong) TextInputCell *estimateNumCell;
///预计到货日期
@property (nonatomic, strong) TextInputCell *estimateDateCell;
///备注
@property (nonatomic, strong) TextInputTextView *remarkTextView;
@property(nonatomic,strong)UIButton *saveBtn;//确认按钮
@end

@implementation LZPurchaseAskVC
@synthesize footerView,headerView,nameLbl,supplierCell,contactsCell,phoneCell,addressCell,estimateNumCell,estimateDateCell,remarkTextView;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setupData];
}

- (void)setupUI{
    self.navigationItem.titleView = [Utility navTitleView:@"采购询问"];
    [self.view addSubview:self.collectionView];
    self.view.backgroundColor = LZHBackgroundColor;
    
    _saveBtn = [[UIButton alloc]init];
    [_saveBtn setBackgroundColor:LZAppBlueColor];
    [_saveBtn setTitle:@"确 认" forState:UIControlStateNormal];
    _saveBtn.titleLabel.font = FONT(15);
    _saveBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [_saveBtn addTarget:self action:@selector(saveBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_saveBtn];
    [_saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.bottom.and.right.equalTo(self.view);
        make.height.mas_offset(50);
    }];
}

//设置头部试图
- (UIView *)headerView{
    if (headerView == nil) {
        headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 30)];
        headerView.backgroundColor = [UIColor redColor];
        
        nameLbl = [[UILabel alloc]init];
        nameLbl.textColor = CD_Text33;
        nameLbl.font = FONT(14);
        nameLbl.backgroundColor = [UIColor whiteColor];
        nameLbl.text = @"    品名：";
        [headerView addSubview:nameLbl];
        [nameLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.top.right.equalTo(headerView);
            make.height.mas_offset(45);
        }];
        
        UIView *bottomView = [[UIView alloc]init];
        bottomView.backgroundColor = [UIColor colorWithHexString:@"#f9f9f9"];
        [headerView addSubview:bottomView];
        [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_offset(35);
            make.top.equalTo(nameLbl.mas_bottom);
            make.left.and.right.equalTo(headerView);
        }];
        
        UILabel *leftColorLbl = [[UILabel alloc]init];
        leftColorLbl.textColor = CD_Text33;
        leftColorLbl.font = FONT(13);
        leftColorLbl.textAlignment = NSTextAlignmentCenter;
        leftColorLbl.text = @"颜色";
        [bottomView addSubview:leftColorLbl];
        [leftColorLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.top.and.bottom.equalTo(bottomView);
            make.width.mas_offset(APPWidth *0.25);
        }];
        
        UILabel *leftNeedLbl = [[UILabel alloc]init];
        leftNeedLbl.textColor = CD_Text33;
        leftNeedLbl.font = FONT(13);
        leftNeedLbl.textAlignment = NSTextAlignmentCenter;
        leftNeedLbl.text = @"需求量";
        [bottomView addSubview:leftNeedLbl];
        [leftNeedLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.and.bottom.equalTo(bottomView);
            make.left.equalTo(leftColorLbl.mas_right);
            make.width.mas_offset(APPWidth *0.25);
        }];
        
        UILabel *rightColorLbl = [[UILabel alloc]init];
        rightColorLbl.textColor = CD_Text33;
        rightColorLbl.font = FONT(13);
        rightColorLbl.textAlignment = NSTextAlignmentCenter;
        rightColorLbl.text = @"颜色";
        [bottomView addSubview:rightColorLbl];
        [rightColorLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.and.bottom.equalTo(bottomView);
            make.left.equalTo(leftNeedLbl.mas_right);
            make.width.mas_offset(APPWidth *0.25);
        }];
        
        UILabel *rightNeedLbl = [[UILabel alloc]init];
        rightNeedLbl.textColor = CD_Text33;
        rightNeedLbl.font = FONT(13);
        rightNeedLbl.textAlignment = NSTextAlignmentCenter;
        rightNeedLbl.text = @"需求量";
        [bottomView addSubview:rightNeedLbl];
        [rightNeedLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.and.bottom.equalTo(bottomView);
            make.left.equalTo(rightColorLbl.mas_right);
            make.width.mas_offset(APPWidth *0.25);
        }];

    }
    return headerView;
}

//设置尾部试图
- (UIView *)footerView{
    if (footerView == nil) {
        footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 412)];
        footerView.backgroundColor = [UIColor whiteColor];
        
        UIView *view0 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 10)];
        view0.backgroundColor = LZHBackgroundColor;
        [footerView addSubview:view0];

        supplierCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, view0.bottom, APPWidth, 49)];
        supplierCell.titleLabel.text = @"供货商名称";
        supplierCell.contentTF.placeholder = @"请输入供货商名称";
        supplierCell.contentTF.enabled = NO;
        [footerView addSubview:supplierCell];

        contactsCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, supplierCell.bottom, APPWidth, 49)];
        contactsCell.titleLabel.text = @"联系人";
        contactsCell.contentTF.placeholder = @"请输入联系人";
        contactsCell.contentTF.enabled = NO;
        [footerView addSubview:contactsCell];

        phoneCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, contactsCell.bottom, APPWidth, 49)];
        phoneCell.titleLabel.text = @"电话";
        phoneCell.contentTF.placeholder = @"请输入电话号码";
        phoneCell.contentTF.enabled = NO;
        [footerView addSubview:phoneCell];

        addressCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, phoneCell.bottom, APPWidth, 49)];
        addressCell.titleLabel.text = @"地址";
        addressCell.contentTF.placeholder = @"请输入地址";
        addressCell.contentTF.enabled = NO;
        [footerView addSubview:addressCell];

        UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0, addressCell.bottom, APPWidth, 10)];
        view1.backgroundColor = LZHBackgroundColor;
        [footerView addSubview:view1];

        estimateNumCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, view1.bottom, APPWidth, 49)];
        estimateNumCell.titleLabel.text = @"预计到货数量";
        estimateNumCell.contentTF.placeholder = @"请输入预计到货数量";
        [footerView addSubview:estimateNumCell];

        estimateDateCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, estimateNumCell.bottom, APPWidth, 49)];
        estimateDateCell.titleLabel.text = @"预计到货日期";
        estimateDateCell.contentTF.placeholder = @"请输入预计到货日期";
        estimateDateCell.contentTF.enabled = NO;
        UITapGestureRecognizer *dateTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dateTapClickAciton)];
        [estimateDateCell addGestureRecognizer:dateTap];
        [footerView addSubview:estimateDateCell];

        remarkTextView = [[TextInputTextView alloc]init];
        remarkTextView.frame = CGRectMake(0, estimateDateCell.bottom, APPWidth, 98);
        remarkTextView.titleLabel.text = @"备注";
        remarkTextView.textView.placeholder = @"请输入备注内容";
        [footerView addSubview:remarkTextView];
        
    }
    return footerView;
}

//初始化collectionView
- (UICollectionView *)collectionView{
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];

        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, APPHeight-50) collectionViewLayout:flowLayout];
        //定义每个UICollectionView 的大小
        flowLayout.itemSize = CGSizeMake(APPWidth *0.5, 44);
        //定义每个UICollectionView 横向的间距
        flowLayout.minimumLineSpacing = 0;
        //定义每个UICollectionView 纵向的间距
        flowLayout.minimumInteritemSpacing = 0;
        //定义每个UICollectionView 的边距距
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);//上左下右
        //定义头部高度
        flowLayout.headerReferenceSize = CGSizeMake(APPWidth, 80);
        //定义尾部高度
        flowLayout.footerReferenceSize = CGSizeMake(APPWidth, 403);

        //注册cell和ReusableView
        [_collectionView registerClass:[LZPurchaseAskCell class] forCellWithReuseIdentifier:@"LZPurchaseAskCellId"];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionElementKindSectionHeaderId"];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"UICollectionElementKindSectionFooterId"];
        
        
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        //自适应大小
        _collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _collectionView.backgroundColor = [UIColor whiteColor];
    }
    return _collectionView;
}

#pragma mark ---- 网络请求 ----
- (void)setupData{
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
                             @"buyId":self.bugId};
    [BXSHttp requestGETWithAppURL:@"documentary/not_handle_detail.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
        _model = [LZPurchaseDetailModel LLMJParse:baseModel.data];
        _lists = _model.itemList;
        
        //赋值
        nameLbl.text = [NSString stringWithFormat:@"    品名：%@",_model.productName];
        supplierCell.contentTF.text = _model.factoryName;
        contactsCell.contentTF.text = _model.contactName;
        phoneCell.contentTF.text = _model.mobile;
        addressCell.contentTF.text = _model.address;
        
        [_collectionView reloadData];
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
    }];
}

#pragma mark ---- UICollectionView delegate ----
// 定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _lists.count;
}

// 定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"LZPurchaseAskCellId";
    LZPurchaseAskCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    [cell sizeToFit];
    cell.model = _lists[indexPath.row];
    //按钮事件就不实现了……
    return cell;
}

//头部、尾部显示的内容
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if([kind isEqualToString:UICollectionElementKindSectionHeader])
    {
        UICollectionReusableView *headerView = [_collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"UICollectionElementKindSectionHeaderId" forIndexPath:indexPath];
        headerView.backgroundColor = [UIColor whiteColor];
        [headerView addSubview:self.headerView];
        
        return headerView;
    }
    else if([kind isEqualToString:UICollectionElementKindSectionFooter])
    {
        UICollectionReusableView *footerView = [_collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"UICollectionElementKindSectionFooterId" forIndexPath:indexPath];
        footerView.backgroundColor = [UIColor whiteColor];
        [footerView addSubview:self.footerView];

        return footerView;
    }
    
    return nil;
}

// UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"选择%ld",indexPath.item);
}

#pragma mark ---- 点击事件 ----
//确认按钮事件
- (void)saveBtnClick{
//    接口名称 更新采购进度信息
    if ([BXSTools stringIsNullOrEmpty:self.estimateNumCell.contentTF.text]) {
        BXS_Alert(@"请输入预计到货数量");
        return;
    }
    if ([BXSTools stringIsNullOrEmpty:self.estimateDateCell.contentTF.text]) {
        BXS_Alert(@"请输入预计到货日期");
        return;
    }
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
                             @"buyId":self.bugId,
                             @"arrivalTime":_dateStr,
                             @"number":self.estimateNumCell.contentTF.text,
                             @"remark":self.remarkTextView.textView.text
                             };
    [BXSHttp requestGETWithAppURL:@"documentary/insert_speed.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
        [LLHudTools showWithMessage:@"提交成功"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:true];
        });
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
    }];

}

//选择日期
- (void)dateTapClickAciton{
    NSDate *minDate = [NSDate br_setYear:1990 month:3 day:12];
    //            NSDate *maxDate = [NSDate date];
    NSDate *maxDate = [NSDate br_setYear:2050 month:1 day:1];
    [BRDatePickerView showDatePickerWithTitle:@"选择到货时间" dateType:BRDatePickerModeYMD defaultSelValue:self.estimateDateCell.contentTF.text minDate:minDate maxDate:maxDate isAutoSelect:YES themeColor:nil resultBlock:^(NSString *selectValue) {
        self.estimateDateCell.contentTF.text =  selectValue;
        _dateStr = [selectValue stringByReplacingOccurrencesOfString:@"-" withString:@""];
    } cancelBlock:^{
        NSLog(@"点击了背景或取消按钮");
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
