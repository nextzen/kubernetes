apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  name: pelias-pip
spec:
  replicas: 1
  template:
    metadata:
      labels:
        app: pelias-pip
    spec:
      initContainers:
        - name: wof-download
          image: pelias/whosonfirst
          command: ["npm", "run", "download"]
          volumeMounts:
            - name: config-volume
              mountPath: /etc/config
            - name: data-volume
              mountPath: /data
          env:
            - name: PELIAS_CONFIG
              value: "/etc/config/pelias.json"
      containers:
        - name: pelias-pip
          image: pelias/pip
          volumeMounts:
            - name: config-volume
              mountPath: /etc/config
            - name: data-volume
              mountPath: /data
          env:
            - name: PELIAS_CONFIG
              value: "/etc/config/pelias.json"
          resources:
            limits:
              memory: 8Gi
            requests:
              memory: 4Gi
          readinessProbe:
            httpGet:
              path: /12/12
              port: 3102
            initialDelaySeconds: 60 #PIP service takes a long time to start up
      volumes:
        - name: config-volume
          configMap:
            name: pelias-json-configmap
            items:
              - key: pelias.json
                path: pelias.json
        - name: data-volume
          emptyDir: {}
