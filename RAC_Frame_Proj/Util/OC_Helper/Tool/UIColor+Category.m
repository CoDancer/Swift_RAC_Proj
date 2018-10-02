//
//  UIColor+Category.m
//  JobProject
//
//  Created by CoDancer on 2016/12/14.
//  Copyright © 2016年 CoDancer. All rights reserved.
//

#import "UIColor+Category.h"

@implementation UIColor (Category)

+ (UIColor *)colorWithHex:(NSString *)string {
    if (string.length > 0) {
        NSString *cleanString = [string stringByReplacingOccurrencesOfString:@"#" withString:@""];
        if([cleanString length] == 3) {
            cleanString = [NSString stringWithFormat:@"%@%@%@%@%@%@",
                           [cleanString substringWithRange:NSMakeRange(0, 1)],[cleanString substringWithRange:NSMakeRange(0, 1)],
                           [cleanString substringWithRange:NSMakeRange(1, 1)],[cleanString substringWithRange:NSMakeRange(1, 1)],
                           [cleanString substringWithRange:NSMakeRange(2, 1)],[cleanString substringWithRange:NSMakeRange(2, 1)]];
        }
        if([cleanString length] == 6) {
            cleanString = [cleanString stringByAppendingString:@"ff"];
        }
        
        unsigned int baseValue;
        [[NSScanner scannerWithString:cleanString] scanHexInt:&baseValue];
        
        float red = ((baseValue >> 24) & 0xFF)/255.0f;
        float green = ((baseValue >> 16) & 0xFF)/255.0f;
        float blue = ((baseValue >> 8) & 0xFF)/255.0f;
        
        return [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    }
    return [UIColor blackColor];
}

@end
