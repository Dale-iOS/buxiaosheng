//
//  HRTableViewOne.h
//  segment
//
//  Created by HR_W on 16/4/22.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HRTableViewOne : UITableView

@end



//NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId};
//[BXSHttp requestGETWithAppURL:@"button_home.do" param:param success:^(id response) {
//    
//    LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
//    if ([baseModel.code integerValue]!=200) {
//        return ;
//    }
//    LLCashBankModel * model = [LLCashBankModel LLMJParse:baseModel.data];
//    
//} failure:^(NSError *error) {
//    BXS_Alert(LLLoadErrorMessage)
//    }];
