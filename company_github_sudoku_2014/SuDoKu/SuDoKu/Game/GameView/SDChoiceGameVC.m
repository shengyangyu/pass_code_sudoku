//
//  SDCassicsVC.m
//  SuDoKu
//
//  Created by shengyang_yu on 13-12-5.
//  Copyright (c) 2013年 com.ysy.www. All rights reserved.
//

#import "SDChoiceGameVC.h"
#import "SDCommonMethod.h"
#import "UIButton+Bootstrap.h"
#import "SDShowGameVC.h"
#import "SDAlertView.h"

@interface SDChoiceGameVC ()



@end

@implementation SDChoiceGameVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       
    }
    return self;
}
#pragma mark - 界面按钮方法
- (IBAction)stopGameMethod:(UIButton *)sender
{
    if ([self.choiceDelegate respondsToSelector:@selector(dismissViewMethod)]) {
        
        [self.choiceDelegate dismissViewMethod];
    }
    /*
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
     */
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self changeViewButtonSytle];
    self.buttomImage.frame = CGRectMake(self.buttomImage.frame.origin.x, MAINSCREEN_HEIGHT - 50 - STATUS_HEIGHT, self.buttomImage.frame.size.width, self.buttomImage.frame.size.height);
    }
- (void)changeViewButtonSytle
{
    for (int i = 0 ; i < [self.numberBtnArray count] ; i ++)
    {
        UIButton *button = (UIButton *)[self.numberBtnArray objectAtIndex:i];
        UIColor *color = ((i / 9 == 0)?Purple_Color:((i / 9 == 1)?Orange_Color:((i / 9 == 2)?Blue_Color:Green_Color)));
        [button setCircleButton:color];
        button.tag = BUTTON_TAG_BASE + i;
        [button addTarget:self action:@selector(buttonMethod:) forControlEvents:UIControlEventTouchUpInside];
    }
}

#pragma mark - 按钮方法
- (void)buttonMethod:(UIButton *)sender
{
    NSInteger currentIndex = [[[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"openInt%dmodel",self.currentModel]] integerValue];
    if (sender.tag - BUTTON_TAG_BASE > currentIndex)
    {
        SDAlertView *alert = [[SDAlertView alloc] initWithTitle:@"不要急，慢慢来!" withContent:@"先完成前面的!" withLeftButtonTitle:nil withRightButtonTitle:@"知道了"];
        [alert showView];
    }
    else if (sender.tag - BUTTON_TAG_BASE < currentIndex)
    {
        SDAlertView *alert = [[SDAlertView alloc] initWithTitle:@"亲,这不是你的最高关卡!" withContent:@"要玩这个关卡?" withLeftButtonTitle:@"返回" withRightButtonTitle:@"确定"];
        [alert showView];
        alert.rightBlock = ^(){
            SDShowGameVC *vc = [[[SDShowGameVC alloc] initWithNibName:@"SDShowGameVC" bundle:nil withGameModel:self.currentModel withGameIndex:sender.tag - BUTTON_TAG_BASE withIsRead:NO] autorelease];
            [self presentViewController:vc animated:YES completion:^{
                
            }];
        };
        [alert release];
    }
    else
    {
        BOOL read = NO;
        if ([[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"answer%dmodel%d",self.currentModel,sender.tag - BUTTON_TAG_BASE]] != nil) {
            read = YES;
        }
        SDShowGameVC *vc = [[[SDShowGameVC alloc] initWithNibName:@"SDShowGameVC" bundle:nil withGameModel:self.currentModel withGameIndex:sender.tag - BUTTON_TAG_BASE withIsRead:read] autorelease];
        [self presentViewController:vc animated:YES completion:^{
            
        }];
    }
}

- (void)setTitleLabelText:(NSString *)title
{
    self.titleLabel.text = title;
    [self.view drawRect:self.view.frame];
}
#pragma mark - MobiSageAdViewDelegate 委托
#pragma mark


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_numberBtnArray release];
    [_mainView release];
    [_titleLabel release];
    [_buttomImage release];
    [super dealloc];
}
@end
