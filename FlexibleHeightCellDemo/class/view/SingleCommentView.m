//
//  SingleCommentView.m
//  FlexibleHeightCellDemo
//
//  Created by 周际航 on 15/12/29.
//  Copyright © 2015年 zjh. All rights reserved.
//

#import "SingleCommentView.h"
#import "NSString+Extension.h"
#import "UIColor+Extension.h"

const CGFloat kCommentLabelTopBottomPadding = 8;        // 评论文字距离视图上下的距离
const CGFloat kCommentLabelLeftRightPadding = 8;        // 左右边距
@interface SingleCommentView()
// 评论
@property (nonatomic, weak) UILabel *commentLabel;
// 分割线
@property (nonatomic, weak) UIView *bottomLine;

// 默认字体
@property (nonatomic, strong) UIFont *defaultFont;

@end

@implementation SingleCommentView

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
    self.defaultFont = [UIFont systemFontOfSize:14];
    
    // 文字
    UILabel *commentLabel = [[UILabel alloc]init];
    commentLabel.numberOfLines = 0;
    commentLabel.font = self.defaultFont;
    [self addSubview:commentLabel];
    self.commentLabel = commentLabel;
    
    // 分割线
    UIView *bottomLine = [[UIView alloc]init];
    bottomLine.backgroundColor = [UIColor getColor:@"dadada"];
    [self addSubview:bottomLine];
    self.bottomLine = bottomLine;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGSize viewSize = self.bounds.size;
    
    // 文字的位置
    if (self.bounds.size.height >= kCommentLabelTopBottomPadding*2) {
        self.commentLabel.frame = CGRectMake(kCommentLabelLeftRightPadding, kCommentLabelTopBottomPadding, viewSize.width-kCommentLabelLeftRightPadding*2, viewSize.height-kCommentLabelTopBottomPadding*2);
    }else{
        self.commentLabel.frame = self.bounds;
    }
    
    if (self.bounds.size.height>0 && self.showBottomLine && !self.hidden) {
        // 显示分割线
        CGFloat onePixelHeight = 1/[UIScreen mainScreen].scale;
        self.bottomLine.frame = CGRectMake(0, self.bounds.size.height-onePixelHeight, self.bounds.size.width, onePixelHeight);
        self.bottomLine.hidden = NO;
    }else{
        self.bottomLine.hidden = YES;
    }
}

- (CGFloat)fillCommentWithModel:(CommentModel *)commentModel maxViewWidth:(CGFloat)viewWidth{
    _commentModel = commentModel;
    _maxViewWidth = viewWidth;
    
    if (!commentModel) {
        self.commentLabel.attributedText = nil;
        return 0;
    }
    
    NSString *name = commentModel.name;
    NSString *replyName = commentModel.replyName;
    NSString *content = commentModel.content;
    
    // 填充内容
    NSDictionary *option = @{
                             NSForegroundColorAttributeName : [UIColor blueColor]
                             };
    
    NSString *commentStr = nil;
    NSRange nameRange = NSMakeRange(0, 0);
    NSRange replyNameRange = NSMakeRange(0, 0);
    if (replyName && replyName.length>0) {
        // 存在回复的人
        NSString *huifu = @"回复";
        NSRange huifuRange = [huifu rangeOfString:huifu];
        commentStr = [NSString stringWithFormat:@"%@%@%@:%@",name,huifu,replyName,content];
        nameRange = [name rangeOfString:name];
        replyNameRange = [replyName rangeOfString:replyName];
        replyNameRange.location += nameRange.length + huifuRange.length;
    }else{
        // 无回复的人
        commentStr = [NSString stringWithFormat:@"%@:%@",name,content];
        nameRange = [name rangeOfString:name];
    }
    // 回复人 和 被回复人 高亮
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc]initWithString:commentStr];
    if (replyNameRange.length > 0) {
        [attributeStr addAttributes:option range:replyNameRange];
    }
    if (nameRange.length > 0) {
        [attributeStr addAttributes:option range:nameRange];
    }
    self.commentLabel.attributedText = attributeStr;
    
    // 计算高度
    CGSize boundingSize = CGSizeMake(_maxViewWidth-2*kCommentLabelLeftRightPadding, 10000);
    CGSize textSize = [commentStr sizeWithBoundingSize:boundingSize font:self.defaultFont];
    
    CGFloat viewHeight = 0;
    if (textSize.height > 0) {
        viewHeight = textSize.height + kCommentLabelTopBottomPadding*2;     // 上下边距
    }else{
        viewHeight = 0;
    }
    
    return viewHeight;
}

@end
