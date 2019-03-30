//
//  ELShopViewController.m
//  Eleenoe
//
//  Created by FaceBook on 2019/3/28.
//  Copyright © 2019 FaceBook. All rights reserved.
//

#import "ELShopViewController.h"
#import "ELShopCollectionViewCell.h"
#import "ELBannerCollectionReusableView.h"
#import "ELShopModel.h"

@interface ELShopViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,ELCycleScrollViewDelegate>
@property (nonatomic,strong) UICollectionView *listCollectionView;
@property (nonatomic,strong) NSMutableArray *lists;
@property (nonatomic,strong) ELShopModel *model;
@end

@implementation ELShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configView];
    [self loadDataSoucre];
}

-(void)setSelectIndex:(NSInteger)selectIndex{
    if (selectIndex!=0) {
        [self createPlaceholderView:nil message:@"敬请期待" image:nil withView:self.view];
        [self.listCollectionView setHidden:YES];
    }else{
        [self removePlaceholderView];
        [self.listCollectionView setHidden:NO];
    }
}

-(void)configView{
    
    _listCollectionView = ({
        UICollectionViewFlowLayout *layout =[[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        UICollectionView *iv =[[UICollectionView alloc] initWithFrame:CGRectZero
                                                 collectionViewLayout:layout];
        iv.backgroundColor = MainTableViewColor;
        iv.showsHorizontalScrollIndicator = NO;
        iv.showsVerticalScrollIndicator =NO;
        iv.dataSource = self;
        iv.delegate = self;
        [iv registerClass:[ELShopCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([ELShopCollectionViewCell class])];
        [iv registerClass:[ELBannerCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([ELBannerCollectionReusableView class])];
        [self.view addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.view);
        }];
        iv;
    });
}

-(void)loadDataSoucre{
    NSDictionary *shop =  [NSString readJson2DicWithFileName:@"Shopping"];
    self.model = [ELShopModel mj_objectWithKeyValues:shop[@"data"]];
    [self.listCollectionView reloadData];
}

#pragma mark UICollectionViewCellDelegate
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ELShopCollectionViewCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ELShopCollectionViewCell class]) forIndexPath:indexPath];
    [cell InitDataWithModel:_model.goods_datas[indexPath.row]];
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView*)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _model.goods_datas.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return  CGSizeMake((self.view.width-kSAdap(20.0))/2 -kSAdap(19.0),kSAdap_V(210.0));
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return kSAdap(10.0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return kSAdap(20.0);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(kSAdap_V(10.0), kSAdap(18.0), kSAdap(10.0), kSAdap(18.0));
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark - 区头
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return (CGSize){[UIScreen mainScreen].bounds.size.width,kSAdap_V(210.0)};
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *reusable = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        ELBannerCollectionReusableView *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([ELBannerCollectionReusableView class]) forIndexPath:indexPath];
        [reusableView InitDataWithModel:_model];
        reusableView.delegate = self;
        reusable = reusableView;
    }
    return reusable;
}

#pragma mark - ELCycleScrollViewDelegate
-(void)cycleScrollView:(ELBannerCollectionReusableView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index model:(ELShopContentModel *)model{
    NSLog(@"%@",model);
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
