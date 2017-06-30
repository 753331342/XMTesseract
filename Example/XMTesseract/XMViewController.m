//
//  XMViewController.m
//  XMTesseract
//
//  Created by 753331342@qq.com on 06/29/2017.
//  Copyright (c) 2017 753331342@qq.com. All rights reserved.
//

#import "XMViewController.h"

#import <XMTesseract/XMTesseract-umbrella.h>

@interface XMViewController ()

@end

@implementation XMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    [XMOpencvImageTool xm_obtainIDNumberImage:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
