//
//  FlexibleHeightCell.h
//  FlexibleHeightCellDemo
//
//  Created by 周际航 on 15/12/29.
//  Copyright © 2015年 zjh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LifeModel.h"

@interface FlexibleHeightCell : UITableViewCell

// 说说模型
@property (nonatomic, strong) LifeModel *lifeModel;

+ (NSString *)identify;

- (CGFloat)cellHeight;

@end
