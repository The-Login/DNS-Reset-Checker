# DNS Reset Checker
Tools to assess the DNS security of web applications.
## Background
### DNS security of web applications? What?  
As recently discovered in my diploma thesis, some web applications have a vulnerable DNS name resolution. Functionalities that rely on the DNS can therefore be attacked. This includes sending **e-mails**.  
If a web application has a "Forgot password?" feature, password reset URLs are most likely sent via **e-mail**. **See the problem?**  
A successful attack on the DNS name resolution of a web application can therefore lead to the takover of user accounts.  
This concept is summarized in the following image:  
![DNS 5(1)_2](https://user-images.githubusercontent.com/84237895/118402283-8559ac80-b669-11eb-962a-6e96e4e97b4c.jpg)
  
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

1. Register on a web application with an e-mail address of the following format: ```test@VVAAIIIIII.[your domain]``` (e.g. 0100000001.analysis.example)
    - V: Decimal number for versioning
    - A: Decimal number for the attack requirement to test
    - I: Decimal number for the unique identifier of the web application
2. On the server use ```sudo ./logs.sh``` to see which attack requirements were already tested
3. If a specific attack requirement is missing register another user and specify the attack requirement to test (e.g. e.g. 01**02**000001.analysis.example). Goto step 2
4. Download the file ```data/dns_log.txt```
5. Fire up the ```log_analyzer.html``` in a browser and select the ```dns_log.txt``` file to start analyzing.

### How do I know if the web application is vulnerable?
check attack requirements (mainly kaminsky)
mention that the server is extensible and other analysis methods can be added to check for further attack requirements.
### What is actually happening?
![Blog Post (2)](https://user-images.githubusercontent.com/84237895/118402797-d074bf00-b66b-11eb-8d30-c39f43808e6c.png)
