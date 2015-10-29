//
//  EnumConfig.h
//  HACKATHON2015
//
//  Created by Minh Tien on 10/24/15.
//  Copyright (c) 2015 hackathon. All rights reserved.
//

#ifndef HACKATHON2015_EnumConfig_h
#define HACKATHON2015_EnumConfig_h


typedef enum{
    pending = 0,
    private_ = 1,
    open_ = 2,
    close_ = 3,
    unpublish =4
} REPORT_STATE;

typedef enum{
    LIST_REPORT_NONE =0,
    USER_REPORT = 1,
    USER_FOLLOW_REPORT = 2,
    USER_REQUEST = 3
} LIST_REPORT_TYPE;



#endif
