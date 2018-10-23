//
//  ViewController.m
//  RealmDemo
//
//  Created by Phuc Nguyen on 9/28/18.
//  Copyright © 2018 Phuc Nguyen. All rights reserved.
//

#import <Realm/Realm.h>
#import "ViewController.h"
#import "DemoModel.h"
#import "RealmManager.h"
#import "DBManager.h"

#import "DBManager.h"

#import "EmailMessageModel.h"
#import "TaskModel.h"
#import "NoteModel.h"
#import "EventModel.h"
#import "ContactModel.h"
#import "BookmarkModel.h"
#import "FileModel.h"

@interface ViewController()

// Data view
@property (weak) IBOutlet NSBox *dataView;
@property (weak) IBOutlet NSButton *emailButton;
@property (weak) IBOutlet NSButton *taskButton;
@property (weak) IBOutlet NSButton *noteButton;
@property (weak) IBOutlet NSButton *eventButton;
@property (weak) IBOutlet NSButton *contactButton;
@property (weak) IBOutlet NSButton *bookmarkButton;
@property (weak) IBOutlet NSButton *fileButton;

// Realm view
@property (weak) IBOutlet NSBox *realmView;
@property (weak) IBOutlet NSBox *realmInsertView;
@property (weak) IBOutlet NSTextField *realmInsertTimeStartLabel;
@property (weak) IBOutlet NSTextField *realmInsertTimeEndLabel;
@property (weak) IBOutlet NSTextField *realmInsertResultLabel;

@property (weak) IBOutlet NSBox *realmSelectView;
@property (weak) IBOutlet NSTextField *realmGetAllTimeStartLabel;
@property (weak) IBOutlet NSTextField *realmGetAllTimeEndLabel;
@property (weak) IBOutlet NSTextField *realmGetAllResultLabel;

@property (weak) IBOutlet NSBox *realmDeleteView;
@property (weak) IBOutlet NSTextField *realmDeleteTimeStartLabel;
@property (weak) IBOutlet NSTextField *realmDeleteTimeEndLabel;
@property (weak) IBOutlet NSTextField *realmDeleteResultLabel;

// SQLite view
@property (weak) IBOutlet NSBox *sqliteView;
@property (weak) IBOutlet NSBox *sqliteInsertView;
@property (weak) IBOutlet NSTextField *sqliteInsertTimeStartLabel;
@property (weak) IBOutlet NSTextField *sqliteInsertTimeEndLabel;
@property (weak) IBOutlet NSTextField *sqliteInsertResultLabel;

@property (weak) IBOutlet NSBox *sqliteSelectView;
@property (weak) IBOutlet NSTextField *sqliteGetAllTimeStartLabel;
@property (weak) IBOutlet NSTextField *sqliteGetAllTimeEndLabel;
@property (weak) IBOutlet NSTextField *sqliteGetAllResultLabel;

@property (weak) IBOutlet NSBox *sqliteDeleteView;
@property (weak) IBOutlet NSTextField *sqliteDeleteTimeStartLabel;
@property (weak) IBOutlet NSTextField *sqliteDeleteTimeEndLabel;
@property (weak) IBOutlet NSTextField *sqliteDeleteResultLabel;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupLayout];
    
    [[RealmManager sharedInstance] saveRealmURLPathIntoAppGroup];
}

- (void)setupLayout {
    [self setBorderForView:self.dataView isRadius:YES];
    
    [self setBorderForView:self.realmView isRadius:YES];
    [self setBorderForView:self.realmInsertView isRadius:NO];
    [self setBorderForView:self.realmSelectView isRadius:NO];
    [self setBorderForView:self.realmDeleteView isRadius:NO];
    
    [self setBorderForView:self.sqliteView isRadius:YES];
    [self setBorderForView:self.sqliteInsertView isRadius:NO];
    [self setBorderForView:self.sqliteSelectView isRadius:NO];
    [self setBorderForView:self.sqliteDeleteView isRadius:NO];
}

- (void)setBorderForView:(NSBox *)view isRadius:(BOOL)isRadius {
    view.boxType = NSBoxCustom;
    view.borderWidth = 1;
    view.borderColor = [NSColor lightGrayColor];
    view.borderType = NSGrooveBorder;
    
    if (isRadius) {
        view.cornerRadius = 5;
    }
}

