package main

import rego.v1

test_compliant_deployment_has_no_denials if {
  count(deny with input as {
    "kind": "Deployment",
    "metadata": {"name": "safe"},
    "spec": {"template": {"spec": {"containers": [{
      "name": "app", "image": "example.invalid/app:1.0.0",
      "securityContext": {"runAsNonRoot": true, "privileged": false, "allowPrivilegeEscalation": false},
      "resources": {"limits": {"cpu": "500m"}}
    }]}}}
  }) == 0
}

test_privileged_deployment_is_denied if {
  count(deny with input as {
    "kind": "Deployment",
    "metadata": {"name": "unsafe"},
    "spec": {"template": {"spec": {"containers": [{
      "name": "app", "image": "example.invalid/app:latest",
      "securityContext": {"runAsNonRoot": false, "privileged": true, "allowPrivilegeEscalation": true},
      "resources": {"limits": {}}
    }]}}}
  }) == 5
}
