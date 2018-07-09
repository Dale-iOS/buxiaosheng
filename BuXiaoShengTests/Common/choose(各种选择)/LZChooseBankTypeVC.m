//
//  LZChooseBankTypeVC.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/7/3.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LZChooseBankTypeVC.h"
#import "LZChooseBankTypeCell.h"
#import "LZChooseBankTypeModel.h"

@interface LZChooseBankTypeVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UITextFieldDelegate>
{
    UILabel *_selectLabel;
    NSArray *_titleArray;//分组标题头
    NSArray *_Array1;//类型数组
    NSArray *_Array2;//收入支出数组
//    NSMutableArray *_totalMuArray;//总数组
    UIButton *_saveBtn;//确认按钮
    UICollectionView *_collectionView;
    NSMutableArray *_payNameAry;//银行名称数组
    NSMutableArray *_payIdAry;//银行id数组
    NSString *_bankStr;
    NSMutableArray *_totalNameArray;//name总数组
    NSMutableArray *_totalIdArray;//id总数组
}
@property (nonatomic,strong)NSMutableArray <LZChooseBankTypeModel*> *lists;
@end

@implementation LZChooseBankTypeVC
static NSString *ItemIdentifier = @"LZChooseBankTypeCellID";
static NSString *leaveDetailsHeadID = @"leaveDetailsHeadID";
static NSString *leaveDetailsFooterID = @"leaveDetailsFooterID";


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    [self setupPayList];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)setupUI{
    self.view.backgroundColor = [UIColor whiteColor];
    _titleArray = [NSArray arrayWithObjects:@"类型",@"银行",@"收入支出", nil];
    
    _Array1 = [NSArray arrayWithObjects:@"预收款单",@"销售单",@"退货单",@"客户收款单",@"费用单",@"加工商付款单",@"供货商付款单",@"生产商付款单",@"采购入库结算",@"现金银行互转",@"其他收入", nil];
    
    _lists = [NSMutableArray new];
    
//    _totalMuArray = [NSMutableArray arrayWithObjects:_Array1,_Array2, nil];
    _Array2 = [NSArray arrayWithObjects:@"收入",@"支出", nil];
    _selectLabel = [[UILabel alloc]init];
    _selectLabel.backgroundColor = LZHBackgroundColor;
    _selectLabel.text = @"  选择筛选";
    _selectLabel.textColor = CD_Text99;
    _selectLabel.font = FONT(12);
    _selectLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:_selectLabel];
    [_selectLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(44);
        make.height.mas_offset(30);
    }];
    
    //底部确认按钮
    _saveBtn = [UIButton new];
    _saveBtn.backgroundColor = [UIColor colorWithRed:61.0f/255.0f green:155.0f/255.0f blue:250.0f/255.0f alpha:1.0f];
    [_saveBtn setTitle:@"确 认" forState:UIControlStateNormal];
    [_saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_saveBtn addTarget:self action:@selector(nextBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_saveBtn];
    [_saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.bottom.and.right.equalTo(self.view);
        make.height.mas_offset(44);
    }];
    
    UICollectionViewFlowLayout *layoutView = [[UICollectionViewFlowLayout alloc]init];
    layoutView.scrollDirection = UICollectionViewScrollDirectionVertical;
    layoutView.itemSize = CGSizeMake(70, 29);
    layoutView.headerReferenceSize = CGSizeMake(APPWidth *0.75, 40);//每个section的Header宽高
    layoutView.footerReferenceSize = CGSizeMake(APPWidth *0.75, 0.5);//每个section的Footer宽高
    
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layoutView];
    _collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_collectionView];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    
    [_collectionView registerClass:[LZChooseBankTypeCell class] forCellWithReuseIdentifier:ItemIdentifier];
    //注册headview
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:leaveDetailsHeadID];
    //注册footerview
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:leaveDetailsFooterID];
    
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_selectLabel.mas_bottom);
        make.left.and.right.equalTo(self.view);
        make.bottom.equalTo(_saveBtn.mas_top);
    }];
    [self.view addSubview:_collectionView];
}

