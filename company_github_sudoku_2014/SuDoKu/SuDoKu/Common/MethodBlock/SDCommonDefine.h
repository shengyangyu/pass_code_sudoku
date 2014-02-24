//
//  SDCommonDefine.h
//  SuDoKu
//
//  Created by ysy on 13-12-6.
//  Copyright (c) 2013年 com.ysy.www. All rights reserved.
//

#ifndef SuDoKu_SDCommonDefine_h
#define SuDoKu_SDCommonDefine_h


#define GAME_MODE_6        6               //6格模式
#define GAME_MODE_9        9               //9格模式
#define BUTTON_TAG_BASE    100          //按钮的tag从100开始
#define MAINSCREEN_HEIGHT  [[UIScreen mainScreen] bounds].size.height //当前屏幕高度
#define STATUS_HEIGHT      (([[UIDevice currentDevice].systemVersion floatValue]>=7.0)?0:20.0)//状态栏高度

#endif
