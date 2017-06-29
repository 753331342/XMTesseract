//
//  XMOpencvImageTool.h
//  XMTesseract
//
//  Created by 张家铭 on 2017/6/27.
//  Copyright © 2017年 张家铭. All rights reserved.
//

#ifdef __cplusplus
#import <opencv2/core.hpp>
#import <opencv2/imgproc.hpp>
#import <opencv2/core/core_c.h>
#import <opencv2/imgcodecs/ios.h>
#endif

#ifdef __ObjC
#import <UIKit/UIKit.h>
#endif

@interface XMOpencvImageTool : NSObject
/**
 *  压缩图片到size大小
 
 *  @param image image
 *  @param size size
 *  @return UIImage
 */
+ (UIImage *)xm_resizingImage:(UIImage *)image withSize:(CGSize)size;


+ (UIImage *)xm_obtainIDNumberImage:(UIImage *)image;
@end
