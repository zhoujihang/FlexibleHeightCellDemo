//
//  NSString+Extension
//  Ayibang
//
//  Created by 阿姨帮 on 15/7/6.
//  Copyright (c) 2015年 ayibang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Extension)

#pragma mark - 计算文本占据位置的大小（CGSize）
/**
 *  给定最大CGSize和字体大小，计算出当前字符串的CGSize
 *
 *  @param boundingSize 最大的长和宽
 *  @param font         具体的字体
 *
 *  @return 字符串在约束范围内的大小
 */
- (CGSize)sizeWithBoundingSize:(CGSize)boundingSize font:(UIFont *)font;

@end
