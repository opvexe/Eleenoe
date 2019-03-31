//
//  ELMineViewController.m
//  Eleenoe
//
//  Created by FaceBook on 2019/3/13.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import "ELMineViewController.h"
#import "ELSettingModel.h"
#import "ELMineListView.h"
@interface ELMineViewController ()
@property (nonatomic,strong) ELMineListView *listView;
@property (nonatomic, strong) UIButton *logoutButton;
@end

@implementation ELMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"个人中心";
    [self configView];
    [self loadDataSoucre];
}

-(void)configView{
    
    UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kSAdap_V(170.0))];
    footView.backgroundColor = [UIColor clearColor];
    _logoutButton =({
        UIButton *iv = [UIButton buttonWithType:UIButtonTypeCustom];
        iv.frame = CGRectMake(0, kSAdap_V(120.0), SCREEN_WIDTH, kSAdap_V(50.0));
        [iv setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
        [iv setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateHighlighted];
        [iv .titleLabel setFont:[UIFont ELPingFangSCMediumFontOfSize:kSaFont(15.0)]];
        [iv setTitleColor:MainBlackTitleColor forState:UIControlStateNormal];
        [iv setTitleColor:MainBlackTitleColor forState:UIControlStateHighlighted];
        [iv setTitle:@"退出" forState:UIControlStateNormal];
        [iv setTitle:@"退出" forState:UIControlStateHighlighted];
        iv.showsTouchWhenHighlighted=NO;
        [iv addTarget:self action:@selector(logoutAction:) forControlEvents:UIControlEventTouchUpInside];
        [footView addSubview:iv];
        iv;
    });
    
    _listView = ({
        ELMineListView *iv = [[ELMineListView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        iv.tableFooterView = footView;
        [self.view addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            if (iOS11) {
                make.edges.mas_equalTo(self.view.safeAreaInsets);
            }else{
                make.edges.mas_equalTo(self.view);
            }
        }];
        iv;
    });
}

-(void)loadDataSoucre{
    NSArray *settings =[NSArray array];
    settings = @[@{@"sections":@[
                           @{@"icon":@"mine_instructions",@"title":@"使用说明",@"itemType":@(WDSettingItemTypeArrow),@"ClassName":@"ELWebViewController"},
                           @{@"icon":@"mine_suggestion",@"title":@"意见反馈",@"itemType":@(WDSettingItemTypeArrow),@"ClassName":@"ELWebViewController"},
                           @{@"icon":@"mine_announcements",@"title":@"注意事项",@"itemType":@(WDSettingItemTypeArrow),@"ClassName":@"ELWebViewController"}]},
                 @{@"sections":@[
                           @{@"icon":@"mine_service",@"title":@"售后服务",@"itemType":@(WDSettingItemTypeArrow),@"ClassName":@"ELWebViewController"}]}];
    NSArray *souce = [ELSettingModel mj_objectArrayWithKeyValuesArray:settings];
    [self.listView initWithSouce:souce];
}

-(void)logoutAction:(UIButton *)sender{
    NSLog(@"退出");
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
