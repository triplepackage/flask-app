# Python Flask Sample Web API Deployed to AWS ECS

## Latest Instructions for Building Docker Container, Publishing to AWS ECR and Running Container in ECS

To run without docker container
<pre>
python web_api.py
</pre>

To run in Docker container locally
<pre>
Johns-MacBook-Pro:flask-app admin$ docker build -t flask-app .
Sending build context to Docker daemon  2.595MB
Step 1/7 : FROM python:3.5
 ---> e649f67bb435
Step 2/7 : MAINTAINER John Domingo "jbdomingo76@gmail.com"
 ---> Using cache
 ---> 6afc79e0200c
Step 3/7 : COPY . /app
 ---> 33c8101a7530
Step 4/7 : WORKDIR /app
Removing intermediate container 5d1e361c6e15
 ---> 9911ad98b09d
Step 5/7 : RUN pip install -r requirements.txt
 ---> Running in 0016038af948
Collecting flask (from -r requirements.txt (line 1))
  Downloading https://files.pythonhosted.org/packages/7f/e7/08578774ed4536d3242b14dacb4696386634607af824ea997202cd0edb4b/Flask-1.0.2-py2.py3-none-any.whl (91kB)
Collecting click>=5.1 (from flask->-r requirements.txt (line 1))
  Downloading https://files.pythonhosted.org/packages/34/c1/8806f99713ddb993c5366c362b2f908f18269f8d792aff1abfd700775a77/click-6.7-py2.py3-none-any.whl (71kB)
Collecting Jinja2>=2.10 (from flask->-r requirements.txt (line 1))
  Downloading https://files.pythonhosted.org/packages/7f/ff/ae64bacdfc95f27a016a7bed8e8686763ba4d277a78ca76f32659220a731/Jinja2-2.10-py2.py3-none-any.whl (126kB)
Collecting itsdangerous>=0.24 (from flask->-r requirements.txt (line 1))
  Downloading https://files.pythonhosted.org/packages/dc/b4/a60bcdba945c00f6d608d8975131ab3f25b22f2bcfe1dab221165194b2d4/itsdangerous-0.24.tar.gz (46kB)
Collecting Werkzeug>=0.14 (from flask->-r requirements.txt (line 1))
  Downloading https://files.pythonhosted.org/packages/20/c4/12e3e56473e52375aa29c4764e70d1b8f3efa6682bef8d0aae04fe335243/Werkzeug-0.14.1-py2.py3-none-any.whl (322kB)
Collecting MarkupSafe>=0.23 (from Jinja2>=2.10->flask->-r requirements.txt (line 1))
  Downloading https://files.pythonhosted.org/packages/4d/de/32d741db316d8fdb7680822dd37001ef7a448255de9699ab4bfcbdf4172b/MarkupSafe-1.0.tar.gz
Building wheels for collected packages: itsdangerous, MarkupSafe
  Running setup.py bdist_wheel for itsdangerous: started
  Running setup.py bdist_wheel for itsdangerous: finished with status 'done'
  Stored in directory: /root/.cache/pip/wheels/2c/4a/61/5599631c1554768c6290b08c02c72d7317910374ca602ff1e5
  Running setup.py bdist_wheel for MarkupSafe: started
  Running setup.py bdist_wheel for MarkupSafe: finished with status 'done'
  Stored in directory: /root/.cache/pip/wheels/33/56/20/ebe49a5c612fffe1c5a632146b16596f9e64676768661e4e46
Successfully built itsdangerous MarkupSafe
Installing collected packages: click, MarkupSafe, Jinja2, itsdangerous, Werkzeug, flask
Successfully installed Jinja2-2.10 MarkupSafe-1.0 Werkzeug-0.14.1 click-6.7 flask-1.0.2 itsdangerous-0.24
You are using pip version 10.0.1, however version 18.0 is available.
You should consider upgrading via the 'pip install --upgrade pip' command.
Removing intermediate container 0016038af948
 ---> 421be92f0c87
Step 6/7 : ENTRYPOINT ["python"]
 ---> Running in c908f9c372f3
Removing intermediate container c908f9c372f3
 ---> 69af57dd69f3
Step 7/7 : CMD ["web_api.py"]
 ---> Running in edaf9681f10a
Removing intermediate container edaf9681f10a
 ---> 2df91c1886ca
Successfully built 2df91c1886ca
Successfully tagged flask-app:latest

