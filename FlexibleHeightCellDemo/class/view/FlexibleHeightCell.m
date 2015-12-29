//
//  FlexibleHeightCell.m
//  FlexibleHeightCellDemo
//
//  Created by 周际航 on 15/12/29.
//  Copyright © 2015年 zjh. All rights reserved.
//

#import "FlexibleHeightCell.h"
#import "NinePicView.h"
#import "CommentView.h"

#import <SDWebImage/UIImageView+WebCache.h>

const CGFloat kPadding_12 = 12.0;      // 控件上下间距
const CGFloat kPadding_8 = 8.0;      // 控件上下间距
#define SCREEN_WIDTH        [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT       [UIScreen mainScreen].bounds.size.height
#define SCREEN_BOUNDS       [UIScreen mainScreen].bounds
@interface FlexibleHeightCell()
// 约束属性
// 竖直关系约束
// 声音控件顶部距离约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *soundImgViewTopPaddingCons;
// 声音控件高度约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *soundImgViewHeightCons;
// 说说正文顶部距离约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentLabelTopPaddingCons;
// 九宫格视图顶部距离约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ninePicViewTopPaddingCons;
// 九宫格视图高度约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ninePicViewHeightCons;
// 评论视图顶部距离约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *commentViewTopPaddingCons;
// 评论视图高度约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *commentViewHeightCons;
// 水平关系约束
// icon到左边的距离约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *iconImgViewLeftSpaceCons;
// icon的宽度约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *iconImgViewWidthCons;
// icon到右边的距离约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *iconImgViewRightPaddingCons;
// namelabel到右边的距离约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nameLabelRightPaddingCons;

// 控件属性
// 头像
@property (weak, nonatomic) IBOutlet UIImageView *iconImgView;
// 用户名
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
// 声音控件
@property (weak, nonatomic) IBOutlet UIImageView *soundImgView;
// 说说内容控件
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
// 九宫格图片视图
@property (weak, nonatomic) IBOutlet NinePicView *ninePicView;
// 瞬间戳
@property (weak, nonatomic) IBOutlet UILabel *timeStampLabel;
// 评论按钮
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;
// 评论视图
@property (weak, nonatomic) IBOutlet CommentView *commentView;

@end

@implementation FlexibleHeightCell

+ (NSString *)identify{
    return @"FlexibleHeightCell";
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setUpViews];
}

// 创建视图控件
- (void)setUpViews{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.iconImgView.layer.cornerRadius = self.iconImgViewWidthCons.constant/2;
    self.iconImgView.layer.masksToBounds = YES;
}
// 设置内容并修改约束
- (void)setLifeModel:(LifeModel *)lifeModel{
    _lifeModel = lifeModel;
    
    self.contentView.bounds = CGRectMake(0, 0, 10000, 10000);
    
    // 头像和名称
    [self.iconImgView sd_setImageWithURL:[NSURL URLWithString:lifeModel.icon]];
    self.nameLabel.text = lifeModel.name;
    
    // 声音控件
    if (lifeModel.sound) {
        self.soundImgView.hidden = NO;
        self.soundImgViewTopPaddingCons.constant = kPadding_8;
        self.soundImgViewHeightCons.constant = 28;
    }else{
        self.soundImgView.hidden = YES;
        self.soundImgViewTopPaddingCons.constant = 0;
        self.soundImgViewHeightCons.constant = 0;
    }
    
    CGFloat maxWidth = SCREEN_WIDTH-self.iconImgViewLeftSpaceCons.constant-self.iconImgViewWidthCons.constant-self.iconImgViewRightPaddingCons.constant-self.nameLabelRightPaddingCons.constant;
    // 说说正文
    self.contentLabel.text = lifeModel.content;
    self.contentLabel.numberOfLines = 0;
    self.contentLabel.preferredMaxLayoutWidth = maxWidth;
    if (!lifeModel.content || [lifeModel.content isEqualToString:@""]) {
        self.contentLabelTopPaddingCons.constant = 0;
    }else{
        self.contentLabelTopPaddingCons.constant = kPadding_8;
    }
    
    // 九宫格图片填充 并 返回填充后的高度
    CGFloat ninePicViewHeight = [self.ninePicView fillDetailWithPicArr:lifeModel.picArr maxViewWidth:maxWidth];
    if (ninePicViewHeight == 0) {
        self.ninePicView.hidden = YES;
        self.ninePicViewHeightCons.constant = 0;
        self.ninePicViewTopPaddingCons.constant = 0;
    }else{
        self.ninePicView.hidden = NO;
        self.ninePicViewHeightCons.constant = ninePicViewHeight;
        self.ninePicViewTopPaddingCons.constant = kPadding_8;
    }
    
    // 时间戳
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm";
    self.timeStampLabel.text = [dateFormatter stringFromDate:lifeModel.timeStamp];
    
    // 评论区域
    CGFloat commentViewHeight = [self.commentView fillDetailWithModel:lifeModel maxViewWidth:maxWidth];
    if (commentViewHeight == 0) {
        self.commentView.hidden = YES;
        self.commentViewHeightCons.constant = 0;
        self.commentViewTopPaddingCons.constant = 0;
    }else{
        self.commentView.hidden = NO;
        self.commentViewHeightCons.constant = commentViewHeight;
        self.commentViewTopPaddingCons.constant = kPadding_8;
    }
}

// 获得cell的高度
- (CGFloat)cellHeight{
    self.contentView.bounds = CGRectMake(0, 0, 10000, 10000);
    [self.contentView updateConstraintsIfNeeded];
    [self.contentView layoutIfNeeded];
    
    CGFloat height = [self.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    return height+1;
}



@end
