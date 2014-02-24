/*
 tesseract 解决方法 ysy
 
 Add the framework "TesseractOCR.framework" (you can drag&drop it) from the Products folder in this repo, to your XCode Project under the frameworks folder.
 
 If you are masochist :) you can generate your TesseractOCR.framework building the TesseractOCRAggregate target.
 
 If you are using iOS7 or greater, link libstdc++.6.0.9.dylib library (Your target => General => Linked Frameworks and Libraries => + => libstdc++.6.0.9)
 
 Go to your project, click on the project and in the Build Settings tab add -lstdc++ to all the "Other Linker Flags" keys.
 
 Go to your project settings, and ensure that C++ Standard Library => Compiler Default. (thanks to https://github.com/trein)
 
 Import the tessdata folder under the root of your project. It contains the "tessdata" files. You can add more tessdata files copyng them here.
 
 Import the header in your classes writing #import <TesseractOCR/TesseractOCR.h>
 
 */
//
//  SDCoreVC.h
//  SuDoKu
//
//  Created by ysy on 13-12-4.
//  Copyright (c) 2013年 com.ysy.www. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDGameProtocol.h"


@interface SDCoreVC : UIViewController
{

}
@property (retain, nonatomic) IBOutlet UIImageView *coreImageView;

@property (retain, nonatomic) IBOutlet UIButton *resultBtn;

@property (retain, nonatomic) IBOutlet UIButton *comebackBtn;

@property (retain, nonatomic) IBOutlet UIButton *clearBtn;


@property (nonatomic, assign) id<SDCoreVCDelegate> coreDelegate;

@property (nonatomic, assign) NSInteger currentTag;

- (void)setTesseractImage:(UIImage *)image;

@end
