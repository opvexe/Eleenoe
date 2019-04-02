//
//  ELSearchBarView.h
//  Eleenoe
//
//  Created by zhanglu on 2019/4/2.
//  Copyright © 2019 FaceBook. All rights reserved.
//

#import "ELBaseView.h"

NS_ASSUME_NONNULL_BEGIN
@class ELSearchBarView;
@protocol ELSearchBarViewDelegate <NSObject>
@optional
- (void)searchBarView:(ELSearchBarView *)searchBarView ShouldBeginEditing:(NSString *)searchText;

- (void)searchBarView:(ELSearchBarView *)searchBarView textDidChange:(NSString *)searchText;

- (void)searchBarView:(ELSearchBarView *)searchBarView textFieldDidEndEditing:(NSString *)searchText;

-(void)searchBarView:(ELSearchBarView *) searchBarView  textFieldShouldReturn:(NSString *)searchText;

-(void)clearSearchBarView:(ELSearchBarView*)searchBarView;

@end

@interface ELSearchBarView : ELBaseView

@property(nonatomic,weak)id <ELSearchBarViewDelegate>delegate;

@property(nonatomic,copy)NSString *searchText;

@property(nonatomic,strong,readonly)UITextField *textField;

@property(nonatomic,copy,readonly)NSString *text;
/**
 
 */
@property(nonatomic,assign)CGFloat maxLength;
/**
 *  取消第一响应
 */
-(void)resignFirstResponder;

-(void)searchbecomeFirstResponder;
@end

NS_ASSUME_NONNULL_END
