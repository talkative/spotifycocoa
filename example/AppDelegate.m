#import "AppDelegate.h"

const uint8_t g_appkey[] = {
	0x01, 0x06, 0xBA, 0x5E, 0x71, 0xA7, 0xF1, 0x1E, 0x82, 0x76, 0x7C, 0x47, 0xDC, 0x0F, 0x56, 0xBC,
	0x3F, 0x8E, 0x88, 0x75, 0xE4, 0x0E, 0xBE, 0xEB, 0xAC, 0xD3, 0xA9, 0x09, 0x1B, 0x72, 0xDE, 0x5F,
	0x79, 0x3D, 0x7D, 0x9B, 0x09, 0xDC, 0xA4, 0xA1, 0x01, 0xC1, 0x1A, 0x12, 0xFD, 0xBC, 0xB5, 0xEB,
	0x7D, 0x18, 0xBC, 0x80, 0xAD, 0x16, 0xB1, 0x32, 0x89, 0xA8, 0x82, 0xA6, 0x2C, 0xAA, 0x93, 0x94,
	0x08, 0x57, 0x40, 0x7F, 0x7D, 0x22, 0x1E, 0xE4, 0x55, 0x4D, 0x95, 0xC4, 0x2A, 0xEB, 0x97, 0xE0,
	0xD4, 0x96, 0xD2, 0xC6, 0x73, 0xEE, 0x13, 0x96, 0x11, 0xF3, 0x48, 0x32, 0x77, 0xA2, 0x5A, 0xAC,
	0xC2, 0xD2, 0xBD, 0xC0, 0xC6, 0xE3, 0xC2, 0xDB, 0xCF, 0xBD, 0x1B, 0x4A, 0xA0, 0x01, 0x85, 0x2F,
	0x01, 0xB3, 0x4A, 0x75, 0x17, 0x33, 0x87, 0x7F, 0x8F, 0xAB, 0x26, 0xF1, 0xE1, 0x48, 0x6F, 0x6C,
	0xF0, 0x2F, 0x23, 0x47, 0xE7, 0xA9, 0xB9, 0x96, 0x99, 0xF2, 0x7D, 0x5B, 0x15, 0x01, 0x4B, 0x01,
	0xFF, 0x13, 0x92, 0x04, 0x7F, 0x4F, 0x0F, 0x84, 0xEC, 0x73, 0x36, 0x53, 0x23, 0x93, 0xC9, 0xD0,
	0x95, 0x5A, 0x77, 0x15, 0xF1, 0xE6, 0xF9, 0x9E, 0x80, 0x8D, 0x82, 0x3C, 0x97, 0xF3, 0x61, 0xAE,
	0xA7, 0x44, 0x22, 0xDA, 0x61, 0x12, 0xC5, 0xEB, 0x44, 0x41, 0xE2, 0x11, 0x68, 0x04, 0x43, 0x9A,
	0x12, 0xF7, 0x7C, 0xD3, 0xD8, 0x0A, 0x11, 0x4D, 0xB5, 0xA3, 0xCF, 0x4C, 0x46, 0x2F, 0x53, 0x78,
	0x90, 0x0C, 0x80, 0x71, 0x90, 0x23, 0x27, 0x9E, 0x36, 0xCE, 0x48, 0xA1, 0x32, 0x48, 0x1D, 0xF5,
	0xB2, 0x80, 0xE7, 0x87, 0xA0, 0xA0, 0x96, 0x23, 0x95, 0xDF, 0x1F, 0x22, 0x30, 0xA8, 0x54, 0xD2,
	0x5A, 0x04, 0x07, 0x28, 0xB9, 0xCF, 0x20, 0x5D, 0x38, 0x81, 0x46, 0x8C, 0x3A, 0x58, 0x61, 0x7F,
	0x49, 0xE4, 0x25, 0xC7, 0x43, 0xF8, 0x85, 0xC6, 0x6B, 0x43, 0x2F, 0x99, 0xBD, 0x3A, 0x48, 0xE8,
	0xCB, 0x90, 0xC7, 0x74, 0x57, 0x29, 0xC2, 0xF0, 0xD2, 0x36, 0xA3, 0x46, 0xE1, 0x45, 0x58, 0x15,
	0x3B, 0xEE, 0x94, 0x04, 0x62, 0x30, 0xE0, 0xA5, 0x41, 0x81, 0xD0, 0x5E, 0x04, 0x69, 0xD6, 0x4F,
	0xA7, 0xDD, 0x03, 0xF7, 0xF6, 0x9C, 0x4A, 0x67, 0xEF, 0x8A, 0xF3, 0x0F, 0xB7, 0x62, 0xAD, 0x25,
	0x3C,
};


@implementation AppDelegate

@synthesize window=_window,
            usernameTextField=_usernameTextField,
						passwordTextField=_passwordTextField;

- (void)applicationWillFinishLaunching:(NSNotification *)notification {
	//setup app key etc
	[SPSession setupWithApplicationKey:g_appkey
														ofLength:sizeof(g_appkey)
											 cacheLocation:self.cacheDirectory
										settingsLocation:self.supportDirectory
													 userAgent:@"SpotifyCocoa example1"];
}

- (void)applicationDidFinishLaunching:(NSNotification *)not {
	_session = [SPSession sharedSession];
	_session.delegate = self;
}

- (IBAction)login:(id)sender {
	NSString *username = [_usernameTextField stringValue];
	NSString *passphrase = [_passwordTextField stringValue];
	NSError *error = nil;
	if (![_session signInUserNamed:username withPassphrase:passphrase error:&error]) {
		NSLog(@"Failed to commence login: %@", error);
	}
}

#pragma mark -
#pragma mark Properties

- (NSString *)supportDirectory {
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
	NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : NSTemporaryDirectory();
	return [basePath stringByAppendingPathComponent:@"SpotifyCocoaExample"];
}

- (NSString *)cacheDirectory {
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : NSTemporaryDirectory();
	return [basePath stringByAppendingPathComponent:@"com.spotify.spotifycocoa.example"];
}

#pragma mark -
#pragma mark SPSession delegate methods

- (void)sessionDidBegin:(SPSession *)session {
	NSLog(@"Logged in as user %@", session.user);
}



- (void)session:(SPSession *)session setupError:(NSError *)error {
	NSLog(@"session setup failed: %@", error);
}

- (void)session:(SPSession *)session connectionError:(NSError *)error {
	NSLog(@"connection error: %@", error);
}

- (void)session:(SPSession *)session singInError:(NSError *)error {
	NSLog(@"Failed to sign in: %@", error);
}

@end
