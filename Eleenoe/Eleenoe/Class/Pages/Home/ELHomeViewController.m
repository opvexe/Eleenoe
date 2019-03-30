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
#import "ELHomeListView.h"
#import "ELHomeTitleListView.h"
#import "ELMyofascialMenuScrolloView.h"
#import "ELMyofascialMenuModel.h"
@interface ELHomeViewController ()
@property(nonatomic,strong)ELMyofascialBottomView *bottomView;
@property(nonatomic,strong)ELHomeListView *homelistView;
@property(nonatomic,strong)ELHomeTitleListView *titleListView;
@property(nonatomic,strong) ELMyofascialMenuScrolloView *menuScrolloView;
@end

@implementation ELHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"肌筋膜放松仪";
    self.navigationRightView = [CJXBarButtonItem buttonWithImageNormal:@"home_nav_more" imageSelected:@"home_nav_more" imageHightlight:@"home_nav_more" target:self selector:@selector(Click)];
    [self settupView];
}
-(void)settupView{
    
    
    _titleListView = ({
        ELHomeTitleListView *iv = [[ELHomeTitleListView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        [self.view addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.height.mas_equalTo(kSAdap(82));
            make.left.and.right.mas_equalTo(0);
        }];
        iv;
    });
    
    
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
    
    //    _homelistView = ({
    //        ELHomeListView *iv = [[ELHomeListView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    //        [self.view addSubview:iv];
    //        iv.backgroundColor = [UIColor whiteColor];
    //        iv.layer.cornerRadius  =5;
    //        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
    //            make.top.mas_equalTo(self.titleListView.mas_bottom);
    //            make.left.and.right.mas_equalTo(0);
    //            make.bottom.mas_equalTo(self.bottomView.mas_top);
    //        }];
    //        iv;
    //    });
    
    _menuScrolloView = ({
        ELMyofascialMenuScrolloView *iv = [[ELMyofascialMenuScrolloView alloc]init];
        iv.backgroundColor = [UIColor clearColor];
        [self.view addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.titleListView.mas_bottom).mas_offset(kSAdap_V(54.0));
            make.left.mas_equalTo(kSAdap(41.0));
            make.height.mas_equalTo(kSAdap_V(200.0));
            make.width.mas_equalTo(kSAdap(80.0));
        }];
        iv;
    });
    NSMutableArray *list = [NSMutableArray arrayWithCapacity:0];
    for (NSInteger i = 0; i< 10; i++) {
        ELMyofascialMenuModel *model = [[ELMyofascialMenuModel alloc]init];
        model.title = [NSString stringWithFormat:@"%ld",i];
        [list addObject:model];
    }
    [self.menuScrolloView initWithSouce:list];
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
