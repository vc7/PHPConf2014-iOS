//
//  PCSessionDetailCell.m
//  PHPConf2014
//
//  Created by vincent on 2014/09/13.
//  Copyright (c) 2014 Vincent Chen. All rights reserved.
//

#import "PCSessionDetailCell.h"

#import "UIColor+PHPConfAdditions.h"

@implementation PCSessionDetailCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self applyStyleSheet];
    }
    return self;
}

#pragma mark - Private Methods

- (void)applyStyleSheet
{
    self.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

@end

@interface PCSessionDetailHeroCell ()

@property (nonatomic, strong) UIView *titleHUD;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *positionLabel;

@end

@implementation PCSessionDetailHeroCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self applyStyleSheet];
    }
    return self;
}

- (void)layoutSubviews
{
    CGFloat titleHUDHeight = 80;
    self.titleHUD.frame = (CGRect){{0, CGRectGetHeight(self.bounds) - titleHUDHeight}, {CGRectGetWidth(self.bounds), titleHUDHeight}};
    
    CGFloat labelMargin = 20;
    
    CGFloat titleLabelHeight = 18;
    self.nameLabel.frame = (CGRect){{ 25, labelMargin }, {CGRectGetWidth(self.titleHUD.frame) - labelMargin - 70, titleLabelHeight}};
    
    CGFloat positionLabelHeight = 16;
    self.positionLabel.frame = (CGRect){{ 25, CGRectGetHeight(self.titleHUD.frame) - labelMargin - positionLabelHeight}, {CGRectGetWidth(self.titleHUD.frame) - labelMargin - 70, positionLabelHeight}};
}

#pragma mark - Accessors

- (void)setSpeakerName:(NSString *)speakerName
{
    if (_speakerName != speakerName) {
        
        if (speakerName && ![speakerName isEqualToString:@""]) {
            _speakerName = speakerName;
        } else {
            _speakerName = @"--";
        }
        
        self.nameLabel.text = _speakerName;
    }
}

- (void)setSpeakerPosition:(NSString *)speakerPosition
{
    if (_speakerPosition != speakerPosition) {
        
        if (speakerPosition && ![speakerPosition isEqualToString:@""]) {
            _speakerPosition = speakerPosition;
        } else {
            _speakerPosition = @"--";
        }
        
        self.positionLabel.text = _speakerPosition;
    }
}

- (void)setVenueName:(NSString *)venueName
{
    if (_venueName != venueName) {
        _venueName = venueName;
    }
}

- (UIImageView *)avatarImageView
{
    if (!_avatarImageView) {
        _avatarImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _avatarImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:_avatarImageView];
    }
    return _avatarImageView;
}

- (UIView *)titleHUD
{
    if (!_titleHUD) {
        _titleHUD = [[UIView alloc] initWithFrame:CGRectZero];
        [self addSubview:_titleHUD];
    }
    
    return _titleHUD;
}

- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLabel.text = @"Default Name";
        [self.titleHUD addSubview:_nameLabel];
    }
    
    return _nameLabel;
}

- (UILabel *)positionLabel
{
    if (!_positionLabel) {
        _positionLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _positionLabel.text = @"Default Position";
        [self.titleHUD addSubview:_positionLabel];
    }
    
    return _positionLabel;
}

#pragma mark - Private Methods

- (void)applyStyleSheet
{
    [super applyStyleSheet];
    
    self.backgroundColor = [UIColor clearColor];
    
    self.avatarImageView.backgroundColor = [UIColor grayColor];
    self.titleHUD.backgroundColor = [UIColor colorWithWhite:0 alpha:0.8];
    
    self.nameLabel.backgroundColor = [UIColor clearColor];
    self.nameLabel.textColor = [UIColor whiteColor];
    self.nameLabel.font = [UIFont boldSystemFontOfSize:16.f];
    
    self.positionLabel.backgroundColor = [UIColor clearColor];
    self.positionLabel.textColor = [UIColor whiteColor];
    self.positionLabel.font = [UIFont systemFontOfSize:14.f];

}

@end

@implementation PCSessionDetailIntroCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self applyStyleSheet];
    }
    return self;
}

#pragma mark - Private Methods

- (void)applyStyleSheet
{
    [super applyStyleSheet];
    
    self.textLabel.font = [UIFont systemFontOfSize:14.f];
    self.textLabel.textColor = [UIColor phpconfBlackColor];
    self.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.textLabel.numberOfLines = 0;
}

@end