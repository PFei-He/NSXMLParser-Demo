//
//  Demo.m
//  NSXMLParser Demo
//
//  Created by PFei_He on 14-7-25.
//  Copyright (c) 2014年 PFei_He. All rights reserved.
//

#import "Demo.h"

@interface Demo ()
{
    NSMutableString *element;
}

@end

@implementation Demo

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    //获取文本节点中的数据
    element = [[NSMutableString alloc] init];

    //获取xml（本Demo从工程文件中获取）
    NSString *path = [[NSBundle mainBundle] pathForResource:@"NSXMLParserDemo" ofType:@"xml"];
    NSString *xmlContent = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];

    //创建NSXMLParser解析器（NSXMLParser为sax方法）
    NSXMLParser *parse=[[NSXMLParser alloc] initWithData:[xmlContent dataUsingEncoding:NSUTF8StringEncoding]];

    //设置代理
    [parse setDelegate:self];

    //运行解析器（当parser初始化并执行parse语句时([parser parse]),程序会执行(parser:didStartElement:namespaceURI:qualifiedName:attributes:)代理方法
    [parse parse];
}

//解析开始
- (void)parserDidStartDocument:(NSXMLParser *)parser
{

}

//开始处理xml数据（把整个xml遍历一遍，识别元素节点名称）
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict
{
    //判断是否是meeting节点
	if ([elementName isEqualToString:@"meeting"]) {
        //判断属性节点
        if ([attributeDict objectForKey:@"addr"]) {
            //获取属性节点中的值
            NSString *addr=[attributeDict objectForKey:@"addr"];
            NSLog(@"%@", addr);
        }
	}

    //判断member节点
    if ([elementName isEqualToString:@"member"]) {
        NSLog(@"member");
    }
}

//获取文本节点里存储的信息数据
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    //这里要赋值为空，目的是为了清空上一次的赋值
    [element setString:@""];

    //string是获取到的文本节点的值，只要是文本节点都会获取(包括换行)，然后在(parser:didEndElement:namespaceURI:qualifiedName:)代理方法中进行判断区分
    [element appendString:string];
}

//存储从(parser:foundCharacters:)代理方法中获取到的信息
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    NSString *str = [[NSString alloc] initWithString:element];

	if ([elementName isEqualToString:@"creator"]) {
        NSLog(@"creator=%@",str);
    }
    if ([elementName isEqualToString:@"name"]) {
        NSLog(@"name=%@",str);
    }
    if ([elementName isEqualToString:@"age"]) {
        NSLog(@"age=%@",str);
    }
}

//解析结束
- (void)parserDidEndDocument:(NSXMLParser *)parser
{

}

//解析错误
- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{
    NSLog(@"%@",[parseError description]);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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
