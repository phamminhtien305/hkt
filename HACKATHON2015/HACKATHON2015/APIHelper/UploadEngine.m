//
//  UploadEngine.m
//  HACKATHON2015
//
//  Created by Tue Nguyen on 10/24/15.
//  Copyright © 2015 hackathon. All rights reserved.
//

#import "UploadEngine.h"

@implementation UploadEngine

+ (UploadEngine*) sharedInstance {
    static UploadEngine *sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        sharedInstance = [[UploadEngine alloc] initWithHostName:nil];
    });
    return sharedInstance;
}


- (void) uploadWithPath:(NSString*) path
    withCompletionBlock:(AppStringCompleteBlock) completeBlock
         withErrorBlock:(AppResultErrorBlock) errorBlock
{
    MKNetworkOperation *op = [self operationWithURLString:@"http://203.162.69.22/share/hackathon/upload.php"
                                                   params:nil
                                               httpMethod:@"POST"];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        NSString *xmlString = [completedOperation responseString];
        xmlString = [xmlString stringByReplacingOccurrencesOfString:@"null" withString:@"\" \""];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[xmlString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
        if (!dict || !dict[@"image"]) {
            errorBlock([NSError errorWithDomain:@"Not valid image" code:1 userInfo:nil]);
        }
        else {
            completeBlock(dict[@"image"]);
        }
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        errorBlock(error);
    }];
    [op addFile:path forKey:@"fileToUpload"];
    [op setFreezable:YES];
    [self enqueueOperation:op];
}
@end
