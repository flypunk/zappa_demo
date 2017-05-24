This is a demo showing how to deploy a Python Flask application (simple API endpoint)
to AWS Lambda using Zappa CLI.
The API endpoint is exposed as a custom domain, such as api.example.com.

To try it, you have to use a machine with python2, virtualenv, openssl, curl and working aws cli.
It works for me on Ubuntu 16.04.  
You also have to have a configured hosted zone for a domain you control where the NS records are correctly pointing to Route53 DNS servers for your zone.

A live demo of an app deployed using this method is available at https://deploy-demo.softishard.com

To try this demo, clone the repo, cd into it and then:
- copy zappa_settings_example.yml to zappa_settings.yml file
and provide correct values at least for s3_bucket and domain.
- Generate a private key for SSL certificate management using this command: `openssl genrsa 2048 > account.key`
- create a virtualenv: `virtualenv venv`
- activate it: `source venv/bin/activate`
- install dependencies: `pip install -r requirements.txt`  
Note: I am using a cloned version of Zappa instead of the official one because of
an open [issue](https://github.com/Miserlou/Zappa/issues/762) preventing DNS management. Once issue 762 is closed, you should use the official Zappa instead.
- deploy the demo_app.py to lambda: `zappa deploy`  
If everything is set up correctly, zappa should run successfully and output a URL of the installed app, like `https://isr02f1byj.execute-api.us-east-1.amazonaws.com/dev`  
HTTP GETting this URL should produce 'Hello YOUR_IP' string.
- Generate and install SSL certificate for your domain: `zappa certify`.
- Update your deployment with `zappa update` and wait a couple of minutes for DNS changes to propagate.  
Now the API should be available at your custom domain specified in `zappa_settings.yml`.  
This is all you need to do manually.
After this, just update the code in demo_app.py and run `deploy.sh` wrapper to redeploy the app.  
This script runs `zappa update` and checks that the domain specified in `zappa_settings.yml` responds correctly.  
If you change the domain in the settings, run `zappa certify` again.
