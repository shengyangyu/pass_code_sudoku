//
//  SDDispatchTimer.h
//  SuDoKu
//
//  Created by ysy on 13-12-20.
//  Copyright (c) 2013年 com.ysy.www. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SDDispatchTimer : NSObject
{
    __block dispatch_source_t mTimer;
}
/**
 *  单例
 *
 *  @return 实体
 */
+ (SDDispatchTimer *)sharedSDDispatchTimer;
/**
 *  开始计时
 *
 *  @param startTime 开始计时
 *
 *  @mStartTime 开始时间
 */
- (void)startTimer:(NSInteger)mStartTime;
/**
 *  取消
 */
- (void)stopTimer;


@end
