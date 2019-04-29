//
//  NSObject+CPHUDExtension.m
//  ChargingPile
//
//  Created by ZL on 16/10/12.
//  Copyright © 2016年 LittleShrimp. All rights reserved.
//

#import "NSObject+CPHUDExtension.h"
#import "CPProgressHUD.h"
@implementation NSObject (CPHUDExtension)
/**
 *  <#Description#>
 *
 *  @param text <#text description#>
 */
void showText(NSString * text)
{
    if (![NSThread isMainThread]) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [CPProgressHUD showWithStatus:text];
        });
        
    }else{
        
        [CPProgressHUD showWithStatus:text];
    }
    
}
/**
 *  <#Description#>
 *
 *  @param image <#image description#>
 *  @param text  <#text description#>
 */
void showImage(UIImage *image,NSString *text){
    
    if (![NSThread isMainThread]) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [CPProgressHUD showImage:image status:text];
            
        });
        
    }else{
        
        [CPProgressHUD showImage:image status:text];
    }
}
void showProgress(NSInteger progress){
    
    if (![NSThread isMainThread]) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [CPProgressHUD showProgress:progress/100.0 status:[NSString stringWithFormat:@"%li%%",(long)progress]];
        });
    }else{
        
        [CPProgressHUD showProgress:progress/100.0 status:[NSString stringWithFormat:@"%li%%",(long)progress]];
    }
}
/**
 *  <#Description#>
 *
 *  @param text <#text description#>
 */
void showErrorText(NSString *text){
    
    if (![NSThread isMainThread]) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [CPProgressHUD showErrorWithStatus:text];
            
        });
        
    }else{
        
        [CPProgressHUD showErrorWithStatus:text];
        
    }
}

/**
 *  <#Description#>
 *
 *  @param text <#text description#>
 */
void showInfoText(NSString *text){
    
    if (![NSThread isMainThread]) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [CPProgressHUD showInfoWithStatus:text];
            
        });
        
    }else{
        
        [CPProgressHUD showInfoWithStatus:text];
        
    }
}

/**
 *  <#Description#>
 *
 *  @param text <#text description#>
 */
void showSuccessText(NSString *text){
    
    if (![NSThread isMainThread]) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [CPProgressHUD showSuccessWithStatus:text];
            
        });
        
    }else{
        
        [CPProgressHUD showSuccessWithStatus:text];
        
    }
    
}
/**
 *  <#Description#>
 */
void showLoading(){
    
    if (![NSThread isMainThread]) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [CPProgressHUD show];
        
        });
        
    }else{
        
        [CPProgressHUD show];
        
    }
}
/**
 *  <#Description#>
 */
void dismiss(){    
    if (![NSThread isMainThread]) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [CPProgressHUD dismiss];
            
        });
        
    }else{
        
        [CPProgressHUD dismiss];
        
    }
    
}

@end