- (void)viewDidAppear {
    [super viewDidAppear];
    
    [self clearData];
    
    RLMRealm *dataRealm = [[RealmManager sharedInstance] getRealmOfData:[[EmailMessageModel alloc] init]];
    
    [dataRealm.configuration setShouldCompactOnLaunch:^BOOL(NSUInteger totalBytes, NSUInteger bytesUsed) {
        // Compact if the file is over 100MB in size or less than 50% 'used'
        NSInteger oneHundredMB = 100 * 1024 * 1024;
        return (totalBytes > oneHundredMB) || (((double)bytesUsed / (double)totalBytes) < 0.5);
    }];
    
    [dataRealm.configuration deleteRealmIfMigrationNeeded];
    
    
    [dataRealm setAutorefresh:YES];
}

#pragma mark - Outlet action
- (IBAction)saveButtonClicked:(id)sender {
    //    DemoModel *demo = [[DemoModel alloc] init];
    //    demo.name = self.nameTextField.stringValue;
    //    demo.address = self.addressTextField.stringValue;
    //    demo.bio = self.bioTextField.stringValue;
    //
    //    [self clearTextFieldata];
    //
    //    RLMRealm *realm = [RLMRealm defaultRealm];
    //    [realm beginWriteTransaction];
    //    [realm addObject:demo];
    //    [realm commitWriteTransaction];
    
    //    id path = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    //
    //    NSLog(@"Henry: %@", path);
    //
    //    NSUserDefaults *userDefault = [[NSUserDefaults alloc] initWithSuiteName:@"RealmDemoAppGroup"];
    //
    //    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    //    dict[@"Henry"] = @"Henry";
    //    [userDefault setPersistentDomain:dict forName:@"Henry"];
    //    [userDefault setVolatileDomain:dict forName:@"Henry"];
    ////    userDefault setdomain
    ////    userDefault registerDefaults:<#(nonnull NSDictionary<NSString *,id> *)#>
    //    NSLog(@"Henry: %@", [userDefault volatileDomainNames]);
    ////    NSLog(@"Henry: %@", [userDefault volatileDomainNames]);
    //
    //
    //    [userDefault setObject:@"Henry" forKey:@"Henry"];
    
    
    
    for (NSInteger i = 0; i < 300000; i++) {
        [[RealmManager sharedInstance] insertData:[[BookmarkModel alloc] init]];
    }
}

- (IBAction)clearButtonClicked:(id)sender {
    //    [self clearTextFieldata];
    BookmarkModel *bookmark = [[BookmarkModel alloc] init];
    
    [[DBManager sharedInstance] insertDemoData:bookmark];
}

- (void)clearTextFieldata {
    //    self.nameTextField.stringValue = @"";
    //    self.addressTextField.stringValue = @"";
    //    self.bioTextField.stringValue = @"";
    
    
    [[RealmManager sharedInstance] deleteAllObjectData:[[BookmarkModel alloc] init]];
}

- (IBAction)showAllButtonClicked:(id)sender {
    //    RLMResults *selectResult = [[RealmManager sharedInstance] selectObjectOfData:[[BookmarkModel alloc] init] predicate:@"syncID CONTAINS 'EE'"];
    //
    //
    //    NSLog(@"Henry: %@", selectResult);
    
    //    for (NSInteger i = 0; i < 10000; i++) {
    //        [[RealmManager sharedInstance] getAllDataOfData:[[BookmarkModel alloc] init]];
    //
    //
    //    }
    //
    //    RLMRealm *realm = [[RealmManager sharedInstance] getRealmOfData:[[BookmarkModel alloc] init]];
    
    
    [[RealmManager sharedInstance] resolveCompactOfData:[[BookmarkModel alloc] init]];
    
    //    [realm compactRealm]
}

