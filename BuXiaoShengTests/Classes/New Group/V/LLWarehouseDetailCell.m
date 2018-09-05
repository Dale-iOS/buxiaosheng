//
//  LLWarehouseDetailCell.m
//  BuXiaoSheng
//
//  Created by lanlan on 2018/9/4.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LLWarehouseDetailCell.h"
#import "LLWarehouseSideModel.h"
@interface LLWarehouseDetailCell()
@property(nonatomic ,strong)UILabel * leftLable;
@property(nonatomic ,strong)UILabel * rightLable;
@end
@implementation LLWarehouseDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setModel:(LLWarehouseDetailModel *)model {
    _model = model;
    self.rightLable.textColor = [UIColor blackColor];
    switch (self.indexPath.row) {
        case 0:
            self.leftLable.text = @"仓库:";
            self.rightLable.text = model.houseName;
            break;
        case 1:
            self.leftLable.text = @"品名:";
            self.rightLable.text = model.productName;
            break;
        case 2:
            self.leftLable.text = @"颜色:";
            self.rightLable.text = model.productColorName;
            break;
        case 3:
            self.leftLable.text = @"条数:";
            self.rightLable.text = model.total;
            break;
        case 4:
            self.leftLable.text = @"数量:";
            self.rightLable.text = model.batchNumber;
            break;
        case 5:
            self.leftLable.text = @"成本单价:";
            self.rightLable.text = model.costUnitPrice;
            break;
        case 6:
            self.leftLable.text = @"成本金额:";
            self.rightLable.text = model.costAmount;
            break;
        case 7:
            self.leftLable.text = @"单位:";
            self.rightLable.text = model.unitName;
            break;
        case 8:
            self.leftLable.text = @"成分:";
            self.rightLable.text = model.component;
            break;
        case 9:
            self.leftLable.text = @"幅宽:";
            self.rightLable.text = model.breadth;
            break;
        case 10:
            self.leftLable.text = @"克重:";
            self.rightLable.text = model.weight;
            break;
        case 11:
            self.leftLable.text = @"批号:";
            self.rightLable.text = model.batchNumber;
            break;
        case 12:
            self.leftLable.text = @"货架:";
            self.rightLable.text = model.shelvesNumber;
            self.rightLable.textColor = [UIColor redColor];
            break;
        case 13:
            self.leftLable.text = @"入库时间:";
            self.rightLable.text = [BXSTools stringFrom14Data:model.createTime] ;
            self.rightLable.textColor = [UIColor redColor];
            break;
        case 14:
            self.leftLable.text = @"备注:";
            self.rightLable.text = model.remark;
            break;
        default:
            break;
    }
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.leftLable = [UILabel new];
        [self.contentView addSubview:self.leftLable];
        self.leftLable.font = [UIFont systemFontOfSize:16];
        self.leftLable.textColor = [UIColor blackColor];
        [self.leftLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(12);
            make.centerY.equalTo(self.contentView);
        }];
        
        self.rightLable = [UILabel new];
        [self.contentView addSubview:self.rightLable];
        self.rightLable.font = [UIFont systemFontOfSize:16];
        self.rightLable.textColor = [UIColor blackColor];
        [self.rightLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(SCREEN_WIDTH/2);
            make.centerY.equalTo(self.contentView);
        }];
    }
    return self;
}

@end

@interface LLWarehouseDetailHeaderFooterView()

@end

@implementation LLWarehouseDetailHeaderFooterView
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.timeLable = [UILabel new];
        [self.contentView addSubview:self.timeLable];
        self.timeLable.textColor = [UIColor darkGrayColor];
        self.timeLable.font = [UIFont systemFontOfSize:16];
        [self.timeLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(12);
            make.centerY.equalTo(self.contentView);
        }];
        UIView * lineView = [UIView new];
        [self.contentView addSubview:lineView];
        lineView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.contentView);
            make.height.mas_equalTo(0.8);
        }];
    }
    return self;
}
@end


