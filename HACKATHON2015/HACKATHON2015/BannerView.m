//
//  BannerView.m
//  Appvn
//
//  Created by tuent on 2/12/14.
//  Copyright (c) 2014 Appota. All rights reserved.
//

#import "BannerView.h"

@implementation BannerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.userInteractionEnabled = YES;        
    }
    return self;
}

-(void)update {
    return;
//    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
//        [super update];
}

- (id) initWithBannerData:(NewsObject*) bData
           withBannerSize:(CGSize) bannerSize;
{
    self = [self initWithFrame:CGRectMake(0, 0, bannerSize.width, bannerSize.height)];
    if (self) {
        self.opaque = YES;
        bannerData = bData;
        [self setupView];
        shadowBg.frame = CGRectMake(0, 0, shadowBg.frame.size.width-1, shadowBg.frame.size.height);
        shadowBg.center = CGPointMake(imgView.center.x, imgView.center.y + 1);
    }
    
    return self;
}

- (void) setupView {
    [self addURLImageViewDescription];
    [self addSubview:shadowBg];
}

//for reload with new data
- (void) setBannerData:(NewsObject *) _bannerData {
    bannerData = _bannerData;
    [self setupView];
}

- (void) addURLImageViewDescription {
    NSString *bannerURL = [bannerData getFirstImage];
    if (bannerURL) {
        float align = 4;
        imgView = [[UIImageView alloc] initWithFrame:CGRectMake(align/2, 0, self.frame.size.width-align, self.frame.size.height)];
        
        __block BannerView *thisBlock = self;
    
        [imgView sd_setImageWithURL:[NSURL URLWithString:bannerURL] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                [thisBlock update];
        }];
        
        imgView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        [self addSubview:imgView];
    }
}

#pragma mark - get bannerdata
- (NewsObject *) getBannerData {
    return bannerData;
}

#pragma mark - Interaction manupliation
//- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
//    NSString *bannerOpenURL = [bannerData getBannerOpenURL];
//    
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:bannerOpenURL]];
//}
@end
