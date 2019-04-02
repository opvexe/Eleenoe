//
//  ELSearchListView.m
//  Eleenoe
//
//  Created by HuiLu on 2019/4/1.
//  Copyright © 2019 FaceBook. All rights reserved.
//

#import "ELSearchListView.h"
#import "ELSearchTableViewCell.h"
#import "ELSearchModel.h"
@interface ELSearchListView()
@property(nonatomic,strong)NSMutableArray *lists;
@property(nonatomic,assign)NSInteger currentPage;
@property(nonatomic,copy)void (^CompleteBlock)( BOOL isData);
@property(nonatomic,assign)BOOL isLoading;
@end

@implementation ELSearchListView
-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    if (self = [super initWithFrame:frame
                              style:style]) {
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        self.dataSource = self;
        self.delegate = self;
        if (@available(iOS 11.0, *)) {
        self.estimatedSectionFooterHeight = 0.01;
        self.estimatedSectionHeaderHeight = 0.01;
        }
        self.backgroundColor =[UIColor whiteColor];
        self.tableFooterView =[UIView new];
        [self setMJRefreshHeaderFooter];
        self.mj_footer.hidden  = YES;
        self.currentPage = 1;
        self.isLoading = YES;
    }
    return self;
}
-(void)refreshLoadMoreData {
//    if (_currentPage>self.focusListModel.totalPage) {
//        [self.mj_footer endRefreshing];
//        return;
//    }
    [self loadData:NO];
}
-(void)refreshDataSyn:(void (^)( BOOL isData))comlete {
    self.CompleteBlock  = comlete;
    [self refreshDataSyn];
}
-(void)refreshDataSyn{
    _currentPage = 1;
    [self loadData:YES];
}
- (void)loadData:(BOOL)isRefresh {
    if (self.isLoading) {
        self.isLoading  = NO;
    }
//    [NetworkRequestManger  GetHotTopicListPage:self.currentPage time:FormatString(@"%lf",[[NSDate date] timeIntervalSince1970]) type:@"1" limit:10 Compelet:^(BOOL result, NSDictionary *lists) {
//        if (self.currentPage==1) {
//            [self.searchLists removeAllObjects];
//            self.listsModel = [GMUHotTopList parseJSON:lists];
//            self.searchLists = [NSMutableArray arrayWithCapacity:0];
//            [self.searchLists addObject:self.listsModel];
//            if (self.CompleteBlock&&! self.listsModel.topics.count) {
//                self.CompleteBlock(NO);
//            }else if(self.CompleteBlock&&self.listsModel.topics.count){
//                self.CompleteBlock(YES);
//            }
//        }
//        if (isRefresh) {
//            [self.mj_header endRefreshing];
//        }else{
//            [self.mj_footer endRefreshing];
//        }
//        [self reloadData];
//    }];
    NSArray *list = @[@{@"title":@"大家都在看",@"dataSoucre":@[@{@"title":@"护膝"},@{@"title":@"球鞋子"},@{@"title":@"护膝fdafdfd"}]},
                      @{@"title":@"我看过的",@"dataSoucre":@[@{@"title":@"护膝"},@{@"title":@"球鞋子"},@{@"title":@"护膝fdafdfd"}]}];
    self.lists = [ELSearchModel mj_objectArrayWithKeyValuesArray:list];
    [self reloadData];
}
-(void)InitDataSoucre:(NSArray *)dataSoucre{
    if (self.currentPage==1) {
        self.lists = [NSMutableArray arrayWithArray:dataSoucre];
    }else{
        [self.lists addObjectsFromArray:dataSoucre];
    }
    [self reloadData];
}
#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.lists.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ELSearchTableViewCell *cell  = [ELSearchTableViewCell CellWithTableView:tableView];
    [cell InitDataWithModel:self.lists[indexPath.row]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [ELSearchTableViewCell getCellHeight:self.lists[indexPath.row]];
}
#pragma mark 适配ios11
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ELSearchTableViewCell *cell =  [tableView cellForRowAtIndexPath:indexPath];

}
@end
