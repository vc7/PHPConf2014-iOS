//
//  PCMapCell.m
//  PHPConf2014
//
//  Created by vincent on 2014/09/15.
//  Copyright (c) 2014年 Vincent Chen. All rights reserved.
//

#import "PCMapCell.h"
#import <GoogleMaps/GoogleMaps.h>

@interface PCMapCell () <GMSMapViewDelegate>

@property (nonatomic, strong) GMSMapView *mainMapView; // 25.0355648,121.4320238, 17z

@end

@implementation PCMapCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self applyStyleSheet];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.mainMapView.frame = (CGRect){{0, 0}, {CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)}};
}

#pragma mark - Accessors

- (void)setLocation:(CLLocationCoordinate2D *)location
{
    
}

#pragma mark - Public Methods

- (void)initializeMapViewIfNeeded
{
    if (!_mainMapView) {
        GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:25.0369648
                                                                longitude:121.4320238
                                                                     zoom:15];
        
        self.mainMapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
        self.mainMapView.delegate = self;
        self.mainMapView.myLocationEnabled = YES;
        self.mainMapView.userInteractionEnabled = NO;
        self.mainMapView.alpha = 0;
        
        [self addSubview:self.mainMapView];
        
        // Creates a marker in the center of the map.
        GMSMarker *marker = [[GMSMarker alloc] init];
        marker.position = CLLocationCoordinate2DMake(25.0355648, 121.4320238);
        marker.title = @"PHPConf Taiwan 2014";
        marker.snippet = @"輔仁大學 國璽樓";
        marker.map = self.mainMapView;
        
        [self.mainMapView setSelectedMarker:marker];
        
        [self setNeedsLayout];
        
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            self.mainMapView.alpha = 1;
        } completion:nil];
    }
}

#pragma mark - Private Methods

- (void)applyStyleSheet
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];
}

@end
