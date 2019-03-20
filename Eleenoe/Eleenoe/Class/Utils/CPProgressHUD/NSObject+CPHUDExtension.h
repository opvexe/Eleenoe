//
//  NSObject+CPHUDExtension.h
//  ChargingPile
//
//  Created by ZL on 16/10/12.
//  Copyright © 2016年 LittleShrimp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (CPHUDExtension)
/**
 *  <#Description#>
 *
 *  @param text <#text description#>
 */
extern void showText(NSString * text);
/**
 *  <#Description#>
 *
 *  @param image <#image description#>
 *  @param text  <#text description#>
 */
extern void showImage(UIImage *image,NSString *text);
/**
 *  <#Description#>
 *
 *  @param progress <#progress description#>
 */
extern void showProgress(NSInteger progress);
/**
 *  <#Description#>
 *
 *  @param text <#text description#>
 */
extern void showErrorText(NSString *text);
/**
 *  <#Description#>
 *
 *  @param text <#text description#>
 */
extern void showSuccessText(NSString *text);
/**
 *  <#Description#>
 */
extern void showLoading();
/**
 *  <#Description#>
 */
extern void dismiss();
@end
