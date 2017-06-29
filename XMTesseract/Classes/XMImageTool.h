//
//  XMImageTool.h
//  PandaCashBox
//
//  Created by 张家铭 on 2017/6/9.
//  Copyright © 2017年 Panda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface XMImageTool : NSObject

/**
 *  将CMSampleBufferRef转成UIImage对象

 *  @param sampleBuffer sampleBuffer
 *  @return image
 */
+ (UIImage *)xm_imageWithSampleBuffer:(CMSampleBufferRef)sampleBuffer;

/**
 *  根据rect裁剪图片

 *  @param image image
 *  @param rect rect
 *  @return image
 */
+ (UIImage *)xm_cropImage:(UIImage *)image inRect:(CGRect)rect;

@end
