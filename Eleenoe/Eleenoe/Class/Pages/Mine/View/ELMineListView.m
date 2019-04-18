//
//  ELMineListView.m
//  Eleenoe
//
//  Created by FaceBook on 2019/3/31.
//  Copyright © 2019 FaceBook. All rights reserved.
//

#import "ELMineListView.h"
#import "ELMineTableViewCell.h"
@interface ELMineListView()
@property(nonatomic,strong)NSMutableArray *lists;
@end

@implementation ELMineListView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    if (self = [super initWithFrame:frame style:style]) {
        self.backgroundColor = MainTableViewColor;
        self.dataSource = self;
        self.delegate = self;
        self.rowHeight = kSAdap_V(60);
        NSArray *settings = @[@{@"sections":@[
                                        @{@"icon":@"mine_instructions",@"title":@"使用说明",@"itemType":@(WDSettingItemTypeArrow),@"url":@"http://www.baidu.com"},
                                        @{@"icon":@"mine_suggestion",@"title":@"意见反馈",@"itemType":@(WDSettingItemTypeArrow),@"url":@"http://www.baidu.com"},
                                        @{@"icon":@"mine_announcements",@"title":@"注意事项",@"itemType":@(WDSettingItemTypeArrow),@"url":@"http://www.baidu.com"}]},
                              @{@"sections":@[
                                        @{@"icon":@"mine_service",@"title":@"售后服务",@"itemType":@(WDSettingItemTypeArrow),@"url":@"http://www.baidu.com"}]}];
        self.lists = [ELSettingModel mj_objectArrayWithKeyValuesArray:settings];
    }
    return self;
}

#pragma mark UITableViewDelegate,UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    ELSettingModel *model = self.lists[section];
    return model.sections.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.lists.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ELMineTableViewCell *cell = [ELMineTableViewCell CellWithTableView:tableView];
    ELSettingModel *model = self.lists[indexPath.section];
    [cell InitDataWithModel:model.sections[indexPath.row]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ELSettingModel *model = self.lists[indexPath.section];
    if (self.listDelegate&&[self.listDelegate respondsToSelector:@selector(pageListView:AtModel:)]) {
        [self.listDelegate pageListView:self AtModel:model.sections[indexPath.row]];
    }
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
    return kSAdap_V(10.0);
}

-(NSMutableArray *)lists{
    if (!_lists) {
        _lists = [NSMutableArray array];
    }
    return _lists;
}
@end
