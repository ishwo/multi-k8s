docker build -t testmstr/multi-client:latest -t testmstr/multi_client:$SHA -f ./client/Dockerfile ./client
docker build -t testmstr/multi-server:latest -t testmstr/multi_server:$SHA -f ./server/Dockerfile ./server 
docker build -t testmstr/multi-worker:latest -t testmstr/multi-worker:$SHA -f ./worker/Dockerfile ./worker 
docker push testmstr/multi-client:latest
docker push testmstr/multi-server:latest
docker push testmstr/multi-worker:latest
docker push testmstr/multi-client:$SHA
docker push testmstr/multi-server:$SHA
docker push testmstr/multi-worker:$SHA

kubectl apply -f k8s 
kubectl set image deployments/server-deployment server=testmstr/multi-server:$SHA 
kubectl set image deployments/client-deployment client=testmstr/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=testmstr/multi-server:$SHA

