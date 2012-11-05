API, Web-Service
================

This repository contain:
* The source code of the Web-Service (`ws`)
* the database schema (`db`)

The full documentation of the API is available in the __Doc__ repository.
This documentation is private. It contains all necessary information about the API and the Web-Service.
* https://github.com/LaVieEstUnJeu/Doc


The public documentation of the API will be available soon on its own public repository.
It will also contains samples of code on how to use the Web-Service using main web languages and maybe other languages.
This future documentation will also introduce basic principles about web-services.
* https://github.com/LaVieEstUnJeu/Public-API

***

Install the database
====================

### PostgreSQL

* Install and configure PostgreSQL:
  * http://wiki.postgresql.org/wiki/Main_Page
* Create a new database using `createdb`
* Info: your password for postgres is the same as your unix password

### Install our database

```shell
$> psql thedatabase < db/life.sql
```
* Make sure that the user who will launch the Ocsigenserver has the required rights on the database.

### Ocsigen

The Web-Service, as well as the website, is made with __Ocsigen__, a powerful Web server and framework in __OCaml__.
* http://ocsigen.org/

### Macaque

To handle the database, we use the __Macaque__ project:
* http://ocsigen.org/macaque/dev/manual/

Macaque require a thread library to manage queries. We chose Lwt:
* http://ocsigen.org/lwt/

When you install Ocsigen using the __bundle__, make sure to install Macaque and the full version of Lwt at the same time:
```shell
$> ./configure --enable-macaque --enable-lwt-all
```

Install the Web-Service
=======================

### Install the required modules:

* Calendar
  * http://calendar.forge.ocamlcore.org/

  You will probably not have to install it as it is installed with Ocsigen.

* YoJson
  * http://mjambon.com/yojson.html

  Install these modules:
  * http://mjambon.com/releases/biniou
  * http://mjambon.com/releases/easy-format
  * http://mjambon.com/releases/cppo
  * http://mjambon.com/releases/yojson


* You can check if a module is well installed using:

```shell
$> ocamlfind query yojson
```

Sometimes, the module is installed but not in the right directory. You can add a path to ocamlfind or re-install it in the correct directory.

* Install the others external modules and generate the configuration file using the command:

```shell
$> ./install.sh
```

Don't forget to re-launch the `install.sh` when you get the latest version of the project.

Compile/Launch the Web-Service
==============================

* Compile the project using `make`
* If the compilation is not working, make sure that all the required modules are installed and the configuration file is correct
* Launch the server:

```shell
$> ocsigenserver -c api.conf
```

***

Developers guide
================

Coding Style
------------

The Web-Service follow the same coding style as the website:
* https://github.com/LaVieEstUnJeu/Website

Files
-----

* The `db` folder contains the database schema.
* The `ws` folder contains the source code of the Web-Service

#### Db

The file `db.eliom` contains the module Db, with functions that handle the database initialization and actions.

* In this file, the database is initialized using information in the configuration file. If these information are invalid (miss argument, wrong password, the database does not exists, ...), the web-service will stop at its launchment.
* The function `query` take a Macaque query as a parameter and return its result. You should use this function and not try to manage database actions by yourself.
* The function `select_first` take a select query and return only the first row. It can raise an exception if the select query has no result.

```ocaml
let get_user_from_login login =
  Db.select_first
    (<:select<
        row | row in $table$ ; row.login = $string:login$ >>)
```

#### EliomJson

The file `eliomJson.eliom` contains the module EliomJson. This module allows you to create Ocsigen Services that return JSON.

The function `register_service` take in parameter a JSON tree of type `Yojson.Basic.json`.

```ocaml
open Eliom_parameter

let _ =
  EliomJson.register_service
    ~path:[]
    ~get_params:unit
    (fun () () ->
      Lwt.return
        (`String "Hello World!"))
```

#### API queries, seperated into categories

Each category of queries has its own module.

Examples of categories:
* User
* Achievement
* Achievement_category
* Search
* Auth
* Activity_comment
* Media
* Country
* Locale

In these files, you will find:
* The Macaque representation of the database table
* Services for queries ("methods") that will get parameters, handle database queries and return a JSON tree

***


Copyright/License
=================

     Copyright 2012 Barbara Lepage
  
     Licensed under the Apache License, Version 2.0 (the "License");
     you may not use this file except in compliance with the License.
     You may obtain a copy of the License at
  
         http://www.apache.org/licenses/LICENSE-2.0
  
     Unless required by applicable law or agreed to in writing, software
     distributed under the License is distributed on an "AS IS" BASIS,
     WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
     See the License for the specific language governing permissions and
     limitations under the License.


### Author

* "LaVieEstUnJeu" project team.
* About us: http://eip.epitech.eu/2014/lavieestunjeu/
* Contributors: db0, Tuxkowo

### Up to date

Latest version of this project is on GitHub:
* https://github.com/LaVieEstUnJeu/API



