//
//  LLDayCalendarVc.m
//  iOS仿钉钉智能报表日历
//
//  Created by 周尊贤 on 2018/5/28.
//  Copyright © 2018年 周尊贤. All rights reserved.
//

#import "LLDayCalendarVc.h"
#import "ViewController.h"
#import "FSCalendar.h"
#import "LLDayRangeCell.h"
@interface LLDayCalendarVc ()<FSCalendarDataSource,FSCalendarDelegate>
@property (weak, nonatomic) FSCalendar *calendar;

@property (weak, nonatomic) UILabel *eventLabel;
@property (strong, nonatomic) NSCalendar *gregorian;
@property (strong, nonatomic) NSDateFormatter *dateFormatter;

// The start date of the range
@property (strong, nonatomic) NSDate *date1;
// The end date of the range
@property (strong, nonatomic) NSDate *date2;
@property(nonatomic,strong)UIButton *affirmBtn;//确认按钮
@property(nonatomic,strong)UIButton *cancelBtn;//取消按钮
@end

@implementation LLDayCalendarVc

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupCalendarView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    NSLog(@"%s",__FUNCTION__);
}


- (void)setupCalendarView
{
    self.gregorian = [NSCalendar currentCalendar];
    self.dateFormatter = [[NSDateFormatter alloc] init];
    self.dateFormatter.dateFormat = @"yyyyMMdd";
    self.calendar.accessibilityIdentifier = @"calendar";
    
    //    UIView *view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    //    view.backgroundColor = [UIColor whiteColor];
    //    self.view = view;
    
    //CGFloat height = [[UIDevice currentDevice].model hasPrefix:@"iPad"] ? 450 : 300;
    CGFloat statusHeight = CGRectGetHeight([UIApplication sharedApplication].statusBarFrame);
    CGFloat pageTitleViewY = 0;
    if (statusHeight == 20.0) {
        pageTitleViewY = 64;
    } else {
        pageTitleViewY = 88;
    }
    FSCalendar *calendar = [[FSCalendar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 300)];
    calendar.dataSource = self;
    calendar.delegate = self;
    calendar.backgroundColor = [UIColor whiteColor];
    calendar.appearance.headerMinimumDissolvedAlpha = 0;
    calendar.appearance.caseOptions = FSCalendarCaseOptionsHeaderUsesDefaultCase;
    [calendar registerClass:[LLDayRangeCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:calendar];
    self.calendar = calendar;
    
    UIButton *previousButton = [UIButton buttonWithType:UIButtonTypeCustom];
    previousButton.frame = CGRectMake(0, 0, 95, 34);
    previousButton.backgroundColor = [UIColor whiteColor];
    previousButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [previousButton setImage:[UIImage imageNamed:@"icon_prev"] forState:UIControlStateNormal];
    [previousButton addTarget:self action:@selector(previousClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:previousButton];
    //self.previousButton = previousButton;
    
    UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    nextButton.frame = CGRectMake(CGRectGetWidth(self.view.frame)-95, 0, 95, 34);
    nextButton.backgroundColor = [UIColor whiteColor];
    nextButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [nextButton setImage:[UIImage imageNamed:@"icon_next"] forState:UIControlStateNormal];
    [nextButton addTarget:self action:@selector(nextClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextButton];
    self.date1 = [calendar today];
    
    //取消按钮
    _cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, calendar.bottom , APPWidth *0.5, 50)];
    [_cancelBtn setBackgroundColor:[UIColor whiteColor]];
    _cancelBtn.titleLabel.font = FONT(14);
    [_cancelBtn setTitleColor:CD_Text33 forState:UIControlStateNormal];
    [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    _cancelBtn.layer.borderColor = [UIColor grayColor].CGColor;
    _cancelBtn.layer.borderWidth = 0.5;
    [_cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_cancelBtn];
    
    //确认按钮
    _affirmBtn = [[UIButton alloc]initWithFrame:CGRectMake(_cancelBtn.right, calendar.bottom, APPWidth *0.5, 50)];
    [_affirmBtn setBackgroundColor:[UIColor whiteColor]];
    _affirmBtn.titleLabel.font = FONT(14);
    [_affirmBtn setTitleColor:LZAppBlueColor forState:UIControlStateNormal];
    [_affirmBtn setTitle:@"确认" forState:UIControlStateNormal];
    _affirmBtn.layer.borderColor = [UIColor grayColor].CGColor;
    _affirmBtn.layer.borderWidth = 0.5;
    [_affirmBtn addTarget:self action:@selector(affirmBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_affirmBtn];
    
}

#pragma mark --- 点击事件 ---
// 取消点击事件
- (void)cancelBtnClick{
    if ([self.delegate respondsToSelector:@selector(didCancelBtnInCalendar)]) {
        [self.delegate didCancelBtnInCalendar];
    }
}
// 确认点击事件
- (void)affirmBtnClick{
    
    NSInteger startInteger = [[self.dateFormatter stringFromDate:self.date1]integerValue];
    NSInteger endInteger = [[self.dateFormatter stringFromDate:self.date2]integerValue];
    NSString *startStr = @"";
    NSString *endStr = @"";
    
    if (startInteger < endInteger) {
        startStr = [NSString stringWithFormat:@"%zd",startInteger];
        endStr = [NSString stringWithFormat:@"%zd",endInteger];
    }else{
        startStr = [NSString stringWithFormat:@"%zd",endInteger];
        endStr = [NSString stringWithFormat:@"%zd",startInteger];
    }
    
//    NSString *dateStr = @"";
//    if (self.date2 == nil) {
//        NSLog(@"%@",[self.dateFormatter stringFromDate:self.date1]);
//        dateStr = [self.dateFormatter stringFromDate:self.date1];
//    }else{
//        NSLog(@"%@-%@",[self.dateFormatter stringFromDate:self.date2],[self.dateFormatter stringFromDate:self.date1]);
//        dateStr = [NSString stringWithFormat:@"%@-%@",[self.dateFormatter stringFromDate:self.date2],[self.dateFormatter stringFromDate:self.date1]];
//    }
//
    if ([self.delegate respondsToSelector:@selector(didaffirmBtnInCalendarWithDateStartStr:andEndStr:)]) {
        [self.delegate didaffirmBtnInCalendarWithDateStartStr:startStr andEndStr:endStr];
    }
    
}

#pragma mark - FSCalendarDataSource

- (NSDate *)minimumDateForCalendar:(FSCalendar *)calendar
{
    return [self.dateFormatter dateFromString:@"2001-01-01"];
}

- (NSDate *)maximumDateForCalendar:(FSCalendar *)calendar
{
    return [self.gregorian dateByAddingUnit:NSCalendarUnitMonth value:10 toDate:[NSDate date] options:0];
}

- (NSString *)calendar:(FSCalendar *)calendar titleForDate:(NSDate *)date
{
    if ([self.gregorian isDateInToday:date]) {
        return @"今";
    }
    return nil;
}

- (FSCalendarCell *)calendar:(FSCalendar *)calendar cellForDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    LLDayRangeCell *cell = [calendar dequeueReusableCellWithIdentifier:@"cell" forDate:date atMonthPosition:monthPosition];
    return cell;
}

- (void)calendar:(FSCalendar *)calendar willDisplayCell:(FSCalendarCell *)cell forDate:(NSDate *)date atMonthPosition: (FSCalendarMonthPosition)monthPosition
{
    [self configureCell:cell forDate:date atMonthPosition:monthPosition];
}

#pragma mark - FSCalendarDelegate

- (BOOL)calendar:(FSCalendar *)calendar shouldSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    return true;
}

- (BOOL)calendar:(FSCalendar *)calendar shouldDeselectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    return true;
}


- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    if ((self.date1 && self.date2 == nil)||[self.date1 compare:self.date2 ] == NSOrderedSame) {
        self.date2 = date;
    }else if (self.date1 && self.date2){
        self.date1 = date;
        self.date2 = nil;
    }
    //if (calendar.swipeToChooseGesture.state == UIGestureRecognizerStateChanged) {
    // If the selection is caused by swipe gestures
    //        if (!self.date1) {
    //            self.date1 = date;
    //        } else {
    //            if (self.date2) {
    //                [calendar deselectDate:self.date2];
    //            }
    //            self.date2 = date;
    //        }
    //    } else {
    //        if (self.date2) {
    //            [calendar deselectDate:self.date1];
    //            [calendar deselectDate:self.date2];
    //            self.date1 = date;
    //            self.date2 = nil;
    //        } else if (!self.date1) {
    //            self.date1 = date;
    //        } else {
    //            self.date2 = date;
    //        }
    //}
    
    [self configureVisibleCells];
}

- (void)calendar:(FSCalendar *)calendar didDeselectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    NSLog(@"did deselect date %@",[self.dateFormatter stringFromDate:date]);
    [self configureVisibleCells];
}

- (NSArray<UIColor *> *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance eventDefaultColorsForDate:(NSDate *)date
{
    if ([self.gregorian isDateInToday:date]) {
        return @[[UIColor orangeColor]];
    }
    return @[appearance.eventDefaultColor];
}

#pragma mark - Private methods

- (void)configureVisibleCells
{
    [self.calendar.visibleCells enumerateObjectsUsingBlock:^(__kindof FSCalendarCell * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDate *date = [self.calendar dateForCell:obj];
        FSCalendarMonthPosition position = [self.calendar monthPositionForCell:obj];
        [self configureCell:obj forDate:date atMonthPosition:position];
    }];
}

- (void)configureCell:(__kindof FSCalendarCell *)cell forDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)position
{
    LLDayRangeCell *rangeCell = cell;
    if (position == FSCalendarMonthPositionCurrent) {
        //        rangeCell.middleLayer.hidden = YES;
        //        rangeCell.selectionLayer.hidden = YES;
        //        rangeCell.markLable.hidden = true;
        rangeCell.titleLabel.textColor = [UIColor blackColor];
        
    }else {
        rangeCell.titleLabel.textColor = [UIColor lightGrayColor];
    }
    if ((self.date1 && self.date2 == nil) ||[self.date1 compare:self.date2] == NSOrderedSame) {
        if ([self.date1 compare:date] == NSOrderedSame) {
            rangeCell.markLable.text = @"开始";
            rangeCell.markLable.hidden = false;
        }
    }
    if (self.date1 && self.date2) {
        // The date is in the middle of the range
        BOOL isMiddle = [date compare:self.date1] != [date compare:self.date2];
        rangeCell.middleLayer.hidden = !isMiddle;
        rangeCell.markLable.hidden = true;
        if (isMiddle) {
            rangeCell.titleLabel.textColor = [UIColor whiteColor];
        }else {
            
        }
        if ([self.date1 compare:self.date2] == NSOrderedAscending) {
            if ([self.date1 compare:date] == NSOrderedSame) {
                rangeCell.markLable.text = @"开始";
                rangeCell.markLable.hidden = false;
            }
            if ([self.date2 compare:date] == NSOrderedSame) {
                rangeCell.markLable.text = @"结束";
                rangeCell.markLable.hidden = false;
            }
        }
        else if([self.date1 compare:self.date2] == NSOrderedDescending) {
            if ([self.date1 compare:date] == NSOrderedSame) {
                rangeCell.markLable.text = @"结束";
                rangeCell.markLable.hidden = false;
            }
            if ([self.date2 compare:date] == NSOrderedSame) {
                rangeCell.markLable.text = @"开始";
                rangeCell.markLable.hidden = false;
            }
        }
        
    } else {
        rangeCell.middleLayer.hidden = YES;
        // rangeCell.titleLabel.textColor = [UIColor blackColor];
    }
    BOOL isSelected = NO;
    isSelected |= self.date1 && [self.gregorian isDate:date inSameDayAsDate:self.date1];
    isSelected |= self.date2 && [self.gregorian isDate:date inSameDayAsDate:self.date2];
    rangeCell.selectionLayer.hidden = !isSelected;
    
}

- (void)previousClicked:(id)sender
{
    NSDate *currentMonth = self.calendar.currentPage;
    NSDate *previousMonth = [self.gregorian dateByAddingUnit:NSCalendarUnitMonth value:-1 toDate:currentMonth options:0];
    [self.calendar setCurrentPage:previousMonth animated:YES];
}

- (void)nextClicked:(id)sender
{
    NSDate *currentMonth = self.calendar.currentPage;
    NSDate *nextMonth = [self.gregorian dateByAddingUnit:NSCalendarUnitMonth value:1 toDate:currentMonth options:0];
    [self.calendar setCurrentPage:nextMonth animated:YES];
}
@end