Johns-MBP:flask-app admin$ docker run -p 8181:80 flask-app
 * Serving Flask app "web_api" (lazy loading)
 * Environment: production
   WARNING: Do not use the development server in a production environment.
   Use a production WSGI server instead.
 * Debug mode: on
 * Running on http://0.0.0.0:80/ (Press CTRL+C to quit)
 * Restarting with stat
 * Debugger is active!
 * Debugger PIN: 336-938-690 
</pre>

Test application is working
![Flask App](/images/ecs5.jpg)

Push image to AWS ECR
<pre>
ohns-MBP:flask-app admin$ aws ecr get-login
docker login -u AWS -p eyJwYXlsb2FkIjoiUHJTUU16SzdHcmxSc0preXpIczBpN3JlQXRIc0cxQms0c0RsTklnSFVLNkNTZmswakNCZTRMd043aXJlTmJMbkFyWDBCZVhCYzZiQ3QrRUM0VEc4MEhoWmwzd0F6eUV6a0c1MUtIZHQ3WTFJMmQ4ZjVNOG5mVzVqSGovRGY3VGpWQjk1ZXR3a3ZkckwwbzBHWGZIUWlyeTlTNE9DOXQzdG16Q3RkVVJLQnJaa0I0Q2h1VDV0OG9aMEk4eDlKVmZGcDhCcXpjUTd1MWVqL3o2L2pjUU04TFFpUittWnVnQXB6eUt1cmpVTTU2QjE5S3l1RE92Nm4zRDVEMXEyMldMNW5VazFWbllKZC9CUTQ2R05LTEYzN1lzU3cvR1hZNUlLS3lQK0ZsU0FyZzV5MEFIMkRwNjN0T0U1WmxTZk0wNkpzc3VEaWRiL3dsRzhZVWRiaDJ4UGVoenFSMkNxOW1PaDl4amN0dWxUVm1UUFB0dHFNYmVzb3orRDY5alI5dWowQmNNQnhKbkw2VXVudVFKV1RMdVdLV2w3Ymd6Q1lQTjNFY01VUXloRGdjUVc5S2NkTTcyclQvYVlhS0E0TFkyM3M0VWxyVkxPa1dPQnhRdGFtUFVUMWlGMksvZHlISlZqR21JL1k1cVRJdnNRQStOdHBvTlR4S253cVRLZi9EN2NSMmsyY1R3TDk1UGprdVc3bkQ5bkdibnpxTFJrdkwwdlRwZ29VcTJmZEIrU1RNcWNHdGdTdHQvaFp2Wng2c3hyT0dCbWJET3p0N2ZjY1U3NSsxd0x4VUx1aW1JeDBpdldmZUtRb3p6MSs2UlJyYUkxeU0wSFB0UVVnUnNvWFdHWGlWTm0xbHo5MzlzYTltemN1TnVMTjVMK1NSWDEyZHR1Rkg1Z2NGOHhjWnZjeWFhR0lYSi9Ua1djTmtPVmZObndmM2hVZWlRVjVYbWczMDFXMGVBcC9pbkljMUZWR3pwVnVBK3JVMmVENzBQMXZjUVZudldlWjZRVUdyNVdDSk5SM01TUUFIMGVwek1vTFJnRGF4cSswamlRN256UmdEWUIvTXR4RnMveXkwcnBWNVBJS3gvV0JQWkpJbWQ1SnJOalZpeVZTb3k3eDlYalU3ZlRhNVpGTDZxWEtpWUVIY25nTWROMTVJSEdXR1hVQTFESkcySVMxdThIRHVBZ293U25WYkZKSk5vY25wSE1WNEYyQVNYdUU1dVU4MEJtakhYSjgyeW9zRTlYdjRYcy9mTURHNW5LTDhROUNWS0RuN0s5MUxXOVZJTnhMTGN1Wm50WWRoUVc0QVNiZXQxTkxrVXdFMEc5clhKaVorMjFLcDVNZStwemRGTjE1c0luY01XMGN3NVQ3YWpIMlJyNUZNS2pTdm9oMWtibHk0SWZNQ2ZINFNFbUUvbis4bzVvNG1LYWdubWEzRkUyNEVMblMwdm8xMkM2ZmthTzJCR2RRMzRSOW5CSENwU3lWc2szeXVvSUg1MVZEbWsxOE1LM1VBPT0iLCJkYXRha2V5IjoiQVFFQkFIaHdtMFlhSVNKZVJ0Sm01bjFHNnVxZWVrWHVvWFhQZTVVRmNlOVJxOC8xNHdBQUFINHdmQVlKS29aSWh2Y05BUWNHb0c4d2JRSUJBREJvQmdrcWhraUc5dzBCQndFd0hnWUpZSVpJQVdVREJBRXVNQkVFREdmNXRFQmtFTVAxRVpPV3Z3SUJFSUE3a201OHpoZk9sTWVTd2RuWXQzL3FzVHIvOFU4aXE0YzcxTGFrdEpydWVFeVp3MUJhNHY1LytHSWVCTmp0aWNsdjlBc3ZHYXVsR2ZQNGp5dz0iLCJ2ZXJzaW9uIjoiMiIsInR5cGUiOiJEQVRBX0tFWSIsImV4cGlyYXRpb24iOjE1MzczMTM2Mjd9 -e none https://002609254882.dkr.ecr.us-east-1.amazonaws.com
Johns-MBP:flask-app admin$ docker login -u AWS -p eyJwYXlsb2FkIjoiUHJTUU16SzdHcmxSc0preXpIczBpN3JlQXRIc0cxQms0c0RsTklnSFVLNkNTZmswakNCZTRMd043aXJlTmJMbkFyWDBCZVhCYzZiQ3QrRUM0VEc4MEhoWmwzd0F6eUV6a0c1MUtIZHQ3WTFJMmQ4ZjVNOG5mVzVqSGovRGY3VGpWQjk1ZXR3a3ZkckwwbzBHWGZIUWlyeTlTNE9DOXQzdG16Q3RkVVJLQnJaa0I0Q2h1VDV0OG9aMEk4eDlKVmZGcDhCcXpjUTd1MWVqL3o2L2pjUU04TFFpUittWnVnQXB6eUt1cmpVTTU2QjE5S3l1RE92Nm4zRDVEMXEyMldMNW5VazFWbllKZC9CUTQ2R05LTEYzN1lzU3cvR1hZNUlLS3lQK0ZsU0FyZzV5MEFIMkRwNjN0T0U1WmxTZk0wNkpzc3VEaWRiL3dsRzhZVWRiaDJ4UGVoenFSMkNxOW1PaDl4amN0dWxUVm1UUFB0dHFNYmVzb3orRDY5alI5dWowQmNNQnhKbkw2VXVudVFKV1RMdVdLV2w3Ymd6Q1lQTjNFY01VUXloRGdjUVc5S2NkTTcyclQvYVlhS0E0TFkyM3M0VWxyVkxPa1dPQnhRdGFtUFVUMWlGMksvZHlISlZqR21JL1k1cVRJdnNRQStOdHBvTlR4S253cVRLZi9EN2NSMmsyY1R3TDk1UGprdVc3bkQ5bkdibnpxTFJrdkwwdlRwZ29VcTJmZEIrU1RNcWNHdGdTdHQvaFp2Wng2c3hyT0dCbWJET3p0N2ZjY1U3NSsxd0x4VUx1aW1JeDBpdldmZUtRb3p6MSs2UlJyYUkxeU0wSFB0UVVnUnNvWFdHWGlWTm0xbHo5MzlzYTltemN1TnVMTjVMK1NSWDEyZHR1Rkg1Z2NGOHhjWnZjeWFhR0lYSi9Ua1djTmtPVmZObndmM2hVZWlRVjVYbWczMDFXMGVBcC9pbkljMUZWR3pwVnVBK3JVMmVENzBQMXZjUVZudldlWjZRVUdyNVdDSk5SM01TUUFIMGVwek1vTFJnRGF4cSswamlRN256UmdEWUIvTXR4RnMveXkwcnBWNVBJS3gvV0JQWkpJbWQ1SnJOalZpeVZTb3k3eDlYalU3ZlRhNVpGTDZxWEtpWUVIY25nTWROMTVJSEdXR1hVQTFESkcySVMxdThIRHVBZ293U25WYkZKSk5vY25wSE1WNEYyQVNYdUU1dVU4MEJtakhYSjgyeW9zRTlYdjRYcy9mTURHNW5LTDhROUNWS0RuN0s5MUxXOVZJTnhMTGN1Wm50WWRoUVc0QVNiZXQxTkxrVXdFMEc5clhKaVorMjFLcDVNZStwemRGTjE1c0luY01XMGN3NVQ3YWpIMlJyNUZNS2pTdm9oMWtibHk0SWZNQ2ZINFNFbUUvbis4bzVvNG1LYWdubWEzRkUyNEVMblMwdm8xMkM2ZmthTzJCR2RRMzRSOW5CSENwU3lWc2szeXVvSUg1MVZEbWsxOE1LM1VBPT0iLCJkYXRha2V5IjoiQVFFQkFIaHdtMFlhSVNKZVJ0Sm01bjFHNnVxZWVrWHVvWFhQZTVVRmNlOVJxOC8xNHdBQUFINHdmQVlKS29aSWh2Y05BUWNHb0c4d2JRSUJBREJvQmdrcWhraUc5dzBCQndFd0hnWUpZSVpJQVdVREJBRXVNQkVFREdmNXRFQmtFTVAxRVpPV3Z3SUJFSUE3a201OHpoZk9sTWVTd2RuWXQzL3FzVHIvOFU4aXE0YzcxTGFrdEpydWVFeVp3MUJhNHY1LytHSWVCTmp0aWNsdjlBc3ZHYXVsR2ZQNGp5dz0iLCJ2ZXJzaW9uIjoiMiIsInR5cGUiOiJEQVRBX0tFWSIsImV4cGlyYXRpb24iOjE1MzczMTM2Mjd9 https://002609254882.dkr.ecr.us-east-1.amazonaws.com
WARNING! Using --password via the CLI is insecure. Use --password-stdin.
Login Succeeded
Johns-MBP:flask-app admin$ docker images
REPOSITORY                          TAG                 IMAGE ID            CREATED              SIZE
flask-app                           latest              2df91c1886ca        About a minute ago   702MB

