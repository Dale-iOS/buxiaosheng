//
//  Tools
//  对账详情
//
//  Created by 王猛 on 2018/8/8.
//  Copyright © 2018年 WM. All rights reserved.
//

#import "Tools.h"

@implementation Tools

+(id)readJsonFileWithPath:(NSString* __nullable)filePath FileName:(NSString*)fileName{
    if (filePath == nil || [filePath isEqualToString:@""]) {
        filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"json"];
    }
    
    NSError * _Nullable  error;
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves|NSJSONReadingMutableContainers|NSJSONReadingMutableLeaves error: &error];
    if (error) {
        NSLog(@"%@", error.localizedDescription);
    }
    
    return json;
}
@end
