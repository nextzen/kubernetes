apiVersion: batch/v1
kind: Job
metadata:
  name: whosonfirst-import
spec:
  template:
    metadata:
      name: whosonfirst-import
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
      - name: whosonfirst-import-container
        image: pelias/whosonfirst
        command: ["npm", "start"]
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
            memory: 2Gi
            cpu: 1.5
          requests:
            memory: 1Gi
            cpu: 1
      restartPolicy: Never
      volumes:
        - name: config-volume
          configMap:
            name: pelias-json-configmap
            items:
              - key: pelias.json
                path: pelias.json
        - name: data-volume
          persistentVolumeClaim:
            claimName: pelias-build-pvc
