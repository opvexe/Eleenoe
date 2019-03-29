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
#import "ELTextField.h"

@interface ELShopViewController ()<UITextFieldDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong) ELTextField *searchField;
@property (nonatomic,strong) UICollectionView *listCollectionView;
@property (nonatomic,strong) NSMutableArray *lists;
@end

@implementation ELShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.titleView = self.searchField;
    [self configView];
}

-(void)configView{
    
    _listCollectionView = ({
        UICollectionViewFlowLayout *layout =[[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        UICollectionView *iv =[[UICollectionView alloc] initWithFrame:CGRectZero
                                                 collectionViewLayout:layout];
        iv.backgroundColor = [UIColor whiteColor];
        iv.showsHorizontalScrollIndicator = NO;
        iv.showsVerticalScrollIndicator =NO;
        iv.dataSource = self;
        iv.delegate = self;
        [iv registerClass:[ELShopCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([ELShopCollectionViewCell class])];
        [iv registerClass:[ELBannerCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([ELBannerCollectionReusableView class])];
        [self.view addSubview:iv];
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
    
    
}

#pragma mark UICollectionViewCellDelegate
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ELShopCollectionViewCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ELShopCollectionViewCell class]) forIndexPath:indexPath];
    //    [cell InitDataWithModel:self.lists[indexPath.row]];
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView*)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.lists.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return  CGSizeMake(self.view.width/2,85);
}
//// 设置最小行间距，也就是前一行与后一行的中间最小间隔
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return kSAdap(8.0);
}
//// 设置最小列间距，也就是左行与右一行的中间最小间隔
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return kSAdap(0);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark - 区头
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return (CGSize){[UIScreen mainScreen].bounds.size.width,kSAdap_V(150.0)};
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *reusable = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        ELBannerCollectionReusableView *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([ELBannerCollectionReusableView class]) forIndexPath:indexPath];
//        [reusableView InitDataWithModel:nil];
        reusable = reusableView;
    }
    return reusable;
}


#pragma mark - 懒加载
- (ELTextField *)searchField{
    if (!_searchField) {
        _searchField = [[ELTextField alloc] initWithImage:[UIImage imageNamed:@"Search"] padding:SCREEN_WIDTH/2 - kSAdap(30.0)];
        _searchField.frame = CGRectMake(kSAdap(15.0), 0, SCREEN_WIDTH - kSAdap(30.0), kSAdap_V(30.0));
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
