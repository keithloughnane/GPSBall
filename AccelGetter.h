//
//  AccelGetter.h
//  FitNexus
//
//  Created by keith on 03/09/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface AccelGetter : NSObject
<UIAccelerometerDelegate>
{
	id *owner;
	UIAccelerometer *accel;
}
-(int)initWithOwner : (id) ownerl;

@property (retain, nonatomic) id *owner;
@property (retain, nonatomic) UIAccelerometer *accel;
@end
