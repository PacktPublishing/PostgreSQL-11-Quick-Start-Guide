# PostgreSQL-11-Quick-Start-Guide
Published by Packt, Author Luca Ferrari (fluca1978)

## Content of the repository

This repository contains code examples related to the *"PostgreSQL 11 Server Side Programming Quick Start Guide"* book published by Packt.

### Naming conventions

The repository is organized on a *per-chapter* basis: each chapter in the book will have a corresponding folder within the repository. Each folder contains a set of files named after the chapter number and the listing in the chapter: as an example the listing 3 of chapter 2 is placed in the folder `2` with the name `2_03.sql`, that is `2/2_03.sql`.

Each file has a suffix corresponding to the type of the file, with main suffixes being:
- `.sql` a script file, either SQL or PL/pgSQL file that can be executed directly into a PostgreSQL prompt (e.g., via `psql(1)`);
- `.java` a Java file;
- `.perl` a Perl 5 file;
- `.output` a text file representing the output of the execution of the corresponding script/program file. Each output file is named after the corresponding input file, so for instance the file `3_05.output` represents the output obtained when executing the `3_05.sql` file.
