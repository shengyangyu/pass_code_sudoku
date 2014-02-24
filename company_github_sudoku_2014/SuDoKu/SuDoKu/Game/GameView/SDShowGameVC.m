//
//  SDChallengeVC.m
//  SuDoKu
//
//  Created by ysy on 13-12-4.
//  Copyright (c) 2013年 com.ysy.www. All rights reserved.
//

#import "SDShowGameVC.h"
#import "SDCoreVC.h"
#import "SDGameVC6.h"
#import "SDGameVC9.h"
#import "SDCommonMethod.h"
#import <QuartzCore/QuartzCore.h>
#import "UIButton+Bootstrap.h"
#import "SDAlertView.h"

@interface SDShowGameVC ()<SDGameProtocol,SDCoreVCDelegate>

//绘制界面
@property (nonatomic,retain) SDCoreVC *coreView;
//按钮界面6
@property (nonatomic,retain) SDGameVC6 *gameVC6;
//按钮界面9
@property (nonatomic,retain) SDGameVC9 *gameVC9;
//当前做题情况
@property (nonatomic,retain) NSMutableArray *resultArray;
//当前游戏模式6 或 9
@property (nonatomic,assign) NSInteger currentModel;
//当前游戏第几关
@property (nonatomic,assign) NSInteger currentIndex;

@end

@implementation SDShowGameVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withGameModel:(NSInteger)gameModel withGameIndex:(NSInteger)gameIndex withIsRead:(BOOL)isRead
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.currentIndex = gameIndex;
        if (gameModel == GAME_MODE_6)
        {
            self.currentModel = GAME_MODE_6;
            self.gameVC6 = [[[SDGameVC6 alloc] initWithNibName:@"SDGameVC6" bundle:nil] autorelease];
            self.gameVC6.gameDelegate = self;
            if (isRead == YES) {
                [self.gameVC6 setView6NumberValue:[[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"answer%dmodel%d",self.currentModel,gameIndex]] withQuesIndex:gameIndex];
            }else{
                [self.gameVC6 setView6NumberValue:[SDCommonMethod getQuestionForIndex:gameIndex withPath:@"sudoku6"]  withQuesIndex:gameIndex];
            }
            [self addChildViewController:self.gameVC6];
        }
        else
        {
            self.currentModel = GAME_MODE_9;
            self.gameVC9 = [[[SDGameVC9 alloc] initWithNibName:@"SDGameVC9" bundle:nil] autorelease];
            self.gameVC9.gameDelegate = self;
            if (isRead == YES) {
                [self.gameVC9 setView9NumberValue:[[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"answer%dmodel%d",self.currentModel,gameIndex]] withQuesIndex:gameIndex];
            }else{
                [self.gameVC9 setView9NumberValue:[SDCommonMethod getQuestionForIndex:gameIndex withPath:@"sudoku9"] withQuesIndex:gameIndex];
            }
            [self addChildViewController:self.gameVC9];
        }
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self displayGameView];
    self.titleLabel.text = [NSString stringWithFormat:@"%d阶%d段第%d关",self.currentModel,(self.currentIndex/9 +1),(self.currentIndex%9+1)];
}
#pragma mark -添加游戏格子
- (void)displayGameView
{
    [self.comebackBtn setBackGroundAndTitleColorStyle];
    [self.comebackBtn addAwesomeIcon:FAIconChevronLeft beforeTitle:YES];
    
    if (self.currentModel == GAME_MODE_6)
    {
         [self.contentView addSubview:self.gameVC6.view];
    }else{
        [self.contentView addSubview:self.gameVC9.view];
    }
}
#pragma mark -完成
- (IBAction)startCoreMethod:(UIButton *)sender
{
    
    if ([[self currentAnswer] isEqualToString:@"less"])
    {
        SDAlertView *alert = [[SDAlertView alloc] initWithTitle:@"亲" withContent:@"您的答题不完整!" withLeftButtonTitle:nil withRightButtonTitle:@"知道了"];
        [alert showView];
        [alert release];
        
    }
    else if ([SDCommonMethod testAnswer:[self currentAnswer] withGameModel:_currentModel])
    {
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:[NSString stringWithFormat:@"answer%dmodel%d",self.currentModel,self.currentIndex]];
        self.currentIndex ++;
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:self.currentIndex] forKey:[NSString stringWithFormat:@"openInt%dmodel",self.currentModel]];
        if (self.currentIndex == 36) {
            self.currentIndex = 35;
            [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:self.currentIndex] forKey:[NSString stringWithFormat:@"openInt%dmodel",self.currentModel]];
            [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:0] forKey:@"openInt9model"];
            SDAlertView *alert = [[SDAlertView alloc] initWithTitle:@"恭喜您,成功通过" withContent:@"6阶全关,9阶开启" withLeftButtonTitle:nil withRightButtonTitle:@"知道了"];
            [alert showView];
            alert.rightBlock = ^(){
                [self comeBackMethod:nil];
            };
            [alert release];
        }
        else
        {
            SDAlertView *alert = [[SDAlertView alloc] initWithTitle:@"恭喜您,成功通过" withContent:[NSString stringWithFormat:@"%d阶%d段第%d关",self.currentModel,(self.currentIndex/9 ),(self.currentIndex%9+1)] withLeftButtonTitle:@"返回" withRightButtonTitle:@"下一关"];
            [alert showView];
            alert.leftBlock = ^(){
                [self comeBackMethod:nil];
            };
            alert.rightBlock = ^(){
                self.titleLabel.text = [NSString stringWithFormat:@"%d阶%d段第%d关",self.currentModel,(self.currentIndex/9 +1),(self.currentIndex%9+1)];
                if (self.currentModel == GAME_MODE_6)
                {
                    [self.gameVC6 setView6NumberValue:[SDCommonMethod getQuestionForIndex:self.currentIndex withPath:@"sudoku6"] withQuesIndex:self.currentIndex];
                }
                else
                {
                    [self.gameVC9 setView9NumberValue:[SDCommonMethod getQuestionForIndex:self.currentIndex withPath:@"sudoku9"] withQuesIndex:self.currentIndex];
                }
            };
            [alert release];
        }
    }else{
        SDAlertView *alert = [[SDAlertView alloc] initWithTitle:@"请仔细检查" withContent:@"您的答案有误!" withLeftButtonTitle:nil withRightButtonTitle:@"知道了"];
        [alert showView];
        [alert release];
    }
     
}
/**
 *  检测当前数据填充 以及答案的录入
 *
 *  @return 答案
 */
