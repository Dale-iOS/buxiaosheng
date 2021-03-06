//
//  LZOutboundSectionView.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/5/30.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LZOutboundSectionView.h"
#import "OutboundViewController.h"
#import "LLOutboundSeletedVC.h"
@implementation LZOutboundSectionView
{
    UIView * _bgView;
    UILabel * _nameLable;//品名
    UILabel * _demandLable;//需求
    UILabel * _colorLable;//颜色
    //UIButton * _foldingBtn;//折叠按钮
    UIButton * _addBtn;
    UIView * _bottomView;
    UIButton * _seletedBtn;
    
    NSMutableArray *_tmpArray;
    
}
-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self setupUI];
        
    }
    return self;
}


-(void)setupUI{
    
    _tmpArray = [NSMutableArray array];
    
    _bgView = [UIView new];
    _bgView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.contentView addSubview:_bgView];
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.contentView);
        make.height.mas_equalTo(10);
    }];
    self.contentView.backgroundColor = [UIColor whiteColor];
    _nameLable = [UILabel new];
    [self.contentView addSubview:_nameLable];
    _nameLable.textColor = [UIColor colorWithHexString:@"#333333"];
    _nameLable.font = [UIFont systemFontOfSize:14];
    [_nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(50);
        make.top.equalTo(_bgView.mas_bottom).offset(10);
    }];
    
    _demandLable = [UILabel new];
    [self.contentView addSubview:_demandLable];
    _demandLable.textColor = [UIColor colorWithHexString:@"#333333"];
    _demandLable.font = [UIFont systemFontOfSize:14];
    [_demandLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(50);
        make.top.equalTo(_nameLable.mas_bottom).offset(8);
    }];
    
    _colorLable = [UILabel new];
    [self.contentView addSubview:_colorLable];
    _colorLable.textColor = [UIColor colorWithHexString:@"#333333"];
    _colorLable.font = [UIFont systemFontOfSize:14];
    [_colorLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(50);
        make.top.equalTo(_demandLable.mas_bottom).offset(8);
    }];
    
    _seletedBtn = [UIButton new];
    [self.contentView addSubview:_seletedBtn];
    [_seletedBtn addTarget:self action:@selector(checkoutBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_seletedBtn setBackgroundImage:[UIImage imageNamed:@"noSelect1"] forState:UIControlStateNormal];
    [_seletedBtn setBackgroundImage:[UIImage imageNamed:@"yesSelect"] forState:UIControlStateSelected];
    [_seletedBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(12);
        make.top.equalTo(self.contentView).offset(40);
    }];
    
    _foldingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.contentView addSubview:_foldingBtn];
    [_foldingBtn addTarget:self action:@selector(foldingBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_foldingBtn setTitle:@"展开    " forState:UIControlStateNormal];
    [_foldingBtn setTitle:@"收起    " forState:UIControlStateSelected];
    _foldingBtn.titleLabel.font = FONT(12);
    [_foldingBtn setTitleColor:[UIColor colorWithHexString:@"#3d9bfa"] forState:UIControlStateNormal];
    [_foldingBtn setTitleColor:[UIColor colorWithHexString:@"#3d9bfa"] forState:UIControlStateSelected];
    [_foldingBtn setImage:[UIImage imageNamed:@"dyeing_close"] forState:UIControlStateNormal];
    [_foldingBtn setImage:[UIImage imageNamed:@"dyeing_show"] forState:UIControlStateSelected];
    
    [_foldingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-12);
        //        make.top.equalTo(self.contentView).offset(40);
        make.centerY.equalTo(self.contentView);
        make.width.mas_equalTo(60);
    }];
    [_foldingBtn layoutIfNeeded];
    _foldingBtn.titleEdgeInsets = UIEdgeInsetsMake(0,  -(_foldingBtn.titleLabel.frame.origin.x), 0, 0);
    
    //整个view都给点击，点击效果和点中左边圆圈一样
    UIButton *selectViewBtn = [[UIButton alloc]init];
    [selectViewBtn setBackgroundColor:[UIColor clearColor]];
    [selectViewBtn addTarget:self action:@selector(checkoutBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:selectViewBtn];
    [selectViewBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.top.mas_equalTo(self).offset(10);
        make.height.mas_offset(80);
        make.right.mas_equalTo(self->_foldingBtn.mas_left);
        
    }];
    
    UIView * _headView = [[UIView alloc]init];
    _headView.backgroundColor = [UIColor colorWithHexString:@"#f9f9f9"];
    _bottomView = _headView;
    [self.contentView addSubview:_headView];
    [_headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(_colorLable.mas_bottom).offset(5);
        make.height.mas_equalTo(39);
    }];
    
    UILabel *warehouseNumLbl = [[UILabel alloc]init];
    warehouseNumLbl.font = FONT(14);
    warehouseNumLbl.textColor = CD_Text33;
    warehouseNumLbl.textAlignment = NSTextAlignmentCenter;
    warehouseNumLbl.text = @"库存数量";
    [_headView addSubview:warehouseNumLbl];
    [warehouseNumLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(_headView);
        make.width.mas_offset(APPWidth *0.2);
        make.height.mas_offset(39);
    }];
    
    UILabel *OutNumLbl = [[UILabel alloc]init];
    OutNumLbl.font = FONT(14);
    OutNumLbl.textColor = CD_Text33;
    OutNumLbl.textAlignment = NSTextAlignmentCenter;
    OutNumLbl.text = @"出库数量";
    [_headView addSubview:OutNumLbl];
    [OutNumLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_headView);
        make.left.equalTo(warehouseNumLbl.mas_right);
        make.width.mas_offset(APPWidth *0.2);
        make.height.mas_offset(39);
    }];
    
    UILabel *lineNumLbl = [[UILabel alloc]init];
    lineNumLbl.font = FONT(14);
    lineNumLbl.textColor = CD_Text33;
    lineNumLbl.textAlignment = NSTextAlignmentCenter;
    lineNumLbl.text = @"条数";
    [_headView addSubview:lineNumLbl];
    [lineNumLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_headView);
        make.left.equalTo(OutNumLbl.mas_right);
        make.width.mas_offset(APPWidth *0.2);
        make.height.mas_offset(39);
    }];
    
    UILabel *fromWarahouseLbl = [[UILabel alloc]init];
    fromWarahouseLbl.font = FONT(14);
    fromWarahouseLbl.textColor = CD_Text33;
    fromWarahouseLbl.textAlignment = NSTextAlignmentCenter;
    fromWarahouseLbl.text = @"出库仓";
    [_headView addSubview:fromWarahouseLbl];
    [fromWarahouseLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_headView);
        make.left.equalTo(lineNumLbl.mas_right);
        make.width.mas_offset(APPWidth *0.2);
        make.height.mas_offset(39);
    }];
    
    _addBtn = [[UIButton alloc]init];;
    [_addBtn addTarget:self action:@selector(addBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_headView addSubview:_addBtn];
    [_addBtn setImage:IMAGE(@"dyeing_add") forState:UIControlStateNormal];
    [_addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_headView);
        make.right.equalTo(_headView).offset(-12);
        make.width.mas_offset(APPWidth *0.2);
        make.height.mas_offset(39);
    }];
}

