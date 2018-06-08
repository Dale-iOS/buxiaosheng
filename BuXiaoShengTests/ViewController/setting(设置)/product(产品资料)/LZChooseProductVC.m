//
//  LZChooseProductVC.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/6/8.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LZChooseProductVC.h"
#import "ChooseLablesCell.h"
#import "LLFactoryModel.h"

@interface LZChooseProductVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UITextFieldDelegate>
@property(nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic, strong) NSArray <LLFactoryModel *> *labels;
@property(nonatomic,strong)UIButton *nextBtn;//确认按钮
@property(nonatomic,strong)UIView *customView;//自定义View
@property(nonatomic,strong)UITextField *cusTF;//自定义TF
@end

@implementation LZChooseProductVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupData];
    [self setupUI];
}

- (void)setupUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *selectLabel = [[UILabel alloc]init];
    selectLabel.backgroundColor = LZHBackgroundColor;
    selectLabel.text = @"  选择标签";
    selectLabel.textColor = CD_Text99;
    selectLabel.font = FONT(12);
    selectLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:selectLabel];
    [selectLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(34);
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
        make.top.equalTo(selectLabel.mas_bottom);
        make.left.and.right.equalTo(self.view);
        make.bottom.equalTo(_customView.mas_top);
    }];
}

#pragma mark ---- 网络请求 ------
//获取标签聊表
-(void)setupData {
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

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.labels.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ChooseLablesCell *cell = (ChooseLablesCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"ChooseLablesCell" forIndexPath:indexPath];
    cell.model = self.labels[indexPath.row];
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

    LLFactoryModel *model = self.labels[indexPath.row];
    if (self.LabelsArrayBlock) {
        self.LabelsArrayBlock(model.id);
    }
    
}


#pragma mark ---- 点击事件 ----
//添加自定义标签按钮事件
- (void)tapAddCustomClick{
    if (!_cusTF.text) {
        return;
    }
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
        [self setupData];
        _cusTF.text = nil;
    } failure:^(NSError *error) {
        [LLHudTools showWithMessage:@"新增失败"];
    }];
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
