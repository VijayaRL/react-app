install:
	helm upgrade --cleanup-on-fail --install react-app . \
	--namespace react-app --create-namespace \
	--values values.yaml

uninstall:
	helm uninstall react-app --namespace react-app