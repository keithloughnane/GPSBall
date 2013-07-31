//
//  TrainingScreen.h
//  FitNexus
//
//  Created by keith on 31/08/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AccelGetter.h"
#import "LocationGetter.h"
//#import "DataBaseControler.h"
#import "statsView.h"


@interface TrainingScreen : UIViewController

{

	//AccelGetter *myAccelGetter;
	AccelGetter *myAccelGetter;
	LocationGetter *myLocationGetter;
	//DataBaseControler *myDBControler;
	IBOutlet statsView *myStatsView;
	
	IBOutlet UILabel *statusText;
	
	NSString *accStatus;
	NSString *locStatus;
	
	double sessionBeganDate;

	
}


@property (retain, nonatomic) UILabel *statusText;
@property (retain, nonatomic) AccelGetter *myAccelGetter;
@property (retain, nonatomic) LocationGetter *myLocationGetter;
//@property (retain, nonatomic) DataBaseControler *myDBControler;
@property (retain,nonatomic) statsView *myStatsView;
@property (retain, nonatomic) NSString *accStatus;
@property (retain, nonatomic) NSString *locStatus;


-(int)getsAccel : (double) ax: (double) ay: (double) az ;
-(double)getTime;
-(int)getsLoc : (double) locLat: (double) locLong : (double) locAlt : (double) LocHAccuracy :  (double) LocVAccuracy;
@end
