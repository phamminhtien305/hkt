//
//  BlockConfig.h
//  HACKATHON2015
//
//  Created by Minh Tien on 10/24/15.
//  Copyright (c) 2015 hackathon. All rights reserved.
//

#ifndef HACKATHON2015_BlockConfig_h
#define HACKATHON2015_BlockConfig_h

typedef void (^AppResultCompleteBlock)(id result, BOOL isCache);
typedef void (^AppResultErrorBlock)(NSError *error);
typedef void (^AppResultProgressBlock)(double progress, double byteRead, double totalByteOfFile);
typedef void (^AppBOOLBlock)(BOOL b);

#endif
