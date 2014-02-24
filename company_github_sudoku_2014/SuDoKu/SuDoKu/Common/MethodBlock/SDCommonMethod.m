//
//  SDCommomMethod.m
//  SuDoKu
//
//  Created by ysy on 13-12-6.
//  Copyright (c) 2013年 com.ysy.www. All rights reserved.
//

#import "SDCommonMethod.h"

@implementation SDCommonMethod


#pragma mark - 读取txt文件
+ (NSArray *)readTxtFile:(NSString *)path
{
    NSMutableArray *resultArray = [NSMutableArray array];
    
    NSString *pathStr = [[NSBundle mainBundle] pathForResource:path ofType:@"txt"];
    NSError *error;
    NSString *resultStr = [NSString stringWithContentsOfFile:pathStr encoding:NSUTF8StringEncoding error:&error];
    NSArray *array = [resultStr componentsSeparatedByString:@"\n"];
    for(NSString *str in array)
    {
        [resultArray addObject:str];
    }
    return [NSArray arrayWithArray:resultArray];
}

#pragma mark - 指定题 index
+ (NSString *)getQuestionForIndex:(NSInteger)index withPath:(NSString *)path
{
    return [[SDCommonMethod readTxtFile:path] objectAtIndex:index];
}

#pragma mark - 等到的字符是@“空”或者@“”
+ (NSString *)displayTitle:(NSString *)originStr
{
    NSString *numStr = nil;
    if ([originStr isEqualToString:@"空"])
    {
        numStr = @"";
    }
    else if ([originStr isEqualToString:@"0"])
    {
        numStr = @"空";
        
    }
    else if ([originStr isEqualToString:@" "] || [originStr isEqualToString:@""])
    {
        numStr = @"空";
        
    }
    else{
        numStr = originStr;
    }
    return numStr;
}

#pragma mark - 判断完成的对错
+ (BOOL)testAnswer:(NSString *)answerData withGameModel:(NSInteger)model
{
    BOOL isSuccess = YES;
    //36 格子
    if (model == GAME_MODE_6)
    {
        NSInteger data[GAME_MODE_6][GAME_MODE_6];
        for (int i = 0; i < GAME_MODE_6 * GAME_MODE_6; i ++)
        {
            //将字符串转换成数字 检测超标的
            NSInteger num = [[answerData substringWithRange:NSMakeRange(i, 1)] integerValue];
            if (num > GAME_MODE_6 || num <= 0) {
                isSuccess = NO;
                return isSuccess;
            }
            data[i/GAME_MODE_6][i%GAME_MODE_6] = num;
        }
        for (int j = 0; j < GAME_MODE_6; j ++)
        {
            //横向
            NSInteger sumx = 0;
            sumx = data[j][0] + data[j][1] + data[j][2] + data[j][3] + data[j][4] + data[j][5];
            if (sumx != 21) {
                isSuccess = NO;
            }
            //纵向
            NSInteger sumy = 0;
            sumy = data[0][j] + data[1][j] + data[2][j] + data[3][j] + data[4][j] + data[5][j];
            if (sumy != 21) {
                isSuccess = NO;
            }
            //方块
            NSInteger sumz = 0;
            int currentx = (j / 2) * 2;
            int currenty = (j % 2) * 3;
            sumz = data[currentx][currenty+0] + data[currentx][currenty+1] + data[currentx][currenty+2] +data[currentx+1][currenty+0] +data[currentx+1][currenty+1]+data[currentx+1][currenty+2];
            if (sumz != 21) {
                isSuccess = NO;
            }
        }
        return isSuccess;
    }
    //81 格子
    else if (model == GAME_MODE_9)
    {
        NSInteger data[GAME_MODE_9][GAME_MODE_9];
        for (int i = 0; i < GAME_MODE_9 * GAME_MODE_9; i ++)
        {
            //将字符串转换成数字 检测超标的
            NSInteger num = [[answerData substringWithRange:NSMakeRange(i, 1)] integerValue];
            if (num > GAME_MODE_9 || num <= 0) {
                isSuccess = NO;
                return isSuccess;
            }
            data[i/GAME_MODE_9][i%GAME_MODE_9] = num;
        }
        for (int j = 0; j < GAME_MODE_9; j ++)
        {
            //横向
            NSInteger sumx = 0;
            sumx = data[j][0] + data[j][1] + data[j][2] + data[j][3] + data[j][4] + data[j][5] + data[j][6] + data[j][7] + data[j][8];
            if (sumx != 45) {
                isSuccess = NO;
            }
            //纵向
            NSInteger sumy = 0;
            sumy = data[0][j] + data[1][j] + data[2][j] + data[3][j] + data[4][j] + data[5][j]+ data[6][j] + data[7][j] + data[8][j];
            if (sumy != 45) {
                isSuccess = NO;
            }
            //方块
            NSInteger sumz = 0;
            int currentx = (j / 3) * 3;
            int currenty = (j % 3) * 3;
            sumz = data[currentx][currenty+0]+data[currentx][currenty+1]+data[currentx][currenty+2]+data[currentx+1][currenty+0]+data[currentx+1][currenty+1]+data[currentx+1][currenty+2]+data[currentx+2][currenty+0]+data[currentx+2][currenty+1]+data[currentx+2][currenty+2];
            if (sumz != 45) {
                isSuccess = NO;
            }
        }
        return isSuccess;
    }

    return isSuccess;
}


