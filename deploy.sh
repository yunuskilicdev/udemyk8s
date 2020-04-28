docker build -t yunuskilicdev/multi-client:latest -t yunuskilicdev/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t yunuskilicdev/multi-server:latest -t yunuskilicdev/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t yunuskilicdev/multi-worker:latest -t yunuskilicdev/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push yunuskilicdev/multi-client:latest
docker push yunuskilicdev/multi-server:latest
docker push yunuskilicdev/multi-worker:latest

docker push yunuskilicdev/multi-client:$SHA
docker push yunuskilicdev/multi-server:$SHA
docker push yunuskilicdev/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployment/server-deployment server yunuskilicdev/multi-server:$SHA
kubectl set image deployment/client-deployment client yunuskilicdev/multi-client:$SHA
kubectl set image deployment/worker-deployment worker yunuskilicdev/multi-worker:$SHA