//
//  SDGameProtocol.h
//  SuDoKu
//
//  Created by ysy on 13-12-12.
//  Copyright (c) 2013年 com.ysy.www. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  游戏界面按钮委托
 */
@protocol SDGameProtocol <NSObject>

@optional

- (void)numberButtonMethod:(UIButton *)sender;

@end

/**
 *  绘制界面委托
 */
@protocol SDCoreVCDelegate <NSObject>

@optional
- (void)sureResultMethod:(UIButton *)sender;

@end