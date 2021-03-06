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
#import "LZSaveOrderModel.h"

@interface LZShipmentVC ()<UIScrollViewDelegate>
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)UISegmentedControl *sgc;
@property(nonatomic,strong)LZShipmentBigGoodsView *shipmentBigGoodsView;//大货
@property(nonatomic,strong)LZShipmentBigGoodsView *shipmentBigBoardView;//板布
//@property(nonatomic,strong)LZShipmentBigBoardView *shipmentBigBoardView;//板布
@property(nonatomic,strong)LZSaveOrderModel *saveOrderModel;
@property (nonatomic, strong) NSMutableArray *saveMuAry;
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
    //大货
    _shipmentBigGoodsView.model = _model;
    /// 网络请求 在VC 里面操作最好
    _shipmentBigGoodsView.didClickCompltBlock = ^(NSMutableArray *boardModelAry) {

        weakSelf.saveMuAry = boardModelAry;
        [weakSelf requestData];
    } ;
    [_scrollView addSubview:_shipmentBigGoodsView];
    
 
    _shipmentBigBoardView = [[LZShipmentBigGoodsView alloc]initWithFrame:CGRectMake(APPWidth, 0, APPWidth, APPHeight -50)];
    //板布
//    _shipmentBigBoardView.singleType = @"1";
    _shipmentBigBoardView.model = _model;
    _shipmentBigBoardView.didClickCompltBlock = ^(NSMutableArray *boardModelAry) {
        
        weakSelf.saveMuAry = boardModelAry;
        [weakSelf requestData];
    } ;
    [_scrollView addSubview:_shipmentBigBoardView];
    
}

#pragma mark --- 网络请求 ---
//接口名称 开单
- (void)requestData
{
    NSMutableArray <NSString *> *saveMuAry = [NSMutableArray array];
    
    for (int i = 0 ; i < self.saveMuAry.count; i++) {
        LZSaveOrderModel *model = self.saveMuAry[i];
        model.singleType = [NSString stringWithFormat:@"%ld",(long)_sgc.selectedSegmentIndex];
        [saveMuAry addObject:[model mj_JSONObject]];
    }
    
    
    NSDictionary *param = @{@"companyId":[BXSUser currentUser].companyId,
                            @"orderDetailItems":[saveMuAry mj_JSONString],
                            @"orderId":self.model.id
                                   };
    
    [BXSHttp requestPOSTWithAppURL:@"settle/create_order_detail.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:true];
        });
        
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

- (NSMutableArray *)saveMuAry{
    if (_saveMuAry == nil) {
        _saveMuAry = [NSMutableArray array];
    }
    return _saveMuAry;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
