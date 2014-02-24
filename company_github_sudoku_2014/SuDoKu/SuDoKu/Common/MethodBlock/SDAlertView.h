//
//  SDAlertView.h
//  SuDoKu
//
//  Created by ysy on 13-12-20.
//  Copyright (c) 2013年 com.ysy.www. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SDAlertView : UIView

- (id)initWithTitle:(NSString *)titleStr withContent:(NSString *)contentStr withLeftButtonTitle:(NSString *)leftStr withRightButtonTitle:(NSString *)rightStr;

- (void)showView;

@property (nonatomic, copy) dispatch_block_t leftBlock;
@property (nonatomic, copy) dispatch_block_t rightBlock;
@property (nonatomic, copy) dispatch_block_t dismissBlock;

@end

@interface UIImage (colorful)

+ (UIImage *)imageWithColor:(UIColor *)color;

@end
