//
//  RatingTableViewCell.m
//  iFifteen
//
//  Created by AKEB on 4/9/10.
//  Copyright 2010 AKEB.RU. All rights reserved.
//

#import "FriendsRatingTableViewCell.h"

@implementation FriendsRatingTableViewCell

@synthesize primaryLabel  = _primaryLabel,
			point1Label   = _point1Label,
			Label1        = _Label1,
			time1Label	  = _time1Label,
			point2Label   = _point2Label,
			Label2        = _Label2,
			time2Label	  = _time2Label,
			runImageView  = _runImageView;



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
		// Initialization code
		UIColor *textColor = [UIColor colorWithRed:0.067 green:0.075 blue:0.514 alpha:1.0];
		
		_primaryLabel = [[UILabel alloc]init];
		_primaryLabel.textAlignment = UITextAlignmentLeft;
		[_primaryLabel setTextColor:textColor];
		_primaryLabel.font = [UIFont systemFontOfSize:16];
		
		UIColor *textColor2 = [UIColor colorWithRed:0.302 green:0.263 blue:0.863 alpha:1.0];
		
		_point1Label = [[UILabel alloc]init];
		_point1Label.textAlignment = UITextAlignmentRight;
		[_point1Label setTextColor:textColor2];
		_point1Label.font = [UIFont systemFontOfSize:14];
		
		_Label1 = [[UILabel alloc]init];
		_Label1.textAlignment = UITextAlignmentLeft;
		[_Label1 setTextColor:textColor2];
		_Label1.font = [UIFont systemFontOfSize:14];
		
		_time1Label = [[UILabel alloc]init];
		_time1Label.textAlignment = UITextAlignmentLeft;
		[_time1Label setTextColor:textColor2];
		_time1Label.font = [UIFont systemFontOfSize:14];
		
		UIColor *textColor3 = [UIColor colorWithRed:0.161 green:0.420 blue:0.133 alpha:1.0];
		
		_point2Label = [[UILabel alloc]init];
		_point2Label.textAlignment = UITextAlignmentRight;
		[_point2Label setTextColor:textColor3];
		_point2Label.font = [UIFont systemFontOfSize:14];
		
		_Label2 = [[UILabel alloc]init];
		_Label2.textAlignment = UITextAlignmentLeft;
		[_Label2 setTextColor:textColor3];
		_Label2.font = [UIFont systemFontOfSize:14];
		
		_time2Label = [[UILabel alloc]init];
		_time2Label.textAlignment = UITextAlignmentLeft;
		[_time2Label setTextColor:textColor3];
		_time2Label.font = [UIFont systemFontOfSize:14];
		
		_runImageView = [[UIImageView alloc]init];
		
		[self.contentView addSubview:_primaryLabel];
		
		[self.contentView addSubview:_point1Label];
		[self.contentView addSubview:_Label1];
		[self.contentView addSubview:_time1Label];
		
		[self.contentView addSubview:_point2Label];
		[self.contentView addSubview:_Label2];		
		[self.contentView addSubview:_time2Label];
		
		[self.contentView addSubview:_runImageView];
    }
    return self;
}

/**
 * Cell layout
 */
- (void)layoutSubviews {
	
	[super layoutSubviews];
	
	
	CGRect contentRect = self.contentView.bounds;
	CGFloat boundsX = contentRect.origin.x;
	CGFloat boundsXEnd = contentRect.size.width;
	
	CGRect frame;
	
	frame= CGRectMake(0 ,0, 60, 60);
	_runImageView.frame = frame;
	
	frame= CGRectMake(70 ,0, 250, 20);
	_primaryLabel.frame = frame;
	

	frame= CGRectMake(70 ,20, 50, 20);
	_Label1.frame = frame;
	
	frame= CGRectMake(70 ,40, 50, 20);
	_Label2.frame = frame;
	
	
	frame= CGRectMake(190 ,20, 60, 20);
	_time1Label.frame = frame;
	
	frame= CGRectMake(190 ,40, 60, 20);
	_time2Label.frame = frame;
	
	frame= CGRectMake(250 ,20, 70, 20);
	_point1Label.frame = frame;

	frame= CGRectMake(250 ,40, 70, 20);
	_point2Label.frame = frame;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
	
    [super setSelected:selected animated:animated];
	
    // Configure the view for the selected state
}

- (void)dealloc {
	[_primaryLabel release];
	[_point1Label release];
	[_Label1 release];
	[_Label2 release];
	[_time1Label release];
	[_point2Label release];
	[_time2Label release];
	[_runImageView release];
	[super dealloc];
}

@end
