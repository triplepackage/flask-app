# Python Flask Sample Web API

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

###Finally, deploy to ECS
![AWS ECS Step 1](/images/ecs1.jpg)

![AWS ECS Step 2](/images/ecs2.jpg)

![AWS ECS Step 3](/images/ecs3.jpg)

![AWS ECS Step 4](/images/ecs4.jpg)
