#!/usr/bin/env bash

for i in {1..50};
    do gcloud compute instances create perf-$i --image-family=ubuntu-1804-lts --image-project=gce-uefi-images --preemptible --machine-type=n1-standard-2 --zone=us-central1-a --metadata startup-script='#! /bin/bash
ulimit -n 65535
wget https://storage.googleapis.com/hey-release/hey_linux_amd64
mv hey_linux_amd64 hey
chmod +x hey
export PROXY_ENDPOINT=amer-cs-hybrid-demo13-test.hybrid-apigee.net
export API_KEY=5DiNM3MoV8FnpiJ7iJEQVKQMx4bxTQrm
while ((1)); do ./hey -n 20000 -c 500 https://${PROXY_ENDPOINT}/httpbin/anything?apikey=${API_KEY}; sleep 1; done
EOF'
    sleep 10;
done

