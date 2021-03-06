//
//  LLQuarterCalendarVc.m
//  iOS仿钉钉智能报表日历
//
//  Created by 周尊贤 on 2018/5/28.
//  Copyright © 2018年 周尊贤. All rights reserved.
//

#import "LLQuarterCalendarVc.h"
#import "LLMonthModel.h"
#import "HYCGetDateAttribute.h"
#import "LLMonthCollectionViewCell.h"
@interface LLQuarterCalendarVc ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    NSString *_selectStr1;
    NSString *_selectStr2;
}
@property (nonatomic,strong) UICollectionView * collectionView;
@property (nonatomic,copy) NSMutableArray <LLMonthModel*>* months;
@property (nonatomic,strong) HYCGetDateAttribute * dateAttribute;
@property (nonatomic,strong) UILabel * yearLable;
@property(nonatomic,strong)UIButton *affirmBtn;//确认按钮
@property(nonatomic,strong)UIButton *cancelBtn;//取消按钮
@end

@implementation LLQuarterCalendarVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dateAttribute = [HYCGetDateAttribute new];
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    self.dateAttribute.HYC_GLTime = [formatter stringFromDate:[NSDate date]];
    for (int i = 0 ; i<4; i++) {
        LLMonthModel * model = [LLMonthModel new];
        model.month = [NSString stringWithFormat:@"第%d季度",i+1];
        [ self.months addObject:model];
    }
    UIView * seletedYearView = [self setupSeletedYearView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(seletedYearView.mas_bottom);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(300);
    }];
    
    //    取消按钮
    _cancelBtn = [[UIButton alloc]initWithFrame:CGRectZero];
    [_cancelBtn setBackgroundColor:[UIColor whiteColor]];
    _cancelBtn.titleLabel.font = FONT(14);
    [_cancelBtn setTitleColor:CD_Text33 forState:UIControlStateNormal];
    [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    _cancelBtn.layer.borderColor = [UIColor grayColor].CGColor;
    _cancelBtn.layer.borderWidth = 0.5;
    [_cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.collectionView addSubview:_cancelBtn];
    [_cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.collectionView);
        make.bottom.equalTo(self.collectionView).offset(300);
        make.width.mas_offset(APPWidth *0.5);
        make.height.mas_offset(50);
    }];
    
    //确认按钮
    _affirmBtn = [[UIButton alloc]initWithFrame:CGRectZero];
    [_affirmBtn setBackgroundColor:[UIColor whiteColor]];
    _affirmBtn.titleLabel.font = FONT(14);
    [_affirmBtn setTitleColor:LZAppBlueColor forState:UIControlStateNormal];
    [_affirmBtn setTitle:@"确认" forState:UIControlStateNormal];
    _affirmBtn.layer.borderColor = [UIColor grayColor].CGColor;
    _affirmBtn.layer.borderWidth = 0.5;
    [_affirmBtn addTarget:self action:@selector(affirmBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.collectionView addSubview:_affirmBtn];
    [_affirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.collectionView).offset(APPWidth*0.5);
        make.bottom.equalTo(self.collectionView).offset(300);
        make.width.mas_offset(APPWidth *0.5);
        make.height.mas_offset(50);
    }];
}

// 取消点击事件
- (void)cancelBtnClick{
    if ([self.delegate respondsToSelector:@selector(didCancelBtnInCalendar)]) {
        [self.delegate didCancelBtnInCalendar];
    }
}

// 确认点击事件
- (void)affirmBtnClick{
    if ([self.delegate respondsToSelector:@selector(didaffirmBtnInQuarterCalendarWithDateStartStr:andEndStr:)]) {
        [self.delegate didaffirmBtnInQuarterCalendarWithDateStartStr:_selectStr1 andEndStr:_selectStr2];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(UIView *)setupSeletedYearView {
    UIView * view = [UIView new];
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(50);
    }];
    
    self.yearLable = [UILabel new];
    self.yearLable.textAlignment = NSTextAlignmentCenter;
    self.yearLable.textColor = [UIColor darkGrayColor];
    self.yearLable.font = [UIFont systemFontOfSize:16];
    [view addSubview:self.yearLable];
    self.yearLable.text = self.dateAttribute.HYC_GLYears;
    [self.yearLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(view);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(25);
    }];
    
    UIButton * prevBtn = [UIButton new];
    [prevBtn addTarget:self action:@selector(prevBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:prevBtn];
    [prevBtn setBackgroundImage:[UIImage imageNamed:@"icon_prev"] forState:UIControlStateNormal];
    [prevBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.yearLable.mas_left).offset(-12);
        make.centerY.equalTo(view);
    }];
    
    UIButton * nextBtn = [UIButton new];
    [view addSubview:nextBtn];
    [nextBtn addTarget:self action:@selector(nextBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [nextBtn setBackgroundImage:[UIImage imageNamed:@"icon_next"] forState:UIControlStateNormal];
    [nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.yearLable.mas_right).offset(12);
        make.centerY.equalTo(view);
    }];
    
    return view;
}

