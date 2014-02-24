//
//  SDGameVC9.m
//  SuDoKu
//
//  Created by ysy on 13-12-9.
//  Copyright (c) 2013年 com.ysy.www. All rights reserved.
//

#import "SDGameVC9.h"
#import "SDCommonMethod.h"

@interface SDGameVC9 ()

@end

@implementation SDGameVC9

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - 按钮事件
- (IBAction)buttonMethod:(UIButton *)sender
{
    if ([self.gameDelegate respondsToSelector:@selector(numberButtonMethod:)])
    {
        [self.gameDelegate numberButtonMethod:sender];
    }
}

- (void)setView9NumberValue:(NSString *)data withQuesIndex:(NSInteger)index
{
    NSString *quesStr = [SDCommonMethod getQuestionForIndex:index withPath:@"sudoku9"];
    for (int i = 0; i < [data length]; i ++)
    {
        NSString *num = [data substringWithRange:NSMakeRange(i, 1)];
        UIButton *button = (UIButton *)[self.view viewWithTag:i + BUTTON_TAG_BASE];
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"select_push" ofType:@"png"];
        [button setBackgroundImage:[UIImage imageWithContentsOfFile:filePath] forState:UIControlStateSelected];
        [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        if ([num isEqualToString:@"0"]) {
            [button setTitle:@" " forState:UIControlStateNormal];
            button.enabled = YES;
        }else{
            [button setTitle:num forState:UIControlStateNormal];
            if ([[quesStr substringWithRange:NSMakeRange(i, 1)]isEqualToString:@"0"]) {
                button.enabled = YES;
            }else{
                [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
                button.enabled = NO;
            }
        }
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
