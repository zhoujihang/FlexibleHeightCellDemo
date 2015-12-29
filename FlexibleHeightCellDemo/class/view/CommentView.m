//
//  CommentView.m
//  FlexibleHeightCellDemo
//
//  Created by 周际航 on 15/12/29.
//  Copyright © 2015年 zjh. All rights reserved.
//

#import "CommentView.h"
#import "SingleCommentView.h"

#import "UIColor+Extension.h"

const NSInteger kMaxCommentCount = 20;     // 最多X条评论

@interface CommentView()

// 所有的评论
@property (nonatomic, strong) NSMutableArray *commentViewMArr;

// 有内容的评论lable
@property (nonatomic, strong) NSMutableArray *validateCommentViewMArr;

// 默认字体大小
@property (nonatomic, strong) UIFont *defaultFont;
@end

@implementation CommentView

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self setUp];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}

- (void)setUp{
    self.commentViewMArr = [@[] mutableCopy];
    for (int i=0; i<kMaxCommentCount; i++) {
        SingleCommentView *singleCommentView = [[SingleCommentView alloc]init];
        singleCommentView.hidden = YES;
        [self addSubview:singleCommentView];
        [self.commentViewMArr addObject:singleCommentView];
    }
}

- (CGFloat)fillDetailWithModel:(LifeModel *)lifeModel maxViewWidth:(CGFloat)viewWidth{
    [self clearCommentData];
    if (lifeModel.commentArr.count==0) return 0;
    
    _lifeModel =  lifeModel;
    _maxViewWidth = viewWidth;
    
    // 设置内容布局控件，返回内容的高度
    CGFloat maxY = [self setCommentData];
    
    return maxY;
}

// 清空评论内容
- (void)clearCommentData{
    for (SingleCommentView *view in self.validateCommentViewMArr) {
        [view fillCommentWithModel:nil maxViewWidth:0];
        view.hidden = YES;
        view.showBottomLine = NO;
    }
    self.validateCommentViewMArr = [@[] mutableCopy];
}
// 设置评论的内容
- (CGFloat)setCommentData{
    [self clearCommentData];
    CGFloat maxY = 0;
    NSArray *commentArr = self.lifeModel.commentArr;
    for (int i=0; i<commentArr.count; i++) {
        CommentModel *model = commentArr[i];
        SingleCommentView *singleView = self.commentViewMArr[i];
        CGFloat viewHeight = [singleView fillCommentWithModel:model maxViewWidth:_maxViewWidth];
        singleView.showBottomLine = YES;
        singleView.hidden = NO;
        singleView.frame = CGRectMake(0, maxY, _maxViewWidth, viewHeight);
        maxY += viewHeight;
        [self.validateCommentViewMArr addObject:singleView];
    }
    
    // 清除最后cell的分割线
    SingleCommentView *lastView = self.validateCommentViewMArr.lastObject;
    lastView.showBottomLine = NO;
    
    return maxY;
}

@end
