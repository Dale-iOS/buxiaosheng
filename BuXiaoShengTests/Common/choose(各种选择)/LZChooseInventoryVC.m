//
//  LZChooseInventoryVC.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/7/4.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LZChooseInventoryVC.h"
#import "LLFactoryModel.h"
#import "LZChooseBankTypeModel.h"
#import "LZChooseBankTypeCell.h"

@interface LZChooseInventoryVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UITextFieldDelegate>
{
    UILabel *_selectLabel;
    NSArray *_titleArray;//分组标题头
    NSArray *_Array1;//类型数组
//    NSMutableArray *_totalMuArray;//总数组
    UIButton *_saveBtn;//确认按钮
    UICollectionView *_collectionView;
    
    NSMutableArray *_unitNameAry;//单位
    NSMutableArray *_unitIdAry;//单位

}
@property (nonatomic,strong)NSMutableArray <LZChooseBankTypeModel*> *lists1;
@property (nonatomic,strong)NSMutableArray <LZChooseBankTypeModel*> *lists2;
@property (nonatomic, strong) NSArray <LLFactoryModel *> *labels;

@end

@implementation LZChooseInventoryVC
static NSString *ItemIdentifier = @"LZChooseBankTypeCellID";
static NSString *leaveDetailsHeadID = @"leaveDetailsHeadID";
static NSString *leaveDetailsFooterID = @"leaveDetailsFooterID";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self setupUnitData];
}

- (void)setupUI{
    self.view.backgroundColor = [UIColor whiteColor];
    _titleArray = [NSArray arrayWithObjects:@"数量排序",@"单位", nil];
    _Array1 = [NSArray arrayWithObjects:@"从多到少",@"从少到多", nil];
    
    _lists1 = [NSMutableArray new];
    _lists2 = [NSMutableArray new];
    
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
    //一定要注册headview
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:leaveDetailsHeadID];
    //一定要注册footerview
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:leaveDetailsFooterID];
    
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_selectLabel.mas_bottom);
        make.left.and.right.equalTo(self.view);
        make.bottom.equalTo(_saveBtn.mas_top);
    }];
    [self.view addSubview:_collectionView];
}

- (void)setupDataArray{
    
    //拼接类型模型
    for (int i = 0; i < _Array1.count; i++) {
        LZChooseBankTypeModel *model = [LZChooseBankTypeModel new];
        model.name = _Array1[i];
        model.id = [NSString stringWithFormat:@"%d",i];
        model.isSelect = NO;
        [_lists1 addObject:model];
    }
    
    //拼接银行模型
    for (int i = 0; i < _unitNameAry.count; i++) {
        LZChooseBankTypeModel *model = [LZChooseBankTypeModel new];
        model.name = _unitNameAry[i];
        model.id = _unitIdAry[i];
        model.isSelect = NO;
        [_lists2 addObject:model];
    }
}

#pragma mark ---- 网络请求 ----
//接口名称 单位列表
- (void)setupUnitData{
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId};
    [BXSHttp requestGETWithAppURL:@"product_unit/list.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
        self.labels = [LLFactoryModel LLMJParse:baseModel.data];
        _unitNameAry = [NSMutableArray array];
        _unitIdAry = [NSMutableArray array];
        NSMutableArray *tempAry = baseModel.data;
        for (int i = 0; i < self.labels.count; i++) {
            [_unitNameAry addObject:tempAry[i][@"name"]];
            [_unitIdAry addObject:tempAry[i][@"id"]];
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
        return [_unitNameAry count];
    }
    
    return 0;
}

//section X item X位置处应该显示什么内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //自定义cell
    LZChooseBankTypeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ItemIdentifier forIndexPath:indexPath];;
    
    cell.contentView.backgroundColor = [UIColor whiteColor];

    if (_lists2.count >0) {
        switch (indexPath.section) {
            case 0:
                cell.model = _lists1[indexPath.row];
                break;
            case 1:
                cell.model = _lists2[indexPath.row];
                break;
            default:
                break;
        }
    }
    
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

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    LZChooseBankTypeModel *model = [[LZChooseBankTypeModel alloc]init];;
    
    switch (indexPath.section) {
        case 0:
            model = _lists1[indexPath.row];
            
            [_lists1 enumerateObjectsUsingBlock:^(LZChooseBankTypeModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                obj.isSelect = NO;
            }];
            
            model.isSelect = !model.isSelect;
            
            break;
        case 1:
            
            model = _lists2[indexPath.row];
            
            [_lists2 enumerateObjectsUsingBlock:^(LZChooseBankTypeModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                obj.isSelect = NO;
            }];
            model.isSelect = !model.isSelect;
            
            break;
        default:
            break;
    }
    [_collectionView reloadData];
}

#pragma mark ---- 点击事件 ----
- (void)nextBtnClick{
    LZChooseBankTypeModel *model1 = [[LZChooseBankTypeModel alloc]init];
    LZChooseBankTypeModel *model2 = [[LZChooseBankTypeModel alloc]init];
    
    //过滤出已选中的
    NSPredicate *predicate1 = [NSPredicate predicateWithFormat:@"isSelect == 1"];
    NSArray *arrar1 = [_lists1 filteredArrayUsingPredicate:predicate1];
    NSPredicate *predicate2 = [NSPredicate predicateWithFormat:@"isSelect == 1"];
    NSArray *arrar2 = [_lists2 filteredArrayUsingPredicate:predicate2];
    
    if (arrar1.count >0) {
        model1 = [LZChooseBankTypeModel LLMJParse:arrar1[0]];
    }
    if (arrar2.count >0) {
        model2 = [LZChooseBankTypeModel LLMJParse:arrar2[0]];
    }
    
    if (self.selectIDBlock) {
        self.selectIDBlock(model1.name, model2.id);
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
