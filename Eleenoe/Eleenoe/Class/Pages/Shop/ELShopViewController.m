//
//  ELShopViewController.m
//  Eleenoe
//
//  Created by FaceBook on 2019/3/28.
//  Copyright © 2019 FaceBook. All rights reserved.
//

#import "ELShopViewController.h"
#import "ELShopListView.h"
#import "ELShopModel.h"
@interface ELShopViewController ()
@property (nonatomic,strong) ELShopListView *listView;
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
        [self.listView setHidden:YES];
    }else{
        [self removePlaceholderView];
        [self.listView setHidden:NO];
    }
}

-(void)configView{
    
    _listView = ({
        UICollectionViewFlowLayout *layout =[[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        ELShopListView *iv = [[ELShopListView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        [self.view addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.view);
        }];
        iv;
    });
}

-(void)loadDataSoucre{
    NSDictionary *shop =  [NSString readJson2DicWithFileName:@"Shopping"];
    ELShopModel *model = [ELShopModel mj_objectWithKeyValues:shop[@"data"]];
    [self.listView initWithSouce:model];
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
