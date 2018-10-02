//
//  KeychainIDFA.m
//  RAC_Frame_Proj
//
//  Created by CoDancer on 2018/8/8.
//  Copyright © 2018年 IOS. All rights reserved.
//

#import "KeychainIDFA.h"
#import <Security/Security.h>
#import <AdSupport/AdSupport.h>

#define IDFAString @"com.name.iosapp.idfa"
#define StringValid(text) (text && text!=NULL && text.length>0 && ![text isEqualToString:@"00000000-0000-0000-0000-000000000000"])

@implementation KeychainIDFA

+ (NSString*)deviceID{
    //0.读取keychain的缓存
    NSString *deviceID = [self IDFA];
    if (StringValid(deviceID)) {
        return deviceID;
    }
    else {
        //1.取IDFA,可能会取不到,如用户关闭IDFA
        if ([ASIdentifierManager sharedManager].advertisingTrackingEnabled){
            deviceID = [[[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString] lowercaseString];
            [self setIdfaString:deviceID];
            return deviceID;
        }
        else
        {
            //2.如果取不到,就生成UUID,当成IDFA
            deviceID = [self UUID];
            [self setIdfaString:deviceID];
            if (StringValid(deviceID)){
                return deviceID;
            }
        }
    }
    //3.再取不到尼玛我也没办法了,你牛B.
    return nil;
}

#pragma mark - Keychain
+ (NSString*)IDFA{
    NSString *ID = [self load:IDFAString];
    return (StringValid(ID)) ? ID:   nil;
}

+ (BOOL)setIdfaString:(NSString *)secValue{
    BOOL result = NO;
    if (StringValid(secValue)) {
        [self save:IDFAString data:secValue];
        result = YES;
    }
    return result;
}

+ (NSMutableDictionary *)getKeychainQuery:(NSString *)service{
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
            (__bridge id)(kSecClassGenericPassword),kSecClass,
            service, kSecAttrService,
            service, kSecAttrAccount,
            kSecAttrAccessibleAfterFirstUnlock,kSecAttrAccessible,nil];
}

+ (void)save:(NSString *)service data:(id)data{
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    SecItemDelete((__bridge CFDictionaryRef)(keychainQuery));
    [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:data]
                      forKey:(__bridge id<NSCopying>)(kSecValueData)];
    SecItemAdd((__bridge CFDictionaryRef)(keychainQuery), NULL);
}

+ (id)load:(NSString *)service{
    id ret = nil;
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    [keychainQuery setObject:(id)kCFBooleanTrue forKey:(__bridge id<NSCopying>)(kSecReturnData)];
    [keychainQuery setObject:(__bridge id)(kSecMatchLimitOne) forKey:(__bridge id<NSCopying>)(kSecMatchLimit)];
    
    CFTypeRef result = NULL;
    if (SecItemCopyMatching((__bridge_retained CFDictionaryRef)keychainQuery, &result) == noErr){
        ret = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge NSData*)result];
    }
    return ret;
}

+ (void)delete:(NSString *)service{
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    SecItemDelete((__bridge CFDictionaryRef)(keychainQuery));
}

#pragma mark - UUID
+ (NSString*)UUID{
    CFUUIDRef uuid_ref = CFUUIDCreate(kCFAllocatorDefault);
    CFStringRef uuid_string_ref= CFUUIDCreateString(kCFAllocatorDefault, uuid_ref);
    CFRelease(uuid_ref);
    NSString *uuid = [NSString stringWithString:(__bridge NSString*)uuid_string_ref];
    if (!StringValid(uuid)){
        uuid = nil;
    }
    CFRelease(uuid_string_ref);
    return [uuid lowercaseString];
}

@end
