//
//  ELDefaultContentViewController.m
//  Eleenoe
//
//  Created by FaceBook on 2019/3/29.
//  Copyright © 2019 FaceBook. All rights reserved.
//

#import "ELDefaultContentViewController.h"
#import "ELSearchViewController.h"
#import "ELShopViewController.h"
#import "ELTextField.h"
#import <SGPagingView.h>
@interface ELDefaultContentViewController ()<SGPageTitleViewDelegate, SGPageContentScrollViewDelegate,UITextFieldDelegate>
@property (nonatomic, strong) SGPageTitleView *pageTitleView;
@property (nonatomic, strong) SGPageContentScrollView *pageContentScrollView;
@property (nonatomic, strong) ELTextField *searchField;
@property (nonatomic,strong) NSMutableArray *childArr;
@end

@implementation ELDefaultContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigationBar];
    [self configView];
}

-(void)setNavigationBar{
    @weakify(self);
    self.navigationItem.titleView = self.searchField;
    UITapGestureRecognizer   *tap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
        @strongify(self);
        [self.navigationController pushViewController:[ELSearchViewController new] animated:YES];
    }];
    [self.searchField addGestureRecognizer:tap];
}

-(void)configView{
    
    NSArray *titleArr = @[@"设备配件", @"跑鞋", @"服装", @"食物",@"康复课程"];
    SGPageTitleViewConfigure *configure = [SGPageTitleViewConfigure pageTitleViewConfigure];
    configure.titleFont = [UIFont ELPingFangSCRegularFontOfSize:14.0];
    configure.titleColor = MainLightGrayTitleColor;
    configure.indicatorHeight = 3.0;
    configure.indicatorCornerRadius = 2.0;
    configure.indicatorToBottomDistance = 0.0;
    configure.titleSelectedFont = [UIFont ELPingFangSCRegularFontOfSize:16.0];
    configure.titleSelectedColor = MainThemColor;
    configure.indicatorColor =  MainThemColor;
    configure.indicatorStyle = SGIndicatorStyleFixed;
    configure.bottomSeparatorColor = [UIColor whiteColor];
    self.pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(0,0, self.view.frame.size.width, 44.0) delegate:self titleNames:titleArr configure:configure];
    [self.view addSubview:_pageTitleView];
    
    self.childArr = [NSMutableArray array];
    for (NSInteger i = 0; i<titleArr.count; i++) {
        ELShopViewController *controller = [[ELShopViewController alloc] init];
        [self.childArr addObject:controller];
    }
    
    CGFloat contentViewHeight = self.view.frame.size.height - CGRectGetMaxY(_pageTitleView.frame) -iPhoneX_Bottom_Navigation_Bar_Height -iPhone_X_Navigation_Bar_Heigth;
    self.pageContentScrollView = [[SGPageContentScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_pageTitleView.frame),SCREEN_WIDTH, contentViewHeight) parentVC:self childVCs:_childArr];
    _pageContentScrollView.delegatePageContentScrollView = self;
    [self.view addSubview:_pageContentScrollView];
}

- (void)pageTitleView:(SGPageTitleView *)pageTitleView selectedIndex:(NSInteger)selectedIndex {
    [self.pageContentScrollView setPageContentScrollViewCurrentIndex:selectedIndex];
}

- (void)pageContentScrollView:(SGPageContentScrollView *)pageContentScrollView progress:(CGFloat)progress originalIndex:(NSInteger)originalIndex targetIndex:(NSInteger)targetIndex {
    [self.pageTitleView setPageTitleViewWithProgress:progress originalIndex:originalIndex targetIndex:targetIndex];
}

- (void)pageContentScrollView:(SGPageContentScrollView *)pageContentScrollView index:(NSInteger)index {
    [self.childArr enumerateObjectsUsingBlock:^(ELShopViewController *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.selectIndex = index;
    }];
}

#pragma mark - 懒加载
- (ELTextField *)searchField{
    if (!_searchField) {
        _searchField = [[ELTextField alloc] initWithImage:[UIImage imageNamed:@"shop_search"] padding:SCREEN_WIDTH/2 - kSAdap(36.0)];
        _searchField.frame = CGRectMake(kSAdap(18.0), 0, SCREEN_WIDTH - kSAdap(36.0), kSAdap_V(25.0));
        _searchField.backgroundColor = UIColorFromRGB(0xf1f1f1);
        _searchField.layer.cornerRadius = 5.0;
        _searchField.clipsToBounds = YES;
        _searchField.delegate = self;
        _searchField.font = [UIFont ELPingFangSCRegularFontOfSize:kSaFont(13.0)];
        _searchField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"搜索" attributes:@{NSFontAttributeName:[UIFont ELPingFangSCRegularFontOfSize:kSaFont(13.0)],NSForegroundColorAttributeName:UIColorFromRGB(0x777777)}];
        _searchField.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    return _searchField;
}

#pragma mark UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    [textField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return NO;
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
