docker build -t pzijlmans/multi-client:latest -t pzijlmans/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t pzijlmans/multi-server:latest -t pzijlmans/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t pzijlmans/multi-worker:latest -t pzijlmans/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push pzijlmans/multi-client:latest
docker push pzijlmans/multi-server:latest
docker push pzijlmans/multi-worker:latest

docker push pzijlmans/multi-client:$SHA
docker push pzijlmans/multi-server:$SHA
docker push pzijlmans/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=pzijlmans/multi-server:$SHA
kubectl set image deployments/client-deployment client=pzijlmans/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=pzijlmans/multi-worker:$SHA