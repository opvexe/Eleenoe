//
//  SLTagView.m
//  TagView
//
//  Created by snowlu on 2017/8/7.
//  Copyright © 2017年 ZhunKuaiTechnology. All rights reserved.
//

#import "SLTagView.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define UIColorFromRGBA(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]

#define FontHelFont(Size) [UIFont fontWithName:@"Helvetica" size:Size]

#define BundleImageName(imageName) [UIImage imageNamed:[NSString stringWithFormat:@"Tag.bundle/%@",imageName]]

static NSString * const CollectionViewCellID = @"TagViewCollectionViewCell";

@interface TagModel :NSObject
@property(nonatomic,copy)NSString *title;
@property(nonatomic,assign)BOOL selected;
@property(nonatomic,strong)UIFont *tagFont;
@property (nonatomic,assign, readonly) CGSize tagContentSize;

-(instancetype)initWithTitle:(NSString *)title Font:(UIFont *)font;

@end

@implementation TagModel

-(instancetype)initWithTitle:(NSString *)title Font:(UIFont *)font{
    
    if (self = [super  init]) {
        
        self.title  = title;
        
        self.tagFont = font;
    }
    return self;
}
-(void)setTagFont:(UIFont *)tagFont{
    
    _tagFont = tagFont;
    
    CGSize textSize = [_title boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 1000)
                                           options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:tagFont} context:nil].size;
    _tagContentSize = CGSizeMake(ceil(textSize.width+20), ceil(textSize.height));
}
@end


#pragma mark  ___________________TagViewCollectionView__________________

@interface TagViewCollectionViewCell : UICollectionViewCell

@property(nonatomic,copy)void(^DeleteBlock)(TagModel *model);

@property(nonatomic,strong)UILabel *tagLabel;

@property(nonatomic,strong)UIButton *deleBT;

@property (nonatomic) UIEdgeInsets contentInsets;

@property(nonatomic,strong)TagModel *tagModel;

-(void)deleteComplete:(void(^)(TagModel *model))Complete;
@end

