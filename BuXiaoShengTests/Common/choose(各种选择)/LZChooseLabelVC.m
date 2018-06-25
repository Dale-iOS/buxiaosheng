//
//  LZChooseLabelVC.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/6/7.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LZChooseLabelVC.h"
#import "ChooseLablesCell.h"
#import "LLFactoryModel.h"

@interface LZChooseLabelVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UITextFieldDelegate>
@property(nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic, strong) NSArray <LLFactoryModel *> *labels;
@property(nonatomic,strong)UIButton *nextBtn;//确认按钮
@property(nonatomic,strong)UIView *customView;//自定义View
@property(nonatomic,strong)UITextField *cusTF;//自定义TF
@property(nonatomic,strong)UILabel *selectLabel;//顶部文字
@end

@implementation LZChooseLabelVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (_ToSearchWhat == ToSearchGroup) {
        //进来获取的是分组
        [self setupGroupData];
    }else if (_ToSearchWhat == ToSearchLabel) {
        //进来获取的是标签
        [self setupLableData];
    }else if (_ToSearchWhat == ToSearchUnit){
        //进来获取的是单位
        [self setupUnitData];
    }
    
    [self setupUI];
}

- (void)setupUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    _selectLabel = [[UILabel alloc]init];
    _selectLabel.backgroundColor = LZHBackgroundColor;
   
    if (_ToSearchWhat == ToSearchGroup) {
        //进来获取的是分组
        _selectLabel.text = @"  选择分组";
    }else if (_ToSearchWhat == ToSearchLabel) {
        //进来获取的是标签
        _selectLabel.text = @"  选择标签";
    }else if (_ToSearchWhat == ToSearchUnit){
        //进来获取的是单位
        _selectLabel.text = @"  选择单位";
    }
    
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
    self.nextBtn = [UIButton new];
    self.nextBtn.backgroundColor = [UIColor colorWithRed:61.0f/255.0f green:155.0f/255.0f blue:250.0f/255.0f alpha:1.0f];
    [self.nextBtn setTitle:@"确 认" forState:UIControlStateNormal];
    [self.nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.nextBtn addTarget:self action:@selector(nextBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.nextBtn];
    [self.nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.bottom.and.right.equalTo(self.view);
        make.height.mas_offset(44);
    }];
    
    //自定义view
    _customView = [[UIView alloc]init];
    _customView.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
    [self.view addSubview:_customView];
    [_customView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.view);
        make.bottom.equalTo(self.nextBtn.mas_top);
        make.height.mas_offset(70);
    }];
    UILabel *cusLbl = [[UILabel alloc]init];
    cusLbl.textColor = CD_Text99;
    cusLbl.font = FONT(12);
    cusLbl.text = @"自定义";
    [_customView addSubview:cusLbl];
    [cusLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_customView).offset(10);
        make.top.equalTo(_customView).offset(5);
        make.width.mas_offset(40);
        make.height.mas_offset(13);
    }];
    _cusTF = [[UITextField alloc]init];
    _cusTF.delegate = self;
    _cusTF.placeholder = @"  输入自定义选项";
    _cusTF.layer.borderColor = CD_Text99.CGColor;
    _cusTF.layer.borderWidth = 0.5;
    _cusTF.layer.cornerRadius = 5.0f;
    _cusTF.textColor = CD_Text33;
    _cusTF.backgroundColor = [UIColor whiteColor];
    [_customView addSubview:_cusTF];
    [_cusTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cusLbl).offset(20);
        make.left.equalTo(_customView).offset(10);
        make.right.equalTo(_customView).offset(-10);
        make.height.mas_offset(34);
    }];
    //添加按钮的白色底图
    UIView *addView = [[UIView alloc]init];
    addView.backgroundColor = [UIColor clearColor];
    addView.userInteractionEnabled = YES;
    UITapGestureRecognizer *AddCustomTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAddCustomClick)];
    [addView addGestureRecognizer:AddCustomTap];
    [addView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(70);
        make.height.mas_offset(35);
    }];
    UILabel *addLbl = [[UILabel alloc]init];
    addLbl.backgroundColor = [UIColor whiteColor];
    addLbl.text = @"添加";
    addLbl.textAlignment = NSTextAlignmentCenter;
    addLbl.textColor = CD_Text66;
    addLbl.font = FONT(15);
    [addView addSubview:addLbl];
    [addLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.and.centerY.equalTo(addView);
        make.width.mas_offset(31);
        make.height.mas_offset(16);
    }];
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = CD_Text99;
    [addView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(1);
        make.height.mas_offset(15);
        make.centerY.equalTo(addView);
        make.left.equalTo(addView.mas_left);
    }];
    
    _cusTF.rightViewMode = UITextFieldViewModeAlways;
    _cusTF.rightView = addView;
    
    
    UICollectionViewFlowLayout *layoutView = [[UICollectionViewFlowLayout alloc]init];
    layoutView.scrollDirection = UICollectionViewScrollDirectionVertical;
    layoutView.itemSize = CGSizeMake(70, 29);

    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layoutView];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[ChooseLablesCell class] forCellWithReuseIdentifier:@"ChooseLablesCell"];

    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_selectLabel.mas_bottom);
        make.left.and.right.equalTo(self.view);
        make.bottom.equalTo(_customView.mas_top);
    }];
}

