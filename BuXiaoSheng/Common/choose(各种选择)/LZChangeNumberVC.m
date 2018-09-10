//
//  LZChangeNumberVC.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/9/7.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LZChangeNumberVC.h"
#import "BigGoodsAndBoardModel.h"

/**
 按钮点击的类型 用于计数
 
 - AdditionBtnClick: +
 - SubtractionBtnClick: -
 - MultiplicationBtnClick: ✖️
 - DivisionBtnClick: ➗
 */

@interface LZChangeNumberVC ()
{
    UILabel *_hintLbl;//总数量
    UILabel *_lineLbl;//总条数
    double _total;//计算中的数量值
    UIButton *_verifyBtn;//确认按钮
    
    NSMutableArray * tCellLineList_;//商品的data
}
@end

@implementation LZChangeNumberVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    tCellLineList_  = [NSMutableArray array];
    for(BigGoodsAndBoardModel * tBigGoodsAndBoardModel in self.cellLineList){
        [tCellLineList_ addObject: [tBigGoodsAndBoardModel mutableCopy]];
    }
}

- (void)setupUI{
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    NSString *tempStr = [NSString stringWithFormat:@"%.1f",self.originalValue];
    _total = [tempStr doubleValue];
    
    UILabel *titleLbl = [[UILabel alloc]init];
    titleLbl.backgroundColor = LZHBackgroundColor;
    titleLbl.text = @"  修改数量";
    titleLbl.textColor = CD_Text99;
    titleLbl.font = FONT(12);
    titleLbl.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:titleLbl];
    [titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(44);
        make.height.mas_offset(30);
    }];
    
    //总数量 用于改变
    _hintLbl = [[UILabel alloc]init];
    _hintLbl.text = [NSString stringWithFormat:@"当前 总数量： %.1f",self.originalValue];
    _hintLbl.textColor = LZAppRedColor;
    _hintLbl.font = FONT(12);
    NSMutableAttributedString *temgpStr = [[NSMutableAttributedString alloc] initWithString:_hintLbl.text];
    NSRange oneRange = [[temgpStr string] rangeOfString:[NSString stringWithFormat:@"当前 总数量："]];
    [temgpStr addAttribute:NSForegroundColorAttributeName value:CD_Text99 range:oneRange];
    _hintLbl.attributedText = temgpStr;
    [self.view addSubview:_hintLbl];
    [_hintLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(15);
        make.top.equalTo(titleLbl.mas_bottom).offset(15);
        make.width.mas_offset(250);
        make.height.mas_offset(15);
    }];
    
    //总条数 用于相加减
    _lineLbl = [[UILabel alloc]init];
    _lineLbl.text = [NSString stringWithFormat:@"总条数： %ld",self.allNumber];
    _lineLbl.textColor = LZAppBlueColor;
    _lineLbl.textAlignment = NSTextAlignmentRight;
    _lineLbl.font = FONT(12);
    NSMutableAttributedString *lineStr = [[NSMutableAttributedString alloc] initWithString:_lineLbl.text];
    NSRange oneRange2 = [[lineStr string] rangeOfString:[NSString stringWithFormat:@"总条数："]];
    [lineStr addAttribute:NSForegroundColorAttributeName value:CD_Text99 range:oneRange2];
    _lineLbl.attributedText = lineStr;
    [self.view addSubview:_lineLbl];
    [_lineLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-15);
        make.top.equalTo(titleLbl.mas_bottom).offset(15);
        make.width.mas_offset(100);
        make.height.mas_offset(15);
    }];
    
    //原始总数量
    UILabel *firstLbl = [[UILabel alloc]init];
    firstLbl.text = [NSString stringWithFormat:@"初始 总数量： %.1f",_originalValue];
    firstLbl.textColor = LZAppBlueColor;
    firstLbl.font = FONT(12);
    NSMutableAttributedString *temgpStr1 = [[NSMutableAttributedString alloc] initWithString:firstLbl.text];
    NSRange oneRange1 = [[temgpStr1 string] rangeOfString:[NSString stringWithFormat:@"初始 总数量："]];
    [temgpStr1 addAttribute:NSForegroundColorAttributeName value:CD_Text99 range:oneRange1];
    firstLbl.attributedText = temgpStr1;
    [self.view addSubview:firstLbl];
    [firstLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(15);
        make.top.equalTo(_hintLbl.mas_bottom).offset(5);
        make.width.mas_offset(250);
        make.height.mas_offset(15);
    }];
    
    //重置按钮
    UIButton *restartBtn = [[UIButton alloc]init];
    [restartBtn setBackgroundImage:IMAGE(@"restart") forState:UIControlStateNormal];
    [restartBtn addTarget:self action:@selector(restartClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:restartBtn];
    [restartBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-15);
        make.top.equalTo(_hintLbl.mas_bottom).offset(5);
        make.width.mas_offset(50);
        make.height.mas_offset(19);
    }];
    
    
    //    加号按钮
    UIButton *additionBtn = [[UIButton alloc]init];
    [additionBtn setBackgroundImage:IMAGE(@"addition") forState:UIControlStateNormal];
    [additionBtn addTarget:self action:@selector(additionBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:additionBtn];
    [additionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(15);
        make.top.equalTo(firstLbl.mas_bottom).offset(15);
        make.height.mas_offset(29);
        make.width.mas_offset((APPWidth *0.75 -15*5)/4);
    }];
    
    //    减号按钮
    UIButton *subtractionBtn = [[UIButton alloc]init];
    [subtractionBtn setBackgroundImage:IMAGE(@"subtraction") forState:UIControlStateNormal];
    [subtractionBtn addTarget:self action:@selector(subtractionBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:subtractionBtn];
    [subtractionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(additionBtn.mas_right).offset(15);
        make.top.equalTo(firstLbl.mas_bottom).offset(15);
        make.height.mas_offset(29);
        make.width.mas_offset((APPWidth *0.75 -15*5)/4);
    }];
    
    //    乘号按钮
    UIButton *multiplicationBtn = [[UIButton alloc]init];
    [multiplicationBtn setBackgroundImage:IMAGE(@"multiplication") forState:UIControlStateNormal];
    [multiplicationBtn addTarget:self action:@selector(multiplicationBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:multiplicationBtn];
    [multiplicationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(subtractionBtn.mas_right).offset(15);
        make.top.equalTo(firstLbl.mas_bottom).offset(15);
        make.height.mas_offset(29);
        make.width.mas_offset((APPWidth *0.75 -15*5)/4);
    }];
    
    //    除号按钮
    UIButton *divisionBtn = [[UIButton alloc]init];
    [divisionBtn setBackgroundImage:IMAGE(@"division") forState:UIControlStateNormal];
    [divisionBtn addTarget:self action:@selector(divisionBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:divisionBtn];
    [divisionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(multiplicationBtn.mas_right).offset(15);
        make.top.equalTo(firstLbl.mas_bottom).offset(15);
        make.height.mas_offset(29);
        make.width.mas_offset((APPWidth *0.75 -15*5)/4);
    }];
    
    
    //确认按钮
    _verifyBtn = [[UIButton alloc]init];
    _verifyBtn.backgroundColor = LZAppBlueColor;
    [_verifyBtn setTitle:@"确 认" forState:UIControlStateNormal];
    [_verifyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_verifyBtn addTarget:self action:@selector(verifyBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_verifyBtn];
    [_verifyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.bottom.and.right.equalTo(self.view);
        make.height.mas_offset(44);
    }];
}

