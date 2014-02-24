//
//  SDReadFileShared.m
//  SuDoKu
//
//  Created by ysy on 13-12-27.
//  Copyright (c) 2013年 com.ysy.www. All rights reserved.
//

#import "SDReadFileShared.h"

@implementation SDReadFileShared

- (id) init
{
    if (self = [super init])
    {
        file6Data = nil;
        file6Data = [NSArray arrayWithArray:[SDReadFileShared readTxtFile:@"sudoku6"]];
        file9Data = nil;
        file9Data = [SDReadFileShared readTxtFile:@"sudoku9"];
    }
    return self;
}

// 创建单例
+ (SDReadFileShared*) sharedReadFile
{
    static id readfileShared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
       
        readfileShared = [[self alloc] init];
    });
    return readfileShared;
}
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
- (NSString *)getQuestionForIndex:(NSInteger)index withPath:(NSString *)path
{
    if ([path isEqualToString:@"sudoku6"])
    {
        return [file6Data objectAtIndex:index];
    }
    return [file9Data objectAtIndex:index];
}
@end
