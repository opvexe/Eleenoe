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
#import "ELMyofascialBottomView.h"
#import "ELHomeListView.h"
#import "ELHomeTitleListView.h"
#import "ELMyofascialMenuModel.h"
#import "ELUpdateViewController.h"
#import "ELTriggerAnalyzeFloatingView.h"
#import "ELBlueToothManager.h"
@interface ELHomeViewController ()<ELHomeListViewDelegate,ELHomeTitleListViewDelegate>
@property(nonatomic,strong)ELMyofascialBottomView *bottomView;
@property(nonatomic,strong)ELHomeListView *homelistView;
@property(nonatomic,strong)ELHomeTitleListView *titleListView;
@property(nonatomic,strong)ELMyofascialContentModel *model;
@property(nonatomic,strong)NSMutableArray *homeLists;
@end

@implementation ELHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self navTitleLabelWithTitle:@"肌筋膜放松仪"];
    [self rightBarButtonWithImage:[UIImage imageNamed:@"home_nav_more"] target:self action:@selector(ClickAction)];
    [ELNotificationCenter addObserver:self selector:@selector(analyzeNotification:) name:TriggerAnalyzeNotificationCenter object:nil];
    [self settupView];
    [self showConnectionFloatingView];
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
    self.bottomView.complete = ^(MyofascialBottomActionType type,UIButton *sender) {
        @strongify(self);
        switch (type) {
            case MyofascialBottomActionTypeHandle:{
                sender.selected = !sender.selected;
                ELTriggerAnalyzeFloatingView  *analyzeView = [ELTriggerAnalyzeFloatingView showComplete:^(ELBaseModel * _Nonnull model) {
                    
                }];
                [analyzeView InitDataWithModel:self.model];
                break;
            }
            case MyofascialBottomActionTypeBluetooth:{
                if (!sender.selected) {
                    [self showConnectionFloatingView];
                }
                break;
            }
            default:
                break;
        }
    };
    
    [self.bottomView.rightContentView WH_whenTapped:^{
        @strongify(self);
        [self.navigationController pushViewController:[ELElectrodeViewController new] animated:YES];
    }];
}

-(void)showConnectionFloatingView{
    
    @weakify(self);
    ELBluetoothConnectionFloatingView *connectView = [ELBluetoothConnectionFloatingView showComplete:^(ConnectionStatusType status) {
        
        
    }];
    
    [[ELBlueToothManager shareInstance] connectPeripheralWithStateCallback:^(ELResultType connectState) {
        @strongify(self);
        dispatch_async(dispatch_get_main_queue(), ^{
            
            switch (connectState) {
                case ELResultTypeDisconnected:{
                    [connectView show];
                    [connectView updateStatus:ConnectionStatusTypeNone];
                    [self.bottomView updateBluetoothStatus:NO];
                    break;
                }
                case ELResultTypeLoading:{
                    [connectView updateStatus:ConnectionStatusTypeLoading];
                    [self.bottomView updateBluetoothStatus:NO];
                    break;
                }
                case ELResultTypeFailed:{
                    [connectView updateStatus:ConnectionStatusTypeFailure];
                    [self.bottomView updateBluetoothStatus:NO];
                    break;
                }
                case ELResultTypeSuccess:{
                    [connectView updateStatus:ConnectionStatusTypeSuccess];
                    [self.bottomView updateBluetoothStatus:YES];
                }
                    break;
                case ELResultTypeTimeOut:{
                    [connectView updateStatus:ConnectionStatusTypeFailure];
                    [self.bottomView updateBluetoothStatus:NO];
                    break;
                }
                default:
                    [connectView updateStatus:ConnectionStatusTypeNone];
                    [self.bottomView updateBluetoothStatus:NO];
                    break;
            }
            
        });
        
    } examBLECallback:^(ELBleLocalState localState) {
        
        
    }];
}

#pragma mark 通知
-(void)analyzeNotification:(NSNotification*)notification{
    ELMyofascialContentModel *model = [notification.userInfo objectForKey:AnalyzeUserInfoKey];
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

#pragma mark Click Navgation
-(void)ClickAction{
    [self pushViewControllerWithViewControllerClass:[ELUpdateViewController class]];
}

#pragma mark 懒加载
-(NSMutableArray *)homeLists{
    if (!_homeLists) {
        _homeLists =[NSMutableArray array];
    }
    return _homeLists;
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
