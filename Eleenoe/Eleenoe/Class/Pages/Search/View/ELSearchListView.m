//
//  ELSearchListView.m
//  Eleenoe
//
//  Created by HuiLu on 2019/4/1.
//  Copyright © 2019 FaceBook. All rights reserved.
//

#import "ELSearchListView.h"
#import "ELSearchTableViewCell.h"

@interface ELSearchListView()
@property(nonatomic,strong)NSMutableArray *lists;
@property(nonatomic,assign)NSInteger currentPage;
@end

@implementation ELSearchListView
-(void)loadMoreDataSoucre{
    self.currentPage++;

}
-(void)refreshLoadDataSoucre{
    self.currentPage = 1;
 
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
