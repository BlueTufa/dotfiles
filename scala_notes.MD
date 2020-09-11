# Fun stuff I've learned since starting the new job
* SQL := assignment.  Use this to prevent SQL from accidentally evaluating your assignments as boolean.
* http://www.foundweekends.org/giter8/ - Use Giter8 to generate source from github templates
* https://dzone.com/articles/the-levenshtein-algorithm-1#:~:text= Levenshtein distance algorithm
* http://pad.haroopress.com/ Haroopad.  For editing markdown.
* Typora `brew cask install typora` For editing markdown.
* EasyRes for screen resolution switching during presentations.
* draw.io for drawing stuff

## Scala specific
* Don't mix AKKA versions
* Research futures
* use flatmap instead of for

# Common build.sbt settings:
For referencing test packages:
"livongo" %% "core-libraries" % coreLibsVersion % "test" classifier "tests",

## sbt debugging
logLevel := Level.Debug

## Debezium Debugging
```
mysqlbinlog --base64-output=decode-rows --verbose --database=kafka /var/lib/mysql/bin.000004
```
