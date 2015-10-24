//
//  UploadEngine.h
//  HACKATHON2015
//
//  Created by Tue Nguyen on 10/24/15.
//  Copyright © 2015 hackathon. All rights reserved.
//

#import "MKNetworkEngine.h"

@interface UploadEngine : MKNetworkEngine
+ (UploadEngine*) sharedInstance;

- (void) uploadWithPath:(NSString*) path
    withCompletionBlock:(AppStringCompleteBlock) completeBlock
         withErrorBlock:(AppResultErrorBlock) errorBlock;
@end
