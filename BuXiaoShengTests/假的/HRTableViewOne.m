//
//  HRTableViewOne.m
//  segment
//
//  Created by HR_W on 16/4/22.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "HRTableViewOne.h"

@interface HRTableViewOne ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation HRTableViewOne

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
            //self.backgroundColor = [UIColor redColor];
        self.delegate = self;
        self.dataSource = self;
        self.bounces = NO;
    }
    return self;
}

- (NSInteger)numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cellOne"];
    cell.textLabel.text = @"名字";
    cell.detailTextLabel.text = @"这是我我的签名";
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        //cell.backgroundColor = [UIColor redColor];
    return cell;
    
}


@end
