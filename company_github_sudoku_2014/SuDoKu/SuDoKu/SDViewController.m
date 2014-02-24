//
//  SDViewController.m
//  SuDoKu
//
//  Created by ysy on 13-12-2.
//  Copyright (c) 2013年 com.ysy.www. All rights reserved.
//

#import "SDViewController.h"
#import "SDChoiceGameVC.h"
#import "SDShowGameVC.h"
#import "UIButton+Bootstrap.h"
#import "SDCommonMethod.h"
#import "SDAlertView.h"
#import "SDMoreVC.h"

@interface SDViewController ()<SDChoiceGameVCDelegate>

@property (nonatomic,retain)SDChoiceGameVC *choiceVC;

@end

@implementation SDViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self buttonCustomerMethod];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
}

- (void)setChoiceVCLabelString:(NSString *)tltle
{
    if (!_choiceVC)
    {
        self.choiceVC = [[[SDChoiceGameVC alloc] initWithNibName:@"SDChoiceGameVC" bundle:nil] autorelease];
        self.choiceVC.currentModel = GAME_MODE_6;
        self.choiceVC.titleLabel.text = tltle;
        self.choiceVC.choiceDelegate = self;
        [self addChildViewController:self.choiceVC];
    }
    self.choiceVC.titleLabel.text = tltle;
}
#pragma mark -按钮外形
- (void)buttonCustomerMethod
{
    [self.button6 buttonOrangeStyle];
    [self.button9 buttonBlueStyle];
    [self.buttonMore buttonGreenStyle];
    [self.buttonLast buttonPurpleStyle];
}

#pragma mark -按钮 事件
- (IBAction)classicMethod:(UIButton *)sender
{
    //self.topImageView.hidden = YES;
    //self.bottomImageView.hidden = YES;
    self.choiceVC.currentModel = GAME_MODE_6;
    [self setChoiceVCLabelString:@"6 阶"];
    [SDCommonMethod panIn:self.choiceVC.view withpParentView:self.view];
}

- (IBAction)challengeMethod:(UIButton *)sender
{
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"openInt9model"] integerValue] >= 0)
    {
        //self.topImageView.hidden = YES;
        //self.bottomImageView.hidden = YES;
        self.choiceVC.currentModel = GAME_MODE_9;
        [self setChoiceVCLabelString:@"9 阶"];
        [SDCommonMethod panIn:self.choiceVC.view withpParentView:self.view];
    }else{
        SDAlertView *alert = [[SDAlertView alloc] initWithTitle:@"不要急，慢慢来!" withContent:@"先完成前面的!" withLeftButtonTitle:nil withRightButtonTitle:@"知道了"];
        [alert showView];
    }
}

- (IBAction)fightMethod:(UIButton *)sender
{
    /*
    SDMoreVC *vc = [[[SDMoreVC alloc] initWithNibName:@"SDMoreVC" bundle:nil] autorelease];
    [self presentViewController:vc animated:YES completion:^{
        
    }];
     */
}

#pragma mark -SDChoiceGameVCDelegate
- (void)dismissViewMethod
{
    [SDCommonMethod panOut:self.choiceVC.view withpParentView:self.view];
    //self.topImageView.hidden = NO;
    //self.bottomImageView.hidden = NO;
}

#pragma mark - MobiSageAdViewDelegate 委托
#pragma mark




#pragma mark - MobiSageRecommendDelegate 委托函数
#pragma mark



- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_button9 release];
    [_button6 release];
    [_buttonMore release];
    [_buttonLast release];
    [_mainView release];
    [_topImageView release];
    [_bottomImageView release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setTopImageView:nil];
    [self setBottomImageView:nil];
    [super viewDidUnload];
}
@end
