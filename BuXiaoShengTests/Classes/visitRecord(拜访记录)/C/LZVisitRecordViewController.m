//
//  LZVisitRecordViewController.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/7/2.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  拜访记录页面

#import "LZVisitRecordViewController.h"
#import "LZHTableView.h"
#import "TextInputCell.h"
#import "TextInputTextView.h"
#import "UITextView+Placeholder.h"
#import "LZVisitRecordListVC.h"
#import "LZPickerView.h"
#import "UITextField+PopOver.h"
#import "ToolsCollectionVC.h"
@interface LZVisitRecordViewController ()<LZHTableViewDelegate,UITextViewDelegate,UIActionSheetDelegate,UIAlertViewDelegate,UINavigationControllerDelegate,UITextFieldDelegate>
{
    NSMutableArray *_selectedPhotos;
    NSMutableArray *_selectedAssets;
    BOOL _isSelectOriginalPhoto;
    
    CGFloat _itemWH;
    CGFloat _margin;
    
//    NSString *_imageStr;
}
@property(nonatomic,copy)NSString *imageStr;
@property (weak, nonatomic) LZHTableView *mainTabelView;
@property (strong, nonatomic) NSMutableArray *datasource;
///拜访对象
@property (nonatomic, strong) TextInputCell *objectCell;
///拜访方式
@property (nonatomic, strong) TextInputCell *wayCell;
///主要事宜
@property (nonatomic, strong) TextInputCell *mainCell;
///拜访结果
@property (nonatomic, strong) TextInputTextView *resultView;
///备注
@property (nonatomic, strong) TextInputTextView *remarkView;
///上传图片的标题
@property(nonatomic,strong) UILabel *textLbl;
///提交按钮
@property (nonatomic, strong) UIButton *commitBtn;
@property(nonatomic,strong)NSArray *typeAry;
@property(nonatomic,strong)NSString *typeStr;

//客户数组
@property(nonatomic,strong)NSMutableArray *customerList;
@property(nonatomic,strong)NSMutableArray *customerNameAry;
@property(nonatomic,strong)NSMutableArray *customerPhoneAry;
@property(nonatomic,strong)NSMutableArray *customerIdAry;
@property(nonatomic,strong)ToolsCollectionVC * collectionVC;
@end

@implementation LZVisitRecordViewController
@synthesize mainTabelView;

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];
    
    [self setupCustomerList];
}

- (void)setupUI{
    
    self.navigationItem.titleView = [Utility navTitleView:@"拜访记录"];
    self.navigationItem.rightBarButtonItem = [Utility navButton:self action:@selector(screenClick) image:IMAGE(@"new_lists")];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //数据初始化
    _selectedPhotos = [NSMutableArray array];
    _selectedAssets = [NSMutableArray array];
    _typeAry = [NSArray arrayWithObjects:@"当面拜访",@"电话拜访",@"聊天软件拜访",@"其他方式拜访",nil];
    

    self.datasource = [NSMutableArray array];
    self.mainTabelView.delegate = self;
    [self.view addSubview:self.mainTabelView];
    
    [self setSectionOne];
    [self setSectionTwo];
    [self setSectionThree];
    
    self.mainTabelView.dataSoure = self.datasource;
    
    self.commitBtn = [UIButton new];
    self.commitBtn.frame = CGRectMake(0, APPHeight -45, APPWidth, 45);
    self.commitBtn.backgroundColor = [UIColor colorWithRed:61.0f/255.0f green:155.0f/255.0f blue:250.0f/255.0f alpha:1.0f];
    [self.commitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [self.commitBtn addTarget:self action:@selector(commitBtnOnClickAction) forControlEvents:UIControlEventTouchUpInside];
    self.commitBtn.titleLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:self.commitBtn];
}

- (LZHTableView *)mainTabelView
{
    if (!mainTabelView) {
        
         LZHTableView *tableView = [[LZHTableView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, APPHeight)];
        tableView.tableView.allowsSelection = YES;
        tableView.backgroundColor = LZHBackgroundColor;
        [self.view addSubview:(mainTabelView = tableView)];
    }
    return mainTabelView;
}