@implementation TagViewCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self setupUI];
        
    }
    return self;
}
-(void)setupUI{
    _tagLabel =  [UILabel new];
    _tagLabel.textAlignment = NSTextAlignmentCenter;
    _tagLabel.userInteractionEnabled = NO;
    _tagLabel.font  =self.tagModel.tagFont;
    [self.contentView addSubview:_tagLabel];
    
    _deleBT  = [UIButton buttonWithType:UIButtonTypeCustom];
    
    
    [_deleBT addTarget:self action:@selector(deleAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_deleBT];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect bounds = self.contentView.bounds;
    CGFloat width = bounds.size.width - self.contentInsets.left - self.contentInsets.right;
    CGRect frame = CGRectMake(0, 0, width, bounds.size.height-5);
    self.tagLabel.frame = frame;
    self.tagLabel.center = self.contentView.center;
    
    [self.deleBT setFrame:CGRectMake(width - 5, 0, 12,12)];
}

-(void)deleAction:(UIButton *)sender{
    
    if (self.DeleteBlock) {
        
        self.DeleteBlock(self.tagModel);
    }
    
}

-(void)deleteComplete:(void(^)(TagModel *model))Complete{
    self.DeleteBlock  = Complete;
}
@end

#pragma mark  ___________________ SLTagSpaceFlowLayout__________________

@interface SLTagSpaceFlowLayout : UICollectionViewFlowLayout
@property(nonatomic,strong)NSMutableArray *itemAttributes;
@property (nonatomic,assign,readonly) CGFloat contentHeight;
@property (weak, nonatomic) id<UICollectionViewDelegateFlowLayout> delegate;
@end

@implementation SLTagSpaceFlowLayout

-(instancetype)init{
    
    if (self  = [super init]) {
        
        self.scrollDirection  =UICollectionViewScrollDirectionVertical;
        
        self.minimumLineSpacing  = 5;
        
        self.minimumInteritemSpacing  = 5;
        
        self.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    }
    return self;
}
-(CGFloat)minimumInteritemSpacingAtSection:(NSInteger)section{
    if (self.delegate &&[self.delegate respondsToSelector:@selector(collectionView:layout:minimumInteritemSpacingForSectionAtIndex:)]) {
        return [self.delegate collectionView:self.collectionView layout:self minimumInteritemSpacingForSectionAtIndex:section];
        
    }
    return self.minimumInteritemSpacing;
}
- (CGFloat)minimumLineSpacingAtSection:(NSInteger)section{
    if (self.delegate &&[self.delegate respondsToSelector:@selector(collectionView:layout:minimumLineSpacingForSectionAtIndex:)]) {
        return [self.delegate collectionView:self.collectionView layout:self minimumLineSpacingForSectionAtIndex:section];
    }
    
    return self.minimumLineSpacing;
    
}
- (UIEdgeInsets)sectionInsetAtSection:(NSInteger)section {
    if (self.delegate &&[self.delegate respondsToSelector:@selector(collectionView:layout:insetForSectionAtIndex:)]) {
        return [self.delegate collectionView:self.collectionView layout:self insetForSectionAtIndex:section];
    }
    
    return self.sectionInset;
}

-(void)prepareLayout{
    
    [super prepareLayout];
    
    _contentHeight   = 0 ;
    
    NSInteger  itemCount = [[self collectionView] numberOfItemsInSection:0];
    
    self.itemAttributes = [NSMutableArray arrayWithCapacity:itemCount];
    
    
    CGFloat minimumInteritemSpacing = [self minimumInteritemSpacingAtSection:0];
    
    CGFloat minimumLineSpacing = [self minimumLineSpacingAtSection:0];
    
    UIEdgeInsets sectionInset = [self sectionInsetAtSection:0];
    
    CGFloat sectionXOffset = sectionInset.left;
    
    CGFloat sectionYOffset = sectionInset.top;
    
    CGFloat sectionxNextOffset = sectionInset.left;
    //获取高度
    for (NSInteger idx = 0; idx < itemCount; idx++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:idx inSection:0];
        CGSize itemSize = [self.delegate collectionView:self.collectionView layout:self sizeForItemAtIndexPath:indexPath];
        
        sectionxNextOffset += (minimumInteritemSpacing + itemSize.width);
        
        if (sectionxNextOffset - minimumInteritemSpacing > [self collectionView].bounds.size.width - sectionInset.right) {
            sectionXOffset = sectionInset.left;
            sectionxNextOffset = (sectionInset.left + minimumInteritemSpacing + itemSize.width);
            sectionYOffset += (itemSize.height + minimumLineSpacing);
        }
        else
        {
            sectionXOffset = sectionxNextOffset - (minimumInteritemSpacing + itemSize.width);
        }
        UICollectionViewLayoutAttributes *layoutAttributes =
        [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        layoutAttributes.frame = CGRectMake(sectionXOffset, sectionYOffset, itemSize.width, itemSize.height);
        [_itemAttributes addObject:layoutAttributes];
        
        _contentHeight = MAX(_contentHeight, CGRectGetMaxY(layoutAttributes.frame));
    }
    _contentHeight += sectionInset.bottom;
    
}
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return (self.itemAttributes)[indexPath.item];
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return [self.itemAttributes filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(UICollectionViewLayoutAttributes *evaluatedObject, NSDictionary *bindings) {
        return CGRectIntersectsRect(rect, [evaluatedObject frame]);
    }]];
}
- (CGSize)collectionViewContentSize {
    //重新计算布局
    [self prepareLayout];
    CGSize contentSize  = CGSizeMake(self.collectionView.frame.size.width, self.contentHeight);
    return contentSize;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    CGRect oldBounds = self.collectionView.bounds;
    if (!CGSizeEqualToSize(oldBounds.size, newBounds.size)) {
        return YES;
    }
    return NO;
}
@end

#pragma mark  ___________________SLTagView__________________

@interface SLTagView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) UICollectionView *collectionView;

@property (strong, nonatomic) NSMutableArray<NSString *> *tagsMutableArray;
@property (strong, nonatomic) NSMutableArray<TagModel *> *tagModels;

