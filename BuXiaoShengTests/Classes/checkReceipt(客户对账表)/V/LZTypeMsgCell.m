//
//  LZTypeMsgCell.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/8/8.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LZTypeMsgCell.h"
#import "LZTypeTopModel.h"

static NSString *cellMark = @"cellMark";
@interface LZTypeMsgCell()
@property (nonatomic,strong)NSMutableArray <UILabel *>*msgContain;
@end

@implementation LZTypeMsgCell

- (NSMutableArray *)msgContain {
    if (!_msgContain) {
        _msgContain = [NSMutableArray arrayWithCapacity:0];
    }
    return _msgContain;
}

- (void)setCellTxtWith:(LZTypeTopModel *)model {
    UILabel *remakeLable = self.msgContain.lastObject;
    CGRect tmpRect = remakeLable.frame;
    tmpRect.size.height = model.remakeHeight;
    remakeLable.frame = tmpRect;
    remakeLable.text = model.remark;
    
    self.msgContain[0].text = model.drawerName;
    self.msgContain[1].text = model.customerMobile;
    self.msgContain[2].text = model.orderNo;
    self.msgContain[3].text = model.customerName;
    //TODO:略
    
}

+ (LZTypeMsgCell *)resuLZTypeMsgCell:(UITableView *)tableView {
    LZTypeMsgCell *cell = [tableView dequeueReusableCellWithIdentifier:cellMark];
    if (!cell) {
        cell = [[LZTypeMsgCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellMark];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUI];
    }
    return self;
}

- (void)setUI {
    
    UILabel *msgTime = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, APPWidth - 10, 30)];
    [self.contentView addSubview:msgTime];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 30, APPWidth, 1)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:lineView];
    
    NSArray *titles = @[@"客户",@"客户电话",@"单号",@"入库仓",@"应付金额",@"实付金额",@"预收付款",@"收款方式",@"备注"];
    
    for (int i = 0; i < 9; i++) {
        UILabel *tempLable = [[UILabel alloc] initWithFrame:CGRectMake(10, 35 + i * 35, 80, 30)];
        tempLable.font = [UIFont systemFontOfSize:14.0];
        tempLable.text = titles[i];
        tempLable.textColor = [UIColor colorWithRed:144/255.0 green:145/255.0 blue:145/255.0 alpha:1.0];
        [self.contentView addSubview:tempLable];
        
        UILabel *msgLable = [[UILabel alloc] initWithFrame:CGRectMake(90 + 10, 35 + i * 35, APPWidth - 120, 30)];
        msgLable.font = [UIFont systemFontOfSize:13.0];
        if (i == 8) {
            msgLable.numberOfLines = 0;
        }
        [self.contentView addSubview:msgLable];
        [self.msgContain addObject:msgLable];
    }
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
