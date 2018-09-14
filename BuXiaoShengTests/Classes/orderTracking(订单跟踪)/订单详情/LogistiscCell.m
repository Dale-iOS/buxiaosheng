//
//  LogistiscCell.m
//  BuXiaoSheng
//
//  Created by 王猛 on 2018/9/10.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LogistiscCell.h"

@implementation LogistiscCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setLogisticslModel:(LZPurchasingInfoDetaiLogisticslModel *)logisticslModel
{
    _logisticslModel = logisticslModel;
    _time1.text = [NSString stringWithFormat:@"预计到货时间：%@",logisticslModel.arrivalTime];
    _number.text = [NSString stringWithFormat:@"预计到货数量：%@",logisticslModel.number];
    _time2.text = logisticslModel.createTime;
    _remark.text = logisticslModel.remark;//logisticslModel.remark;
    
    CGSize strSize = [self sizeForString:self.remark.text font:[UIFont systemFontOfSize:14] maxWidth:self.width - 20 - 44];
    CGFloat h = 17+17+10+23.5+strSize.height;
    WMLineView *dLine = [[WMLineView alloc] initWithFrame:CGRectMake(self.line.mj_x, self.line.mj_y, self.line.mj_w, h) withLineLength:5 withLineSpacing:3 withLineColor:[UIColor lightGrayColor]];
    
    [self.contentView addSubview:dLine];
    
}


- (CGSize)sizeForString:(NSString*)content font:(UIFont*)font maxWidth:(CGFloat) maxWidth{
    if (!content || content.length == 0) {
        return CGSizeMake(0, 0);
    }
    
    NSMutableParagraphStyle* paragraphStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle.alignment = NSTextAlignmentLeft;
    
    CGSize contentSize = [content boundingRectWithSize:CGSizeMake(maxWidth, CGFLOAT_MAX)
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                            attributes:@{NSParagraphStyleAttributeName : paragraphStyle,
                                                         NSFontAttributeName : font}
                                               context:nil].size;
    
    return contentSize;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
