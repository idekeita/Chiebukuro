//
//  QuestionListViewController.m
//  Chiebukuro
//
//  Created by IDE KEITA on 2014/09/07.
//  Copyright (c) 2014年 IDE KEITA. All rights reserved.
//

#import "QuestionListViewController.h"

@interface QuestionListViewController ()
@property (strong, nonatomic) NSArray *questions;
@end

@implementation QuestionListViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self fetchNewQuestions];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)fetchNewQuestions
{
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURL *url = [NSURL URLWithString:@"http://chiebukuro.yahooapis.jp/Chiebukuro/V1/getNewQuestionList?appid=&condition=open&results=20&output=json"];
    
    /*
    NSURLSessionDataTask *task =
    [session dataTaskWithURL:url
           completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                   if (error)
                   {
                       return;
                   }
                   
                   NSError *jsonError = nil;
                   NSDictionary *jsonDictionary =
                   [NSJSONSerialization JSONObjectWithData:data
                                                   options:0
                                                   error:&jsonError];
                   
                   if (jsonError != nil) return;
                   
                   self.questions = jsonDictionary[@"ResultSet"][@"Result"];
                   
//                   [self performSelectorOnMainThread:@selector(reloadTableView)
//                                          withObject:nil
//                                          waitUntilDone:YES];
               
               [self performSelectorOnMainThread:@selector(reloadTableView) withObject:nil waitUntilDone:YES];
               }];
    */
    NSURLSessionDataTask *task =
    [session dataTaskWithURL:url
           completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
     {
         if (error)
         {
             // 通信が異常終了したときの処理
             return;
         }
         
         // 通信が正に常終了したときの処理
         NSError *jsonError = nil;
         NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
         
         // JSONエラーチェック
         if (jsonError != nil) return;
         
         // 検索結果をディクショナリにセット
         self.questions = jsonDictionary[@"ResultSet"][@"Result"];
         
         // TableView をリロード
         // メインスレッドでやらないと最悪クラッシュする
         [self performSelectorOnMainThread:@selector(reloadTableView) withObject:nil waitUntilDone:YES];
     }];
    
    [task resume];
}

// テーブルビューを再描画する
- (void)reloadTableView
{
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self.questions count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
//    cell.textLabel.text = self.questions[indexPath.row];
    
    NSDictionary *question = self.questions[indexPath.row];
    
    cell.textLabel.text = question[@"Content"];
    cell.detailTextLabel.text = question[@"Category"];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
