package main

import rego.v1

deny contains msg if {
  input.kind == "Deployment"
  container := input.spec.template.spec.containers[_]
  not container.securityContext.runAsNonRoot
  msg := sprintf("%s: container %q must set runAsNonRoot=true", [input.metadata.name, container.name])
}

deny contains msg if {
  input.kind == "Deployment"
  container := input.spec.template.spec.containers[_]
  container.securityContext.privileged
  msg := sprintf("%s: container %q must not be privileged", [input.metadata.name, container.name])
}

deny contains msg if {
  input.kind == "Deployment"
  container := input.spec.template.spec.containers[_]
  not container.securityContext.allowPrivilegeEscalation == false
  msg := sprintf("%s: container %q must disable privilege escalation", [input.metadata.name, container.name])
}

deny contains msg if {
  input.kind == "Deployment"
  container := input.spec.template.spec.containers[_]
  not container.resources.limits.cpu
  msg := sprintf("%s: container %q must set a CPU limit", [input.metadata.name, container.name])
}

deny contains msg if {
  input.kind == "Deployment"
  container := input.spec.template.spec.containers[_]
  endswith(container.image, ":latest")
  msg := sprintf("%s: container %q must use an immutable image tag or digest", [input.metadata.name, container.name])
}
