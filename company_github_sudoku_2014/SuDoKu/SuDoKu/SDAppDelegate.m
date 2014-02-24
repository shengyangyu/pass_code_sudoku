//
//  SDAppDelegate.m
//  SuDoKu
//
//  Created by ysy on 13-12-2.
//  Copyright (c) 2013年 com.ysy.www. All rights reserved.
//

#import "SDAppDelegate.h"
#import "SDViewController.h"


@implementation SDAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    SDViewController *vc = [[[SDViewController alloc] initWithNibName:@"SDViewController" bundle:nil] autorelease];
    self.window.rootViewController = vc;
    [self.window makeKeyAndVisible];
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:0] forKey:@"openInt6model"];
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:-1] forKey:@"openInt9model"];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    //为了延长程序进入后台 文件操作时间
    [self beginBackgroundTask];
    // 在这里加上你需要长久运行的代码
    NSLog(@"applicationDidEnterBackground");
    
    [self endBackgroundTask];
    
}
//开始
- (void)beginBackgroundTask
{
    self.backgroundUpdateTask = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
        [self endBackgroundTask];
    }];
}
//结束
- (void)endBackgroundTask
{
    [[UIApplication sharedApplication] endBackgroundTask:self.backgroundUpdateTask];
    self.backgroundUpdateTask = UIBackgroundTaskInvalid;
}


- (void)applicationWillEnterForeground:(UIApplication *)application
{
    
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