- (void)clearData {
    // Data
    self.emailButton.state = NSControlStateValueOff;
    self.taskButton.state = NSControlStateValueOff;
    self.noteButton.state = NSControlStateValueOff;
    self.eventButton.state = NSControlStateValueOff;
    self.contactButton.state = NSControlStateValueOff;
    self.bookmarkButton.state = NSControlStateValueOff;
    self.fileButton.state = NSControlStateValueOff;
    
    // Realm
    self.realmInsertTimeStartLabel.stringValue = @"";
    self.realmInsertTimeEndLabel.stringValue = @"";
    self.realmInsertResultLabel.stringValue = @"0";
    self.realmGetAllTimeStartLabel.stringValue = @"";
    self.realmGetAllTimeEndLabel.stringValue = @"";
    self.realmGetAllResultLabel.stringValue = @"0 Item";
    self.realmDeleteTimeStartLabel.stringValue = @"";
    self.realmDeleteTimeEndLabel.stringValue = @"";
    self.realmDeleteResultLabel.stringValue = @"0";
    
    // SQLite
    self.sqliteInsertTimeStartLabel.stringValue = @"";
    self.sqliteInsertTimeEndLabel.stringValue = @"";
    self.sqliteInsertResultLabel.stringValue = @"0";
    self.sqliteGetAllTimeStartLabel.stringValue = @"";
    self.sqliteGetAllTimeEndLabel.stringValue = @"";
    self.sqliteGetAllResultLabel.stringValue = @"0 Item";
    self.sqliteDeleteTimeStartLabel.stringValue = @"";
    self.sqliteDeleteTimeEndLabel.stringValue = @"";
    self.sqliteDeleteResultLabel.stringValue = @"0";
}

- (NSString *)getTimeStringFromDate:(NSDate *)date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"HH:mm:ss.SSSS";
    
    return [dateFormatter stringFromDate:[NSDate date]];
}

- (NSMutableArray *)getSelectedDataClass {
    NSMutableArray *classArray = [[NSMutableArray alloc] init];
    
    if (self.emailButton.state == NSControlStateValueOn) {
        [classArray addObject:[EmailMessageModel class]];
    }
    
    if (self.taskButton.state == NSControlStateValueOn) {
        [classArray addObject:[TaskModel class]];
    }
    
    if (self.noteButton.state == NSControlStateValueOn) {
        [classArray addObject:[NoteModel class]];
    }
    
    if (self.eventButton.state == NSControlStateValueOn) {
        [classArray addObject:[EventModel class]];
    }
    
    if (self.contactButton.state == NSControlStateValueOn) {
        [classArray addObject:[ContactModel class]];
    }
    
    if (self.bookmarkButton.state == NSControlStateValueOn) {
        [classArray addObject:[BookmarkModel class]];
    }
    
    if (self.fileButton.state == NSControlStateValueOn) {
        [classArray addObject:[FileModel class]];
    }
    
    return classArray;
}

// Data
- (IBAction)resetDataButtonClicked:(id)sender {
    [self clearData];
    
    EmailMessageModel *email = [[EmailMessageModel alloc] init];
    [[RealmManager sharedInstance] resolveCompactOfData:email];
    
    EmailMessageModel *bookmark = [[EmailMessageModel alloc] init];
    
    
    NSMutableArray *itemArray = [[NSMutableArray alloc] init];
    NSDate *date1 = [NSDate date];
    RLMResults *realmResult = [[RealmManager sharedInstance] selectObjectOfData:bookmark predicate:@"title CONTAINS [cd] 'E'"];
    id item = [realmResult objectAtIndex:0];
    
    NSLog(@"Henry: %@", item);
    for (AbstractModel *dataItem in realmResult) {
        [itemArray addObject:dataItem];
    }

    NSDate *date2 = [NSDate date];
//    NSArray *SQLResult = [[DBManager sharedInstance] selectDemoData:bookmark withPredicate:@"title like '%E%'"];

    NSDate *date3 = [NSDate date];
    
    NSLog(@"realm : %f - %ld", [date2 timeIntervalSinceDate:date1], itemArray.count);
//    NSLog(@"sqlite: %f - %ld", [date3 timeIntervalSinceDate:date2], SQLResult.count);
}

