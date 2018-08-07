//
//  LLTurnoverChatView.m
//  BuXiaoSheng
//
//  Created by lanlan on 2018/8/7.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LLTurnoverChatView.h"
#import "LLHomePieChartModel.h"
#import "DateValueFormatter.h"
@interface LLTurnoverChatView()<ChartViewDelegate>
@property (nonatomic, strong)  LineChartView *chartView;
@end
@implementation LLTurnoverChatView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)setChartData:(NSArray<LLTurnoverListModel *> *)chartData {
    _chartData = chartData;
    [self setDataCount:chartData.count];
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.chartView];
        [_chartView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
    return self;
}


- (void)setDataCount:(NSInteger)count
{
    NSMutableArray *xVals = [[NSMutableArray alloc] init];
    
    NSMutableArray *values = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < count; i++)
    {
        LLTurnoverListModel * model = _chartData[i];
        [xVals addObject:model.date];
        [values addObject:[[ChartDataEntry alloc] initWithX:i y:model.amount icon: [UIImage imageNamed:@"icon"]]];
    }
    _chartView.xAxis.valueFormatter = [[DateValueFormatter alloc]initWithArr:xVals];
    
    LineChartDataSet *set1 = nil;
    if (_chartView.data.dataSetCount > 0)
    {
        set1 = (LineChartDataSet *)_chartView.data.dataSets[0];
        set1.values = values;
        [_chartView.data notifyDataChanged];
        [_chartView notifyDataSetChanged];
    }
    else
    {
        set1 = [[LineChartDataSet alloc] initWithValues:values label:@"DataSet 1"];
        set1.mode = LineChartModeHorizontalBezier;
        set1.drawIconsEnabled = NO;
        
        set1.lineDashLengths = @[@5.f, @2.5f];
        set1.highlightLineDashLengths = @[@5.f, @2.5f];
         set1.drawCircleHoleEnabled = true;
        
        set1.lineCapType = kCGLineCapSquare;
        [set1 setColor:UIColor.whiteColor];
        [set1 setCircleColor:UIColor.blueColor];
        set1.circleHoleColor = [UIColor redColor];
        set1.lineWidth = 1.0;
        set1.circleRadius = 3.0;
       
        set1.valueFont = [UIFont systemFontOfSize:9.f];
        set1.formLineDashLengths = @[@5.f, @2.5f];
        set1.formLineWidth = 1.0;
        set1.formSize = 15.0;
        
        NSArray *gradientColors = @[
                                    (id)[ChartColorTemplates colorFromString:@"#00ff0000"].CGColor,
                                    (id)[ChartColorTemplates colorFromString:@"#ffff0000"].CGColor
                                    ];
        CGGradientRef gradient = CGGradientCreateWithColors(nil, (CFArrayRef)gradientColors, nil);
        
        set1.fillAlpha = 1.f;
        set1.fill = [ChartFill fillWithLinearGradient:gradient angle:90.f];
        set1.drawFilledEnabled = YES;
        
        CGGradientRelease(gradient);
        
        NSMutableArray *dataSets = [[NSMutableArray alloc] init];
        [dataSets addObject:set1];
        
        LineChartData *data = [[LineChartData alloc] initWithDataSets:dataSets];
        
        _chartView.data = data;
    }
}
-(LineChartView *)chartView {
    if (!_chartView) {
        _chartView = [[LineChartView alloc]init];
        _chartView.delegate = self;
        _chartView.chartDescription.enabled = NO;
        _chartView.dragEnabled = YES;
        [_chartView setScaleEnabled:YES];
        _chartView.pinchZoomEnabled = YES;
        _chartView.drawGridBackgroundEnabled = NO;
        ChartXAxis *xaxis = _chartView.xAxis;
        xaxis.labelPosition = XAxisLabelPositionBottom;
        xaxis.gridColor = [UIColor clearColor];
        _chartView.rightAxis.enabled = NO;//不绘制右边轴
        ChartYAxis *leftAxis = _chartView.leftAxis;//获取左边Y轴
        leftAxis.labelCount = 4;//Y轴label数量，数值不一定，如果forceLabelsEnabled等于YES, 则强制绘制制定数量的label, 但是可能不平均
        leftAxis.forceLabelsEnabled = false;//不强制绘制指定数量的label
        // leftAxis.axisMinValue = 0;//设置Y轴的最小值
        //leftAxis.axisMaxValue = 105;//设置Y轴的最大值
        leftAxis.inverted = NO;//是否将Y轴进行上下翻转
        leftAxis.axisLineColor = [UIColor grayColor];//Y轴颜色
        // leftAxis.valueFormatter = [[SymbolsValueFormatter alloc]init];
        leftAxis.labelPosition = YAxisLabelPositionOutsideChart;//label位置
        // leftAxis.labelTextColor = HYC_HEXCOLOR(0x9A9A9A); //hexColor(@"#9A9A9A");//[UIColor blackColor];//文字颜色
        leftAxis.labelFont = [UIFont systemFontOfSize:10.0f];//文字字体
        leftAxis.gridColor = [UIColor clearColor];//网格线颜色
        leftAxis.gridAntialiasEnabled = true;//开启抗锯齿
        leftAxis.granularityEnabled = true;//设置重复的值不显示
        
//        BalloonMarker *marker = [[BalloonMarker alloc]
//                                 initWithColor: [UIColor colorWithWhite:180/255. alpha:1.0]
//                                 font: [UIFont systemFontOfSize:12.0]
//                                 textColor: UIColor.whiteColor
//                                 insets: UIEdgeInsetsMake(8.0, 8.0, 20.0, 8.0)];
//        marker.chartView = _chartView;
//        marker.minimumSize = CGSizeMake(80.f, 40.f);
//        _chartView.marker = marker;
//
//        _chartView.legend.form = ChartLegendFormLine;
//
//        _sliderX.value = 45.0;
//        _sliderY.value = 100.0;
    }
    return _chartView;
}

@end
