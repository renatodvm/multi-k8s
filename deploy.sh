docker build -t renatodvm/multi-client:latest -t renatodvm/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t renatodvm/multi-server:latest -t renatodvm/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t renatodvm/multi-worker:latest -t renatodvm/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push renatodvm/multi-client:latest
docker push renatodvm/multi-server:latest
docker push renatodvm/multi-worker:latest

docker push renatodvm/multi-client:$SHA
docker push renatodvm/multi-server:$SHA
docker push renatodvm/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=renatodvm/multi-server:$SHA
kubectl set image deployments/client-deployment client=renatodvm/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=renatodvm/multi-worker:$SHA
