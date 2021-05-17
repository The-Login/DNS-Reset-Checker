# DNS Reset Checker
Tools to assess the DNS security of web applications.
## Background
### DNS security of web applications? What?  
The DNS is a central part of many functionalities of a web application. This includes sending **e-mails**. If a web application wants to send an e-mail, the e-mail domain first needs to be resolved to an IP address. This is done via a DNS name resolution.  
**But what happens, if this DNS name resolution is vulnerable?**  
In this case, an attacker could manipulate the resolution of the e-mail domain. This furthermore means, that e-mails can be redirected to an attacker e-mail server, instead of the actual e-mail server.  
This concept is summarized in the following image:  
![DNS 5(1)_2](https://user-images.githubusercontent.com/84237895/118402283-8559ac80-b669-11eb-962a-6e96e4e97b4c.jpg)
  
### An attacker can receive e-mails, so what?
Among newsletters and account notifications there is one functionality that almost always uses e-mails:  
The "Forgot password?" feature.  
A successful attack on the DNS name resolution of a web application can therefore lead to the takover of user accounts.  
This attack concept is not new and has already been discussed back in 2008 when Dan Kaminsky "broke" the DNS. However, as recently discovered in my diploma thesis, some web applications still have a vulnerable DNS name resolution.  
Now, to check for vulnerabilities in the DNS name resolution of a webapplication, the **DNS Reset Checker** comes into play.  
  
*A more in-depth look at the DNS security of web applications and the inner workings of the DNS Reset Checker can be found [here](https://sec-consult.com).*
## Requirements and Installation
For a complete setup of the DNS Reset Checker the following components are required:
* A server (e.g. AWS EC2)
* A domain (you must be able to set your server as authoritative name server of this domain)
* docker
* docker-compose
* A browser

The installation requires the following steps to be done:
1. Set the server as the authoritative DNS server of your domain (use "ns1" and "ns2" as name server names)
2. Make sure your firewall settings allow DNS traffic to reach the server
3. On the server: ```git clone https://github.com/The-Login/DNS-Reset-Checker```
4. On the server: ```sudo ./start.sh [your domain] [server ip address]```

With these steps done, the analysis server should be running on your server and receive DNS queries for the specified domain.  
To confirm this, the following command can be used:
```dig @[server ip address] 9900999999.[your domain]```


## Usage
### Server's running, now what?
With a working analysis server, the below testing procedure can be followed:

1. Register on a web application with an e-mail address of the following format: ```test@VVAAIIIIII.[your domain]``` (e.g. test@0100000001.analysis.example)
    - V: Decimal number for versioning
    - A: Decimal number for the attack requirement to test
    - I: Decimal number for the unique identifier of the web application
2. On the server use ```sudo ./logs.sh``` to see which attack requirements were already tested
3. If a specific attack requirement is missing register another user and specify the attack requirement to test (e.g. e.g. test@01**02**000001.analysis.example). Goto step 2
4. Download the file ```data/dns_log.txt```
5. Fire up the ```log_analyzer.html``` in a browser and select the ```dns_log.txt``` file to start analyzing.

### How do I know if the web application is vulnerable?
check attack requirements (mainly kaminsky)
mention that the server is extensible and other analysis methods can be added to check for further attack requirements.
### What is actually happening?
![Blog Post (2)](https://user-images.githubusercontent.com/84237895/118402797-d074bf00-b66b-11eb-8d30-c39f43808e6c.png)
