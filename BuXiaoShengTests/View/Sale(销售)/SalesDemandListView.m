//
//  SalesDemandListView.m
//  BuXiaoShengTests
//
//  Created by 罗镇浩 on 2018/4/12.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "SalesDemandListView.h"
#import "DemandListTableViewCell.h"
#import "SalesDemandViewController.h"
#import "LLSalesDemandSideSlipVc.h"
#import "UIViewController+CWLateralSlide.h"
@interface SalesDemandListView()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UIView *_headerView;
    UIView *_footerView;
    UITableView *_tableView;
}
@end

@implementation SalesDemandListView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    [self setupHeaderView];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, _headerView.bottom, APPWidth, 200) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = _footerView;
    [self addSubview:_tableView];
}

- (void)setupHeaderView
{
    _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPHeight, 40)];
    _headerView.backgroundColor = LZHBackgroundColor;
    [self addSubview:_headerView];
    
    //品名  颜色  条数  数量  单价
    UILabel *nameLabel = [[UILabel alloc]init];
    nameLabel.font = FONT(14);
    nameLabel.text = @"品名";
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.textColor = CD_Text33;
    [_headerView addSubview:nameLabel];
    
    UILabel *colorLabel = [[UILabel alloc]init];
    colorLabel.font = FONT(14);
    colorLabel.text = @"颜色";
    colorLabel.textAlignment = NSTextAlignmentCenter;
    colorLabel.textColor = CD_Text33;
    [_headerView addSubview:colorLabel];
    
    UILabel *lineNumLabel = [[UILabel alloc]init];
    lineNumLabel.font = FONT(14);
    lineNumLabel.text = @"条数";
    lineNumLabel.textAlignment = NSTextAlignmentCenter;
    lineNumLabel.textColor = CD_Text33;
    [_headerView addSubview:lineNumLabel];
    
    UILabel *numLabel = [[UILabel alloc]init];
    numLabel.font = FONT(14);
    numLabel.text = @"数量";
    numLabel.textAlignment = NSTextAlignmentCenter;
    numLabel.textColor = CD_Text33;
    [_headerView addSubview:numLabel];
    
    UILabel *priceLabel = [[UILabel alloc]init];
    priceLabel.font = FONT(14);
    priceLabel.text = @"条数";
    priceLabel.textAlignment = NSTextAlignmentCenter;
    priceLabel.textColor = CD_Text33;
    [_headerView addSubview:priceLabel];
    
    nameLabel.sd_layout
    .topSpaceToView(_headerView, 0)
    .leftSpaceToView(_headerView, 0)
    .heightRatioToView(_headerView, 1)
    .widthIs(LZHScale_WIDTH(240));
    
    colorLabel.sd_layout
    .topSpaceToView(_headerView, 0)
    .leftSpaceToView(nameLabel, 0)
    .heightRatioToView(_headerView, 1)
    .widthIs(LZHScale_WIDTH(150));
    
    lineNumLabel.sd_layout
    .topSpaceToView(_headerView, 0)
    .leftSpaceToView(colorLabel, 0)
    .heightRatioToView(_headerView, 1)
    .widthIs(LZHScale_WIDTH(105));
    
    numLabel.sd_layout
    .topSpaceToView(_headerView, 0)
    .leftSpaceToView(lineNumLabel, 0)
    .heightRatioToView(_headerView, 1)
    .widthIs(LZHScale_WIDTH(150));
    
    priceLabel.sd_layout
    .topSpaceToView(_headerView, 0)
    .leftSpaceToView(numLabel, 0)
    .heightRatioToView(_headerView, 1)
    .widthIs(LZHScale_WIDTH(105));
    
    
    //初始化尾部试图
    _footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 65)];
    _footerView.backgroundColor = [UIColor whiteColor];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, _footerView.top, APPWidth, 1)];
    lineView.backgroundColor = LZHBackgroundColor;
    [_footerView addSubview:lineView];
    
    UIButton *addBtn = [UIButton new];
    addBtn.backgroundColor = [UIColor whiteColor];
    [addBtn setBackgroundImage:IMAGE(@"addbtn") forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(addBtnOnClickAction) forControlEvents:UIControlEventTouchUpInside];
    [_footerView addSubview:addBtn];
    
    addBtn.sd_layout
    .centerXEqualToView(_footerView)
    .centerYEqualToView(_footerView)
    .widthIs(92)
    .heightIs(31);
    
}


#pragma mark ------ tableview delegate -------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"DemandListTableViewCell";
    DemandListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil)
    {
        cell = [[DemandListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}

#pragma mark ------ 点击事件 --------
- (void)addBtnOnClickAction
{
    SalesDemandViewController * demandVc = (SalesDemandViewController *)[Utility getVCAtView:self WithVcClass:[SalesDemandViewController class]];
    NSLog(@"addBtnOnClickAction");
    LLSalesDemandSideSlipVc *vc = [[LLSalesDemandSideSlipVc alloc] init];
    CWLateralSlideConfiguration *conf = [CWLateralSlideConfiguration defaultConfiguration];
    conf.direction = CWDrawerTransitionFromRight; // 从右边滑出
    conf.finishPercent = 0.2f;
    conf.showAnimDuration = 0.2;
    conf.HiddenAnimDuration = 0.2;
    conf.maskAlpha = 0.1;
    
    [demandVc cw_showDrawerViewController:vc animationType:CWDrawerAnimationTypeDefault configuration:conf];
    
    
    
}

@end
