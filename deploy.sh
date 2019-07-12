docker build -t greendost/multi-client:latest -t greendost/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t greendost/multi-server:latest -t greendost/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t greendost/multi-worker:latest -t greendost/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push greendost/multi-client:latest
docker push greendost/multi-server:latest
docker push greendost/multi-worker:latest

docker push greendost/multi-client:$SHA
docker push greendost/multi-server:$SHA
docker push greendost/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=greendost/multi-server:$SHA
kubectl set image deployments/client-deployment client=greendost/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=greendost/multi-worker:$SHA
