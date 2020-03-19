docker build -t carpema/multi-client:latest -t carpema/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t carpema/multi-server:latest -t carpema/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t carpema/multi-worker:latest -t carpema/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push carpema/multi-client:latest
docker push carpema/multi-server:latest
docker push carpema/multi-worker:latest
docker push carpema/multi-client:$SHA
docker push carpema/multi-server:$SHA
docker push carpema/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/client-deployment client=carpema/multi-client:$SHA
kubectl set image deployments/server-deployment server=carpema/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=carpema/multi-worker:$SHA