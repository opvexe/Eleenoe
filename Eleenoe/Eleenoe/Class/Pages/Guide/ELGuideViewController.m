//
//  ELGuideViewController.m
//  Eleenoe
//
//  Created by FaceBook on 2019/3/13.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import "ELGuideViewController.h"
#import "ELLoginViewController.h"
#import "ELBaseNavigationViewController.h"
#import "ELGuideView.h"

@interface ELGuideViewController ()

@property(nonatomic,strong)ELGuideView *guideView;

@end

@implementation ELGuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.guideView];
    [self.guideView didEnterCompletetedBlock:^{
        [ELUserDefaults setValue:AppVersion forKey:WithEleenoeVersion];
        [ELUserDefaults synchronize];
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window setRootViewController:[[ELBaseNavigationViewController alloc] initWithRootViewController: [[ELLoginViewController alloc] init]]];
    }];
}

-(ELGuideView *)guideView{
    if (!_guideView) {
        _guideView = [[ELGuideView alloc] initWithFrame:self.view.bounds];
        _guideView.guideImages = @[@"WithEleeno1",@"WithEleeno2",@"WithEleeno3"];
    }
    return _guideView;
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