@property(nonatomic,assign)BOOL allowEmptySelection;

@property(nonatomic,strong)UILongPressGestureRecognizer *longPress;
@end

@implementation SLTagView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setupUI];
    }
    
    return self;
}
-(void)awakeFromNib{
    
    [super awakeFromNib];
    [self setupUI];
}
-(void)setupUI{
    
    _contentInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    
    _tagInsets = UIEdgeInsetsMake(2, 2,2,2);
    
    _allowsMultipleSelection =NO;
    
    _allowEmptySelection  = YES;
    
    _allowsSelection  =  YES;
    
    _longPressMove  = NO;
    
    self.collectionView.backgroundColor = self.contenBGColor;
    [self addSubview:self.collectionView];
}
-(void)layoutSubviews{
    [super layoutSubviews]
    ;
    UICollectionView *collectionView = self.subviews.firstObject;
    collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    //
    //    NSLayoutConstraint *leftContraint = [NSLayoutConstraint constraintWithItem:collectionView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    //    NSLayoutConstraint *rightContraint = [NSLayoutConstraint constraintWithItem:collectionView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
    //    NSLayoutConstraint *topContraint = [NSLayoutConstraint constraintWithItem:collectionView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    //    NSLayoutConstraint *bottomContraint = [NSLayoutConstraint constraintWithItem:collectionView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
    //    [self addConstraints:@[leftContraint,rightContraint,topContraint,bottomContraint]];
    
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(collectionView);
    //约束1 横向
    [self addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[collectionView]|"
                                             options:0
                                             metrics:nil
                                               views:viewsDictionary]];
    //约束2 纵向
    [self addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[collectionView]|"
                                             options:0
                                             metrics:nil
                                               views:viewsDictionary]];
}
- (CGSize)intrinsicContentSize {
    CGSize contentSize = self.collectionView.collectionViewLayout.collectionViewContentSize;
    return CGSizeMake(UIViewNoIntrinsicMetric, contentSize.height);
}
-(void)setTags:(NSArray<NSString *> *)tags{
    _tagsMutableArray = [tags mutableCopy];
    [self.tagModels removeAllObjects];
    [tags enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        TagModel *tagModel = [[TagModel alloc] initWithTitle:obj Font:self.tagFont];
        [self.tagModels addObject:tagModel];
    }];
    [self.collectionView reloadData];
}
- (void)lonePressMoving:(UILongPressGestureRecognizer *)longPress
{
    switch (_longPress.state) {
        case UIGestureRecognizerStateBegan: {
            {
                NSIndexPath *selectIndexPath = [self.collectionView indexPathForItemAtPoint:[_longPress locationInView:self.collectionView]];
                
                TagViewCollectionViewCell *cell = (TagViewCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:selectIndexPath];
                
                cell.deleBT.hidden  = NO;
                
                [self.collectionView beginInteractiveMovementForItemAtIndexPath:selectIndexPath];
            }
            break;
        }
        case UIGestureRecognizerStateChanged: {
            [self.collectionView updateInteractiveMovementTargetPosition:[longPress locationInView:_longPress.view]];
            break;
        }
        case UIGestureRecognizerStateEnded: {
            [self.collectionView endInteractiveMovement];
            break;
        }
        default: [self.collectionView cancelInteractiveMovement];
            break;
    }
}
#pragma mark public Function
-(NSUInteger)indexWithTag:(NSString *)tagTile{
    __block  NSUInteger index = NSNotFound;
    [self.tagsMutableArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([obj isEqualToString:tagTile]) {
            index = idx;
            *stop =YES;
            
        }
    }];
    return index;
}
-(void)addTag:(NSString *)tagTitle atIndex:(NSUInteger )index{
    
    if (index >=self.tagsMutableArray.count) {
        return;
    }
    [self.tagsMutableArray addObject:tagTitle];
    TagModel *tagModel = [[TagModel alloc] initWithTitle:tagTitle Font:self.tagFont];
    [self.tagModels insertObject:tagModel atIndex:index];
    [self.collectionView reloadData];
    [self invalidateIntrinsicContentSize];
}

