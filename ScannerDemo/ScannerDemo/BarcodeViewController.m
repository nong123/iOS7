//
//  BarcodeViewController.m
//  ScannerDemo
//
//  Created by xuyunan on 13-9-29.
//  Copyright (c) 2013年 xu_yunan@163.com. All rights reserved.
//

#import "BarcodeViewController.h"

@interface BarcodeViewController ()

@end

@implementation BarcodeViewController

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
	// Do any additional setup after loading the view.
    
    _session = [[AVCaptureSession alloc] init];
    [_session setSessionPreset:AVCaptureSessionPresetHigh];;
    
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    NSError *error;
    AVCaptureDeviceInput* deviceInput = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
    if ([_session canAddInput:deviceInput]) {
        [_session addInput:deviceInput];
    }
    
    if (error) {
        NSLog(@"error: %@", error.description);
    }
    
    AVCaptureMetadataOutput* output = [[AVCaptureMetadataOutput alloc] init];
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    if ([_session canAddOutput:output]) {
        [_session addOutput:output];
    }
    
    // 条码类型
    output.metadataObjectTypes = @[AVMetadataObjectTypeUPCECode, AVMetadataObjectTypeCode39Code, AVMetadataObjectTypeCode39Mod43Code, AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode93Code, AVMetadataObjectTypeCode128Code, AVMetadataObjectTypePDF417Code, AVMetadataObjectTypeQRCode, AVMetadataObjectTypeAztecCode];
    
    _previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_session];
    [_previewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    CALayer *rootLayer = [[self view] layer];
    [rootLayer setMasksToBounds:YES];
    [rootLayer insertSublayer:_previewLayer atIndex:0];
    [_session startRunning];
    
    CGSize size = self.view.layer.bounds.size;
    
    if (UIInterfaceOrientationIsLandscape(self.interfaceOrientation)) {
        [_previewLayer setFrame:CGRectMake(0, 0, size.height, size.width)];
    } else {
        [_previewLayer setFrame:CGRectMake(0, 0, size.width, size.height)];
    }
    
    [self setVideoOrientation:self.interfaceOrientation];
}

#pragma mark -
#pragma mark AVCaptureMetadataOutputObjectsDelegate

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    NSLog(@"metadataObjects: %@", metadataObjects);
    
    NSString *stringValue;
    
    if ([metadataObjects count] > 0) {
        AVMetadataMachineReadableCodeObject *metadataObject = [metadataObjects objectAtIndex:0];
        stringValue = metadataObject.stringValue;
    }
    
    [_session stopRunning];
    
    [self dismissViewControllerAnimated:YES completion:^{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:stringValue
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil, nil];
        [alert show];
    }];
}

- (IBAction)btnClicked:(id)sender
{
    if ([_session isRunning]) {
        [_session stopRunning];
    }
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark -

// 屏幕旋转处理
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration;
{
    if (_previewLayer) {
        CGSize size = self.view.layer.bounds.size;
        [_previewLayer setFrame:CGRectMake(0, 0, size.height, size.width)];
    }
    
    [self setVideoOrientation:toInterfaceOrientation];
}

// 防止影像旋转90°
- (void)setVideoOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    AVCaptureVideoOrientation videoOrientation = AVCaptureVideoOrientationPortrait;
    
    switch (toInterfaceOrientation) {
        case UIInterfaceOrientationPortrait:
            videoOrientation = AVCaptureVideoOrientationPortrait;
            break;
        case UIInterfaceOrientationPortraitUpsideDown:
            videoOrientation = AVCaptureVideoOrientationPortraitUpsideDown;
            break;
        case UIInterfaceOrientationLandscapeLeft:
            videoOrientation = AVCaptureVideoOrientationLandscapeLeft;
            break;
        case UIInterfaceOrientationLandscapeRight:
            videoOrientation = AVCaptureVideoOrientationLandscapeRight;
            break;
            
        default:
            break;
    }
    [_previewLayer.connection setVideoOrientation:videoOrientation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
