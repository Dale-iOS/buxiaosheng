//
//  LLWarehouseDetailVcViewController.m
//  BuXiaoSheng
//
//  Created by lanlan on 2018/9/4.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LLWarehouseDetailVc.h"
#import "LLWarehouseSideModel.h"
#import "LLWarehouseDetailCell.h"
@interface LLWarehouseDetailVc ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic ,strong)UITableView * tableView;
@property(nonatomic ,strong)LLWarehouseDetailModel * dictModel;
@property(nonatomic ,strong)UILabel * timeLable;
@property(nonatomic ,strong)UIView * bottomView;
@end

@implementation LLWarehouseDetailVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self setupData];
    [self setupUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setupUI {
    UIView * timeView = [UIView new];
    timeView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:timeView];
    [timeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(20+LLNavViewHeight);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.mas_equalTo(25);
    }];
    [timeView addSubview:self.timeLable];
    [self.timeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(timeView);
        make.left.equalTo(self.view).offset(12);
    }];
     [self.view addSubview:self.tableView];
    
    if ([self.model.isReduce boolValue]) { //是否有减绑
        [self.view addSubview:self.bottomView];
        [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.view);
            make.height.mas_equalTo(90);
        }];
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.bottom.equalTo(self.bottomView.mas_top);
            make.top.equalTo(timeView.mas_bottom);
        }];
    }else {
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.view);
            make.top.equalTo(timeView.mas_bottom);
        }];
    }
   
   
}

-(void)setupData {
    NSMutableDictionary * param = [NSMutableDictionary dictionary];
    param[@"stockId"] = self.model.stockId;
    param[@"companyId"] = [BXSUser currentUser].companyId;
    [BXSHttp requestGETWithAppURL:@"house_stock/house_product_detail.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue]!=200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
        self.dictModel = [LLWarehouseDetailModel LLMJParse:baseModel.data];
        self.timeLable.text = [BXSTools stringFrom14Data:self.dictModel.createTime] ;
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        [LLHudTools showWithMessage:LLLoadErrorMessage];
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LLWarehouseDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LLWarehouseDetailCell"];
    cell.indexPath = indexPath;
    cell.model = self.dictModel;
    return cell;
}
/// MARK: ---- 懒加载
-(UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[LLWarehouseDetailCell class] forCellReuseIdentifier:@"LLWarehouseDetailCell"];
        _tableView.rowHeight = 45;
    }
    return _tableView;
}
-(UILabel *)timeLable {
    if (!_timeLable) {
        _timeLable = [UILabel new];
        _timeLable.font = [UIFont systemFontOfSize:15];
        _timeLable.textColor = [UIColor darkGrayColor];
    }
    return _timeLable;
}
-(UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [UIView new];
        _bottomView.backgroundColor =[UIColor whiteColor];
        NSArray * titles = @[@"分配",@"合匹",@"加空减空",@"破损"];
        NSArray * images = @[@"fenpi",@"hepi",@"jiakongjiankong",@"posun"];
        CGFloat width = SCREEN_WIDTH/titles.count;
        for (int i = 0; i<titles.count; i++) {
            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
             btn.frame = CGRectMake(i*width, 10, width, 60);
            [_bottomView addSubview:btn];
            [btn setTitleColor:LZAppBlueColor forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:13];
            btn.tag = i;
            [btn setTitle:titles[i] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
            CGFloat offset =10.0f;
            btn.titleEdgeInsets = UIEdgeInsetsMake(0, -btn.imageView.frame.size.width, -btn.imageView.frame.size.height-offset/2, 0);
            // button.imageEdgeInsets = UIEdgeInsetsMake(-button.titleLabel.frame.size.height-offset/2, 0, 0, -button.titleLabel.frame.size.width);
            // 由于iOS8中titleLabel的size为0，用上面这样设置有问题，修改一下即可
            btn.imageEdgeInsets = UIEdgeInsetsMake(-btn.titleLabel.intrinsicContentSize.height-offset/2, 0, 0, -btn.titleLabel.intrinsicContentSize.width);
           
            
        }
    }
    return _bottomView;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