Johns-MBP:flask-app admin$ docker tag 2df91c1886ca 002609254882.dkr.ecr.us-east-1.amazonaws.com/prototype:latest
Johns-MBP:flask-app admin$ docker push 002609254882.dkr.ecr.us-east-1.amazonaws.com/prototype:latest
The push refers to repository [002609254882.dkr.ecr.us-east-1.amazonaws.com/prototype]
418e15b0dd03: Pushed 
4431413464da: Pushed 
844c451fdce8: Pushed 
e68319026069: Pushed 
263c749465d7: Pushed 
7ad7ab2d3895: Pushed 
23044129c2ac: Pushed 
8b229ec78121: Pushed 
3b65755e1220: Pushed 
2c833f307fd8: Pushed 
latest: digest: sha256:44a9643320d1805ccb0371d8f63df6d22c93b01aa1ba908b27a870d81d5bec75 size: 2429
</pre>

Deploy Docker container in ECS

![Flask App In AWS ECS](/images/ecr-ecs-01.jpg)
![Flask App In AWS ECS](/images/ecr-ecs-02.jpg)
![Flask App In AWS ECS](/images/ecr-ecs-03.jpg)
![Flask App In AWS ECS](/images/ecr-ecs-04.jpg)
![Flask App In AWS ECS](/images/ecr-ecs-05.jpg)
![Flask App In AWS ECS](/images/ecr-ecs-06.jpg)
![Flask App In AWS ECS](/images/ecr-ecs-07.jpg)
![Flask App In AWS ECS](/images/ecr-ecs-08.jpg)
![Flask App In AWS ECS](/images/ecr-ecs-09.jpg)
![Flask App In AWS ECS](/images/ecr-ecs-10.jpg)
![Flask App In AWS ECS](/images/ecr-ecs-11.jpg)
![Flask App In AWS ECS](/images/ecr-ecs-12.jpg)

