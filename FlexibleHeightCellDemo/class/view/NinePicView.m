//
//  NinePicView.m
//  FlexibleHeightCellDemo
//
//  Created by 周际航 on 15/12/29.
//  Copyright © 2015年 zjh. All rights reserved.
//

#import "NinePicView.h"
#import <SDWebImage/UIImageView+WebCache.h>
const CGFloat kPicWidth = 90;        // 图片宽度
const CGFloat kPicHeight = 90;        // 图片高度
const CGFloat kPicPadding = 4;       // 图片间距

@interface NinePicView()

// 存放9张图片
@property (nonatomic, strong) NSMutableArray *picViewArr;

@end

@implementation NinePicView

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
// 初始化9张图片控件
- (void)setUp{
    self.picViewArr = [@[] mutableCopy];
    for (int i=0; i<9; i++) {
        UIImageView *imgView = [[UIImageView alloc]init];
        imgView.contentMode = UIViewContentModeScaleAspectFill;
        imgView.clipsToBounds = YES;
        [self addSubview:imgView];
        [self.picViewArr addObject:imgView];
    }
}


- (CGFloat)fillDetailWithPicArr:(NSArray *)picArr maxViewWidth:(CGFloat)viewWidth{
    [self clearImgData];
    if (picArr.count == 0) return 0;
    
    // 接收参数
    _picArr = picArr;
    if (picArr.count >9){
        NSMutableArray *marr = [@[] mutableCopy];
        for (int i=0; i<9; i++) {
            [marr addObject:picArr[i]];
        }
        _picArr = [marr copy];
    }
    _maxViewWidth = viewWidth;
    
    // 设置图片
    [self setImgData];
    // 布局图片位置
    CGFloat maxY = [self layoutPosition];
    
    return maxY;
}
// 清空图片
- (void)clearImgData{
    for (UIImageView *imgView in self.picViewArr) {
        imgView.image = nil;
    }
}
// 填充图片
- (void)setImgData{
    for (int i=0; i<_picArr.count; i++) {
        NSString *picUrlStr = _picArr[i];
        UIImageView *imgView = self.picViewArr[i];
        [imgView sd_setImageWithURL:[NSURL URLWithString:picUrlStr]];
    }
}
// 布局图片的位置
- (CGFloat)layoutPosition{
    CGFloat maxY = 0;       // 视图填充完毕后最大的y值
    NSInteger indexX = 0;
    NSInteger indexY = 0;
    for (int i=0; i<_picArr.count; i++) {
        UIImageView *imgView = self.picViewArr[i];
        indexX = i%3;
        indexY = i/3;
        CGFloat picX = (kPicWidth+kPicPadding)*indexX;
        CGFloat picY = (kPicHeight+kPicPadding)*indexY;
        imgView.frame = CGRectMake(picX, picY, kPicWidth, kPicHeight);
        
        maxY = CGRectGetMaxY(imgView.frame);
    }
    return maxY;
}
@end
