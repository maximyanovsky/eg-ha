#!/bin/bash
mvn install:install-file -Dfile=libs/SwiftSuspenders-v1.6.0.swc -DartifactId=swiftsuspenders -DgroupId=org.swiftsuspenders -Dversion=1.6.0 -Dpackaging=swc
mvn install:install-file -Dfile=libs/flexunit-4.2.0-20140410-as3_4.12.0.swc -DgroupId=com.adobe.flexunit -DartifactId=flexunit -Dversion=4.2.0 -Dpackaging=swc -Dclassifier=flex
mvn install:install-file -Dfile=libs/hamcrest-as3-flex-1.1.3.swc -DgroupId=org.hamcrest -DartifactId=hamcrest-as3 -Dversion=1.1.3 -Dpackaging=swc -Dclassifier=flex
mvn install:install-file -Dfile=libs/mockolate-0.12.4-as3.swc -Dversion=0.12.4 -Dclassifier=flex -Dpackaging=swc -DgroupId=mockolate -DartifactId=mockolate