- (NSString *)currentAnswer
{
    if (!_resultArray) {
        self.resultArray = [NSMutableArray array];
    }
    [self.resultArray removeAllObjects];
    for (int i = 0; i < _currentModel * _currentModel; i ++) {
        UIButton *btn = (self.currentModel == GAME_MODE_6)?((UIButton *)[self.gameVC6.view viewWithTag:BUTTON_TAG_BASE + i]):((UIButton *)[self.gameVC9.view viewWithTag:BUTTON_TAG_BASE + i]);
        [self.resultArray addObject:[btn titleForState:UIControlStateNormal]];
        
        if ([[self.resultArray objectAtIndex:i] isEqualToString:@" "]) {
            return @"less";
        }
    }
    NSString *string = [NSString stringWithFormat:@"%@",[self.resultArray componentsJoinedByString:@""]];
    return string;
}

- (IBAction)comeBackMethod:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
#pragma mark -SDGameProtocol 游戏界面按钮代理
// 界面上的按钮 触发手写 先给你一个默认的值
- (void)numberButtonMethod:(UIButton *)sender
{
    [sender setBackgroundImage:[SDCommonMethod buttonImageFromColor:[UIColor colorWithRed:27/255.0 green:147/255.0 blue:237/255.0 alpha:1] withFrame:sender.bounds] forState:UIControlStateSelected];
    sender.selected = YES;
    //分两次 初始化 都写在init里面会卡
    if (!_coreView) {
        self.coreView = [[[SDCoreVC alloc] initWithNibName:@"SDCoreVC" bundle:nil] autorelease];
        self.coreView.coreDelegate = self;
    }
    [self.coreView.resultBtn setTitle:[SDCommonMethod displayTitle:[sender titleForState:UIControlStateNormal]] forState:UIControlStateNormal];
    self.coreView.currentTag = sender.tag;
    [self.view addSubview:self.coreView.view];
    //手写板 添加
    [SDCommonMethod fadeIn:self.coreView.view];
    self.comebackBtn.hidden = YES;
    self.lastBtn.hidden = YES;
    [sender superview].userInteractionEnabled = NO;
}

#pragma mark -SDCoreVCDelegate 手写绘制按钮代理
// 写入完毕 将新得到的值 给当前的按钮
- (void)sureResultMethod:(UIButton *)sender
{
    self.comebackBtn.hidden = NO;
    self.lastBtn.hidden = NO;
    //手写板 消失
    [SDCommonMethod fadeOut:self.coreView.view];
    UIButton *btn = (self.currentModel == GAME_MODE_6)?((UIButton *)[self.gameVC6.view viewWithTag:self.coreView.currentTag]):((UIButton *)[self.gameVC9.view viewWithTag:self.coreView.currentTag]);
    btn.selected = NO;
    [btn superview].userInteractionEnabled = YES;
    //如果有值 sender不为nil 则继续
    if (sender) {
        [btn setTitle:[SDCommonMethod displayTitle:[sender titleForState:UIControlStateNormal]] forState:UIControlStateNormal];
    }
    
}

#pragma mark - MobiSageAdViewDelegate 委托
#pragma mark


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    if (!_resultArray) {
        self.resultArray = [NSMutableArray array];
    }
    [self.resultArray removeAllObjects];
    for (int i = 0; i < _currentModel * _currentModel; i ++) {
        UIButton *btn = (self.currentModel == GAME_MODE_6)?((UIButton *)[self.gameVC6.view viewWithTag:BUTTON_TAG_BASE + i]):((UIButton *)[self.gameVC9.view viewWithTag:BUTTON_TAG_BASE + i]);
        NSString *str = [btn titleForState:UIControlStateNormal];
        if ([str isEqualToString:@" "] ) {
            str = @"0";
        }
        [self.resultArray addObject:str];
    }
    NSString *string = [NSString stringWithFormat:@"%@",[self.resultArray componentsJoinedByString:@""]];
    [[NSUserDefaults standardUserDefaults] setObject:string forKey:[NSString stringWithFormat:@"answer%dmodel%d",self.currentModel,self.currentIndex]];
}
- (void)dealloc {
    
    [_coreView release],_coreView = nil;
    [_gameVC6 release],_gameVC6 = nil;
    [_gameVC9 release],_gameVC9 = nil;
    [_resultArray release],_resultArray = nil;
    [_contentView release];
    [_comebackBtn release];
    [_lastBtn release];
    [_titleLabel release];
    [super dealloc];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
