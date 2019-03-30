//
//  ELHomeViewController.m
//  Eleenoe
//
//  Created by FaceBook on 2019/3/13.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import "ELHomeViewController.h"
#import "ELBluetoothConnectionFloatingView.h"
#import "ELElectrodeViewController.h"
#import "ELBluetoothConnectionFloatingView.h"
#import "ELMyofascialBottomView.h"
@interface ELHomeViewController ()
@property(nonatomic,strong)ELMyofascialBottomView *bottomView;
@end

@implementation ELHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"肌筋膜放松仪";
    self.navigationRightView = [CJXBarButtonItem buttonWithImageNormal:@"home_nav_more" imageSelected:@"home_nav_more" imageHightlight:@"home_nav_more" target:self selector:@selector(Click)];
    
    _bottomView = ({
        ELMyofascialBottomView *iv = [[ELMyofascialBottomView alloc]init];
        [self.view addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.height.mas_equalTo(kSAdap_V(146));
        }];
        iv;
    });
}

-(void)Click{
    
    
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
