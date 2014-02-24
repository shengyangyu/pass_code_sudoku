//
//  SDCassicsVC.h
//  SuDoKu
//
//  Created by shengyang_yu on 13-12-5.
//  Copyright (c) 2013年 com.ysy.www. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SDChoiceGameVCDelegate <NSObject>

@optional

- (void)dismissViewMethod;

@end

@interface SDChoiceGameVC : UIViewController
{
    
}


@property (nonatomic,assign)id<SDChoiceGameVCDelegate>choiceDelegate;

@property (retain, nonatomic) IBOutlet UILabel *titleLabel;

@property (retain, nonatomic) IBOutlet UIView *mainView;

@property (retain, nonatomic) IBOutletCollection(UIButton) NSArray *numberBtnArray;

//当前游戏模式6 或 9
@property (nonatomic,assign) NSInteger currentModel;

- (void)setTitleLabelText:(NSString *)title;

@property (retain, nonatomic) IBOutlet UIImageView *buttomImage;


@end
