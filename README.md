# JSON to Database
**JSONtoDB** is a command-line tool allowing HTTP methods to be called from a terminal or other program.  It was originally intended
to be used to send requests from a client computer to a [Wordpress](https://wordpress.com/) server using the [REST-API plugin](https://wordpress.org/plugins/rest-api/).

## Installation
To install, use the standard RubyGems syntax:
```sh
$ gem install jsontodb
```
Or if necessary, you can add it to your `Gemfile`:
```rb
gem 'jsontodb'
```

## Usage
**JSONtoDB** provides a command-line interface, which can be invoked using:
```sh
$ jsontodb
```
This command will open an interactive shell for **JSONtoDB** after prompting for authentication credentials (see [Authentication](#authentication)).

You can also pass your authentication credentials to the command then open an interactive shell:
```sh
$ jsontodb [username] [password]
```

Running a full **JSONtoDB** command is possible directly from the command-line as well:
```sh
$ jsontodb [username] [password] [command]
```

Functionality is planned for placing credentials in a file to avoid passwords being visible, as they are when passed to the `jsontodb` command (though
they are hidden in the interactive shell).

## Commands
Four commands are provided by default, and they represent their respective HTTP method:

### Get
Get represents the GET HTTP method, and its only parameter is the URL to GET:
```sh
$ [parent command] get [url]
```

### Delete
Delete represents the DELETE HTTP method, and its only parameter is the URL to DELETE:
```sh
$ [parent command] delete [url]
```

### Put
Put represents the PUT HTTP method.  Its first parameter is the URL to PUT to, and its second parameter is the source of the data (a file path, see [Source Files](#source-files)):
```sh
$ [parent command] put [url] [source file]
```

### Post
Post represents the POST HTTP method.  Its first parameter is the URL to POST to, and its second parameter is the source of the data (a file path, see [Source Files](#source-files)):
```sh
$ [parent command] post [url] [source file]
```

## Source Files
The only source data type (or content type) that **JSONtoDB** currently supports is [JSON](http://www.json.org/), hence the name **JSONtoDB**.

## Authentication
**JSONtoDB** offers basic authentication capabilities.  If you are using the interactive shell mode, it will prompt for credentials.  Otherwise, you
can pass them in as the first two parameters to the `jsontodb` command.

## Copyright
Copyright (c) 2016 Christopher Lutz. See [LICENSE.txt](LICENSE.txt) for details.