- (void)postNotification:(NSInteger)type {
    [[NSNotificationCenter defaultCenter] postNotificationName:kChangeYardNotification object:@(type)];
}

#pragma mark ---- 点击事件 ----
//加号方法
- (void)additionBtnClick{
    [self postNotification:AdditionBtnClick];
    _total+=_lineValue;
    [self publicBtnClickFunc:AdditionBtnClick];
    
    
    //    _hintLbl.text = [NSString stringWithFormat:@"当前 总数量： %.1lf",_total];
    //    NSMutableAttributedString *temgpStr = [[NSMutableAttributedString alloc] initWithString:_hintLbl.text];
    //    NSRange oneRange = [[temgpStr string] rangeOfString:[NSString stringWithFormat:@"当前 总数量："]];
    //    [temgpStr addAttribute:NSForegroundColorAttributeName value:CD_Text99 range:oneRange];
    //    _hintLbl.attributedText = temgpStr;
    //    if (self.NumValueBlock) {
    //        self.NumValueBlock([NSString stringWithFormat:@"%.1lf",_total]);
    //    }
}
//减号方法
- (void)subtractionBtnClick{
    if (_total<= 0) {
        _total = 0;
    }else{
        [self postNotification:SubtractionBtnClick];
        _total-=self.lineValue;
    }
    [self publicBtnClickFunc:SubtractionBtnClick];
    //    _hintLbl.text = [NSString stringWithFormat:@"当前 总数量： %.1lf",_total];
    //    NSMutableAttributedString *temgpStr = [[NSMutableAttributedString alloc] initWithString:_hintLbl.text];
    //    NSRange oneRange = [[temgpStr string] rangeOfString:[NSString stringWithFormat:@"当前 总数量："]];
    //    [temgpStr addAttribute:NSForegroundColorAttributeName value:CD_Text99 range:oneRange];
    //    _hintLbl.attributedText = temgpStr;
    //    if (self.NumValueBlock) {
    //        self.NumValueBlock([NSString stringWithFormat:@"%.1lf",_total]);
    //    }
}