#pragma mark ---- 网络请求 ------
//接口名称 组别列表
-(void)setupGroupData {
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId
                             };
    [BXSHttp requestGETWithAppURL:@"product_group/list.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue]!=200) {
            BXS_Alert(baseModel.msg);
            return ;
        }
        self.labels = [LLFactoryModel LLMJParse:baseModel.data];
        [self.collectionView reloadData];
        
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
    }];
}

//获取标签聊表
-(void)setupLableData {
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId
                             };
    [BXSHttp requestGETWithAppURL:@"customer_label/list.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue]!=200) {
            BXS_Alert(baseModel.msg);
            return ;
        }
        self.labels = [LLFactoryModel LLMJParse:baseModel.data];
        [self.collectionView reloadData];
        
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
    }];
}

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
        [self.collectionView reloadData];
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
    }];
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.labels.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ChooseLablesCell *cell = (ChooseLablesCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"ChooseLablesCell" forIndexPath:indexPath];
    cell.model = self.labels[indexPath.row];
//    UIView* selectedBGView = [[UIView alloc] initWithFrame:cell.bounds];
//
//    selectedBGView.backgroundColor = LZAppBlueColor;
//
//    cell.selectedBackgroundView = selectedBGView;
    

    return cell;
}

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

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ChooseLablesCell *cell = (ChooseLablesCell *)[collectionView cellForItemAtIndexPath:indexPath];

    //选中之后的cell变颜色
    [self updateCellStatus:cell selected:YES];
    
    LLFactoryModel *model = self.labels[indexPath.row];
    if (self.LabelsArrayBlock) {
        self.LabelsArrayBlock(model.name);
    }
    
    if (self.LabelsDetailBlock) {
        self.LabelsDetailBlock(model.name, model.id);
    }
    
}


//取消选中操作
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ChooseLablesCell *cell = (ChooseLablesCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [self updateCellStatus:cell selected:NO];
}
// 改变cell的背景颜色
-(void)updateCellStatus:(ChooseLablesCell *)cell selected:(BOOL)selected
{
//    cell.backgroundColor = selected ? [UIColor redColor]:[UIColor greenColor];
    cell.titleLabel.backgroundColor = selected ? LZAppBlueColor : [UIColor colorWithHexString:@"#eeeeee"];
    cell.titleLabel.textColor = selected ? [UIColor whiteColor] : CD_Text99;
}

#pragma mark ---- 点击事件 ----
//添加自定义标签按钮事件
- (void)tapAddCustomClick{
    if (!_cusTF.text) {
        return;
    }
    
    if (_ToSearchWhat == ToSearchGroup) {
        NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
                                 @"name":_cusTF.text
                                 };
        [BXSHttp requestGETWithAppURL:@"product_group/add.do" param:param success:^(id response) {
            LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
            if ([baseModel.code integerValue] != 200) {
                [LLHudTools showWithMessage:baseModel.msg];
                return ;
            }
            [LLHudTools showWithMessage:@"新增成功"];
            self.cusTF.text = @"";
            [self setupGroupData];
        } failure:^(NSError *error) {
            [LLHudTools showWithMessage:@"新增失败"];
        }];
        
    }else if (_ToSearchWhat == ToSearchLabel) {
        NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
                                 @"name":_cusTF.text
                                 };
        [BXSHttp requestGETWithAppURL:@"customer_label/add.do" param:param success:^(id response) {
            LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
            if ([baseModel.code integerValue] != 200) {
                [LLHudTools showWithMessage:baseModel.msg];
                return ;
            }
            [LLHudTools showWithMessage:@"新增成功"];
            self.cusTF.text = @"";
            [self setupLableData];
        } failure:^(NSError *error) {
            [LLHudTools showWithMessage:@"新增失败"];
        }];
    }else if (_ToSearchWhat == ToSearchUnit){
        NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
                                 @"name":_cusTF.text
                                 };
        [BXSHttp requestGETWithAppURL:@"product_unit/add.do" param:param success:^(id response) {
            LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
            if ([baseModel.code integerValue] != 200) {
                [LLHudTools showWithMessage:baseModel.msg];
                return ;
            }
            [LLHudTools showWithMessage:@"新增成功"];
            self.cusTF.text = @"";
            [self setupUnitData];
        } failure:^(NSError *error) {
            [LLHudTools showWithMessage:@"新增失败"];
        }];
    }
}

//底部的确认按钮
- (void)nextBtnClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
