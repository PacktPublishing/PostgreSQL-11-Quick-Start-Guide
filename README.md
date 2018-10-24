# PostgreSQL-11-Quick-Start-Guide
Published by Packt, Author Luca Ferrari (fluca1978)

## Content of the repository

This repository contains code examples related to the *"PostgreSQL 11 Server Side Programming Quick Start Guide"* book published by Packt.

### Naming conventions


The repository is organized on a *per-chapter* basis: each chapter in the book will have a corresponding folder within the repository. Each folder contains a set of files named after the chapter number and the listing in the chapter: as an example the listing 3 of chapter 2 is placed in the folder `chapter_2` with the name `Chapter2_Listing03.sql`, that is `chapter_02/Chapter2_Listing03.sql`.


Each file has a suffix corresponding to the type of the file, with main suffixes being:
- `.sql` a script file, either SQL or PL/pgSQL file that can be executed directly into a PostgreSQL prompt (e.g., via `psql(1)`);
- `.java` a Java file;
- `.perl` a Perl 5 file;
- `.output` a text file representing the output of the execution of a command. If the output is shown within the same listing of the command to be executed, its numbering is the same of the command file. As an example, if the following two files both exist:

```
Chapter3_Listing01.sql
Chapter3_Listing01.output
```

it means that the the output file is related to the command in the SQL file, and the two are shown within the same Listing (in this case, numbered 01).

