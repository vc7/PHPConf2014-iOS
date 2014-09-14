//
//  PCSessionCell.m
//  PHPConf2014
//
//  Created by vincent on 2014/09/09.
//  Copyright (c) 2014 Vincent Chen. All rights reserved.
//

#import "PCSessionCell.h"
#import "UIColor+PHPConfAdditions.h"

@interface PCSessionCell ()

@property (nonatomic, strong) CALayer *topStick;
@property (nonatomic, strong) CALayer *bottomStick;
@property (nonatomic, strong) CALayer *imageBlock;

@end

@implementation PCSessionCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.cellState = PCSessionCellStateDefault;
        
        [self applyStyleSheet];
        [self applyTimeline];
    }
    return self;
}

#pragma mark - UIView - UIView Hierarchy

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect textLabelRect = self.textLabel.frame;
    CGRect timeLabelRect = self.timeLabel.frame;
    
    textLabelRect.origin = (CGPoint){112, 42};
    timeLabelRect.origin = (CGPoint){112, 26};
    
    self.textLabel.frame = textLabelRect;
    [self.textLabel sizeToFit];
    
    self.timeLabel.frame = timeLabelRect;
    [self.timeLabel sizeToFit];
    
    CGFloat stickHeight = CGRectGetHeight(self.frame) / 2;
    
    self.topStick.frame = (CGRect){{53, 0}, {3, stickHeight}};
    self.bottomStick.frame = (CGRect){{53, stickHeight}, {3, stickHeight}};
    
    switch (self.cellState) {
        case PCSessionCellStateFirst:
            self.topStick.hidden = YES;
            self.bottomStick.hidden = NO;
            break;
            
        case PCSessionCellStateLast:
            self.topStick.hidden = NO;
            self.bottomStick.hidden = YES;
            break;
            
        default:
            self.topStick.hidden = NO;
            self.bottomStick.hidden = NO;
            break;
    }
    
}

#pragma mark - Private Methods

- (void)applyStyleSheet
{
    self.textLabel.font = [UIFont boldSystemFontOfSize:14.f];
    self.textLabel.textColor = [UIColor phpconfBlueColor];
    
    self.timeLabel.font = [UIFont systemFontOfSize:12.f];
    self.timeLabel.textColor = [UIColor phpconfBlackColor];
    
    self.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)applyTimeline
{
    self.topStick = [CALayer new];
    self.bottomStick = [CALayer new];
    self.imageBlock = [CALayer new];
    
    self.topStick.backgroundColor = [UIColor phpconfGreenColor].CGColor;
    self.bottomStick.backgroundColor = [UIColor phpconfGreenColor].CGColor;
    self.imageBlock.backgroundColor = [UIColor phpconfGreenColor].CGColor;
    
    self.imageBlock.cornerRadius = 5;
    self.imageBlock.masksToBounds = YES;
    
    [self.layer addSublayer:self.topStick];
    [self.layer addSublayer:self.bottomStick];
    [self.layer addSublayer:self.imageBlock];
}

#pragma mark - Accessors

- (UILabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [UILabel new];
        [self addSubview:_timeLabel];
    }
    
    return _timeLabel;
}

@end

@interface PCSessionRegularCell ()

@property (nonatomic, strong) UIView *avatarBase;

@end

@implementation PCSessionRegularCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.cellState = PCSessionCellStateDefault;
        
        [self applyTimeline];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat imageBlockWidthHeight = 64;
    CGFloat imageBlockPositionX = 22.5f;
    CGFloat imageBlockPositionY = CGRectGetHeight(self.frame) / 2 - imageBlockWidthHeight / 2;
    
    self.avatarBase.frame = (CGRect){{imageBlockPositionX, imageBlockPositionY}, {imageBlockWidthHeight, imageBlockWidthHeight}};
    
    self.imageView.frame = (CGRect){{24.5f, CGRectGetHeight(self.frame) / 2 - 60 / 2}, {60, 60}};
   
    CGRect topStickFrame = self.topStick.frame;
    topStickFrame.size.height = imageBlockPositionY;
    self.topStick.frame = topStickFrame;
    
    CGRect bottomStickFrame = self.bottomStick.frame;
    bottomStickFrame.origin.y = imageBlockPositionY + imageBlockWidthHeight;
    bottomStickFrame.size.height = CGRectGetHeight(self.frame) - (imageBlockPositionY + imageBlockWidthHeight);
    self.bottomStick.frame = bottomStickFrame;
}

- (void)applyTimeline
{
    [super applyTimeline];
    
    self.imageBlock = nil;
    
    self.avatarBase = [[UIView alloc] initWithFrame:CGRectZero];
    [self addSubview:self.avatarBase];
    
    self.imageView.image = [UIImage imageNamed:@"avatar_placeholder.png"];
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.layer.cornerRadius = 3;
    self.imageView.layer.masksToBounds = YES;
    
    self.avatarBase.layer.backgroundColor = [UIColor phpconfGreenColor].CGColor;
    self.avatarBase.layer.cornerRadius = 5;
    self.avatarBase.layer.masksToBounds = YES;
    
    [self sendSubviewToBack:self.avatarBase];
}

@end

@implementation PCSessionOtherCell

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat imageBlockWidthHeight = 24;
    CGFloat imageBlockPositionX = 42.5f;
    CGFloat imageBlockPositionY = CGRectGetHeight(self.frame) / 2 - imageBlockWidthHeight / 2;
    
    self.imageBlock.frame = (CGRect){{imageBlockPositionX, imageBlockPositionY}, {imageBlockWidthHeight, imageBlockWidthHeight}};
}

@end