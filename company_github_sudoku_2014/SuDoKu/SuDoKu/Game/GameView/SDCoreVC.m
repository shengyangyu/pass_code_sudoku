//
//  SDCoreVC.m
//  SuDoKu
//
//  Created by ysy on 13-12-4.
//  Copyright (c) 2013年 com.ysy.www. All rights reserved.
//

#import "SDCoreVC.h"
#import <TesseractOCR/TesseractOCR.h>
#import "UIButton+Bootstrap.h"

@interface SDCoreVC ()
{
    uint32_t *mpixels;
}
@property (nonatomic, retain) Tesseract *myTesseract;

@end

@implementation SDCoreVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.myTesseract = [[[Tesseract alloc] initWithDataPath:@"tessdata" language:@"heb-seg"] autorelease];
        [self.myTesseract setVariableValue:@"123456789" forKey:@"tessedit_char_whitelist"];
        self.currentTag = 0;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setViewButtonStyel];
    
}
#pragma mark 界面按钮
- (void)setViewButtonStyel
{
    [self.comebackBtn setBackGroundAndTitleColorStyle];
    [self.comebackBtn addAwesomeIcon:FAIconChevronLeft beforeTitle:NO];

    [self.resultBtn defaultStyle];
    
    [self.clearBtn setBackGroundAndTitleColorStyle];
    [self.clearBtn addAwesomeIcon:FAIconUndo beforeTitle:NO];
}

#pragma mark 检测方法
- (void)startRecognize:(UIImage *)imageData
{
    [self.myTesseract setImage:imageData];
    if ([self.myTesseract recognize])
    {
        if ([[self.myTesseract recognizedText] length] > 0) {
            
        NSString *numStr = ([[[self.myTesseract recognizedText] substringToIndex:1] length] > 0)?([[self.myTesseract recognizedText] substringToIndex:1]):@"空";
        [self.resultBtn setTitle:numStr forState:UIControlStateNormal];
            
        }else{
            [self.resultBtn setTitle:@"空" forState:UIControlStateNormal];
        }
    }else{
        [self.resultBtn setTitle:@"空" forState:UIControlStateNormal];
    }
//    [self.myTesseract clear];
}

#pragma mark - 界面按钮
#pragma mark -关闭绘制
- (void)closeCoreMethod
{
    self.coreImageView.image = UIGraphicsGetImageFromCurrentImageContext();
    CGContextClosePath(UIGraphicsGetCurrentContext());
}

#pragma mark -返回
- (IBAction)comebackMethod:(UIButton *)sender
{
    [self closeCoreMethod];
    if ([self.coreDelegate respondsToSelector:@selector(sureResultMethod:)])
    {
        [self.coreDelegate sureResultMethod:nil];
    }
}


#pragma mark -确定
- (IBAction)sureMethod:(UIButton *)sender
{
   [self closeCoreMethod];
    
    if ([self.coreDelegate respondsToSelector:@selector(sureResultMethod:)])
    {
        [self.coreDelegate sureResultMethod:sender];
    }
}

#pragma mark -清除
- (IBAction)clearMethod:(UIButton *)sender
{
    [self.resultBtn setTitle:@"空" forState:UIControlStateNormal];
    [self closeCoreMethod];
}

