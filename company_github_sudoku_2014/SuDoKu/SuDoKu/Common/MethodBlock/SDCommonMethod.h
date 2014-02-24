//
//  SDCommomMethod.h
//  SuDoKu
//
//  Created by ysy on 13-12-6.
//  Copyright (c) 2013年 com.ysy.www. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SDCommonMethod : NSObject

//读取txt文件
+ (NSArray *)readTxtFile:(NSString *)path;

//指定题 index
+ (NSString *)getQuestionForIndex:(NSInteger)index withPath:(NSString *)path;

//等到的字符是@“空”或者@“”
+ (NSString *)displayTitle:(NSString *)originStr;

//判断完成的对错
+ (BOOL)testAnswer:(NSString *)answerData withGameModel:(NSInteger)model;

//出现 消失 动画
+ (void)fadeIn:(UIView *)view;
+ (void)fadeOut:(UIView *)view;

//出现 消失 平移动画
+ (void)panIn:(UIView *)view withpParentView:(UIView *)pView;
+ (void)panOut:(UIView *)view withpParentView:(UIView *)pView;

/**
 *  生成一个纯色的背景图
 *
 *  @param color 背景颜色
 *
 *  @return 返回一个uiimage
 */
+ (UIImage *) buttonImageFromColor:(UIColor *)color withFrame:(CGRect)frame;
@end

