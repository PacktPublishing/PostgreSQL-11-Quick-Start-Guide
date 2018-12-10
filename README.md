# PostgreSQL 11 Server Side Programming Quick Start Guide

<a href="https://www.packtpub.com/big-data-and-business-intelligence/postgresql-11-server-side-programming-quick-start-guide?utm_source=github&utm_medium=repository&utm_campaign=9781789342222"><img src="https://dz13w8afd47il.cloudfront.net/sites/default/files/imagecache/ppv4_main_book_cover/B11208.png" alt="PostgreSQL 11 Server Side Programming Quick Start Guide" height="256px" align="right"></a>

This is the code repository for [PostgreSQL 11 Server Side Programming Quick Start Guide](https://www.packtpub.com/big-data-and-business-intelligence/postgresql-11-server-side-programming-quick-start-guide?utm_source=github&utm_medium=repository&utm_campaign=9781789342222), published by Packt.

**Effective database programming and interaction**

## What is this book about?
PostgreSQL is a rock-solid, scalable, and safe enterprise-level relational database. With a broad range of features and stability, it is ever increasing in popularity.This book shows you how to take advantage of PostgreSQL 11 features for server-side programming. Server-side programming enables strong data encapsulation and coherence.

This book covers the following exciting features: 
* Explore data encapsulation
* Write stored procedures in different languages
* Interact with transactions from within a function
* Get to grips with triggers and rules
* Create and manage custom data types

If you feel this book is for you, get your [copy](https://www.amazon.com/dp/1789342228) today!

<a href="https://www.packtpub.com/?utm_source=github&utm_medium=banner&utm_campaign=GitHubBanner"><img src="https://raw.githubusercontent.com/PacktPublishing/GitHub/master/GitHub.png" 
alt="https://www.packtpub.com/" border="5" /></a>


## Instructions and Navigations
All of the code is organized into folders. For example, Chapter02.

The code will look like the following:
```
ImgRes* new_ImgRes() {
  ImgRes* new_object = (ImgRes*) palloc( sizeof( ImgRes ) );
  new_object->h_px = 300;
  new_object->v_px = 300;
  new_object->dpi  = 96;
  return new_object;
}

char* to_string( ImgRes* object ){
```

**Following is what you need for this book:**
This book is for database administrators, data engineers, and database engineers who want to implement advanced functionalities and master complex administrative tasks with PostgreSQL 11.

With the following software and hardware list you can run all code files present in the book (Chapter 1-11).

### Software and Hardware List

| Chapter  | Software required                   | OS required                        |
| -------- | ------------------------------------| -----------------------------------|
| 1-11     | PostgreSQL 11                       | Unix or Linux (Any)                |
| 4-5      | Perl 5 (5.27.8 or higher)           | Unix or Linux (Any)                |
| 4-5      | Java JDK (version 8, update 181)    | Unix or Linux (Any)                |

### Related products <Paste books from the Other books you may enjoy section>
* Learning PostgreSQL 10 - Second Edition [[Packt]](https://india.packtpub.com/in/big-data-and-business-intelligence/learning-postgresql-10-second-edition?utm_source=github&utm_medium=repository&utm_campaign=9781788392013) [[Amazon]](https://www.amazon.com/dp/1788392019)

* PostgreSQL 10 Administration Cookbook [[Packt]](https://india.packtpub.com/in/big-data-and-business-intelligence/postgresql-10-administration-cookbook?utm_source=github&utm_medium=repository&utm_campaign=9781788474924) [[Amazon]](https://www.amazon.com/dp/1788474929)

## Get to Know the Author
**Luca**
has been passionate about computer science since the Commodore 64 era, and today holds a master's degree (with honors) and a PhD from the University of Modena and Reggio Emilia. He has written several research papers, technical articles, and book chapters.
In 2011, he was named Adjunct Professor by the University of Nipissing. An avid Unix user, he is a strong advocate of open source, and in his free time he collaborates with a few projects. He met PostgreSQL back in release 7.3; he was a founder and former president of the Italian PostgreSQL Community (ITPUG), he talks regularly at technical conferences and events, and delivers professional training. In his teenage years, he was quite a proficient archer. He lives in Italy with his beautiful wife, son, and two (female) cats.

### Suggestions and Feedback
[Click here](https://docs.google.com/forms/d/e/1FAIpQLSdy7dATC6QmEL81FIUuymZ0Wy9vH1jHkvpY57OiMeKGqib_Ow/viewform) if you have any feedback or suggestions.