- (void)setSectionOne
{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 10)];
    headerView.backgroundColor = LZHBackgroundColor;
    
    //拜访对象
    _objectCell = [[TextInputCell alloc]init];
    _objectCell.frame = CGRectMake(0, 0, APPWidth, 50);
    _objectCell.userInteractionEnabled = YES;
    _objectCell.titleLabel.text = @"拜访对象";
    _objectCell.contentTF.placeholder = @"请输入拜访对象";
    
    
    //拜访记录
    _wayCell = [[TextInputCell alloc]init];
    _wayCell.frame = CGRectMake(0, 0, APPWidth, 50);
    _wayCell.userInteractionEnabled = YES;
    _wayCell.rightArrowImageVIew.hidden = NO;
    _wayCell.titleLabel.text = @"拜访方式";
    _wayCell.contentTF.placeholder = @"请选择拜访方式";
    _wayCell.contentTF.enabled = NO;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapWayClick)];
    [_wayCell addGestureRecognizer:tap];
    
    //主要事宜
    _mainCell = [[TextInputCell alloc]init];
    _mainCell.frame = CGRectMake(0, 0, APPWidth, 50);
    _mainCell.userInteractionEnabled = YES;
    _mainCell.titleLabel.text = @"主要事宜";
    _mainCell.contentTF.placeholder = @"请输入主要事宜";
    
    //拜访结果
    _resultView = [[TextInputTextView alloc]init];
    _resultView.frame = CGRectMake(0, 0, APPWidth, 80);
    //    self.resultView.userInteractionEnabled = YES;
    _resultView.textView.delegate = self;
    _resultView.titleLabel.text = @"拜访结果";
    _resultView.textView.placeholder = @"请输入拜访结果";
    
    
    LZHTableViewItem *item = [[LZHTableViewItem alloc]init];
    item.sectionRows = @[_objectCell,_wayCell,_mainCell,_resultView];
    item.canSelected = NO;
    item.sectionView = headerView;
    [self.datasource addObject:item];
    
}

- (void)setSectionTwo{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 10)];
    headerView.backgroundColor = LZHBackgroundColor;
    
    _remarkView = [[TextInputTextView alloc]init];
    _remarkView.frame = CGRectMake(0, 0, APPWidth, 80);
    _remarkView.textView.delegate = self;
    
    _remarkView.titleLabel.text = @"备注";
    _remarkView.textView.placeholder = @"请输入告知仓库事项";
    
    LZHTableViewItem *item = [[LZHTableViewItem alloc]init];
    item.sectionRows = @[_remarkView];
    item.canSelected = NO;
    item.sectionView = headerView;
    [self.datasource addObject:item];
}

- (void)setSectionThree{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 10)];
    headerView.backgroundColor = LZHBackgroundColor;
    
	UILabel *textLbl = [[UILabel alloc]initWithFrame:CGRectMake(15, 5, APPWidth -15*2, 28)];
	textLbl.textColor = CD_Text33;
	textLbl.font = FONT(14);
	textLbl.text = @"图片";
	CGFloat tHight = 104;//这个高度动态设置,根据每个屏幕的大小去设置
	[self.collectionVC setupMainCollectionViewWithFrame:CGRectMake(0, 0, APPWidth, tHight)];
	LZHTableViewItem *item = [[LZHTableViewItem alloc]init];
	item.sectionRows = @[textLbl,self.collectionVC.mainCollectionView];
	item.canSelected = NO;
	item.sectionView = headerView;
	[self.datasource addObject:item];
}

