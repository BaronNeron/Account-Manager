//
//  AES256.m
//  Account Manager
//
//  Created by Admin on 09/12/15.
//  Copyright © 2015 Andrey Kozlov. All rights reserved.
//

#import "AES256.h"

@implementation NSData (AES256)

- (NSData*)aes256EncryptWithKey:(NSString*)key
{
    char keyPtr[kCCKeySizeAES256 + 1];
    bzero( keyPtr, sizeof( keyPtr ) );
    
    [key getCString:keyPtr maxLength:sizeof( keyPtr ) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [self length];
    
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc( bufferSize );
    
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt( kCCEncrypt, kCCAlgorithmAES128, kCCOptionPKCS7Padding,
                                          keyPtr, kCCKeySizeAES256,
                                          NULL,
                                          [self bytes], dataLength,
                                          buffer, bufferSize,
                                          &numBytesEncrypted );
    if( cryptStatus == kCCSuccess )
    {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }
    
    free( buffer );
    return nil;
}

- (NSData*)aes256DecryptWithKey:(NSString*)key
{
    char keyPtr[kCCKeySizeAES256+1];
    bzero( keyPtr, sizeof( keyPtr ) );
    
    [key getCString:keyPtr maxLength:sizeof( keyPtr ) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [self length];
    
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc( bufferSize );
    
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt( kCCDecrypt, kCCAlgorithmAES128, kCCOptionPKCS7Padding,
                                          keyPtr, kCCKeySizeAES256,
                                          NULL,
                                          [self bytes], dataLength,
                                          buffer, bufferSize,
                                          &numBytesDecrypted );
    
    if( cryptStatus == kCCSuccess )
    {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
    }
    
    free( buffer );
    return nil;
}

@end
