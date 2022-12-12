#!/bin/bash

mkdir tempdir
mkdir tempdir/templates
mkdir tempdir/static

cp flask_app.py tempdir/
cp -r templates/* tempdir/templates/.
cp -r static/* tempdir/static/.

echo "FROM python" > tempdir/Dockerfile
echo "Run pip install flask" >> tempdir/Dockerfile
echo "COPY ./static /home/myapp/static/" >> tempdir/Dockerfile
echo "COPY ./templates /home/myapp/templates/" >> tempdir/Dockerfile
echo "COPY flask_app.py /home/myapp/" >> tempdir/Dockerfile
echo "EXPOSE 8008" >>  tempdir/Dockerfile
echo "CMD python /home/myapp/flask_app.py" >> tempdir/Dockerfile

cd tempdir
docker build -t sampleapp .
docker run -t -d -p 5099:8008 --name samplerunning sampleapp
docker container ls -a
