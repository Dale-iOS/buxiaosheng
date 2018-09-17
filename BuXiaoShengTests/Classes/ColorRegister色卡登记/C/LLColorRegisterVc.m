//
//  LLColorRegisterVc.m
//  BuXiaoSheng
//
//  Created by lanlan on 2018/9/7.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  色卡登记页面

#import "LLColorRegisterVc.h"
#import "TextInputCell.h"
#import "LLColorRegistModel.h"
#import "LLColorRegisterCell.h"
#import "TZImagePickerController.h"
#import "ToolsCollectionVC.h"
@interface LLColorRegisterVc ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate>
@property(nonatomic ,strong)UITableView * tableView;
@property(nonatomic ,strong)UIView * tableHeaderView;
@property(nonatomic ,strong)UIView * tableFooterView;
//备注
@property(nonatomic ,strong)TextInputCell * remakView;

@property(nonatomic ,strong)NSMutableArray<LLColorRegistModel*> * modelDatas;

@property(nonatomic ,assign)NSInteger seletedImageIndex;
@property(nonatomic,strong)ToolsCollectionVC * collectionVC;
@property (nonatomic,copy)NSString * imageUrl;
@property (nonatomic, strong) UIView *ViImage;
@property (nonatomic, strong) UILabel *labImage;
@end

@implementation LLColorRegisterVc

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)setupUI {
    self.title = @"色卡登记";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@""] style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemClick)];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    self.tableView.tableHeaderView = self.tableHeaderView;
    self.tableView.tableFooterView = self.tableFooterView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.modelDatas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LLColorRegisterCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LLColorRegisterCell"];
    cell.itemView.lineView.hidden = true;
    cell.itemView.titleLabel.text = self.modelDatas[indexPath.row].leftStr;
    cell.itemView.contentTF.placeholder = self.modelDatas[indexPath.row].rightPlaceholder;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:true];
}
//先要设Cell可编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
//定义编辑样式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
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
    if (self.modelDatas.count==1) {
        [LLHudTools showWithMessage:@"至少有一个品名"];
        return;
    }
    //删除数据，和删除动画
    [self.modelDatas removeObjectAtIndex:indexPath.row];
    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:indexPath.row inSection:0]] withRowAnimation:UITableViewRowAnimationTop];
    [self.modelDatas enumerateObjectsUsingBlock:^(LLColorRegistModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx==0) {
            obj.leftStr = @"品名";
            obj.rightPlaceholder = @"请输入品名";
        }else {
            obj.leftStr = [NSString stringWithFormat:@"品名%ld",idx];
            obj.rightPlaceholder = [NSString stringWithFormat:@"请输入品名%ld",idx];
        }
      
    }];
    [self.tableView reloadData];
}
/// MARK: ---- 导航右边按钮的点击
-(void)rightBarButtonItemClick {
    
}
/// MARK: ---- 新增一条的点击
-(void)addItemBtnClick {
    //默认进来初始化一条数据
    LLColorRegistModel * model = [LLColorRegistModel new];
    model.leftStr = [NSString stringWithFormat:@"品名%ld",self.modelDatas.count+1];
    model.rightPlaceholder = [NSString stringWithFormat:@"请输入品名%ld",self.modelDatas.count+1];
    [_modelDatas addObject:model];
    [self.tableView reloadData];
}
-(UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 45;
        [_tableView registerClass:[LLColorRegisterCell class] forCellReuseIdentifier:@"LLColorRegisterCell"];
    }
    return _tableView;
}
-(UIView *)tableHeaderView {
    if (!_tableHeaderView) {
        _tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APPWidth, 110)];
        _tableHeaderView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        NSArray * titles = @[@"客户名称",@"手机号码"];
        NSArray * placeholders = @[@"请输入客户名称",@""];
        [titles enumerateObjectsUsingBlock:^(NSString*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            TextInputCell * itemView = [TextInputCell new];
            itemView.backgroundColor = [UIColor whiteColor];
            [self->_tableHeaderView addSubview:itemView];
            itemView.titleLabel.text = obj;
            itemView.contentTF.placeholder = placeholders[idx];
            [itemView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(self->_tableHeaderView);
                make.top.equalTo(self->_tableHeaderView).offset(idx*45 + 10);
                make.height.mas_equalTo(45);
            }];
        }];
    }
    return _tableHeaderView;
}
-(UIView *)tableFooterView {
    if (!_tableFooterView) {
        _tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APPWidth, 305)];
        _tableFooterView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        UIView * addItemView = [UIView new];
        addItemView.backgroundColor = [UIColor whiteColor];
        [_tableFooterView addSubview:addItemView];
        [addItemView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self->_tableFooterView);
            make.height.mas_equalTo(45);
        }];
        UIButton * addItemBtn = [UIButton new];
        [addItemView addSubview:addItemBtn];
        [addItemBtn setBackgroundImage:[UIImage imageNamed:@"addbtn"] forState:UIControlStateNormal];
        [addItemBtn addTarget:self action:@selector(addItemBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [addItemBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(addItemView);
        }];
        //备注
        TextInputCell * remakView = [TextInputCell new];
        self.remakView = remakView;
        remakView.titleLabel.text = @"备注";
        remakView.contentTF.placeholder= @"请输入备注内容";
        remakView.backgroundColor = [UIColor whiteColor];
        [_tableFooterView addSubview:remakView];
        [remakView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self->_tableFooterView);
            make.top.equalTo(addItemView.mas_bottom).offset( 10);
            make.height.mas_equalTo(100);
        }];

		self.ViImage = [[UIView alloc]init];
		self.ViImage.backgroundColor = [UIColor whiteColor];
		[_tableFooterView addSubview:self.ViImage];
		self.ViImage.sd_layout
		.leftSpaceToView(self.tableFooterView, 0)
		.topSpaceToView(self.remakView, 9)
		.widthIs(APPWidth)
		.heightIs(132);//这个高度根据屏幕尺寸去算-->这个高度为 图片的lable和collection高的总和
		//设置图片信息
		[self setupImageView];
    }
    return _tableFooterView;
}
/**
 设置图片
 */
