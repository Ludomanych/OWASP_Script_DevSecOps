# OWASP Script Descriprion

During my DAST study, I used OWASP ZAP to test a test site. During my training, I didn't like that everything was output to the console, so I decided to make this script for easier use, i.e. you don't need to enter commands, just enter the required URL and wait for the scan to complete, after which the number of vulnerabilities found will be output in a convenient format, and all output will be written to a file.

Important note:
I used a container with OWASP ZAP, before using it, you need to install it and run tests only for your applications.
You also need to write the protocol used ("http://..." or "https://...")
