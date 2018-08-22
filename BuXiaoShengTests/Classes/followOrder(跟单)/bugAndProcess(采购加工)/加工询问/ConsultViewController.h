//
//  ConsultViewController.h
//  对账详情
//
//  Created by 王猛 on 2018/8/21.
//  Copyright © 2018年 WM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConsultViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property(nonatomic,copy) NSString *bugId;
@end
