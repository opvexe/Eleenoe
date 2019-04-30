//
//  ELSearchViewController.m
//  Eleenoe
//
//  Created by FaceBook on 2019/3/29.
//  Copyright © 2019 FaceBook. All rights reserved.
//

#import "ELSearchViewController.h"
#import "ELSearchNavigationView.h"
#import "ELSearchResultView.h"
#import "ELSearchListView.h"
@interface ELSearchViewController ()<ELSearchNavigationViewDelegate,ELSearchBarViewDelegate>
@property(nonatomic,strong)ELSearchNavigationView *searchNavigationView;
@property(nonatomic,strong)ELSearchListView *listView;
@property(nonatomic,strong)ELSearchResultView *resullistView;
@end

@implementation ELSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupView];
}

-(void)setupView{
    _searchNavigationView = ({
        ELSearchNavigationView *iv = [[ELSearchNavigationView alloc] init];
        iv.searchBarView.delegate = self;
        [self.view addSubview:iv];
        iv.delegate  = self;
        iv.backgroundColor = [UIColor whiteColor];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(44);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.top.mas_equalTo(StatusBarHeight);
        }];
        iv;
    });
    
    _listView = ({
        ELSearchListView *iv = [[ELSearchListView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];;
        [self.view addSubview:iv];
        iv.backgroundColor = [UIColor whiteColor];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.searchNavigationView.mas_bottom);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
        }];
        iv;
    });
    
    _resullistView = ({
        ELSearchResultView *iv = [[ELSearchResultView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];;
        [self.view addSubview:iv];
        iv.hidden  = YES;
        iv.backgroundColor = [UIColor whiteColor];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.searchNavigationView.mas_bottom);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
        }];
        iv;
    });
    
    @weakify(self);
    [self.listView refreshDataSyn:^(BOOL isData) {
        @strongify(self);
        if (isData) {
            [self removePlaceholderView];
        }else{
            [self createPlaceholderView:nil message:nil image:[UIImage imageNamed:@"UGCPushTopicEmpty"] withView:self.view];
        }
    }];
    
    [self.listView didSelectRowAtModelCompleteBlock:^(ELSearchListView * _Nonnull listView, id  _Nonnull model) {
        
    }];
    
    [self.resullistView didSelectRowAtModelCompleteBlock:^(ELSearchResultView * _Nonnull listView, id  _Nonnull model) {
        
    }];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
[self.navigationController setNavigationBarHidden:YES animated:YES];
      [MobClick beginLogPageView:@"search_page"];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [MobClick endLogPageView:@"search_page"];
}
#pragma mark ELSearchNavigationViewDelegate
-(void)popSearchBarView:(ELSearchNavigationView *)searchBarView{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)searchBarView:(ELSearchBarView *)searchBarView textDidChange:(NSString *)searchText{
    self.resullistView.hidden =!searchText.length;
    self.listView.hidden = searchText.length;
    [self.resullistView refreshDataSyn:^(BOOL isData) {
        
    }];
}
-(void)clearSearchBarView:(ELSearchBarView *)searchBarView{
    self.resullistView.hidden =!searchBarView.text.length;
    self.listView.hidden = searchBarView.text.length;
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
