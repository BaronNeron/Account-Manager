//
//  AES256.h
//  Account Manager
//
//  Created by Admin on 09/12/15.
//  Copyright © 2015 Andrey Kozlov. All rights reserved.
//

#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>
#import <Foundation/Foundation.h>

@interface NSData (AES256)

- (NSData*)aes256EncryptWithKey:(NSString*)key;
- (NSData*)aes256DecryptWithKey:(NSString*)key;

@end
