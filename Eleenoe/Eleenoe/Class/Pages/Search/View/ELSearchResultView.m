//
//  ELSearchResultView.m
//  Eleenoe
//
//  Created by HuiLu on 2019/4/1.
//  Copyright © 2019 FaceBook. All rights reserved.
//

#import "ELSearchResultView.h"
@interface ELSearchResultView()
@property(nonatomic,strong)NSMutableArray *lists;
@property(nonatomic,assign)NSInteger currentPage;
@end
@implementation ELSearchResultView
-(void)loadMoreDataSoucre{
    self.currentPage++;
    if (self.resultDelegate &&[self.delegate respondsToSelector:@selector(searchResultView: loadMoreDataSoucreWithPage:)]) {
        [self.resultDelegate searchResultView:self loadMoreDataSoucreWithPage:self.currentPage];
    }
}
-(void)refreshLoadDataSoucre{
    self.currentPage = 1;
    if (self.delegate &&[self.delegate respondsToSelector:@selector(searchResultView: refreshLoadDataSoucreWithPage:)]) {
        [self.resultDelegate searchResultView:self refreshLoadDataSoucreWithPage:self.currentPage];
    }
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
    ELSearchResultTableViewCell *cell  = [ELSearchResultTableViewCell CellWithTableView:tableView];
    [cell InitDataWithModel:self.lists[indexPath.row]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
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
    ELSearchResultTableViewCell *cell =  [tableView cellForRowAtIndexPath:indexPath];
    if (self.resultDelegate &&[self.resultDelegate respondsToSelector:@selector(searchResultView:cell:model:)]) {
        [self.resultDelegate searchResultView:self cell:cell model:self.lists[indexPath.row]];
    }
}

@end
