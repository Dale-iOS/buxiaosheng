//
//  LZTypeProductCell.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/8/8.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LZTypeProductCell.h"
#import "LZTypeProductModel.h"

static NSString *productMark = @"productMark";

@interface LZInnerLAbel:UIView
@property (nonatomic,strong)UILabel *colorLable;
@property (nonatomic,strong)UILabel *maLable;
@property (nonatomic,strong)UILabel *unitLable;
@property (nonatomic,strong)UILabel *numLable;
@property (nonatomic,strong)UILabel *moneyLable;
@end

@implementation LZInnerLAbel

- (instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        self.colorLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
        self.colorLable.font = [UIFont systemFontOfSize:13.0];
        self.colorLable.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.colorLable];
        self.maLable = [[UILabel alloc] initWithFrame:CGRectMake(60, 0, frame.size.width - 240, frame.size.height)];
        self.maLable.font = [UIFont systemFontOfSize:13.0];
        self.maLable.textAlignment = NSTextAlignmentCenter;
        self.maLable.numberOfLines = 0;
        self.maLable.lineBreakMode=NSLineBreakByWordWrapping;
        [self addSubview:self.maLable];
        self.unitLable = [[UILabel alloc] initWithFrame:CGRectMake(frame.size.width - 180, 0, 60, 30)];
        self.unitLable.font = [UIFont systemFontOfSize:13.0];
        self.unitLable.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.unitLable];
        self.numLable = [[UILabel alloc] initWithFrame:CGRectMake(frame.size.width - 120, 0, 60, 30)];
        self.numLable.font = [UIFont systemFontOfSize:13.0];
        self.numLable.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.numLable];
        self.moneyLable = [[UILabel alloc] initWithFrame:CGRectMake(frame.size.width - 60, 0, 60, 30)];
        self.moneyLable.font = [UIFont systemFontOfSize:13.0];
        self.moneyLable.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.moneyLable];
    }
    return self;
}
- (void)setSubViewTitles:(NSArray *)titles {
    for (int i = 0; i < titles.count; i++) {
        [self.subviews[i] setValue:titles[i] forKeyPath:@"text"];
    }
}

@end


@interface LZTypeProductCell()
@property (nonatomic,strong)UILabel *productName;//品名
@property (nonatomic,strong)UILabel *totalNum; //数量
@property (nonatomic,strong)UIView *centerView;
@property (nonatomic,strong)UIView *bottomView;
@property (nonatomic,strong)UILabel *inHouseNum;//入库条数
@property (nonatomic,strong)UILabel *tagNum;//标签数量
@property (nonatomic,strong)UILabel *refundAmount;//退款金额
@property (nonatomic,strong)UILabel *plusAmount; //结算数量
@end

@implementation LZTypeProductCell
+ (LZTypeProductCell *)refuProductCell:(UITableView *)tbview {
    LZTypeProductCell *cell = [tbview dequeueReusableCellWithIdentifier:productMark];
    if (!cell) {
        cell = [[LZTypeProductCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:productMark];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)changeCellHeight:(LZTypeProductModel *)modelHeight {
    CGRect tmpRect = self.centerView.frame;
    tmpRect.size.height = modelHeight.totalHeight - 105;
    self.centerView.frame = tmpRect;
    CGRect bottomRect = self.bottomView.frame;
    bottomRect.origin.y = CGRectGetMaxY(tmpRect);
    self.bottomView.frame = bottomRect;
    LZInnerLAbel *outXD = nil;
    for (int i = 0; i < modelHeight.valList.count; i++) {
        float tmpH = 35;
        LZInnerLAbel *lable = nil;
        if (i == 0) {
            lable = [[LZInnerLAbel alloc] initWithFrame:CGRectMake(0, tmpH, APPWidth - 20, [modelHeight.conHeight[i] intValue])];
        }else {
            tmpH = CGRectGetMaxY(outXD.frame);
            lable = [[LZInnerLAbel alloc] initWithFrame:CGRectMake(0, tmpH + 5, APPWidth - 20, [modelHeight.conHeight[i] intValue])];
        }
        outXD = lable;
        lable.colorLable.text = modelHeight.productColorName;
        lable.maLable.text = modelHeight.valList[i][@"value"];
        lable.unitLable.text = modelHeight.unitName;
        lable.numLable.text = modelHeight.valList[i][@"total"];
        lable.moneyLable.text = modelHeight.totalNumber;
        [self.centerView addSubview:lable];
    }
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUI];
    }
    return self;
}
- (void)setUI {
    self.productName = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, APPWidth / 2 - 10, 30)];
    self.productName.text = @"品名:LF001";
    self.totalNum = [[UILabel alloc] initWithFrame:CGRectMake(APPWidth / 2, 0, APPWidth/2 - 10, 30)];
    self.totalNum.text = @"数量:5000";
    self.totalNum.textAlignment = NSTextAlignmentRight;
    UIView *topLine = [[UIView alloc] initWithFrame:CGRectMake(10, 30, APPWidth - 20, 1)];
    topLine.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:self.productName];
    [self.contentView addSubview:self.totalNum];
    [self.contentView addSubview:topLine];
    
    NSArray *titles = @[@"颜色",@"细码",@"单位",@"条数",@"单价"];
    
    self.centerView = [[UIView alloc] initWithFrame:CGRectMake(10, 35, APPWidth - 20, 30)];
    [self.contentView addSubview:self.centerView];
    
    LZInnerLAbel *lable = [[LZInnerLAbel alloc] initWithFrame:CGRectMake(0, 0, APPWidth - 20, 30)];
    [lable setSubViewTitles:titles];
    [self.centerView addSubview:lable];
    
    self.bottomView = [[UIView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.centerView.frame) + 5, APPWidth - 20, 75)];
    [self.contentView addSubview:self.bottomView];
    
    UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APPWidth - 20, 1)];
    bottomLine.backgroundColor = [UIColor lightGrayColor];
    [self.bottomView addSubview:bottomLine];
    
    self.inHouseNum = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, (APPWidth - 20)/2, 30)];
    self.inHouseNum.text = @"入库条数合计:156";
    [self.bottomView addSubview:self.inHouseNum];
    
    self.tagNum = [[UILabel alloc] initWithFrame:CGRectMake((APPWidth - 20)/2, 5, (APPWidth - 20)/2, 30)];
    self.tagNum.text = @"标签数量:2900";
    [self.bottomView addSubview:self.tagNum];
    
    self.refundAmount = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, (APPWidth - 20)/2, 30)];
    self.refundAmount.text = @"本次退款金额:30000";
    [self.bottomView addSubview:self.refundAmount];
    
    self.plusAmount = [[UILabel alloc] initWithFrame:CGRectMake((APPWidth - 20)/2, 40, (APPWidth - 20)/2, 30)];
    self.plusAmount.text = @"结算数量:3000";
    [self.bottomView addSubview:self.plusAmount];
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
