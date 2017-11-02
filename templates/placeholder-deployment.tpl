apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  name: pelias-placeholder
spec:
  replicas: 1
  template:
    metadata:
      labels:
        app: pelias-placeholder
    spec:
      initContainers:
        - name: placeholder-download
          image: busybox
          command: ["sh", "-c",
            "mkdir -p /data/placeholder/ &&\n
             wget -O- http://pelias-data.s3.amazonaws.com/placeholder/graph.json.gz | gunzip > /data/placeholder/graph.json &\n
             wget -O- http://pelias-data.s3.amazonaws.com/placeholder/store.sqlite3.gz | gunzip > /data/placeholder/store.sqlite3" ]
          volumeMounts:
            - name: data-volume
              mountPath: /data
      containers:
        - name: pelias-placeholder
          image: pelias/placeholder
          volumeMounts:
            - name: data-volume
              mountPath: /data
          env:
            - name: PLACEHOLDER_DATA
              value: "/data/placeholder/"
          resources:
            limits:
              memory: 1Gi
              cpu: 2
            requests:
              memory: 512Mi
              cpu: 1
      volumes:
        - name: data-volume
          emptyDir: {}
