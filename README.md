# DNS Reset Checker
Tools to assess the DNS security of web applications.
## Background
### DNS security of web applications? What?  
The DNS is a central part of many functionalities of a web application. This includes sending **e-mails**. If a web application wants to send an e-mail, the e-mail domain first needs to be resolved to an IP address. This is done via a DNS name resolution. Easy!  
**But what happens, if this DNS name resolution is vulnerable?**  
In this case, an attacker could manipulate the resolution of the e-mail domain. This furthermore means, that e-mails can be redirected to an attacker e-mail server, instead of the actual e-mail server.  
This concept is summarized in the following image:  
![methodology_english_2](https://user-images.githubusercontent.com/84237895/118851556-2f3b7200-b8d2-11eb-8681-7011e5aacd70.jpg)
  
### An attacker can receive e-mails, so what?
Among newsletters and account notifications there is another functionality that almost always uses e-mails:  
The "Forgot password?" feature.  
A successful attack on the DNS name resolution of a web application combined with the "Forgot password?" feature can therefore lead to the takover of user accounts.  
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
4. On the server: ```sudo ./start.sh [your domain] [server ip address]``` (e.g. ```sudo ./start.sh analysis.example 203.0.113.37```)

With these steps done, the analysis server should be running on your server and receive DNS queries for the specified domain.  
To confirm this the following command can be used:
```dig 9999999999.[your domain]```  
This should return the IP address of the server.


## Usage
### Server's running, now what?
With a working analysis server, the below testing procedure can be followed:
1. Register on a web application with an e-mail address of the following format: ```test@VVAAIIIIII.[your domain]``` (e.g. test@0100000001.analysis.example)
    - V: Decimal number for versioning
    - A: Decimal number for the attack requirement to test
    - I: Decimal number for the **unique** identifier of the web application (one identifier per web app)
2. On the server use ```sudo ./logs.sh``` to see which attack requirements were already tested
3. If a specific attack requirement is missing, register another user and specify the attack requirement to test (e.g. test@01**02**000001.analysis.example). Goto step 2
4. Download the file ```data/dns_log.txt```
5. Fire up the ```log_analyzer.html``` in a browser and select the ```dns_log.txt``` file to start analyzing.

This process is summarized in the below image:
![Blog Post (2)](https://user-images.githubusercontent.com/84237895/118402797-d074bf00-b66b-11eb-8d30-c39f43808e6c.png)
  
### What is actually happening? Why do I have to register? What's the server for?

Let's go to through the testing procedure again:  
As already described, the whole process starts with a registration. In this case, your special e-mail address (e.g. test@0100000001.analysis.example) is used to register on the web application with identifier "000001". This is done because web applications often send registration e-mails to new users. The  web application sending an e-mail initiates a DNS name resolution to your authoritative name server (analysis server), since you entered your analysis domain as e-mail domain. This DNS name resolution can now be analyzed and actively used to test one or more DNS attack requirements. This is done via a DNS proxy (dns_proxy.py). The DNS proxy proxies DNS requests to and from the ADNS and can therefore perform the described actions.  
The server's purpose is therefore, as described, to act as an authoritative analysis server. 

### How do I know if a web application is vulnerable?
As just mentioned, the analysis server tests for attack requirements. These are requirements for **DNS attacks**.  
If all requirements for a DNS attack are fulfilled, the attack should be practically possible.  
Currently, the DNS Reset Checker can be used to test for 2 DNS attacks:
- Kaminsky attacks
- IP fragmentation attacks

What exactly are their attack requirements, one might ask. Here's a summary of some **main** requirements:  
- Kaminsky attacks:
    1. Low/No random distribution of source ports
    2. No usage/enforcement of DNS security features (DNS SEC, DNS cookies, 0x20 encoding, etc.)
- IP fragmentation attacks:
    1. The DNS resolver of the web application accepts IP fragmented DNS responses
    2. No usage/enforcement of DNS security features (DNS SEC, etc.)
    3. Maximum EDNS buffer size larger than 1232 

For example, if the DNS name resolution of a web application is vulnerable to Kaminsky attacks, you might see the following scatter plot via the log analyzer:  
![0000000154_example_IP](https://user-images.githubusercontent.com/84237895/118691325-3fd3e580-b809-11eb-8e6e-ed8c76a84736.png)

The other requirements mentioned can be checked by reading the "General Info" section of the log analyzer output or by analyzing the dns_log.txt log entries directly.
![general_info](https://user-images.githubusercontent.com/84237895/118853912-92c69f00-b8d4-11eb-88e8-9c9620e44efa.PNG)

*As already mentioned, for a more in-depth look at this topic check out [this](https://sec-consult.com) blog post.*

