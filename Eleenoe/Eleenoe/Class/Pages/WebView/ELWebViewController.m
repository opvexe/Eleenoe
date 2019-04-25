//
//  ELWebViewController.m
//  Eleenoe
//
//  Created by FaceBook on 2019/3/18.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import "ELWebViewController.h"

@interface ELWebViewController ()

@end

@implementation ELWebViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    self.showsToolBar = NO;
    self.navigationType = AXWebViewControllerNavigationBarItem;
    if (AX_WEB_VIEW_CONTROLLER_iOS9_0_AVAILABLE()) {
        self.webView.allowsLinkPreview = YES;
    }
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
