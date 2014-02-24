//
//  SDGameVC9.h
//  SuDoKu
//
//  Created by ysy on 13-12-9.
//  Copyright (c) 2013年 com.ysy.www. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDGameProtocol.h"

@interface SDGameVC9 : UIViewController

@property (nonatomic,assign) id<SDGameProtocol> gameDelegate;

- (void)setView9NumberValue:(NSString *)data withQuesIndex:(NSInteger)index;


@end
