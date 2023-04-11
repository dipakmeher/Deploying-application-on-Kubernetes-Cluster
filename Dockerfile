# GroupName: TeamCDN Chaitra Bekal, Dipak Meher, Nishad Main)
# Docker builds image for the given war file by reading the below commands from this docker file
FROM tomcat:9.0-jdk15
COPY StudentSurvey_DipakMeher645.war /usr/local/tomcat/webapps/
