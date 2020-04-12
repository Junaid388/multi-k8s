docker build -t junaid388/multi-client:latest -t junaid388/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t junaid388/multi-server:latest -t junaid388/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t junaid388/multi-worker:latest -t junaid388/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push junaid388/multi-client:latest
docker push junaid388/multi-server:latest
docker push junaid388/multi-worker:latest

docker push junaid388/multi-client:$SHA
docker push junaid388/multi-server:$SHA
docker push junaid388/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=junaid388/multi-server:$SHA
kubectl set image deployments/client-deployment client=junaid388/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=junaid388/multi-worker:$SHA