- (void)setupImageView{
	//图片
	self.labImage =[[UILabel alloc]initWithFrame:CGRectMake(10, 0, APPWidth, 28)];
	self.labImage.textColor = CD_Text33;
	self.labImage.font = FONT(14);
	self.labImage.text = @"图片";
	self.labImage.backgroundColor = [UIColor whiteColor];
	[self.ViImage addSubview:self.labImage];

	//Collection
	CGRect tFrame =CGRectMake(0, 28, APPWidth, 104);//这个高度根据屏幕去算的暂时写死
	_collectionVC = [[ToolsCollectionVC alloc]init];
	self.collectionVC.maxCountTF = @"5";//最多选择5张
	_collectionVC.columnNumberTF = @"4";
	_collectionVC.view.frame = tFrame;
	_collectionVC.view.backgroundColor = [UIColor whiteColor];
	[self addChildViewController:_collectionVC];
	[self.ViImage addSubview:_collectionVC.view];
	[_collectionVC didMoveToParentViewController:self];
	[self.collectionVC setupMainCollectionViewWithFrame:CGRectMake(0, 0, APPWidth, 104)];
	[self.collectionVC.view addSubview:self.collectionVC.mainCollectionView];
}
-(NSMutableArray<LLColorRegistModel *> *)modelDatas {
    if (!_modelDatas) {
        _modelDatas = [NSMutableArray array];
        //默认进来初始化一条数据
        LLColorRegistModel * model = [LLColorRegistModel new];
        model.leftStr = @"品名";
        model.rightPlaceholder = @"请输入品名";
        [_modelDatas addObject:model];
    }
    return _modelDatas;
}
@end
