//
//  SDChallengeVC.h
//  SuDoKu
//
//  Created by ysy on 13-12-4.
//  Copyright (c) 2013年 com.ysy.www. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SDShowGameVC : UIViewController
{
   
}

@property (retain, nonatomic) IBOutlet UIView *contentView;
@property (retain, nonatomic) IBOutlet UIButton *comebackBtn;
@property (retain, nonatomic) IBOutlet UIButton *lastBtn;
@property (retain, nonatomic) IBOutlet UILabel *titleLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withGameModel:(NSInteger)gameModel withGameIndex:(NSInteger)gameIndex withIsRead:(BOOL)isRead;


@end
