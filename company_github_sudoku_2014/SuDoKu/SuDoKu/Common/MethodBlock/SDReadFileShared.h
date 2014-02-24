//
//  SDReadFileShared.h
//  SuDoKu
//
//  Created by ysy on 13-12-27.
//  Copyright (c) 2013年 com.ysy.www. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SDReadFileShared : NSObject
{
    NSArray *file6Data;
    NSArray *file9Data;
}
// 创建单例
+ (SDReadFileShared*) sharedReadFile;
// 读取文件
- (NSString *)getQuestionForIndex:(NSInteger)index withPath:(NSString *)path;

@end
