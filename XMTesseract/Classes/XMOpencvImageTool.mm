//
//  XMOpencvImageTool.m
//  XMTesseract
//
//  Created by 张家铭 on 2017/6/27.
//  Copyright © 2017年 张家铭. All rights reserved.
//

#import "XMOpencvImageTool.h"
#import "XMImageTool.h"

#include <iostream>

using namespace cv;
using namespace std;

@implementation XMOpencvImageTool

+ (UIImage *)xm_obtainIDNumberImage:(UIImage *)image {
    cv::Mat resultImage = [self matWithImage:image];
    
    cvtColor(resultImage, resultImage, cv::COLOR_BGR2GRAY);
    
    cv::threshold(resultImage, resultImage, 100, 200, CV_THRESH_BINARY);
    
    cv::Mat erodeElement = getStructuringElement(cv::MORPH_RECT, cv::Size(30,1));
    cv::erode(resultImage, resultImage, erodeElement);
    
    std::vector<std::vector<cv::Point>> contours;
    cv::findContours(resultImage, contours, CV_RETR_TREE, CV_CHAIN_APPROX_SIMPLE, cvPoint(0, 0));
    
    std::vector<cv::Rect> rects;
    cv::Rect numberRect = cv::Rect(0,0,0,0);
    std::vector<std::vector<cv::Point>>::const_iterator itContours = contours.begin();
    
    for ( ; itContours != contours.end(); ++itContours) {
        cv::Rect rect = cv::boundingRect(*itContours);
        rects.push_back(rect);
        if (rect.width > numberRect.width && rect.width > rect.height * 7) {
            numberRect = rect;
        }
    }
    
    // 定位失败
    if (numberRect.width == 0 || numberRect.height == 0) {
        return nil;
    }
    
    // 定位成功
    cv::Mat matImage = [self matWithImage:image];
    resultImage = matImage(numberRect);
    cvtColor(resultImage, resultImage, cv::COLOR_BGR2GRAY);
    cv::threshold(resultImage, resultImage, 100, 200, CV_THRESH_BINARY);
    UIImage *numberImage = [self imageWithCVMat:resultImage];
    return numberImage;
}

+ (UIImage *)xm_resizingImage:(UIImage *)image withSize:(CGSize)size {
    cv::Mat mat = [self matWithImage:image];
    cv::resize(mat, mat, cvSize(size.width * [UIScreen mainScreen].scale, size.height * [UIScreen mainScreen].scale));
    return [self imageWithCVMat:mat];
}

+ (cv::Mat)matWithImage:(UIImage *)image {
    
    CGColorSpaceRef colorSpace = CGImageGetColorSpace(image.CGImage);
    CGFloat cols = image.size.width;
    CGFloat rows = image.size.height;
    
    cv::Mat cvMat(rows, cols, CV_8UC4); // 8 bits per component, 4 channels
    
    CGContextRef contextRef = CGBitmapContextCreate(cvMat.data,                 // Pointer to backing data
                                                    cols,                      // Width of bitmap
                                                    rows,                     // Height of bitmap
                                                    8,                          // Bits per component
                                                    cvMat.step[0],              // Bytes per row
                                                    colorSpace,                 // Colorspace
                                                    kCGImageAlphaNoneSkipLast |
                                                    kCGBitmapByteOrderDefault); // Bitmap info flags
    
    CGContextDrawImage(contextRef, CGRectMake(0, 0, cols, rows), image.CGImage);
    CGContextRelease(contextRef);
    
    return cvMat;
}


+ (UIImage *)imageWithCVMat:(const cv::Mat&)cvMat {
    NSData *data = [NSData dataWithBytes:cvMat.data length:cvMat.elemSize() * cvMat.total()];
    
    CGColorSpaceRef colorSpace;
    
    if (cvMat.elemSize() == 1)
    {
        colorSpace = CGColorSpaceCreateDeviceGray();
    }
    else
    {
        colorSpace = CGColorSpaceCreateDeviceRGB();
    }
    
    CGDataProviderRef provider = CGDataProviderCreateWithCFData((__bridge_retained CFDataRef)data);
    
    CGImageRef imageRef = CGImageCreate(cvMat.cols,                                     // Width
                                        cvMat.rows,                                     // Height
                                        8,                                              // Bits per component
                                        8 * cvMat.elemSize(),                           // Bits per pixel
                                        cvMat.step[0],                                  // Bytes per row
                                        colorSpace,                                     // Colorspace
                                        kCGImageAlphaNone | kCGBitmapByteOrderDefault,  // Bitmap info flags
                                        provider,                                       // CGDataProviderRef
                                        NULL,                                           // Decode
                                        false,                                          // Should interpolate
                                        kCGRenderingIntentDefault);                     // Intent
    
    UIImage *image = [[UIImage alloc] initWithCGImage:imageRef];
    CGImageRelease(imageRef);
    CGDataProviderRelease(provider);
    CGColorSpaceRelease(colorSpace);
    
    return image;
}

@end
