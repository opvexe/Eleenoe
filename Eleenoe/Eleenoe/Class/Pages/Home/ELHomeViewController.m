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
#import "ELUpdateViewController.h"
#import "ELTriggerAnalyzeFloatingView.h"
@interface ELHomeViewController ()<ELHomeListViewDelegate,ELHomeTitleListViewDelegate>
@property(nonatomic,strong)ELMyofascialBottomView *bottomView;
@property(nonatomic,strong)ELHomeListView *homelistView;
@property(nonatomic,strong)ELHomeTitleListView *titleListView;
@property(nonatomic,strong) ELMyofascialMenuScrolloView *pickListView;
@property(nonatomic,strong)ELTriggerAnalyzeFloatingView *analyzeView;
@property(nonatomic,strong)ELMyofascialContentModel *model;
@property(nonatomic,strong)NSMutableArray *lists;
@end

@implementation ELHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"肌筋膜放松仪";
    self.navigationRightView = [CJXBarButtonItem buttonWithImageNormal:@"home_nav_more" imageSelected:@"home_nav_more" imageHightlight:@"home_nav_more" target:self selector:@selector(Click)];
    [ELNotificationCenter addObserver:self selector:@selector(Analyze:) name:TriggerAnalyzeNotificationCenter object:nil];
    [self settupView];
}

-(void)settupView{
    
    _titleListView = ({
        UICollectionViewFlowLayout *  flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.minimumLineSpacing = kSAdap(45);
        flowLayout.sectionInset = UIEdgeInsetsMake(0,kSAdap(15), kSAdap_V(10), kSAdap(15));
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        ELHomeTitleListView*collectionView = [[ELHomeTitleListView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        collectionView.bounces = NO;
        collectionView.delegatePageContentCollectionView  = self;
        [self.view addSubview:collectionView];
        [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.height.mas_equalTo(kSAdap_V(82));
            make.left.and.right.mas_equalTo(0);
        }];
        collectionView;
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
    
    _homelistView = ({
        UICollectionViewFlowLayout *  flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.minimumLineSpacing = kSAdap(0);
        flowLayout.sectionInset = UIEdgeInsetsZero;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        ELHomeListView*collectionView = [[ELHomeListView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        collectionView.bounces = NO;
        collectionView.delegatePageContentCollectionView = self;
        [self.view addSubview:collectionView];
        [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.titleListView.mas_bottom);
            make.left.and.right.mas_equalTo(0);
            make.bottom.mas_equalTo(self.bottomView.mas_top);
        }];
        collectionView;
    });
    
    @weakify(self);
    self.bottomView.complete = ^(BottomViewClickType type) {
        @strongify(self);
        switch (type) {
            case BottomViewClickTypeElectrode:{
                [self.navigationController pushViewController:[ELElectrodeViewController new] animated:YES];
            }
                break;
            case BottomViewClickTypeDownload:{
               self.analyzeView = [ELTriggerAnalyzeFloatingView showComplete:^(ELBaseModel * _Nonnull model) {
                    
                }];
                [self.analyzeView InitDataWithModel:self.model];
            }
                break;
            default:
                break;
        }
    };
}

-(void)Analyze:(NSNotification*)notification{
    NSLog(@"%@===%@",[notification.userInfo objectForKey:@"page"],[notification.userInfo objectForKey:@"model"]);
    ELMyofascialContentModel *model = [notification.userInfo objectForKey:@"model"];
    _model = model;
}

#pragma mark ELHomeTitleListViewDelegate
-(void)pageTitleListView:(ELHomeTitleListView *)pageContentCollectionView index:(NSInteger)index{
    [self.homelistView setPageContentCollectionViewCurrentIndex:index];
}
#pragma  mark ELHomeListViewDelegate
-(void)pageContentCollectionView:(ELHomeListView *)pageContentCollectionView index:(NSInteger)index{
    [self.titleListView setELHomeTitleListViewCurrentIndex:index];
}


#pragma mark 懒加载
-(NSMutableArray *)lists{
    if (!_lists) {
        _lists =[NSMutableArray array];
    }
    return _lists;
}

-(void)Click{
    [self.navigationController pushViewController:[ELUpdateViewController new] animated:YES];
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