-(void)addBtnClick {
    
    OutboundViewController *  outboundVc = (OutboundViewController *)[BXSTools viewWithViewController:self.contentView ];
    
    LLOutboundSeletedVC * rightSeletedVc = [LLOutboundSeletedVC new];
    rightSeletedVc.itemModel = self.model;
    rightSeletedVc.block = ^(NSArray<LLOutboundRightModel *> *seleteds, LZOutboundItemListModel *lastModel) {
        outboundVc.sectionModel = lastModel;
        [_tmpArray addObjectsFromArray:seleteds];
        outboundVc.rightSeleteds = _tmpArray;
    };
    CWLateralSlideConfiguration *conf = [CWLateralSlideConfiguration configurationWithDistance:0 maskAlpha:0.4 scaleY:1.0 direction:CWDrawerTransitionFromRight backImage:[UIImage imageNamed:@"back"]];
    
    [outboundVc cw_showDrawerViewController:rightSeletedVc animationType:(CWDrawerAnimationTypeMask) configuration:conf];
    
}

-(void)checkoutBtnClick {
    self.model.checkOut = !self.model.checkOut;
    OutboundViewController * outVc = (OutboundViewController*)[BXSTools viewWithViewController:self.contentView];
    [outVc.tableView reloadData];
}
-(void)foldingBtnClick {
    if ([self.model.stock isEqualToString:@"0"]) {
        return;
    }
    if ([self.delegate respondsToSelector:@selector(sectionViewDelegate:)]) {
        [self.delegate sectionViewDelegate:self];
    }
}