//选择上一年
-(void)prevBtnClick {
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    self.dateAttribute.HYC_GLTime = [formatter stringFromDate:[self OneMothisUP:false]];
    self.yearLable.text = self.dateAttribute.HYC_GLYears;
    
    //跟着年的变化跟新选中的日期
    _selectStr1 = [_selectStr1 substringFromIndex:4];
    _selectStr1 = [NSString stringWithFormat:@"%@%@",self.yearLable.text,_selectStr1];
    NSLog(@"%@",_selectStr1);
    _selectStr2 = [_selectStr2 substringFromIndex:4];
    _selectStr2 = [NSString stringWithFormat:@"%@%@",self.yearLable.text,_selectStr2];
    NSLog(@"%@",_selectStr2);
}

//选择下一年
-(void)nextBtnClick {

    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    self.dateAttribute.HYC_GLTime = [formatter stringFromDate:[self OneMothisUP:true]];
    self.yearLable.text = self.dateAttribute.HYC_GLYears;
    
    //跟着年的变化跟新选中的日期
    _selectStr1 = [_selectStr1 substringFromIndex:4];
    _selectStr1 = [NSString stringWithFormat:@"%@%@",self.yearLable.text,_selectStr1];
    NSLog(@"%@",_selectStr1);
    _selectStr2 = [_selectStr2 substringFromIndex:4];
    _selectStr2 = [NSString stringWithFormat:@"%@%@",self.yearLable.text,_selectStr2];
    NSLog(@"%@",_selectStr2);
}

- (NSDate*)OneMothisUP:(BOOL)isUP{
    
    static NSInteger indexYear = 0 ;
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateFormatter *formatter1 = [[NSDateFormatter alloc]init];
    [formatter1 setDateFormat:@"yyyy-MM-dd"];
    
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    //[adcomps setYear:0];
    if (isUP) [adcomps setYear:indexYear++];
    else      [adcomps setYear:indexYear--];
    [adcomps setMonth:0];
    [adcomps setDay:0];
    return [calendar dateByAddingComponents:adcomps toDate:[NSDate date] options:NSCalendarWrapComponents];
    
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.months.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LLMonthCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LLMonthCollectionViewCell" forIndexPath:indexPath];
    cell.model = self.months[indexPath.row];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self.months enumerateObjectsUsingBlock:^(LLMonthModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.seleted = false;
        if (idx == indexPath.row) {
            obj.seleted = true;
        }
    }];
    
    NSInteger year = [self.yearLable.text integerValue];
    NSString *month = 0;
    
    NSInteger days = [self howManyDaysInThisYear:year withMonth:indexPath.row*3];
    //月初那一天
    _selectStr1 = [NSString stringWithFormat:@"%zd-%@-01",year,month];
    //月末那一天
    _selectStr2 = [NSString stringWithFormat:@"%zd-%@-%zd",year,month,days];
    
    switch (indexPath.row) {
        case 0:
            //月初那一天
            _selectStr1 = [NSString stringWithFormat:@"%zd-01-01",year];
            //月末那一天
            _selectStr2 = [NSString stringWithFormat:@"%zd-03-%zd",year,days];
            break;
        case 1:
            //月初那一天
            _selectStr1 = [NSString stringWithFormat:@"%zd-04-01",year];
            //月末那一天
            _selectStr2 = [NSString stringWithFormat:@"%zd-06-%zd",year,days];
            break;
        case 2:
            //月初那一天
            _selectStr1 = [NSString stringWithFormat:@"%zd-07-01",year];
            //月末那一天
            _selectStr2 = [NSString stringWithFormat:@"%zd-09-%zd",year,days];
            break;
        case 3:
            //月初那一天
            _selectStr1 = [NSString stringWithFormat:@"%zd-10-01",year];
            //月末那一天
            _selectStr2 = [NSString stringWithFormat:@"%zd-12-%zd",year,days];
            break;
            
        default:
            break;
    }
    
    NSLog(@"%@ - %@",_selectStr1,_selectStr2);
    [collectionView reloadData];
}

-(UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout * layout = [UICollectionViewFlowLayout new];
        layout.minimumLineSpacing  = 30;
        layout.minimumInteritemSpacing = 16;
        layout.itemSize = CGSizeMake(80, 35);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [_collectionView registerClass:[LLMonthCollectionViewCell class] forCellWithReuseIdentifier:@"LLMonthCollectionViewCell"];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}

-(NSMutableArray<LLMonthModel *> *)months {
    if (!_months) {
        _months = [NSMutableArray array];
    }
    return _months;
}

#pragma mark - 获取某年某月的天数
- (NSInteger)howManyDaysInThisYear:(NSInteger)year withMonth:(NSInteger)month{
    if((month == 1) || (month == 3) || (month == 5) || (month == 7) || (month == 8) || (month == 10) || (month == 12))
        return 31 ;
    
    if((month == 4) || (month == 6) || (month == 9) || (month == 11))
        return 30;
    
    if((year % 4 == 1) || (year % 4 == 2) || (year % 4 == 3))
    {
        return 28;
    }
    
    if(year % 400 == 0)
        return 29;
    
    if(year % 100 == 0)
        return 28;
    
    return 29;
}

@end