-(void)addTag:(NSString *)tagTitle{
    [self.tagsMutableArray addObject:tagTitle];
    TagModel *tagModel = [[TagModel alloc] initWithTitle:tagTitle Font:self.tagFont];
    [self.tagModels addObject:tagModel];
    [self.collectionView reloadData];
    [self invalidateIntrinsicContentSize];
}

-(void)removeWithTag:(NSString *)tagTitle{
    
    [self removeWithIndex:[self indexWithTag:tagTitle]];
    
}
-(void)removeWithIndex:(NSUInteger )Index{
    if (Index >=self.tagsMutableArray.count ||Index  == NSNotFound) {
        return;
    }
    [self.tagsMutableArray removeObjectAtIndex:Index];
    [self.tagModels removeObjectAtIndex:Index];
    [self.collectionView reloadData];
    [self invalidateIntrinsicContentSize];
}
-(void)removeAllTags{
    
    [self.tagsMutableArray removeAllObjects];
    
    [self.tagModels removeAllObjects];
    
    [self.collectionView reloadData];
    
    [self invalidateIntrinsicContentSize];
}

- (void)selectTagAtIndex:( NSUInteger )index animated:(BOOL)animated {
    [self.collectionView selectItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]
                                      animated:animated
                                scrollPosition:UICollectionViewScrollPositionNone];
}

- (void)deselectTagAtIndex:(NSUInteger )index animated:(BOOL)animated {
    [self.collectionView deselectItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] animated:animated];
}
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.delegate&&[self.delegate respondsToSelector:@selector(tagView:shouldSelectTagAtIndex:)]) {
        return [self.delegate tagView:self shouldSelectTagAtIndex:indexPath.row];
    }
    return self.allowsSelection;
}
- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return YES;
}
- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath*)destinationIndexPath{
    
    if (self.delegate &&[self.delegate respondsToSelector:@selector(tagView:moveItemAtTagAtIndex:toIndex:)]) {
        
        [self.delegate tagView:self moveItemAtTagAtIndex:sourceIndexPath.row toIndex:destinationIndexPath.row];
    }
    
    [self.tagModels exchangeObjectAtIndex:sourceIndexPath.item withObjectAtIndex:destinationIndexPath.item];
    [collectionView reloadData];
}
- (BOOL)collectionView:(UICollectionView *)collectionView shouldDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.delegate&&[self.delegate respondsToSelector:@selector(tagView:shouldDeselectTagAtIndex:)]) {
        return [self.delegate tagView:self shouldDeselectTagAtIndex:indexPath.row];
    }
    return YES;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.delegate&&[self.delegate respondsToSelector:@selector(tagView:didSelectTagAtIndex:)]) {
        [self.delegate tagView:self didSelectTagAtIndex:indexPath.row];
    }


    TagModel *tagModel = self.tagModels[indexPath.item];
    TagViewCollectionViewCell *cell = (TagViewCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if (self.allowsMultipleSelection) {
        tagModel.selected = YES;
        [self setCell:cell selected:YES];
        return;
    }
    if (tagModel.selected) {
        if (!self.allowEmptySelection && self.collectionView.indexPathsForSelectedItems.count == 1) {
            return;
        }
        cell.selected = NO;
        collectionView.allowsMultipleSelection = YES;
        [collectionView deselectItemAtIndexPath:indexPath animated:NO];
        [self collectionView:collectionView didDeselectItemAtIndexPath:indexPath];
        collectionView.allowsMultipleSelection = NO;
        return;
    }
    tagModel.selected = YES;
    [self setCell:cell selected:YES];
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.delegate respondsToSelector:@selector(tagView:didDeselectTagAtIndex:)]) {
        [self.delegate tagView:self didDeselectTagAtIndex:indexPath.row];
    }
    TagModel *tagModel = self.tagModels[indexPath.row];
    TagViewCollectionViewCell *cell = (TagViewCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    tagModel.selected = NO;
    [self setCell:cell selected:NO];
}
#pragma mark privately-owned

- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.tagModels.count;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return self.elementSpacing;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return self.lineSpacing;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return self.contentInsets;
}
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    TagModel *tagModel = self.tagModels[indexPath.row];
    CGFloat width = tagModel.tagContentSize.width + self.tagInsets.left + self.tagInsets.right;
    if (width < self.mininumTagWidth) {
        width = self.mininumTagWidth;
    }
    if (width > self.maximumTagWidth) {
        width = self.maximumTagWidth;
    }
    return CGSizeMake(width, self.tagHeight);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TagViewCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CollectionViewCellID forIndexPath:indexPath];
    TagModel *tagModel = self.tagModels[indexPath.row];
    cell.tagModel = tagModel;
    cell.tagLabel.text = tagModel.title;
    cell.tagLabel.layer.cornerRadius = self.tagcornerRadius;
    cell.tagLabel.layer.masksToBounds = self.tagcornerRadius > 0;
    cell.contentInsets = self.tagInsets;
    cell.tagLabel.layer.borderWidth = self.tagBorderWidth;
    cell.deleBT.hidden =YES;
    [cell.deleBT setBackgroundImage:self.deleteImage.length?[UIImage imageNamed:self.deleteImage]:BundleImageName(@"img-guanbi") forState:UIControlStateNormal];
    [cell.deleBT setBackgroundImage:self.deleteImage.length?[UIImage imageNamed:self.deleteImage]:BundleImageName(@"img-guanbi") forState:UIControlStateHighlighted];
    [cell.deleBT setBackgroundImage:self.deleteImage.length?[UIImage imageNamed:self.deleteImage]:BundleImageName(@"img-guanbi") forState:UIControlStateDisabled];
    [cell.deleBT setBackgroundImage:self.deleteImage.length?[UIImage imageNamed:self.deleteImage]:BundleImageName(@"img-guanbi") forState:UIControlStateSelected];
    __weak __typeof(&*self)weakSelf = self;
    [cell deleteComplete:^(TagModel *model) {
        [weakSelf removeWithTag:model.title];
    }];
    [self setCell:cell selected:tagModel.selected];
    return cell;
}
- (void)setCell:(TagViewCollectionViewCell *)cell selected:(BOOL)selected {
    
    
    
    if (selected) {
        cell.tagLabel.backgroundColor = self.tagSelectedBackgroundColor;
        cell.tagLabel.font = self.tagSelectedFont;
        cell.tagLabel.textColor = self.tagSelectedTextColor;
        cell.tagLabel.layer.borderColor = self.tagSelectedBoaderColor.CGColor;
    }else {
        cell.tagLabel.backgroundColor = self.tagNormaBackgroundlColor;
        cell.tagLabel.font = self.tagFont;
        cell.tagLabel.textColor = self.tagNormaTextColor;
        cell.tagLabel.layer.borderColor = self.tagNormalBoaderColor.CGColor;
    }
}

#pragma marl setter getter

-(NSUInteger)selectedIndex{
    
    return self.collectionView.indexPathsForSelectedItems.firstObject.row;
}

