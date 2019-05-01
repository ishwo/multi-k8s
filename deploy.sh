docker build -t ishwo/multi-client:latest -t ishwo/multi_client:$SHA -f ./client/Dockerfile ./client
docker build -t ishwo/multi-server:latest -t ishwo/multi_server:$SHA -f ./server/Dockerfile ./server 
docker build -t ishwo/multi-worker:latest -t ishwo/multi-worker:$SHA -f ./worker/Dockerfile ./worker 
docker push ishwo/multi-client:latest
docker push ishwo/multi-server:latest
docker push ishwo/multi-worker:latest
docker push ishwo/multi-client:$SHA
docker push ishwo/multi-server:$SHA
docker push ishwo/multi-worker:$SHA

kubectl apply -f k8s 
kubectl set image deployments/server-deployment server=testmstr/multi-server:$SHA 
kubectl set image deployments/client-deployment client=testmstr/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=testmstr/multi-server:$SHA

