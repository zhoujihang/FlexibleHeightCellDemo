//
//  CommentView.h
//  FlexibleHeightCellDemo
//
//  Created by 周际航 on 15/12/29.
//  Copyright © 2015年 zjh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LifeModel.h"
@interface CommentView : UIView

// 评论的数据源
@property (nonatomic, strong, readonly) LifeModel *lifeModel;
// 视图的最大宽度，用于计算label文字的宽
@property (nonatomic, assign, readonly) CGFloat maxViewWidth;

/**
 *  生成评论
 *
 *  @param lifeModel 包含评论列表
 *  @param viewWidth 视图最大宽度
 *
 *  @return 填充完毕后视图的高度
 */
- (CGFloat)fillDetailWithModel:(LifeModel *)lifeModel maxViewWidth:(CGFloat)viewWidth;

@end