## Previous Instructions for Building Docker Container, Publishing to AWS ECR and Running Container in ECS

To run in Docker container
<pre>




To run without docker container
<pre><code>python web_api.py</code>
</pre>

To run in Docker container
<pre>
<code>
$ docker build -t flask-app .
    
Sending build context to Docker daemon  52.22kB
Step 1/7 : FROM python:3.5
 ---> e649f67bb435
Step 2/7 : MAINTAINER John Domingo "jbdomingo76@gmail.com"
 ---> Using cache
 ---> 6afc79e0200c
Step 3/7 : COPY . /app
 ---> d8416e54d162
Step 4/7 : WORKDIR /app
Removing intermediate container 8643c39c2d82
 ---> 7e25657df022
Step 5/7 : RUN pip install -r requirements.txt
 ---> Running in 9e75340f73d6
Collecting flask (from -r requirements.txt (line 1))
  Downloading https://files.pythonhosted.org/packages/7f/e7/08578774ed4536d3242b14dacb4696386634607af824ea997202cd0edb4b/Flask-1.0.2-py2.py3-none-any.whl (91kB)
Collecting click>=5.1 (from flask->-r requirements.txt (line 1))
  Downloading https://files.pythonhosted.org/packages/34/c1/8806f99713ddb993c5366c362b2f908f18269f8d792aff1abfd700775a77/click-6.7-py2.py3-none-any.whl (71kB)