- (IBAction)selectAllButtonClicked:(id)sender {
    self.emailButton.state = NSControlStateValueOn;
    self.taskButton.state = NSControlStateValueOn;
    self.noteButton.state = NSControlStateValueOn;
    self.eventButton.state = NSControlStateValueOn;
    self.contactButton.state = NSControlStateValueOn;
    self.bookmarkButton.state = NSControlStateValueOn;
    self.fileButton.state = NSControlStateValueOn;
}

#pragma mark - Realm Outlet
- (IBAction)realmInsert1KButtonClicked:(id)sender {
    self.realmInsertTimeStartLabel.stringValue = @"";
    self.realmInsertTimeEndLabel.stringValue = @"";
    self.realmInsertResultLabel.stringValue = @"0";
    
    NSDate *startDate = [NSDate date];
    self.realmInsertTimeStartLabel.stringValue = [self getTimeStringFromDate:startDate];
    
    
    NSArray *selectedClassArray = [self getSelectedDataClass];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        for (Class classData in selectedClassArray) {
            for (NSInteger i = 0; i < 1000; i++) {
                AbstractModel *data = [[classData alloc] init];
                [[RealmManager sharedInstance] insertData:data];
            }
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSDate *endDate = [NSDate date];
            self.realmInsertTimeEndLabel.stringValue = [self getTimeStringFromDate:endDate];
            
            NSTimeInterval resultTime = [endDate timeIntervalSinceDate:startDate];
            self.realmInsertResultLabel.stringValue = [NSString stringWithFormat:@"%f", resultTime];
        });
    });
}

- (IBAction)realmInsert10KButtonClicked:(id)sender {
    NSDate *startDate = [NSDate date];
    self.realmInsertTimeStartLabel.stringValue = [self getTimeStringFromDate:startDate];
    
    NSArray *selectedClassArray = [self getSelectedDataClass];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        for (Class classData in selectedClassArray) {
            for (NSInteger i = 0; i < 10000; i++) {
                AbstractModel *data = [[classData alloc] init];
                [[RealmManager sharedInstance] insertData:data];
            }
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSDate *endDate = [NSDate date];
            self.realmInsertTimeEndLabel.stringValue = [self getTimeStringFromDate:endDate];
            
            NSTimeInterval resultTime = [endDate timeIntervalSinceDate:startDate];
            self.realmInsertResultLabel.stringValue = [NSString stringWithFormat:@"%f", resultTime];
        });
    });
}

- (IBAction)realmGetAllButtonClicked:(id)sender {
    __block NSInteger numberData = 0;
    
    NSDate *startDate = [NSDate date];
    self.realmGetAllTimeStartLabel.stringValue = [self getTimeStringFromDate:startDate];
    
    NSArray *selectedClassArray = [self getSelectedDataClass];
    
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    
    for (Class classData in selectedClassArray) {
        AbstractModel *data = [[classData alloc] init];
        
        RLMResults *result = [[RealmManager sharedInstance] getAllDataOfData:data];
    
        for (AbstractModel *dataItem in result) {
            [dataArray addObject:dataItem];
        }
        
        numberData = numberData + result.count;
    }
    
//    EmailMessageModel *emailModel = dataArray[0];
    NSLog(@"realmGetAllButtonClicked: %@ - %ld", dataArray, dataArray.count);
    
    NSDate *endDate = [NSDate date];
    self.realmGetAllTimeEndLabel.stringValue = [self getTimeStringFromDate:endDate];
    
    NSTimeInterval resultTime = [endDate timeIntervalSinceDate:startDate];
    self.realmGetAllResultLabel.stringValue = [NSString stringWithFormat:@"%ld Item / %f", numberData, resultTime];
}

- (IBAction)realmDeleteAllButtonClicked:(id)sender {
    NSDate *startDate = [NSDate date];
    self.realmDeleteTimeStartLabel.stringValue = [self getTimeStringFromDate:startDate];
    
    NSArray *selectedClassArray = [self getSelectedDataClass];
    for (Class classData in selectedClassArray) {
        AbstractModel *data = [[classData alloc] init];
        
        [[RealmManager sharedInstance] deleteAllObjectData:data];
    }
    
    NSDate *endDate = [NSDate date];
    self.realmDeleteTimeEndLabel.stringValue = [self getTimeStringFromDate:endDate];
    
    NSTimeInterval resultTime = [endDate timeIntervalSinceDate:startDate];
    self.realmDeleteResultLabel.stringValue = [NSString stringWithFormat:@"%f", resultTime];
}

