//
//  LLHomeChildCell.m
//  BuXiaoSheng
//
//  Created by lanlan on 2018/8/7.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LLHomeChildCell.h"
#import "LLHomePieChartModel.h"
@interface LLHomeChildCell()
@property(nonatomic ,strong)PieChartView * pieChartView;
@property(nonatomic ,strong)LLHomePieChartModel * pieChartModel;
@end
@implementation LLHomeChildCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setIndexPath:(NSIndexPath *)indexPath {
    _indexPath = indexPath;
    switch (indexPath.row) {
        case 0:
            
            break;
        case 1:
            
            break;
        case 2:
            
            break;
        default:
            break;
    }
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

-(void)setupUI {
    [self.contentView addSubview:self.pieChartView];
    [self.pieChartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
        
    }];
}

-(void)setupPieCharData {
    //每个区块的数据
    NSMutableArray *yVals = [[NSMutableArray alloc] init];
    
    [self.pieChartModel.bigGoodsList enumerateObjectsUsingBlock:^(LLBigGoodsListModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [yVals addObject: [[PieChartDataEntry alloc] initWithValue:obj.number label:obj.productName icon: nil]];
    }];
    //    for (int i = 0; i < count; i++) {
    //        switch (i) {//大货列表
    //            case 0:
    //            {
    //                [self.pieChartModel.bigGoodsList enumerateObjectsUsingBlock:^(LLBigGoodsListModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
    //                   [yVals addObject: [[PieChartDataEntry alloc] initWithValue:obj.number label:@"大货列表" icon: nil]];
    //                }];
    //            }
    //                break;
    //            case 1://销售业绩列表
    //            {
    //                [self.pieChartModel.saleList enumerateObjectsUsingBlock:^(LLSaleListModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
    //                    [yVals addObject: [[PieChartDataEntry alloc] initWithValue:obj.number label:@"销售业绩列表" icon: nil]];
    //                }];
    //            }
    //                break;
    //            case 2://板布列表
    //            {
    //                [self.pieChartModel.sheetClothList enumerateObjectsUsingBlock:^(LLSheetClothListModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
    //                  [yVals addObject: [[PieChartDataEntry alloc] initWithValue:obj.number label:@"板布列表" icon: nil]];
    //                }];
    //            }
    //                break;
    //            case 3://最近半年营业额度列表
    //            {
    //                [self.pieChartModel.turnoverList enumerateObjectsUsingBlock:^(LLTurnoverListModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
    //                    [yVals addObject: [[PieChartDataEntry alloc] initWithValue:obj.amount label:@"最近半年营业额度列表" icon: nil]];
    //                }];
    //            }
    //                break;
    //            default:
    //                break;
    //        }
    //    }
    PieChartDataSet *dataSet = [[PieChartDataSet alloc] initWithValues:yVals label:@"Election Results"];
    
    dataSet.drawIconsEnabled = NO;
    
    dataSet.sliceSpace = 2.0;
    dataSet.iconsOffset = CGPointMake(0, 40);
    
    // add a lot of colors
    
    NSMutableArray *colors = [[NSMutableArray alloc] init];
    [colors addObjectsFromArray:ChartColorTemplates.material];
    [colors addObjectsFromArray:ChartColorTemplates.vordiplom];
    [colors addObjectsFromArray:ChartColorTemplates.joyful];
    [colors addObjectsFromArray:ChartColorTemplates.colorful];
    [colors addObjectsFromArray:ChartColorTemplates.liberty];
    [colors addObjectsFromArray:ChartColorTemplates.pastel];
    [colors addObject:[UIColor colorWithRed:51/255.f green:181/255.f blue:229/255.f alpha:1.f]];
    
    dataSet.colors = colors;
    
    PieChartData *data = [[PieChartData alloc] initWithDataSet:dataSet];
    
    NSNumberFormatter *pFormatter = [[NSNumberFormatter alloc] init];
    pFormatter.numberStyle = NSNumberFormatterPercentStyle;
    pFormatter.maximumFractionDigits = 1;
    pFormatter.multiplier = @1.f;
    pFormatter.percentSymbol = @" %";
    [data setValueFormatter:[[ChartDefaultValueFormatter alloc] initWithFormatter:pFormatter]];
    [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:11.f]];
    [data setValueTextColor:UIColor.whiteColor];
    _pieChartView.data = data;
    [_pieChartView highlightValues:nil];
    
    NSMutableAttributedString *centerText = [[NSMutableAttributedString alloc] initWithString:@"大货列表"];
    _pieChartView.centerAttributedText = centerText;
    
}


/// MARK: ---- 懒加载
-(PieChartView *)pieChartView {
    if (!_pieChartView) {
        _pieChartView = [[PieChartView alloc] init];
        _pieChartView.delegate = self;
//        [self.view addSubview:_pieChartView];
        [_pieChartView setExtraOffsetsWithLeft:30 top:0 right:30 bottom:0];//饼状图距离边缘的间隙
        _pieChartView.usePercentValuesEnabled = YES;//是否根据所提供的数据, 将显示数据转换为百分比格式
        _pieChartView.dragDecelerationEnabled = YES;//拖拽饼状图后是否有惯性效果
        _pieChartView.drawCenterTextEnabled = true;//是否显示区块文本
        _pieChartView.drawHoleEnabled = false;//饼状图是否是空心
        _pieChartView.holeRadiusPercent = 0.6;//空心半径占比
        _pieChartView.holeColor = [UIColor clearColor];//空心颜色
        _pieChartView.transparentCircleRadiusPercent = 0.4;//半透明空心半径占比
        _pieChartView.transparentCircleColor = [UIColor clearColor];//半透明空心的颜色
        
        //添加图例
        ChartLegend *l = _pieChartView.legend;
        l.horizontalAlignment = ChartLegendHorizontalAlignmentRight;
        l.verticalAlignment = ChartLegendVerticalAlignmentTop;
        l.orientation = ChartLegendOrientationVertical;
        l.drawInside = NO;
        l.xEntrySpace = 7.0;
        l.yEntrySpace = 0.0;
        l.yOffset = 0.0;
        
        // entry label styling
        _pieChartView.entryLabelColor = UIColor.whiteColor;
        _pieChartView.entryLabelFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:12.f];
        
        [_pieChartView animateWithXAxisDuration:1.4 easingOption:ChartEasingOptionEaseOutBack];
    }
    return _pieChartView;
}


@end
