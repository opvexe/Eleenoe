//
//  UITextField+ELFormatNumber.h
//  Eleenoe
//
//  Created by FaceBook on 2019/3/30.
//  Copyright © 2019 FaceBook. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,  kTextFieldType) {
    kIDCardNoTextFieldType,
    kPhoneNumberTextFieldType,
    kBankCardNumberTextFieldType
};

@interface UITextField (ELFormatNumber)

+ (BOOL)numberFormatTextField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string textFieldType:(kTextFieldType)type;

@end

NS_ASSUME_NONNULL_END