#pragma mark - SQLite Outlet
- (IBAction)SQLiteInsert1KButtonClicked:(id)sender {
    self.sqliteInsertTimeStartLabel.stringValue = @"";
    self.sqliteInsertTimeEndLabel.stringValue = @"";
    self.sqliteInsertResultLabel.stringValue = @"0";
    
    NSDate *startDate = [NSDate date];
    self.sqliteInsertTimeStartLabel.stringValue = [self getTimeStringFromDate:startDate];
    
    NSArray *selectedClassArray = [self getSelectedDataClass];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        for (Class classData in selectedClassArray) {
            for (NSInteger i = 0; i < 1000; i++) {
                AbstractModel *data = [[classData alloc] init];
                [[DBManager sharedInstance] insertDemoData:data];
            }
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSDate *endDate = [NSDate date];
            self.sqliteInsertTimeEndLabel.stringValue = [self getTimeStringFromDate:endDate];
            
            NSTimeInterval resultTime = [endDate timeIntervalSinceDate:startDate];
            self.sqliteInsertResultLabel.stringValue = [NSString stringWithFormat:@"%f", resultTime];
        });
    });
}

- (IBAction)SQLiteInsert10KButtonClicked:(id)sender {
    NSDate *startDate = [NSDate date];
    self.sqliteInsertTimeStartLabel.stringValue = [self getTimeStringFromDate:startDate];
    
    NSArray *selectedClassArray = [self getSelectedDataClass];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        for (Class classData in selectedClassArray) {
            for (NSInteger i = 0; i < 10000; i++) {
                AbstractModel *data = [[classData alloc] init];
                [[DBManager sharedInstance] insertDemoData:data];
            }
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSDate *endDate = [NSDate date];
            self.sqliteInsertTimeEndLabel.stringValue = [self getTimeStringFromDate:endDate];
            
            NSTimeInterval resultTime = [endDate timeIntervalSinceDate:startDate];
            self.sqliteInsertResultLabel.stringValue = [NSString stringWithFormat:@"%f", resultTime];
        });
    });
}

- (IBAction)SQLiteGetAllButtonClicked:(id)sender {
    __block NSInteger numberData = 0;
    
    NSDate *startDate = [NSDate date];
    self.sqliteGetAllTimeStartLabel.stringValue = [self getTimeStringFromDate:startDate];
    
    NSArray *selectedClassArray = [self getSelectedDataClass];
    for (Class classData in selectedClassArray) {
        AbstractModel *data = [[classData alloc] init];
        NSArray *result = [[DBManager sharedInstance] getAllDemoData:data];
        
        numberData = numberData + result.count;
    }
    
    NSDate *endDate = [NSDate date];
    self.sqliteGetAllTimeEndLabel.stringValue = [self getTimeStringFromDate:endDate];
    
    NSTimeInterval resultTime = [endDate timeIntervalSinceDate:startDate];
    self.sqliteGetAllResultLabel.stringValue = [NSString stringWithFormat:@"%ld Item / %f", numberData, resultTime];
}

- (IBAction)SQLiteDeleteAllButtonClicked:(id)sender {
    NSDate *startDate = [NSDate date];
    self.sqliteDeleteTimeStartLabel.stringValue = [self getTimeStringFromDate:startDate];
    
    NSArray *selectedClassArray = [self getSelectedDataClass];
    for (Class classData in selectedClassArray) {
        AbstractModel *data = [[classData alloc] init];
        [[DBManager sharedInstance] deleteDemoData:data];
    };
    
    NSDate *endDate = [NSDate date];
    self.sqliteDeleteTimeEndLabel.stringValue = [self getTimeStringFromDate:endDate];
    
    NSTimeInterval resultTime = [endDate timeIntervalSinceDate:startDate];
    self.sqliteDeleteResultLabel.stringValue = [NSString stringWithFormat:@"%f", resultTime];
}

@end