- (void)setupDataArray{
    _totalNameArray = [NSMutableArray array];
    [_totalNameArray addObjectsFromArray:_Array1];
    [_totalNameArray addObjectsFromArray:_payNameAry];
    [_totalNameArray addObjectsFromArray:_Array2];
    
    _totalIdArray = [NSMutableArray array];
    [_totalIdArray addObjectsFromArray:_Array1];
    [_totalIdArray addObjectsFromArray:_payIdAry];
    [_totalIdArray addObjectsFromArray:_Array2];
    
    for (int i = 0; i < _totalNameArray.count; i++) {
        LZChooseBankTypeModel *model = [LZChooseBankTypeModel new];
        model.name = _totalNameArray[i];
        model.id = _totalIdArray[i];
        model.isSelect = NO;
        [_lists addObject:model];
    }
}

//接口名称 银行列表
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
        [self setupDataArray];
        [_collectionView reloadData];
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
    }];
}

#pragma mark ---- collectionDelegate ----
//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(20, 20, 20, 20);
}

//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 8;
}

//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 15;
}

//有多少个sections
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return _titleArray.count;
}

//每个section 中有多少个items
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (section == 0) {
        return [_Array1 count];
    }else if (section == 1)
    {
        return [_payNameAry count];
    }else if (section == 2)
    {
        return [_Array2 count];
    }
    
    return 0;
}

//section X item X位置处应该显示什么内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    LZChooseBankTypeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ItemIdentifier forIndexPath:indexPath];
    if (_lists.count >0) {
        cell.model = _lists[indexPath.row];
    }
    
    
//    //自定义cell
//    ChooseLablesCell *cell=nil;
//
//    if (cell==nil) {
//        cell = [collectionView dequeueReusableCellWithReuseIdentifier:ItemIdentifier forIndexPath:indexPath];
//    }
//    cell.contentView.backgroundColor = [UIColor whiteColor];
//
//    if (indexPath.section == 0) {
//        cell.titleLabel.text = _Array1[indexPath.row];
//    }else if (indexPath.section == 1){
//        cell.titleLabel.text = _payNameAry[indexPath.row];
//    }else if (indexPath.section == 2){
//        cell.titleLabel.text = _Array2[indexPath.row];
//    }
    return cell;
}

//cell的header与footer的显示内容
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if (kind == UICollectionElementKindSectionHeader)
    {
        UICollectionReusableView *reusableHeaderView = nil;
        
        if (reusableHeaderView==nil) {
            
            reusableHeaderView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader  withReuseIdentifier:leaveDetailsHeadID forIndexPath:indexPath];
            reusableHeaderView.backgroundColor = [UIColor whiteColor];
            
            //这部分一定要这样写 ，否则会重影，不然就自定义headview
            UILabel *label = (UILabel *)[reusableHeaderView viewWithTag:100];
            if (!label) {
                label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.view.frame.size.width, 40)];
                label.tag = 100;
                label.textColor = CD_Text99;
                label.font = FONT(12);
                label.textAlignment = NSTextAlignmentLeft;
                [reusableHeaderView addSubview:label];
            }
            
            label.text = _titleArray[indexPath.section];
        }
        return reusableHeaderView;
        
    }else if (kind == UICollectionElementKindSectionFooter){
        
        UICollectionReusableView *reusableFooterView = nil;
        
        if (reusableFooterView == nil) {
            
            reusableFooterView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter  withReuseIdentifier:leaveDetailsFooterID forIndexPath:indexPath];
            reusableFooterView.backgroundColor = LZHBackgroundColor;
        }
        return reusableFooterView;
    }
    return nil;
}
//点击cell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    LZChooseBankTypeModel *model = _lists[indexPath.row];
    model.isSelect = !model.isSelect;
    [_collectionView reloadData];
}


#pragma mark ---- 点击事件 ----
- (void)nextBtnClick{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