//跳转到拜访记录列表
- (void)screenClick{
    LZVisitRecordListVC *vc = [[LZVisitRecordListVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)tapWayClick{
	[self.view endEditing:YES];
    LZPickerView *pickerView =[[LZPickerView alloc] initWithComponentDataArray:_typeAry titleDataArray:nil];
    WEAKSELF
    pickerView.getPickerValue = ^(NSString *compoentString, NSString *titileString) {
        NSInteger row = [titileString integerValue];
        self.wayCell.contentTF.text = compoentString;
        weakSelf.typeStr = [NSString stringWithFormat:@"%zd",row];
    };
    
    [self.view addSubview:pickerView];
}


#pragma mark ---- 网络请求 ----
//功能用到客户列表
- (void)setupCustomerList{
	WEAKSELF
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId};
    [BXSHttp requestGETWithAppURL:@"customer/customer_list.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
        weakSelf.customerList = baseModel.data;
        weakSelf.customerNameAry = [NSMutableArray array];
        weakSelf.customerIdAry = [NSMutableArray array];
        weakSelf.customerPhoneAry = [NSMutableArray array];
        for (int i = 0 ; i <weakSelf.customerList.count; i++) {
            [weakSelf.customerNameAry addObject:weakSelf.customerList[i][@"name"]];
            [weakSelf.customerIdAry addObject:weakSelf.customerList[i][@"id"]];
            [weakSelf.customerPhoneAry addObject:weakSelf.customerList[i][@"mobile"]];
        }
        self.objectCell.contentTF.delegate = self;
        self.objectCell.contentTF.scrollView = (UIScrollView *)self.view;
        self.objectCell.contentTF.positionType = ZJPositionBottomThree;
        [self.objectCell.contentTF popOverSource:weakSelf.customerNameAry index:^(NSInteger index) {
		weakSelf.objectCell.contentTF.text = weakSelf.customerNameAry[index];
//            _customerIdStr = _customerIdAry[index];
        }];
        
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
    }];
}
//
////接口名称 图片上传
//- (void)uploadPhotos:(NSArray *)selectArray{
//    [LLHudTools showLoadingMessage:@"图片上传中~"];
//    NSDictionary * param = @{@"file":@"0"};
//	WEAKSELF
//    [BXSHttp requestPOSTPhotosWithArray:selectArray param:param AppURL:@"file/imageUpload.do" Key:@"file" success:^(id response) {
//        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
//        if ([baseModel.code integerValue] != 200) {
//            [LLHudTools showWithMessage:baseModel.msg];
//            return ;
//        }
//        NSDictionary *tempDic = baseModel.data;
//        weakSelf.imageStr = tempDic[@"path"];
//        [LLHudTools dismiss];
//    } failure:^(NSError *error) {
//        NSLog(@"%@",error);
//    }];
//}

//接口名称 添加拜访记录
//提交点击按钮
- (void)commitBtnOnClickAction
{
    if ([BXSTools stringIsNullOrEmpty:self.objectCell.contentTF.text]) {
        BXS_Alert(@"请输入拜访对象名称");
        return;
    }
    if ([BXSTools stringIsNullOrEmpty:self.mainCell.contentTF.text]) {
        BXS_Alert(@"请输入主要事宜");
        return;
    }
    if ([BXSTools stringIsNullOrEmpty:self.resultView.textView.text]) {
        BXS_Alert(@"请输入拜访结果");
        return;
    }
	WEAKSELF
	[self.collectionVC uploadDatePhotosWithUrlStr:^(NSString *urlStr) {
		weakSelf.imageStr =urlStr;
		[weakSelf requestComment];
	}];
}
- (void)requestComment{
	WEAKSELF
	NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
							 @"img":weakSelf.imageStr,
							 @"matters":self.mainCell.contentTF.text,
							 @"name":self.objectCell.contentTF.text,
							 @"remark":self.remarkView.textView.text,
							 @"result":self.resultView.textView.text,
							 @"type":_typeStr
							 };
	[BXSHttp requestGETWithAppURL:@"record/add.do" param:param success:^(id response) {
		LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
		[LLHudTools showWithMessage:baseModel.msg];
		if ([baseModel.code integerValue] != 200) {
			return ;
		}
		dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
			[self.navigationController popViewControllerAnimated:true];
		});
	} failure:^(NSError *error) {
		BXS_Alert(LLLoadErrorMessage);
	}];

}
- (ToolsCollectionVC *)collectionVC{
	if (!_collectionVC) {
		_collectionVC = [[ToolsCollectionVC alloc]init];
		self.collectionVC.maxCountTF = @"1";//最多选择5张
		_collectionVC.columnNumberTF = @"4";
		_collectionVC.view.frame = CGRectMake(0, 0, 0, 0);
		[self addChildViewController:_collectionVC];
		[self.view addSubview:_collectionVC.view];
		[_collectionVC didMoveToParentViewController:self];
		_collectionVC.cTarget = self;
	}
	return _collectionVC;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