#pragma mark - 出现 消失 动画 
+ (void)fadeIn:(UIView *)view
{
    view.transform = CGAffineTransformMakeScale(0.0, 0.0);
    view.hidden = YES;
    [UIView animateWithDuration:.35 animations:^{
        view.hidden = NO;
        view.transform = CGAffineTransformMakeScale(1, 1);
    }];
    
}

+ (void)fadeOut:(UIView *)view
{
    view.hidden = NO;
    [UIView animateWithDuration:.35 animations:^{
        view.transform = CGAffineTransformMakeScale(0.0, 0.0);
    } completion:^(BOOL finished) {
        if (finished) {
            [view removeFromSuperview];
        }
    }];
}

#pragma mark - 出现 消失 平移动画
+ (void)panIn:(UIView *)view withpParentView:(UIView *)pView
{
    [pView addSubview:view];
    view.hidden = YES;
    CGRect rect = view.frame;
    view.frame = CGRectMake(320,rect.origin.y, rect.size.width, rect.size.height);
    
    [UIView animateWithDuration:.35 animations:^{
        view.hidden = NO;
        CGRect rect = view.frame;
        UIView *mainview = [pView viewWithTag:501];
        CGRect selfrect = mainview.frame;
        view.frame = CGRectMake(0,rect.origin.y, rect.size.width, rect.size.height);
        mainview.frame = CGRectMake(-270,selfrect.origin.y, selfrect.size.width, selfrect.size.height);
    }
    completion:^(BOOL finished)
    {
        if (finished)
        {
        
        }
    }];
}
+ (void)panOut:(UIView *)view withpParentView:(UIView *)pView
{
    view.hidden = NO;
    
    [UIView animateWithDuration:.35 animations:^{
        CGRect rect = view.frame;
        UIView *mainview = [pView viewWithTag:501];
        CGRect selfrect = mainview.frame;
        view.frame = CGRectMake(320,rect.origin.y, rect.size.width, rect.size.height);
        mainview.frame = CGRectMake(0,selfrect.origin.y, selfrect.size.width, selfrect.size.height);
    }
    completion:^(BOOL finished)
     {
         if (finished)
         {
            [view removeFromSuperview];
         }
     }];
}

/**
 *  生成一个纯色的背景图
 *
 *  @param color 背景颜色
 *
 *  @return 返回一个uiimage
 */
+ (UIImage *) buttonImageFromColor:(UIColor *)color withFrame:(CGRect)frame
{
    CGRect rect = CGRectMake(0, 0, frame.size.width, frame.size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

@end
