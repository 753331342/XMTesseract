//
//  XMTesseract.h
//  XMTesseract
//
//  Created by 张家铭 on 2017/6/23.
//  Copyright © 2017年 张家铭. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XMTesseract : NSObject

@property (nonatomic, strong) UIImage *image;

@property (nonatomic, readonly) NSString *recognizedText;

- (BOOL)recognize;

@end
