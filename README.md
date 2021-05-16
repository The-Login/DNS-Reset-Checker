# DNS Reset Checker
Tools to assess the DNS security of web applications.
# Background
DNS security of web applications? Why is this important?  
As recently discovered in my diploma thesis, some web applications have a vulnerable DNS name resolution. Functionalities that rely on the DNS can therefore be attacked. This includes sending **e-mails**.  
If a web application has a "Forgot password?" feature, password reset URLs are most likely sent via **e-mail**. See the problem?  
A successful attack on the DNS name resolution of a web application can therefore lead to the takover of user accounts.  
All of this is summarized in the following image:  
![DNS 5(1)_2](https://user-images.githubusercontent.com/84237895/118402283-8559ac80-b669-11eb-962a-6e96e4e97b4c.jpg)


Now, to check for vulnerabilities in the DNS name resolution of a webapplication, the **DNS Reset Checker** comes into play.

# Requirements
* A server (e.g. AWS EC2)
* A domain (you must be able to set your server as authoritative name server of this domain)
* docker
* docker-compose
* A browser

# Installation and usage
The **DNS Reset Checker** consists of an authoritative DNS analysis server and a log analyzer.  
Their usage and the general testing procedure is described in the following image:
![Blog Post (2)](https://user-images.githubusercontent.com/84237895/118402797-d074bf00-b66b-11eb-8d30-c39f43808e6c.png)

