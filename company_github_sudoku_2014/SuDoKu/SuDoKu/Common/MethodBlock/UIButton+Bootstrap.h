//
//  UIButton+Bootstrap.h
//  SuDoKu
//
//  Created by ysy on 13-12-12.
//  Copyright (c) 2013年 com.ysy.www. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "NSString+FontAwesome.h"

#define Green_Color  [UIColor colorWithRed:86/255.0 green:215/255.0 blue:43/255.0 alpha:1]
#define Blue_Color   [UIColor colorWithRed:35/255.0 green:155/255.0 blue:246/255.0 alpha:1]
#define Orange_Color [UIColor colorWithRed:248/255.0 green:130/255.0 blue:10/255.0 alpha:1]
#define Purple_Color [UIColor colorWithRed:190/255.0 green:87/255.0 blue:217/255.0 alpha:1]

@interface UIButton (Bootstrap)

- (void)addAwesomeIcon:(FAIcon)icon beforeTitle:(BOOL)before;

-(void)bootstrapStyle;

-(void)defaultStyle;

-(void)primaryStyle;

-(void)successStyle;

-(void)infoStyle;

-(void)warningStyle;

-(void)dangerStyle;

/**
 *  ios7 四个主色调
 */
-(void)buttonGreenStyle;
-(void)buttonBlueStyle;
-(void)buttonOrangeStyle;
-(void)buttonPurpleStyle;
/**
 *  白底按钮
 */
-(void)setBackGroundAndTitleColorStyle;

/**
 *  圆形按钮
 */
-(void)setCircleButton:(UIColor *)color;

@end
