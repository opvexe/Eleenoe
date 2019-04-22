//
//  ELMyofascialPickView.m
//  Eleenoe
//
//  Created by FaceBook on 2019/4/18.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import "ELMyofascialPickView.h"
#import <STDPickerView.h>
@interface ELMyofascialPickView ()<STDPickerViewDataSource,STDPickerViewDelegate>
@property (strong, nonatomic) STDPickerView *pickerView;
@property (strong, nonatomic) NSMutableArray *items;
@end

@implementation ELMyofascialPickView

-(void)ELSinitConfingViews{
    
    _pickerView = ({
        STDPickerView *iv = [[STDPickerView alloc] init];
        iv.backgroundColor = [UIColor clearColor];
        iv.dataSource = self;
        iv.delegate = self;
        iv.forceItemTypeText = NO;
        iv.selectionIndicatorStyle = STDPickerViewSelectionIndicatorStyleCustom;
        iv.showVerticalDivisionLine = NO;
        iv.edgeInsets = UIEdgeInsetsZero;
        iv.spacingOfComponents = 0;
        iv.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self);
        }];
        iv;
    });
}

-(void)InitDataSouce:(NSArray *)souce{
    if (souce.count&&!self.items.count) {
        self.items = [NSMutableArray arrayWithArray:souce];
        [self.items enumerateObjectsUsingBlock:^(ELMyofascialContentListModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.choose == YES) {
                NSLog(@"selectRow:==%ld",idx);
                [self.pickerView selectRow:idx inComponent:0 animated:NO];
                *stop = YES;
            }
        }];
    }
        [self.pickerView reloadAllComponents];
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(STDPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.items.count;
}

- (NSString *)pickerView:(STDPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return self.items[row];
}

- (UIView *)pickerView:(STDPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel *label = (UILabel *)view;
    if (!label) {
        label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont ELPingFangSCRegularFontOfSize:kSaFont(12)];
        [label sizeToFit];
    }
    label.textColor = MainLightThemColor;
//    label.transform = CGAffineTransformIdentity;
    ELMyofascialContentListModel *model = self.items[row];
    label.text = model.title;
    return label;
}

- (CGFloat)pickerView:(STDPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return kSAdap_V(30);
}

- (void)pickerView:(STDPickerView *)pickerView willSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    UILabel *label = (UILabel *)[pickerView viewForRow:row forComponent:component];
//    [UIView animateWithDuration:0.25 animations:^{
//        label.transform = CGAffineTransformMakeScale(1.2, 1.2);
//    }];
    label.font = [UIFont ELPingFangSCRegularFontOfSize:kSaFont(14)];
    label.textColor = [UIColor whiteColor];
}

- (void)pickerView:(STDPickerView *)pickerView willDeselectRow:(NSInteger)row inComponent:(NSInteger)component{
    UILabel *label = (UILabel *)[pickerView viewForRow:row forComponent:component];
//    [UIView animateWithDuration:0.25 animations:^{
//        label.transform = CGAffineTransformIdentity;
//    }];
    label.font = [UIFont ELPingFangSCRegularFontOfSize:kSaFont(12)];
    label.textColor = MainLightThemColor;
}

- (void)pickerView:(STDPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (self.items.count) {
        if (self.MyofascialPickBlock) {
            self.MyofascialPickBlock(self, row, self.items[row]);
        }
    }
}

- (UIView *)selectionIndicatorViewForPickerView:(STDPickerView *)pickerView{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    view.layer.borderColor = [UIColor whiteColor].CGColor;
    view.layer.borderWidth = .5f;
    view.layer.cornerRadius = kSAdap(15);
    view.layer.masksToBounds = YES;
    return view;
}
@end
