@echo off
cd /d C:\stupidspeed\exec\clojure
java -cp "C:\stupidspeed\tools\clojure\clojure-1.12.0.jar;C:\stupidspeed\tools\clojure\spec.alpha-0.5.238.jar;C:\stupidspeed\tools\clojure\core.specs.alpha-0.4.74.jar" clojure.main %1.clj