- (void)setModel:(LZOutboundItemListModel *)model
{
    _model = model;
    _nameLable.text = [NSString stringWithFormat:@"品名 : %@",_model.productName];
    _demandLable.text = [NSString stringWithFormat:@"需求量 : %@",_model.number];
    _colorLable.text = [NSString stringWithFormat:@"颜色 : %@",_model.productColorName];
    _model.seleted ? (_bottomView.hidden = false) : (_bottomView.hidden = true);
    _seletedBtn.selected = _model.checkOut;
    if ([model.stock isEqualToString:@"0"]) {
        [_foldingBtn setTitle:@"无库存" forState:UIControlStateNormal];
        [_foldingBtn setTitleColor:[UIColor colorWithHexString:@"#ff6565"] forState:UIControlStateNormal];
        [_foldingBtn setBackgroundColor:[UIColor colorWithRed:255.0f/255.0f green:101.0f/255.0f blue:101.0f/255.0f alpha:0.2f]];
        [_foldingBtn setImage:nil forState:UIControlStateNormal];
        [_foldingBtn setImage:nil forState:UIControlStateSelected];
        _foldingBtn.layer.cornerRadius = 2.0f;
        _foldingBtn.layer.masksToBounds = YES;
        _foldingBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        _foldingBtn.titleEdgeInsets = UIEdgeInsetsMake(0,  0, 0, 0);
        _foldingBtn.imageEdgeInsets = UIEdgeInsetsMake(0, (_foldingBtn.frame.size.width - _foldingBtn.imageView.frame.origin.x - _foldingBtn.imageView.frame.size.width), 0, -(_foldingBtn.frame.size.width - _foldingBtn.imageView.frame.origin.x - _foldingBtn.imageView.frame.size.width));
    }else {
        _foldingBtn.backgroundColor = [UIColor whiteColor];
        [_foldingBtn setTitle:@"展开    " forState:UIControlStateNormal];
        [_foldingBtn setTitle:@"收起    " forState:UIControlStateSelected];
        _foldingBtn.titleLabel.font = FONT(12);
        [_foldingBtn setTitleColor:[UIColor colorWithHexString:@"#3d9bfa"] forState:UIControlStateNormal];
        [_foldingBtn setTitleColor:[UIColor colorWithHexString:@"#3d9bfa"] forState:UIControlStateSelected];
        [_foldingBtn setImage:[UIImage imageNamed:@"dyeing_close"] forState:UIControlStateNormal];
        [_foldingBtn setImage:[UIImage imageNamed:@"dyeing_show"] forState:UIControlStateSelected];
        //_foldingBtn.titleEdgeInsets = UIEdgeInsetsMake(0,  -(_foldingBtn.titleLabel.frame.origin.x), 0, 0);
        //_foldingBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 40, 0, -(_foldingBtn.frame.size.width - _foldingBtn.imageView.frame.origin.x - _foldingBtn.imageView.frame.size.width));
        //设置图片和文字位置 因为你的title有空格，所以图片和文字的间距设置为0 看起来间距也大 可以把文字的空格去掉或者把间距设为负数
        [_foldingBtn imageOnTheTitleRightWithSpace:0];
        
        _model.seleted ? (_foldingBtn.imageView.transform = CGAffineTransformMakeRotation(M_PI)) :(_foldingBtn.imageView.transform = CGAffineTransformIdentity);
        _model.seleted ? [_foldingBtn setTitle:@"收起    " forState:UIControlStateNormal] :[_foldingBtn setTitle:@"展开    " forState:UIControlStateNormal];;
    }
    
    
}

@end