-(NSArray<NSString *> *)selectedTags{
    
    if (!self.allowsMultipleSelection) {
        return nil;
    }
    NSMutableArray *selectedTag  = [NSMutableArray arrayWithCapacity:0];
    for (NSIndexPath *indexPath in self.collectionView.indexPathsForSelectedItems) {
        [selectedTag addObject:self.tagsMutableArray[indexPath.row]];
    }
    return selectedTag.copy;
}
-(NSArray<NSNumber *> *)selectedIndexs{
    
    if (!self.allowsMultipleSelection) {
        return nil;
    }
    NSMutableArray *selectedTag  = [NSMutableArray arrayWithCapacity:0];
    for (NSIndexPath *indexPath in self.collectionView.indexPathsForSelectedItems) {
        [selectedTag addObject:@(indexPath.row)];
    }
    return selectedTag.copy;
}
-(void)setAllowsMultipleSelection:(BOOL)allowsMultipleSelection{
    
    _allowsMultipleSelection = allowsMultipleSelection;
    
    _collectionView.allowsMultipleSelection  =allowsMultipleSelection;
    
}
-(void)setAllowsSelection:(BOOL)allowsSelection{
    
    _allowsSelection  = allowsSelection;
    
    _collectionView.allowsSelection   = allowsSelection;
    
}
-(void)setLongPressMove:(BOOL)longPressMove{
    
    _longPressMove  =longPressMove;
    
    if (longPressMove) {
        
        _longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(lonePressMoving:)];
        [self.collectionView addGestureRecognizer:self.longPress];
        
    }
}
-(CGFloat)contentHeigth{
    return [self intrinsicContentSize].height;
}
-(UICollectionView *)collectionView{
    
    if (!_collectionView) {
        
        SLTagSpaceFlowLayout  *layout=  [[SLTagSpaceFlowLayout alloc] init];
        layout.delegate  =self ;
        _collectionView  = [[UICollectionView alloc] initWithFrame:self.bounds  collectionViewLayout:layout];
        [_collectionView registerClass:[TagViewCollectionViewCell class] forCellWithReuseIdentifier:CollectionViewCellID];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        
    }
    
    
    return _collectionView;
}
-(NSMutableArray<TagModel *> *)tagModels{
    
    if (!_tagModels) {
        
        _tagModels = [NSMutableArray arrayWithCapacity:0];
    }
    return _tagModels;
}
-(CGFloat)lineSpacing{
    
    if (!_lineSpacing) {
        
        return 5.0;
    }
    return _lineSpacing;
}
-(CGFloat)elementSpacing{
    if (!_elementSpacing) {
        
        return 5.0;
    }
    return _elementSpacing;
    
}
-(UIColor *)tagNormaBackgroundlColor{
    
    if (!_tagNormaBackgroundlColor) {
        
        return UIColorFromRGB(0xa9a9a9);
    }
    return _tagNormaBackgroundlColor;
}
-(UIColor *)tagSelectedBackgroundColor{
    
    if (!_tagSelectedBackgroundColor) {
        
        return UIColorFromRGB(0xdc143c);
    }
    return _tagSelectedBackgroundColor;
}
-(UIColor *)tagNormaTextColor{
    
    if (!_tagNormaTextColor) {
        
        return UIColorFromRGB(0xff8c00);
    }
    return _tagNormaTextColor;
}

-(UIColor *)tagSelectedTextColor{
    
    if (!_tagSelectedTextColor) {
        
        return  [UIColor whiteColor];
    }
    return _tagSelectedTextColor;
}
-(UIColor *)tagNormalBoaderColor{
    
    if (!_tagNormalBoaderColor) {
        
        return UIColorFromRGB(0xff8c00);
    }
    return _tagNormalBoaderColor;
}

-(UIColor *)tagSelectedBoaderColor{
    
    if (!_tagSelectedBoaderColor) {
        
        return [UIColor whiteColor];
    }
    return _tagSelectedBoaderColor;
    
}

-(UIColor *)contenBGColor{
    
    if (!_contenBGColor) {
        
        return  [UIColor whiteColor];
    }
    return _contenBGColor;
    
}
-(UIFont *)tagFont{
    
    if (!_tagFont ) {
        
        return FontHelFont(12);
    }
    return _tagFont;
}
-(UIFont *)tagSelectedFont{
    
    if (!_tagSelectedFont ) {
        
        return FontHelFont(12);
    }
    return _tagSelectedFont;
    
}

-(CGFloat)tagBorderWidth{
    
    if (!_tagBorderWidth) {
        
        return 0.5;
    }
    return _tagBorderWidth;
}
-(CGFloat)tagcornerRadius{
    
    if (!_tagcornerRadius) {
        
        return 0;
    }
    return _tagcornerRadius;
}
-(CGFloat)tagHeight{
    
    if (!_tagHeight) {
        
        return 28;
    }
    
    return _tagHeight;
}


-(CGFloat)mininumTagWidth{
    
    if (!_mininumTagWidth) {
        
        return  0;
    }
    return _mininumTagWidth;
}

-(CGFloat)maximumTagWidth{
    
    if (!_maximumTagWidth) {
        
        return CGFLOAT_MAX;
    }
    return _maximumTagWidth;
}
@end
