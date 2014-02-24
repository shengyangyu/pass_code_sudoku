//
//  SDAppDelegate.h
//  SuDoKu
//
//  Created by ysy on 13-12-2.
//  Copyright (c) 2013年 com.ysy.www. All rights reserved.
//  web change 2013-12-23 15:24

#import <UIKit/UIKit.h>

@interface SDAppDelegate : UIResponder <UIApplicationDelegate>
{
    
}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, assign) UIBackgroundTaskIdentifier backgroundUpdateTask;

@end
