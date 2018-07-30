//
//  BXSPurchaChangeWarehousingView.m
//  BuXiaoSheng
//
//  Created by 家朋 on 2018/7/25.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "BXSPurchaChangeWarehousingView.h"

@implementation BXSPurchaChangeWarehousingView
{
    UILabel *allCountLabel, *unitLabel;
    
    NSArray *_codeArr;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, APPWidth * 0.2, self.height);
    [self addSubview:leftButton];
    [leftButton addTarget:self action:@selector(clickDis) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIView *rightView = [[UIView alloc]initWithFrame:CGRectMake(APPWidth * 0.2, 0, APPWidth *0.8, self.height)];
    [self addSubview:rightView];
    
    rightView.backgroundColor = [UIColor whiteColor];
    
    UILabel *title = [UILabel labelWithColor:Text33 font:FONT(14)];
    LineView *topV = [LineView lineViewOfHeight:20];
    topV.width = rightView.width;
    topV.top = 22;
    [rightView addSubview:topV];
    [topV addSubview:title];
    title.text = @"修改标签数量";
    title.frame = CGRectMake(15, 0, topV.width - 15, topV.height);
    
    //all
    UILabel *allTitleLabel = [UILabel labelWithColor:Text33 font:FONT(14)];
    [rightView addSubview:allTitleLabel];
    allTitleLabel.frame = CGRectMake(15, topV.bottom, 50, 50);
    allTitleLabel.text = @"总数量";
    
    allCountLabel = [UILabel labelWithColor:LZAppBlueColor font:FONT(14)];
    [rightView addSubview:allCountLabel];
    allCountLabel.frame = CGRectMake(allTitleLabel.right + 2, allTitleLabel.top, 70, 50);
    allCountLabel.text = @"0";
    
    //unit
    UILabel *unitTitleLabel = [UILabel labelWithColor:Text33 font:FONT(14)];
    [rightView addSubview:unitTitleLabel];
    unitTitleLabel.frame = CGRectMake(allCountLabel.right + 10 , allTitleLabel.top, 50, 50);
    unitTitleLabel.text = @"总条数";
    
    unitLabel = [UILabel labelWithColor:LZAppBlueColor font:FONT(14)];
    [rightView addSubview:unitLabel];
    unitLabel.frame = CGRectMake(unitTitleLabel.right + 2 , allTitleLabel.top, 50, 50);
    unitLabel.text = @"0";
    
    LineView *sLine = [LineView lineViewOfHeight:1];
    sLine.left = 15;
    sLine.width = rightView.width - 15;
    sLine.top = allTitleLabel.bottom;
    [rightView addSubview:sLine];
    
    UILabel *label3 = [UILabel labelWithColor:Text33 font:FONT(14)];
    [rightView addSubview:label3];
    label3.frame = CGRectMake(15,sLine.bottom, 120, 40);
    label3.text = @"全部加减";
   
    
    //restart
    UIButton *botton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightView addSubview:botton];
    [botton setImage:IMAGE(@"restart") forState:UIControlStateNormal];
    botton.frame = CGRectMake(rightView.width - 80, 0,80, 40);
    [botton addTarget:self action:@selector(clickReset) forControlEvents:UIControlEventTouchUpInside];
    botton.centerY = label3.centerY;
    
    
    // 按钮
    CGFloat btnW = rightView.width/4;
    NSArray *imageArr = @[@"addition",@"subtraction",@"multiplication",@"division"];
    
    for (int i=0 ;i < imageArr.count ; i++) {
        UIButton *rBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [rightView addSubview:rBtn];
        NSString *img = imageArr[i];
        [rBtn setImage:IMAGE(img) forState:UIControlStateNormal];
        rBtn.frame = CGRectMake(btnW*i , label3.bottom + 5,btnW, 55);
        rBtn.tag = i;
        [rBtn addTarget:self action:@selector(clickCalculation:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    

    
    // bottomButton
    UIButton *bottomButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightView addSubview:bottomButton];
    [bottomButton setTitle:@"确认" forState:UIControlStateNormal];
    bottomButton.backgroundColor = LZAppBlueColor;
    bottomButton.frame = CGRectMake(0, APPHeight - 50,rightView.width, 50);
    [bottomButton addTarget:self action:@selector(clickRrue) forControlEvents:UIControlEventTouchUpInside];
    
    
    
}
-(void)setModel:(BXSAllCodeModel *)model {
    _model = model;
    _codeArr = [model.findCodeArray mutableCopy];
    
    [self calculation];
    
}
#pragma mark --- Click ---

- (void)clickCalculation:(UIButton *)sender {
  
    switch (sender.tag) {
        case 0 :
            [self clickAdd];
            break;
        case 1 :
            [self clickReduce];
            break;
        case 2 :
            [self clickRide];
            break;
        case 3 :
            [self clickDivision];
            break;
            
        default:
            break;
    }
    
}
/// +
-(void)clickAdd {
    
    for (LZFindCodeModel *kModel in _codeArr) {
        CGFloat aValue = kModel.code.floatValue;
        aValue += 1;
        kModel.code = [NSString stringWithFormat:@"%.1f",aValue];
    }
    
    [self calculation];
}
/// -
-(void)clickReduce {
   
    for (LZFindCodeModel *kModel in _codeArr) {
        CGFloat aValue = kModel.code.floatValue;
        aValue -= 1;
        kModel.code = [NSString stringWithFormat:@"%.1f",aValue];
    }
    
    [self calculation];
}

/// *
-(void)clickRide {
    for (LZFindCodeModel *kModel in _codeArr) {
        CGFloat aValue = kModel.code.floatValue;
        aValue *= 0.99;
        kModel.code = [NSString stringWithFormat:@"%.1f",aValue];
    }
    
    [self calculation];
}

/// /
-(void)clickDivision {
 
    for (LZFindCodeModel *kModel in _codeArr) {
        CGFloat aValue = kModel.code.floatValue;
        aValue /= 0.99;
        kModel.code = [NSString stringWithFormat:@"%.1f",aValue];
    }
    [self calculation];
}
/// 重置
- (void)clickReset {
    
    [self setModel:_model];
}

/// 确认
- (void)clickRrue {
    
    _model.findCodeArray = [NSMutableArray arrayWithArray:_codeArr];
    !_clickChangeBlock?:_clickChangeBlock();
    [self clickDis];
}

/// 每次点击的计算
- (void)calculation {
 
    //总条数和总码数
    unitLabel.text = [NSString stringWithFormat:@"%ld",_codeArr.count];
    CGFloat allCount = 0.0f;
    for (LZFindCodeModel *kModel in _codeArr) {
        allCount += kModel.code.floatValue;
    }
    allCountLabel.text = [NSString stringWithFormat:@"%.1f",allCount];
    
    
}


- (void)clickDis {
    [BYAlertHelper hideAlert];
    
}

@end
