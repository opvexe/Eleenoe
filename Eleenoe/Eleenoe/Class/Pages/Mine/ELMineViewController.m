//
//  ELMineViewController.m
//  Eleenoe
//
//  Created by FaceBook on 2019/3/13.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import "ELMineViewController.h"
#import "ELMineTableViewCell.h"

@interface ELMineViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableListView;
@property (nonatomic, strong) NSMutableArray *lists;
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
    
    UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kSAdap_V(80.0))];
    footView.backgroundColor = [UIColor clearColor];
    _logoutButton =({
        UIButton *iv = [UIButton buttonWithType:UIButtonTypeCustom];
        iv.frame = CGRectMake(0, kSAdap_V(40.0), SCREEN_WIDTH, kSAdap_V(40.0));
        [iv setBackgroundImage:[UIImage imageWithColor:[UIColor redColor]] forState:UIControlStateNormal];
        [iv setBackgroundImage:[UIImage imageWithColor:[UIColor redColor]] forState:UIControlStateHighlighted];
        [iv .titleLabel setFont:[UIFont ELHelveticaFontOfSize:kSaFont(16.0)]];
        [iv setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [iv setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        [iv setTitle:@"退出" forState:UIControlStateNormal];
        [iv setTitle:@"退出" forState:UIControlStateHighlighted];
        iv.showsTouchWhenHighlighted=NO;
        [iv addTarget:self action:@selector(logoutAction:) forControlEvents:UIControlEventTouchUpInside];
        [footView addSubview:iv];
        iv;
    });
    
    _tableListView = ({
        UITableView *iv = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];;
        [self.view addSubview:iv];
        iv.showsVerticalScrollIndicator =NO;
        iv.showsHorizontalScrollIndicator =NO;
        iv.separatorStyle = UITableViewCellSeparatorStyleNone;
        iv.dataSource = self;
        iv.delegate = self;
        iv.rowHeight = kSAdap_V(60.0);
        iv.tableFooterView  = footView;
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
                           @{@"icon":@"instructions",@"title":@"使用说明",@"itemType":@(WDSettingItemTypeArrow),@"ClassName":@"ELWebViewController"},
                           @{@"icon":@"suggestion",@"title":@"意见反馈",@"itemType":@(WDSettingItemTypeArrow),@"ClassName":@"ELSuggestionViewController"},
                           @{@"icon":@"announcements",@"title":@"注意事项",@"itemType":@(WDSettingItemTypeArrow),@"ClassName":@"ELWebViewController"}]},
                 @{@"sections":@[
                           @{@"icon":@"service",@"title":@"售后服务",@"itemType":@(WDSettingItemTypeArrow),@"ClassName":@"ELWebViewController"}]}];
    self.lists = [ELSettingModel mj_objectArrayWithKeyValuesArray:settings];
    [self.tableListView reloadData];
}

#pragma mark - 退出
-(void)logoutAction:(UIButton *)sender{
    
}

#pragma mark UITableViewDelegate,UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    ELSettingModel *model = self.lists[section];
    return model.sections.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.lists.count;;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ELMineTableViewCell *cell = [ELMineTableViewCell CellWithTableView:tableView];
    ELSettingModel *model = self.lists[indexPath.section];
    [cell InitDataWithModel:model.sections[indexPath.row]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark 适配ios11
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return kSAdap_V(8.0);
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
