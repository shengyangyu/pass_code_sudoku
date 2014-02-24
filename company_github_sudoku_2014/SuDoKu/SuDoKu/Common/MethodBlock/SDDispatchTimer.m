//
//  SDDispatchTimer.m
//  SuDoKu
//
//  Created by ysy on 13-12-20.
//  Copyright (c) 2013年 com.ysy.www. All rights reserved.
//

#import "SDDispatchTimer.h"

@implementation SDDispatchTimer

+ (SDDispatchTimer *)sharedSDDispatchTimer
{
    static SDDispatchTimer *mSDDispatchTimer=nil;
    @synchronized(self)
    {
        if (!mSDDispatchTimer)
        {
            mSDDispatchTimer = [[self alloc] init];
        }
    }
    return mSDDispatchTimer;
}

- (id) init
{
    if (self = [super init])
    {
        mTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0));
    }
    return self;
}

- (void)startTimer:(NSInteger)mStartTime
{
    __block NSInteger nowTimer = mStartTime;
    
    dispatch_source_set_timer(mTimer, DISPATCH_TIME_NOW, 500 * NSEC_PER_MSEC, 0);
    dispatch_source_set_event_handler(mTimer, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"%d",nowTimer);
            nowTimer ++;
        });
    });
    dispatch_resume(mTimer);
}
- (void)stopTimer
{
    if (mTimer) {
        dispatch_source_cancel(mTimer);
        dispatch_release(mTimer);
        mTimer = nil;
    }

}
- (void)dealloc
{
    [self stopTimer];
    [super dealloc];
}
@end