/**
 返回切割后的str
 
 @param pDouble 精度值传入
 @return 返回 切割到.1位的str->55.8或888.8
 */
- (NSString * )resultDoubleNumber:(double)pDouble{
    //精度精确到5位数,转str,切割然后在赋值
    NSString * tDoubleNumber =[NSString stringWithFormat:@"%.5lf",pDouble];
    NSRange tRange = [tDoubleNumber rangeOfString:@"."];//匹配得到的下标
    tDoubleNumber = tDoubleNumber.length > tRange.location + 2 ?
    [tDoubleNumber substringToIndex:tRange.location + 2] : [NSString stringWithFormat:@"%.1lf",pDouble];//正常逻辑是 tDoubleNumber.length 永远都会大于 tRange.location + 2 只是为了防止崩溃
    return tDoubleNumber;
}
//乘号方法
- (void)multiplicationBtnClick{
    if (LZChangeNumVCTypeOrder == _type) {
        NSString * tSumStr;
        for (int i = 0; i < tCellLineList_.count; i ++) {
            BigGoodsAndBoardModel * tBigGoodsAndBoardModel =tCellLineList_[i];
            double tMultiplication = [tBigGoodsAndBoardModel.number doubleValue];
            tMultiplication = tMultiplication * 0.99;
            tBigGoodsAndBoardModel.number = [self resultDoubleNumber:tMultiplication];
            NSLog(@"精度到0.1的乘数值:%@",tBigGoodsAndBoardModel.number);
            if (i == 0) {
                tSumStr = tBigGoodsAndBoardModel.number;
            }else{
                double tOld =[tSumStr doubleValue];
                double tNew =[tBigGoodsAndBoardModel.number doubleValue];
                double tSumOldNew =tOld + tNew;
                tSumStr = [NSString stringWithFormat:@"%.1lf",tSumOldNew];
            }
        }
        _total = [tSumStr doubleValue];
    } else {
        if (_total > 0) {
            [self postNotification:MultiplicationBtnClick];
        }
        _total *= 0.99;
    }
    
    _hintLbl.text = [NSString stringWithFormat:@"当前 总数量： %@",[BXSTools notRounding:_total afterPoint:1]];
    NSMutableAttributedString *temgpStr = [[NSMutableAttributedString alloc] initWithString:_hintLbl.text];
    NSRange oneRange = [[temgpStr string] rangeOfString:[NSString stringWithFormat:@"当前 总数量："]];
    [temgpStr addAttribute:NSForegroundColorAttributeName value:CD_Text99 range:oneRange];
    _hintLbl.attributedText = temgpStr;
}
//除号方法
- (void)divisionBtnClick{
    if (LZChangeNumVCTypeOrder == _type) {
        NSString * tSumStr;
        for (int i = 0; i < tCellLineList_.count; i ++) {
            BigGoodsAndBoardModel * tBigGoodsAndBoardModel =tCellLineList_[i];
            //这里_total不能再使用 直接赋值的逻辑,应为乘除会导致精度丢失,所以逻辑应该是先给每一个cell赋值,然后在将每一个cell的值精度到0.1 进行循环相加,然后在进行赋值
            double tDivisionBtn = [tBigGoodsAndBoardModel.number doubleValue];
            tDivisionBtn = tDivisionBtn / 0.99;
            tBigGoodsAndBoardModel.number = [self resultDoubleNumber:tDivisionBtn];;
            NSLog(@"精度到0.1的除数值:%@",tBigGoodsAndBoardModel.number);
            if (i == 0) {
                tSumStr = tBigGoodsAndBoardModel.number;
            }else{
                double tOld =[tSumStr doubleValue];
                double tNew =[tBigGoodsAndBoardModel.number doubleValue];
                double tSumOldNew =tOld + tNew;
                tSumStr = [NSString stringWithFormat:@"%.1lf",tSumOldNew];
            }
        }
        _total = [tSumStr doubleValue];
    } else {
        if (_total > 0) {
            [self postNotification:DivisionBtnClick];
        }
        _total /= 0.99;
    }
    
    _hintLbl.text = [NSString stringWithFormat:@"当前 总数量： %@",[BXSTools notRounding:_total afterPoint:1]];
    NSMutableAttributedString *temgpStr = [[NSMutableAttributedString alloc] initWithString:_hintLbl.text];
    NSRange oneRange = [[temgpStr string] rangeOfString:[NSString stringWithFormat:@"当前 总数量："]];
    [temgpStr addAttribute:NSForegroundColorAttributeName value:CD_Text99 range:oneRange];
    _hintLbl.attributedText = temgpStr;
}

