//
//  ELShopViewController.m
//  Eleenoe
//
//  Created by FaceBook on 2019/3/28.
//  Copyright © 2019 FaceBook. All rights reserved.
//

#import "ELShopViewController.h"
#import "ELTextField.h"

@interface ELShopViewController ()<UITextFieldDelegate>
@property(nonatomic,strong)ELTextField *searchField;
@end

@implementation ELShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.titleView = self.searchField;
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
