//
//  LifeModel.m
//  FlexibleHeightCellDemo
//
//  Created by 周际航 on 15/12/29.
//  Copyright © 2015年 zjh. All rights reserved.
//

#import "LifeModel.h"

@implementation LifeModel

+ (NSDictionary *)objectClassInArray{
    return @{@"commentArr" : [CommentModel class]};
}

+ (NSArray *)fakeLifeModelArr{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Life.json" ofType:@""];
    NSString *jsonStr = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
    
    NSArray *arr = [LifeModel objectArrayWithKeyValuesArray:jsonStr];
    return arr;
}

- (id)newValueFromOldValue:(id)oldValue property:(MJProperty *)property{
    id newValue = oldValue;
    
    if ([property.name isEqualToString:@"timeStamp"]) {
        newValue = [NSDate dateWithTimeIntervalSince1970:[oldValue longValue]];
    }
    
    return newValue;
}

@end


@implementation CommentModel

@end


