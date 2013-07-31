//
//  StatsScreen.h
//  FitNexus
//
//  Created by keith on 07/09/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
//#import "DataBaseControler.h"
#import "statsView.h"
#import "LocationGetter.h"
//#import "DataBaseControler.h"
@interface StatsScreen : UIViewController {
IBOutlet statsView *myStatsView;
	IBOutlet MKMapView *myMap;
	//DataBaseControler *myDBControler;
	CLLocationCoordinate2D location;
	LocationGetter *myLocationGetter;
	
	NSTimer *repeatingTimer;
	
	IBOutlet UILabel *livesLabel;
	IBOutlet UILabel *scoreLabel;

	int locIndex;
	double baseTime;
	
	
	
	
	
}
//@property (retain, nonatomic) DataBaseControler *myDBControler;
@property (retain,nonatomic) statsView *myStatsView;
@property (retain, nonatomic) MKMapView *myMap;
@property (assign) NSTimer *repeatingTimer;

@property (retain, nonatomic) UILabel *livesLabel;
@property (retain, nonatomic) UILabel *scoreLabel;


@property (retain, nonatomic) LocationGetter *myLocationGetter;

-(int)setAT : (double) value : (int) index; 
-(int)setAX : (double) value : (int) index; 
-(int)setAY : (double) value : (int) index; 
-(int)setAZ : (double) value : (int) index; 

-(int)setLT : (double) value : (int) index; 
-(int)setLLat : (double) value : (int) index; 
-(int)setLLong : (double) value : (int) index;

-(int)getsLoc : (double) locLat: (double) locLong : (double) locAlt : (double) LocHAccuracy :  (double) LocVAccuracy;


- (void)tick;
- (void)updateMap;


@end
