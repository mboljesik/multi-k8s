docker build -t michalboljesik/multi-client:latest -t michalboljesik/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t michalboljesik/multi-server:latest -t michalboljesik/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t michalboljesik/multi-worker:latest -t michalboljesik/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push michalboljesik/multi-client:latest
docker push michalboljesik/multi-server:latest
docker push michalboljesik/multi-worker:latest

docker push michalboljesik/multi-client:$SHA
docker push michalboljesik/multi-server:$SHA
docker push michalboljesik/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=michalboljesik/multi-server:$SHA
kubectl set image deployments/client-deployment client=michalboljesik/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=michalboljesik/multi-worker:$SHA