Collecting Werkzeug>=0.14 (from flask->-r requirements.txt (line 1))
  Downloading https://files.pythonhosted.org/packages/20/c4/12e3e56473e52375aa29c4764e70d1b8f3efa6682bef8d0aae04fe335243/Werkzeug-0.14.1-py2.py3-none-any.whl (322kB)
Collecting Jinja2>=2.10 (from flask->-r requirements.txt (line 1))
  Downloading https://files.pythonhosted.org/packages/7f/ff/ae64bacdfc95f27a016a7bed8e8686763ba4d277a78ca76f32659220a731/Jinja2-2.10-py2.py3-none-any.whl (126kB)
Collecting itsdangerous>=0.24 (from flask->-r requirements.txt (line 1))
  Downloading https://files.pythonhosted.org/packages/dc/b4/a60bcdba945c00f6d608d8975131ab3f25b22f2bcfe1dab221165194b2d4/itsdangerous-0.24.tar.gz (46kB)
Collecting MarkupSafe>=0.23 (from Jinja2>=2.10->flask->-r requirements.txt (line 1))
  Downloading https://files.pythonhosted.org/packages/4d/de/32d741db316d8fdb7680822dd37001ef7a448255de9699ab4bfcbdf4172b/MarkupSafe-1.0.tar.gz
Building wheels for collected packages: itsdangerous, MarkupSafe
  Running setup.py bdist_wheel for itsdangerous: started
  Running setup.py bdist_wheel for itsdangerous: finished with status 'done'
  Stored in directory: /root/.cache/pip/wheels/2c/4a/61/5599631c1554768c6290b08c02c72d7317910374ca602ff1e5
  Running setup.py bdist_wheel for MarkupSafe: started
  Running setup.py bdist_wheel for MarkupSafe: finished with status 'done'
  Stored in directory: /root/.cache/pip/wheels/33/56/20/ebe49a5c612fffe1c5a632146b16596f9e64676768661e4e46
Successfully built itsdangerous MarkupSafe
Installing collected packages: click, Werkzeug, MarkupSafe, Jinja2, itsdangerous, flask
Successfully installed Jinja2-2.10 MarkupSafe-1.0 Werkzeug-0.14.1 click-6.7 flask-1.0.2 itsdangerous-0.24
Removing intermediate container 9e75340f73d6
 ---> 85d645a33f9b
Step 6/7 : ENTRYPOINT ["python"]
 ---> Running in 54a51294c3be
Removing intermediate container 54a51294c3be
 ---> 6a2c98c61ea3
Step 7/7 : CMD ["web_api.py"]
 ---> Running in 35e459555589
Removing intermediate container 35e459555589
 ---> da10dbdf8e10
Successfully built da10dbdf8e10
Successfully tagged flask-app:latest

$ docker run -p 80:80 flask-app
 * Serving Flask app "web_api" (lazy loading)
 * Environment: production
   WARNING: Do not use the development server in a production environment.
   Use a production WSGI server instead.
 * Debug mode: on
 * Running on http://0.0.0.0:80/ (Press CTRL+C to quit)
 * Restarting with stat
 * Debugger is active!
 * Debugger PIN: 227-259-578

  </code>
</pre>

### Publish Docker image to Docker Hub
<pre><code>$ docker login --username=triplepackage
$ docker images
REPOSITORY                   TAG                 IMAGE ID            CREATED             SIZE
flask-app                    latest              da10dbdf8e10        6 minutes ago       699MB

$ docker tag da10dbdf8e10 triplepackage/flask-app:latest
$ docker push triplepackage/flask-app
</code></pre>
![Docker Hub](/images/dockerhub.jpg)

### Finally, deploy to ECS
![AWS ECS Step 1](/images/ecs1.jpg)

![AWS ECS Step 2](/images/ecs2.jpg)

![AWS ECS Step 3](/images/ecs3.jpg)

Test application is working
![AWS ECS Step 4](/images/ecs4.jpg)