//重置方法
- (void)restartClick{
    
    _hintLbl.text = [NSString stringWithFormat:@"当前 总数量： %.1f",self.originalValue];
    
    _total = [[NSString stringWithFormat:@"%.1f",self.originalValue] doubleValue];
    
    NSMutableAttributedString *temgpStr = [[NSMutableAttributedString alloc] initWithString:_hintLbl.text];
    NSRange oneRange = [[temgpStr string] rangeOfString:[NSString stringWithFormat:@"当前 总数量："]];
    [temgpStr addAttribute:NSForegroundColorAttributeName value:CD_Text99 range:oneRange];
    _hintLbl.attributedText = temgpStr;
    
    tCellLineList_ = nil;
    [tCellLineList_ removeAllObjects];
    tCellLineList_  = [NSMutableArray array];
    for(BigGoodsAndBoardModel * tBigGoodsAndBoardModel in self.cellLineList){
        [tCellLineList_ addObject: [tBigGoodsAndBoardModel mutableCopy]];
    }
}
- (void)publicBtnClickFunc:(WithBtnClickStyle)pBtnClickStyle{
    _hintLbl.text = [NSString stringWithFormat:@"当前 总数量： %@",[BXSTools notRounding:_total afterPoint:1]];
    NSMutableAttributedString *temgpStr = [[NSMutableAttributedString alloc] initWithString:_hintLbl.text];
    NSRange oneRange = [[temgpStr string] rangeOfString:[NSString stringWithFormat:@"当前 总数量："]];
    [temgpStr addAttribute:NSForegroundColorAttributeName value:CD_Text99 range:oneRange];
    _hintLbl.attributedText = temgpStr;
    for (BigGoodsAndBoardModel * tBigGoodsAndBoardModel in tCellLineList_) {
        switch (pBtnClickStyle) {
            case AdditionBtnClick:{
                double tAdd = [tBigGoodsAndBoardModel.number doubleValue];
                tAdd =tAdd + 1;
                tBigGoodsAndBoardModel.number = [NSString stringWithFormat:@"%.1f",tAdd];
            }
                break;
            case SubtractionBtnClick:{
                double tSubtraction = [tBigGoodsAndBoardModel.number doubleValue];
                if (tSubtraction <=0) {
                    tSubtraction = 0;
                }else{
                    tSubtraction = tSubtraction - 1;
                }
                tBigGoodsAndBoardModel.number = [NSString stringWithFormat:@"%.1f",tSubtraction];
            }
                break;
            case MultiplicationBtnClick:{
                double tMultiplication = [tBigGoodsAndBoardModel.number doubleValue];
                tMultiplication = tMultiplication * 0.99;
                tBigGoodsAndBoardModel.number = [NSString stringWithFormat:@"%.1f",tMultiplication];
            }
                break;
            case DivisionBtnClick:{
                double tDivisionBtn = [tBigGoodsAndBoardModel.number doubleValue];
                tDivisionBtn = tDivisionBtn /0.99;
                tBigGoodsAndBoardModel.number = [NSString stringWithFormat:@"%.1f",tDivisionBtn];
            }
                break;
            default:
                break;
        }
    }
}
//确认按钮方法
- (void)verifyBtnClick{
    //遍历取到的list 修改对应的值,刷新tableview
    for (int i = 0; i <_cellLineList.count ; i ++) {
        //        double changeVaule   =_total -_originalValue;
        BigGoodsAndBoardModel * tOldData =self.cellLineList[i];
        BigGoodsAndBoardModel * tNewData = tCellLineList_[i];
        tOldData.number = tNewData.number;
    }
    //修改总数量的值
    self.itemModel.value = [NSString stringWithFormat:@"%.1lf",_total];
    NSString *str = @"";
    if (self.NumValueBlock) {
        self.NumValueBlock([NSString stringWithFormat:@"%.1lf",_total], str);
        //        self.NumValueBlock([NSString stringWithFormat:@"%.1lf",_total]);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end

