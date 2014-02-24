//
//  UIButton+Bootstrap.m
//  SuDoKu
//
//  Created by ysy on 13-12-12.
//  Copyright (c) 2013年 com.ysy.www. All rights reserved.
//

#import "UIButton+Bootstrap.h"

#import <QuartzCore/QuartzCore.h>

@implementation UIButton (Bootstrap)

/**
 *  这是几个简单的例子
 */

-(void)bootstrapStyle{
    self.layer.borderWidth = 1;
    self.layer.cornerRadius = 4.0;
    self.layer.masksToBounds = YES;
    [self setAdjustsImageWhenHighlighted:NO];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.titleLabel setFont:[UIFont fontWithName:@"FontAwesome" size:self.titleLabel.font.pointSize]];
}

-(void)defaultStyle{
    [self bootstrapStyle];
    [self setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    self.backgroundColor = [UIColor clearColor];
    self.layer.borderColor = [[UIColor colorWithRed:66/255.0 green:139/255.0 blue:202/255.0 alpha:1] CGColor];
    [self setBackgroundImage:[self buttonImageFromColor:[UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:0]] forState:UIControlStateHighlighted];
}

-(void)primaryStyle{
    [self bootstrapStyle];
    self.backgroundColor = [UIColor colorWithRed:66/255.0 green:139/255.0 blue:202/255.0 alpha:1];
    self.layer.borderColor = [[UIColor colorWithRed:53/255.0 green:126/255.0 blue:189/255.0 alpha:1] CGColor];
    [self setBackgroundImage:[self buttonImageFromColor:[UIColor colorWithRed:51/255.0 green:119/255.0 blue:172/255.0 alpha:1]] forState:UIControlStateHighlighted];
}

-(void)successStyle{
    [self bootstrapStyle];
    self.backgroundColor = [UIColor colorWithRed:92/255.0 green:184/255.0 blue:92/255.0 alpha:1];
    self.layer.borderColor = [[UIColor colorWithRed:76/255.0 green:174/255.0 blue:76/255.0 alpha:1] CGColor];
    [self setBackgroundImage:[self buttonImageFromColor:[UIColor colorWithRed:69/255.0 green:164/255.0 blue:84/255.0 alpha:1]] forState:UIControlStateHighlighted];
}

-(void)infoStyle{
    [self bootstrapStyle];
    self.backgroundColor = [UIColor colorWithRed:91/255.0 green:192/255.0 blue:222/255.0 alpha:1];
    self.layer.borderColor = [[UIColor colorWithRed:70/255.0 green:184/255.0 blue:218/255.0 alpha:1] CGColor];
    [self setBackgroundImage:[self buttonImageFromColor:[UIColor colorWithRed:57/255.0 green:180/255.0 blue:211/255.0 alpha:1]] forState:UIControlStateHighlighted];
}

-(void)warningStyle{
    [self bootstrapStyle];
    self.backgroundColor = [UIColor colorWithRed:240/255.0 green:173/255.0 blue:78/255.0 alpha:1];
    self.layer.borderColor = [[UIColor colorWithRed:238/255.0 green:162/255.0 blue:54/255.0 alpha:1] CGColor];
    [self setBackgroundImage:[self buttonImageFromColor:[UIColor colorWithRed:237/255.0 green:155/255.0 blue:67/255.0 alpha:1]] forState:UIControlStateHighlighted];
}

-(void)dangerStyle{
    [self bootstrapStyle];
    self.backgroundColor = [UIColor colorWithRed:217/255.0 green:83/255.0 blue:79/255.0 alpha:1];
    self.layer.borderColor = [[UIColor colorWithRed:212/255.0 green:63/255.0 blue:58/255.0 alpha:1] CGColor];
    [self setBackgroundImage:[self buttonImageFromColor:[UIColor colorWithRed:210/255.0 green:48/255.0 blue:51/255.0 alpha:1]] forState:UIControlStateHighlighted];
}
/**
 *  可以给按钮加上图片
 *
 *  @param icon   图片的类型可以在faicon里面选
 *  @param before 要不要加上标题
 */
- (void)addAwesomeIcon:(FAIcon)icon beforeTitle:(BOOL)before
{
    NSString *iconString = [NSString stringFromAwesomeIcon:icon];
    self.titleLabel.font = [UIFont fontWithName:@"FontAwesome"
                                           size:self.titleLabel.font.pointSize];
    
    NSString *title = [NSString stringWithFormat:@"%@", iconString];
    
    if(self.titleLabel.text) {
        if(before)
            title = [title stringByAppendingFormat:@" %@", self.titleLabel.text];
        else
            title = [NSString stringWithFormat:@"%@  %@", self.titleLabel.text, iconString];
    }
    
    [self setTitle:title forState:UIControlStateNormal];
}
/**
 *  生成一个纯色的背景图
 *
 *  @param color 背景颜色
 *
 *  @return 返回一个uiimage
 */
- (UIImage *) buttonImageFromColor:(UIColor *)color {
    CGRect rect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

/**
 *  ios7 四个主色调
 */
-(void)buttonOrangeStyle
{
    [self bootstrapStyle];
    self.backgroundColor = [UIColor colorWithRed:248/255.0 green:130/255.0 blue:10/255.0 alpha:1];
    self.layer.borderColor = [[UIColor colorWithRed:245/255.0 green:125/255.0 blue:8/255.0 alpha:1] CGColor];
    [self setBackgroundImage:[self buttonImageFromColor:[UIColor colorWithRed:240/255.0 green:120/255.0 blue:5/255.0 alpha:1]] forState:UIControlStateHighlighted];
}
-(void)buttonGreenStyle
{
    [self bootstrapStyle];
    self.backgroundColor = [UIColor colorWithRed:86/255.0 green:215/255.0 blue:43/255.0 alpha:1];
    self.layer.borderColor = [[UIColor colorWithRed:82/255.0 green:211/255.0 blue:42/255.0 alpha:1] CGColor];
    [self setBackgroundImage:[self buttonImageFromColor:[UIColor colorWithRed:78/255.0 green:237/255.0 blue:38/255.0 alpha:1]] forState:UIControlStateHighlighted];
}
-(void)buttonBlueStyle
{
    [self bootstrapStyle];
    self.backgroundColor = [UIColor colorWithRed:35/255.0 green:155/255.0 blue:246/255.0 alpha:1];
    self.layer.borderColor = [[UIColor colorWithRed:30/255.0 green:150/255.0 blue:240/255.0 alpha:1] CGColor];
    [self setBackgroundImage:[self buttonImageFromColor:[UIColor colorWithRed:27/255.0 green:147/255.0 blue:237/255.0 alpha:1]] forState:UIControlStateHighlighted];
}
-(void)buttonPurpleStyle
{
    [self bootstrapStyle];
    self.backgroundColor = [UIColor colorWithRed:190/255.0 green:87/255.0 blue:217/255.0 alpha:1];
    self.layer.borderColor = [[UIColor colorWithRed:180/255.0 green:77/255.0 blue:207/255.0 alpha:1] CGColor];
    [self setBackgroundImage:[self buttonImageFromColor:[UIColor colorWithRed:200/255.0 green:74/255.0 blue:204/255.0 alpha:1]] forState:UIControlStateHighlighted];
}
/**
 *  返回按钮都是白色的底 透明的
 */
-(void)setBackGroundAndTitleColorStyle
{
    self.layer.borderWidth = 1;
    self.layer.cornerRadius = 4.0;
    self.layer.masksToBounds = YES;
    [self setAdjustsImageWhenHighlighted:NO];
    [self setTitleColor:[UIColor colorWithRed:35/255.0 green:155/255.0 blue:246/255.0 alpha:1] forState:UIControlStateNormal];
    [self.titleLabel setFont:[UIFont fontWithName:@"FontAwesome" size:self.titleLabel.font.pointSize]];
    
    
    self.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0];
    self.layer.borderColor = [[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0] CGColor];
    [self setBackgroundImage:[self buttonImageFromColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0]] forState:UIControlStateHighlighted];
    
}
/**
 *  圆形按钮
 */
-(void)setCircleButton:(UIColor *)color
{
    self.layer.borderWidth = 1;
    self.layer.cornerRadius = 15.0;
    self.layer.masksToBounds = YES;
    [self setAdjustsImageWhenHighlighted:NO];
    [self.titleLabel setFont:[UIFont fontWithName:@"FontAwesome" size:self.titleLabel.font.pointSize]];
    [self setTitleColor:color forState:UIControlStateNormal];
    [self setTitleColor:color forState:UIControlStateHighlighted];
    
    self.showsTouchWhenHighlighted = YES;
    self.backgroundColor = [UIColor whiteColor];
    self.layer.borderColor = [[UIColor blackColor] CGColor];
    [self setBackgroundImage:[self buttonImageFromColor:[UIColor whiteColor]] forState:UIControlStateHighlighted];
}
@end
