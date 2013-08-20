
AUTO_VERSION=`grep app.grails.version application.properties` 
AUTO_VERSION=${AUTO_VERSION:19}

gvm use grails $AUTO_VERSION
