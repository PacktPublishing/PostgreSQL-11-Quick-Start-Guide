# PostgreSQL 11 Server Side Programming Quick Start Guide

This repository contains code examples related to the book 
**[PostgreSQL 11 Server Side Programming Quick Start Guide](https://www.packtpub.com/big-data-and-business-intelligence/postgresql-11-server-side-programming-quick-start-guide)** 
published by [Packt](https://www.packtpub.com/), 
author [Luca Ferrari (fluca1978)](https://fluca1978.github.io)

[![PostgreSQL-11-ServerSideProgramming-cover-image](/images/cover.png)](https://www.packtpub.com/big-data-and-business-intelligence/postgresql-11-server-side-programming-quick-start-guide)

## Table of Contents

The book is organized in 10 chapters:

- *Chapter 1*, **Introduction to Server Side Programming**;
- *Chapter 2*, **Query Tricks**;
- *Chapter 3*, **The PL/pgSQL Language**;
- *Chapter 4*, **Stored Procedures**;
- *Chapter 5*, **PL/Perl and PL/Java**;
- *Chapter 6*, **Triggers**;
- *Chapter 7*, **Rules and the Query Rewriting System**;
- *Chapter 8*, **Extensions**;
- *Chapter 9*, **Intra-Process Communications**;
- *Chapter 10*, **Custom Data Types**;

The code contained in this repository is organized with regard to above table of contents.

## Naming conventions

Each chapter in the book has a corresponding folder within the repository. Each folder contains a set of files named after the chapter number and the listing in the chapter: as an example the listing 3 of chapter 2 is placed in the folder `chapter_2` with the name `Chapter2_Listing03.sql`, that is `chapter_02/Chapter2_Listing03.sql`.


Each file has a suffix corresponding to the type of the file, with main suffixes being:
- `.sql` a script file, either SQL or PL/pgSQL file that can be executed directly into a PostgreSQL prompt (e.g., via `psql(1)`);
- `.java` a Java file;
- `.perl` a Perl 5 file;
- `.output` a text file representing the output of the execution of a command. If the output is shown within the same listing of the command to be executed, its numbering is the same of the command file. As an example, if the following two files both exist:

```
Chapter3_Listing01.sql
Chapter3_Listing01.output
```

it means that the the output file is related to the command in the SQL file, and the two are shown within the same Listing `01`.

