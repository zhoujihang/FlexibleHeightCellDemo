//
//  SingleCommentView.h
//  FlexibleHeightCellDemo
//
//  Created by 周际航 on 15/12/29.
//  Copyright © 2015年 zjh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LifeModel.h"
@interface SingleCommentView : UIView

@property (nonatomic, strong, readonly) CommentModel *commentModel;

@property (nonatomic, assign, readonly) CGFloat maxViewWidth;

// 显示底部分割线
@property (nonatomic, assign) BOOL showBottomLine;
/**
 *  生成评论
 *
 *  @param commentModel 评论
 *  @param viewWidth    视图最大宽度
 *
 *  @return 填充完毕后视图的高度
 */
- (CGFloat)fillCommentWithModel:(CommentModel *)commentModel maxViewWidth:(CGFloat)viewWidth;


@end
