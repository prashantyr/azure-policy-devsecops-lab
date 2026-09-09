.PHONY: test checkov trivy conftest negative

test: checkov trivy conftest negative

checkov:
	checkov -d fixtures/compliant --external-checks-dir checkov/custom --check CUSTOM_AZURE_001 --quiet

trivy:
	trivy config --exit-code 1 --severity HIGH,CRITICAL fixtures/compliant

conftest:
	conftest verify --policy policy/kubernetes
	conftest test fixtures/compliant/deployment.yaml --policy policy/kubernetes

negative:
	! checkov -d fixtures/noncompliant --external-checks-dir checkov/custom --check CUSTOM_AZURE_001 --quiet
	! trivy config --exit-code 1 --severity HIGH,CRITICAL fixtures/noncompliant
	! conftest test fixtures/noncompliant/deployment.yaml --policy policy/kubernetes
