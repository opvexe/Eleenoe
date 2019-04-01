//
//  SLTagView.h
//  TagView
//
//  Created by snowlu on 2017/8/7.
//  Copyright © 2017年 ZhunKuaiTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SLTagView;
@protocol SLTagViewDelegate <NSObject>

@optional
- (BOOL)tagView:(SLTagView *)tagView shouldSelectTagAtIndex:(NSUInteger )index;

- (BOOL)tagView:(SLTagView *)tagView shouldDeselectTagAtIndex:(NSUInteger )index;

-(void)tagView:(SLTagView *)tagView didSelectTagAtIndex:(NSUInteger )index;

- (void)tagView:(SLTagView *)tagView didDeselectTagAtIndex:(NSUInteger)index;

- (void)tagView:(SLTagView *)tagView moveItemAtTagAtIndex:(NSUInteger)sourceIndex toIndex:(NSUInteger)destinationIndex;
@end


IB_DESIGNABLE

@interface SLTagView : UIView


@property(nonatomic,weak)id<SLTagViewDelegate> delegate;
/**
 *
 */
@property (nonatomic) IBInspectable UIEdgeInsets contentInsets;
/**
 *  数据源
 */
@property (nonatomic,strong) NSArray <NSString *> *tags;

/**
 * 行间距
 */
@property (nonatomic,assign) IBInspectable  CGFloat lineSpacing;
/**
 *  元素间距
 */
@property (nonatomic,assign) IBInspectable  CGFloat elementSpacing;
/**
 *   内容背影
 */
@property (nonatomic,strong) UIColor *contenBGColor;
/**
 *  标签正常背影
 */
@property (nonatomic,strong) UIColor *tagNormaBackgroundlColor;

@property (nonatomic,strong) UIColor *tagSelectedBackgroundColor;

@property (nonatomic,strong) UIColor *tagNormaTextColor;

@property (nonatomic,strong) UIColor *tagSelectedTextColor;

@property (nonatomic,strong) UIColor *tagNormalBoaderColor;

@property (nonatomic,strong) UIColor *tagSelectedBoaderColor;

@property (nonatomic,strong) UIFont *tagFont;

@property (nonatomic,strong) UIFont *tagSelectedFont;

@property (nonatomic) UIEdgeInsets tagInsets;

@property (nonatomic,assign) CGFloat tagBorderWidth;

@property (nonatomic,assign) CGFloat tagcornerRadius;

@property(nonatomic,copy)NSString *deleteImage;

/**
 *  标签高度 default 28
 */
@property (nonatomic,assign) CGFloat tagHeight;

@property (nonatomic,assign) CGFloat mininumTagWidth;

@property (nonatomic,assign) CGFloat maximumTagWidth;

@property (nonatomic,assign) BOOL allowsSelection;             //是否允许选中, default is YES

@property (nonatomic,assign) BOOL allowsMultipleSelection;     //是否允许多选, default is NO

@property(nonatomic,assign) BOOL longPressMove; //是否允许多选, default is NO

@property(nonatomic,assign,readonly)CGFloat contentHeigth;

@property (nonatomic,assign,readonly) NSUInteger selectedIndex;

@property (nonatomic,strong,readonly) NSArray <NSString * > *selectedTags;

@property (nonatomic,strong,readonly) NSArray <NSNumber *> *selectedIndexs;
/**
 *  选择标签
 *
 *  @param index    index description
 *  @param animated animated description
 */
- (void)selectTagAtIndex:( NSUInteger )index animated:(BOOL)animated;
/**
 *  取消标签
 *
 *  @param index    <#index description#>
 *  @param animated animated description
 */
- (void)deselectTagAtIndex:(NSUInteger )index animated:(BOOL)animated;
/**
 *  获取标签下标
 *
 *  @param tagTile <#tagTile description#>
 *
 *  @return <#return value description#>
 */
-(NSUInteger)indexWithTag:(NSString *)tagTile;
/**
 *  通过下标添加标签
 *
 *  @param tagTitle <#tagTitle description#>
 *  @param index    <#index description#>
 */
-(void)addTag:(NSString *)tagTitle atIndex:(NSUInteger )index;

-(void)addTag:(NSString *)tagTitle;
/**
 *  删除标签
 *
 *  @param tagTitle <#tagTitle description#>
 */
-(void)removeWithTag:(NSString *)tagTitle;
/**
 *  通过下标删除标签
 *
 *  @param Index <#Index description#>
 */
-(void)removeWithIndex:(NSUInteger )Index;
/**
 *  删除所有标签
 */
-(void)removeAllTags;

@end
