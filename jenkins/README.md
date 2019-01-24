* Build docker image from Dockerfile

```docker image build --tag pr-jenkins:1.0 .```

* Create and run the container and show logs

```docker container run -it -p 9000:8080 --name pr-jenkins pr-jenkins:1.0```

* Connect with command line to the container

```docker exec -it pr-jenkins /bin/bash```

* Stop the container

```docker container stop pr-jenkins```

* Delete the container

```docker container rm pr-jenkins```

