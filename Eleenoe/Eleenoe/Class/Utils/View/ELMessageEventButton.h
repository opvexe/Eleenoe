//
//  ELMessageEventButton.h
//  Eleenoe
//
//  Created by FaceBook on 2019/3/13.
//  Copyright © 2019 FaceBook. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ELMessageEventButton;
@protocol ELMessageEventButtonDelegate <NSObject>
@optional
-(void)ClickedWithMessageButton:(ELMessageEventButton*)messageButton;
@end

@interface ELMessageEventButton : UIButton

@property (nonatomic, copy) NSString *normalStateImageName;

@property (nonatomic, copy) NSString *highlightedStateImageName;

@property (nonatomic, copy) NSString *selectedStateImageName;

@property (nonatomic, copy) NSString *normalStateBgImageName;

@property (nonatomic, copy) NSString *highlightedStateBgImageName;

@property (nonatomic, copy) NSString *selectedStateBgImageName;

@property(nonatomic)NSUInteger countdownBeginNumber;

@property(nonatomic,weak)id<ELMessageEventButtonDelegate>delegate;

-(void)startBeginNumber;

@end

NS_ASSUME_NONNULL_END
