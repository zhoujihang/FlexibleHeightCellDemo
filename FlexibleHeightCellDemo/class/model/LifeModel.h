//
//  LifeModel.h
//  FlexibleHeightCellDemo
//
//  Created by 周际航 on 15/12/29.
//  Copyright © 2015年 zjh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MJExtension/MJExtension.h>

@class CommentModel;
// 说说模型
@interface LifeModel : NSObject
// 头像
@property (nonatomic, copy) NSString *icon;
// 名字
@property (nonatomic, copy) NSString *name;
// 说说内容
@property (nonatomic, copy) NSString *content;
// 图片数组
@property (nonatomic, strong) NSArray *picArr;
// 说说时间戳
@property (nonatomic, strong) NSDate *timeStamp;
// 是否有声音
@property (nonatomic, assign) BOOL sound;
// 评论列表
@property (nonatomic, strong) NSArray *commentArr;

+ (NSArray *)fakeLifeModelArr;

@end

// 评论模型
@interface CommentModel : NSObject
// 评论人的名字
@property (nonatomic, copy) NSString *name;
// 评论内容
@property (nonatomic, copy) NSString *content;
// 回复对象的名字
@property (nonatomic, copy) NSString *replyName;

@end

