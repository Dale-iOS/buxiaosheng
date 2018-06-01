//
//  LZOutboundSectionView.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/5/30.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LZOutboundSectionView.h"
#import "OutboundViewController.h"
#import "LZDrawerChooseView.h"
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
}
-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}


-(void)setupUI{
    
    _bgView = [UIView new];
    _bgView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.contentView addSubview:_bgView];
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.contentView);
        make.height.mas_equalTo(20);
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
        make.top.equalTo(self.contentView).offset(40);
         make.width.mas_equalTo(60);
    }];
    [_foldingBtn layoutIfNeeded];
    
    
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
    CWLateralSlideConfiguration *conf = [CWLateralSlideConfiguration configurationWithDistance:0 maskAlpha:0.4 scaleY:1.0 direction:CWDrawerTransitionFromRight backImage:[UIImage imageNamed:@"back"]];
    
    [outboundVc cw_showDrawerViewController:rightSeletedVc animationType:(CWDrawerAnimationTypeMask) configuration:conf];
   
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
    if ([model.stock isEqualToString:@"0"]) {
        [_foldingBtn setTitle:@"无库存" forState:UIControlStateNormal];
        [_foldingBtn setBackgroundColor:[UIColor redColor]];
        [_foldingBtn setImage:nil forState:UIControlStateNormal];
         [_foldingBtn setImage:nil forState:UIControlStateSelected];
        _foldingBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        _foldingBtn.titleEdgeInsets = UIEdgeInsetsMake(0,  0, 0, 0);
    }else {
        [_foldingBtn setTitle:@"展开    " forState:UIControlStateNormal];
        [_foldingBtn setTitle:@"收起    " forState:UIControlStateSelected];
        _foldingBtn.titleLabel.font = FONT(12);
        [_foldingBtn setTitleColor:[UIColor colorWithHexString:@"#3d9bfa"] forState:UIControlStateNormal];
        [_foldingBtn setTitleColor:[UIColor colorWithHexString:@"#3d9bfa"] forState:UIControlStateSelected];
        [_foldingBtn setImage:[UIImage imageNamed:@"dyeing_close"] forState:UIControlStateNormal];
        [_foldingBtn setImage:[UIImage imageNamed:@"dyeing_show"] forState:UIControlStateSelected];
        _foldingBtn.titleEdgeInsets = UIEdgeInsetsMake(0,  -(_foldingBtn.titleLabel.frame.origin.x), 0, 0);
        _foldingBtn.imageEdgeInsets = UIEdgeInsetsMake(0, (_foldingBtn.frame.size.width - _foldingBtn.imageView.frame.origin.x - _foldingBtn.imageView.frame.size.width), 0, -(_foldingBtn.frame.size.width - _foldingBtn.imageView.frame.origin.x - _foldingBtn.imageView.frame.size.width));
        
         _model.seleted ? (_foldingBtn.imageView.transform = CGAffineTransformMakeRotation(M_PI)) :(_foldingBtn.imageView.transform = CGAffineTransformIdentity);
    }
    
    
}

@end

