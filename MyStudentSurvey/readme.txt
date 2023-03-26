URL:
https://ec2-35-153-51-26.compute-1.amazonaws.com/surveyform/
http://swe-645-assignment1.s3-website-us-east-1.amazonaws.com/

Steps to launch survey form webpage on AWS EC2 machine using Tomcat server:
1. Create the index.html and style.css files that contains the code for the survey form.
2. Open AWS console and create an EC2 instance using the "tomcat by bitnami" AMI.
3. While creating the instance create a key-pair and keep in your local system.
4. After the instance is started, open ssh on your local computer, switch to the folder that has the key-pair that was downloaded.
5. Use the command : chmod 400 newKey.pem to change permissions on the key-pair file.
6. Then use the command: ssh -i key-new.pem bitnami@ec2-54-88-220-123.compute-1.amazonaws.com where bitnami is the username and ec2-54-88-220-123.compute-1.amazonaws.com is the public DNS.
7. Once the host is connected we can now use the command "sudo su" to go to the root directory.
8. Use cd command to go to the webapps folder which is in the apache-tomcat folder.
9. Comment the line <!--
<Valve className="org.apache.catalina.valves.RemoteAddrValve" allow="127\.\d+\.\d+\.\d+|::1|0:0:0:0:0:0:0:1" />
--> in the context.xml file
10. Now when you open the public dns the tomcat should be up and running and go to manager and upload the .war file and click deploy.
11. Now when you add /surveyform in the address after the dns address you should be able to see the survey form.