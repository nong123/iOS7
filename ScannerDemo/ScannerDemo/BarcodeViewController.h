//
//  BarcodeViewController.h
//  ScannerDemo
//
//  Created by xuyunan on 13-9-29.
//  Copyright (c) 2013年 xu_yunan@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface BarcodeViewController : UIViewController <AVCaptureMetadataOutputObjectsDelegate>
@property (nonatomic, strong) AVCaptureSession *session;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;
@end