#pragma mark - touch 事件
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //绘制状态
    UIGraphicsBeginImageContext(self.coreImageView.frame.size);
    [self.coreImageView.image drawInRect:CGRectMake(0, 0, self.coreImageView.frame.size.width, self.coreImageView.frame.size.height)];
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 6);
    
    CGContextSetAllowsAntialiasing(UIGraphicsGetCurrentContext(), YES);
    CGContextSetShouldAntialias(UIGraphicsGetCurrentContext(), YES);
    
    CGContextSetRGBFillColor(UIGraphicsGetCurrentContext(), 0, 0, 0, 1);
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    //绘制状态
    UITouch * touch = [touches anyObject];
    CGPoint location = [touch locationInView:self.view];
    CGPoint pastLocation = [touch previousLocationInView:self.view];
    
    // draw lines
    CGContextBeginPath(UIGraphicsGetCurrentContext());
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), pastLocation.x, pastLocation.y);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), location.x, location.y);
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    self.coreImageView.image = UIGraphicsGetImageFromCurrentImageContext();
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    //绘制状态
    UIGraphicsEndImageContext();
    //本地是否存在
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filePath = [NSString stringWithFormat:@"%@/ImageCaches",documentPath];
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath])
    {
        [[NSFileManager defaultManager] createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSString *lastName = @"yangge.jpg";
    filePath = [filePath stringByAppendingFormat:@"/%@",lastName];
    
    if ([UIImageJPEGRepresentation(self.coreImageView.image,1) writeToFile:filePath atomically:YES])
    {
        [self showResult:filePath];
    }
}

#pragma mark - tesseract 解析
- (void)showResult:(NSString *)imagepath
{
    //二值化，和灰度是为了对从相机获取的图片进行预处理以提高识别准确率
    //图片二值化  在用相机拍照时在开启二值化，测试demo图片时可以不开启
    UIImage* tmp_img=[self convertToGrayscale:[UIImage imageWithData:[NSData dataWithContentsOfFile:imagepath]]];
    //灰度 在用相机拍照时在开启二值化，测试demo图片时可以不开启
    UIImage *image = [self grayImage:tmp_img];
    
    [self setTesseractImage:image];
}

- (void)setTesseractImage:(UIImage *)image
{
    free(mpixels);
    CGSize size = [image size];
    int width = size.width;
    int height = size.height;
	if (width <= 0 || height <= 0)
		return;
    // the pixels will be painted to this array
    mpixels = (uint32_t *) malloc(width * height * sizeof(uint32_t));
    // clear the pixels so any transparency is preserved
    memset(mpixels, 0, width * height * sizeof(uint32_t));
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    // create a context with RGBA pixels
    CGContextRef context = CGBitmapContextCreate(mpixels, width, height, 8, width * sizeof(uint32_t), colorSpace,
                                                 kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedLast);
    // paint the bitmap to our context which will fill in the pixels array
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), [image CGImage]);
	// we're done with the context and color space
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    
    //开始检测
    [self startRecognize:image];
}

//二值化
- (UIImage *)convertToGrayscale:(UIImage*)img{
    
    CGSize size = [img size];
    int width = size.width;
    int height = size.height;
    // the pixels will be painted to this array
    uint32_t *pixels = (uint32_t *) malloc(width * height * sizeof(uint32_t));
    // clear the pixels so any transparency is preserved
    memset(pixels, 0, width * height * sizeof(uint32_t));
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    // create a context with RGBA pixels
    CGContextRef context = CGBitmapContextCreate(pixels, width, height, 8, width * sizeof(uint32_t), colorSpace,
                                                 kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedLast);
    // paint the bitmap to our context which will fill in the pixels array
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), [img CGImage]);
    int tt = 1;
    CGFloat intensity;
    int bw;
    for(int y = 0; y < height; y++) {
        for(int x = 0; x < width; x++) {
            uint8_t *rgbaPixel = (uint8_t *) &pixels[y * width + x];
            intensity = (rgbaPixel[tt] + rgbaPixel[tt + 1] + rgbaPixel[tt + 2]) / 3. / 255.;
            if (intensity > 0.45) {
                bw = 255;
            } else {
                bw = 0;
            }
            rgbaPixel[tt] = bw;
            rgbaPixel[tt + 1] = bw;
            rgbaPixel[tt + 2] = bw;
        }
    }
    // create a new CGImageRef from our context with the modified pixels
    CGImageRef image = CGBitmapContextCreateImage(context);
    // we're done with the context, color space, and pixels
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    free(pixels);
    // make a new UIImage to return
    UIImage *resultUIImage = [UIImage imageWithCGImage:image];
    // we're done with image now too
    CGImageRelease(image);
    return resultUIImage;
}

//灰度
-(UIImage *)grayImage:(UIImage *)source
{
    int width = source.size.width;
    int height = source.size.height;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    CGContextRef context = CGBitmapContextCreate(nil,width,height,8,0,colorSpace,kCGBitmapByteOrderDefault);
    CGColorSpaceRelease(colorSpace);
    if (context == NULL) {
        return nil;
    }
    CGContextDrawImage(context,
                       CGRectMake(0, 0, width, height), source.CGImage);
    CGImageRef image = CGBitmapContextCreateImage(context);
    UIImage *grayImage = [UIImage imageWithCGImage:image];
    CGContextRelease(context);
    CGImageRelease(image);
    return grayImage;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    
    [_coreImageView release];
    [_myTesseract release],_myTesseract = nil;
    
    [_resultBtn release];
    [_comebackBtn release];
    [_clearBtn release];
    [super dealloc];
}
@end
