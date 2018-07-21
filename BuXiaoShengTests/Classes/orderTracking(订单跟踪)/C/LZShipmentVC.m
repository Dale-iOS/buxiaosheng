//
//  LZShipmentVC.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/6/18.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  开单页面

#import "LZShipmentVC.h"
#import "LZShipmentBigGoodsView.h"
#import "LZShipmentBigBoardView.h"
#import "BigGoodsAndBoardModel.h"

@interface LZShipmentVC ()<UIScrollViewDelegate>
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)UISegmentedControl *sgc;
@property(nonatomic,strong)LZShipmentBigGoodsView *shipmentBigGoodsView;//大货
@property(nonatomic,strong)LZShipmentBigGoodsView *shipmentBigBoardView;//板布
//@property(nonatomic,strong)LZShipmentBigBoardView *shipmentBigBoardView;//板布
@property(nonatomic,strong)BigGoodsAndBoardModel *bigGoodsAndBoardModel;
@end

@implementation LZShipmentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI{
    self.navigationItem.titleView = [Utility navTitleView:@"开单"];

    [self setupSgc];
}

- (void)setupSgc{
    
    _sgc = [[UISegmentedControl alloc]initWithItems:@[@"大货",@"板布"]];
    _sgc.selectedSegmentIndex = 0;
    _sgc.tintColor = LZAppBlueColor;
    [_sgc addTarget:self action:@selector(segClick:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_sgc];
    [_sgc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(LLNavViewHeight +10);
        make.height.mas_offset(30);
        make.width.mas_offset(180);
        make.centerX.equalTo(self.view);
    }];
    
    UILabel *hintLbl = [[UILabel alloc]init];
    hintLbl.backgroundColor = [UIColor colorWithHexString:@"#fc6666"];
    hintLbl.textColor = [UIColor whiteColor];
    hintLbl.font = FONT(12);
    hintLbl.textAlignment = NSTextAlignmentCenter;
    hintLbl.text = @"务必确认选择是大货还是板布";
    [self.view addSubview:hintLbl];
    [hintLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_sgc.mas_bottom).offset(10);
        make.left.and.right.equalTo(self.view);
        make.height.mas_offset(24);
    }];
    
    _scrollView = [[UIScrollView alloc]init];
    _scrollView.backgroundColor = [UIColor whiteColor];
    _scrollView.contentSize = CGSizeMake(APPWidth *2, 0);
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.scrollEnabled = YES;
    _scrollView.delegate = self;
    [self.view addSubview:_scrollView];
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(hintLbl.mas_bottom);
        make.left.and.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    
    WEAKSELF;
    _shipmentBigGoodsView = [[LZShipmentBigGoodsView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, APPHeight -50)];
    _shipmentBigGoodsView.model = _model;
    /// 网络请求 在VC 里面操作最好
    _shipmentBigGoodsView.didClickCompltBlock = ^(BigGoodsAndBoardModel *boardModel) {
        weakSelf.bigGoodsAndBoardModel = boardModel;
        [weakSelf submitRequest];
        
    };
    [_scrollView addSubview:_shipmentBigGoodsView];
    
    
    
    _shipmentBigBoardView = [[LZShipmentBigGoodsView alloc]initWithFrame:CGRectMake(APPWidth, 0, APPWidth, APPHeight -50)];
    _shipmentBigBoardView.model = _model;
    _shipmentBigBoardView.didClickCompltBlock = ^(BigGoodsAndBoardModel *boardModel) {
        weakSelf.bigGoodsAndBoardModel = boardModel;
        [weakSelf submitRequest];
        
    };
    [_scrollView addSubview:_shipmentBigBoardView];
    
}

#pragma mark --- 网络请求 ---
- (void)submitRequest
{
    NSMutableDictionary * param = [NSMutableDictionary dictionary];
    [param setObject:[BXSUser currentUser].companyId forKey:@"companyId"];
    [param setObject:_sgc.selectedSegmentIndex == 0? @"大货":@"板布" forKey:@"type"];
    
    [BXSHttp requestPOSTWithAppURL:@"sale/outproduct_list.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
        
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
    }];
}

#pragma mark --- 点击事件 ----
//分段选择器方法
- (void)segClick:(UISegmentedControl *)sgc
{
    
    if (sgc.selectedSegmentIndex == 0) {
        _scrollView.contentOffset = CGPointMake(0, 0);
        
    }else if (sgc.selectedSegmentIndex == 1)
    {
        _scrollView.contentOffset = CGPointMake(APPWidth, 0);
    }
    
}

//轮播图偏移方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.x /APPWidth >= 1) {
        _sgc.selectedSegmentIndex = 1;
    }else if (scrollView.contentOffset.x /APPWidth < 1)
    {
        _sgc.selectedSegmentIndex = 0;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
