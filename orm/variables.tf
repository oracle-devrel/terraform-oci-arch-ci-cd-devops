## Copyright (c) 2022, Oracle and/or its affiliates.
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

variable "tenancy_ocid" {}
variable "compartment_ocid" {}
# variable "user_ocid" {}
# variable "fingerprint" {}
# variable "private_key_path" {}
variable "region" {}

variable "app_name" {
  default     = "DevOps"
  description = "Application name. Will be used as prefix to identify resources, such as OKE, VCN, DevOps, and others"
}

variable "oci_username" {}
variable "oci_user_authtoken" {}

variable "release" {
  description = "Reference Architecture Release (OCI Architecture Center)"
  default     = "1.1.2"
}

variable "project_logging_config_retention_period_in_days" {
  default = 30
}

variable "project_description" {
  default = "DevOps CI/CD Sample Project"
}


variable "build_pipeline_description" {
  default = "build pipeline for Node.JS application"
}

variable "build_pipeline_display_name" {
  default = "NodeJS-build-pipeline"
}

variable "repository_name" {
  default = "nodejs"
}

variable "repository_default_branch" {
  default = "main"
}

variable "repository_description" {
  default = "nodejs sample application"
}

variable "git_repo" {
  default = "https://github.com/oracle-quickstart/oci-devops-node.git"
}

variable "git_repo_name" {
  default = "oci-devops-node"
}

variable "build_pipeline_stage_build_pipeline_stage_predecessor_collection_items_id" {
  default = "id"
}

variable "build_pipeline_stage_build_pipeline_stage_type" {
  default = "BUILD"
}

variable "build_pipeline_stage_deliver_artifact_stage_type" {
  default = "DELIVER_ARTIFACT"
}

variable "build_pipeline_stage_deploy_stage_type" {
  default = "TRIGGER_DEPLOYMENT_PIPELINE"
}

variable "build_pipeline_stage_build_source_collection_items_branch" {
  default = "main"
}

variable "build_pipeline_stage_build_source_collection_items_connection_type" {
  default = "DEVOPS_CODE_REPOSITORY"
}

variable "build_pipeline_stage_build_source_collection_items_name" {
  default = "node_express"
}

variable "build_pipeline_stage_build_spec_file" {
  default = ""
}

variable "build_pipeline_stage_deliver_artifact_collection_items_artifact_name" {
  default = "output01"
}

variable "build_pipeline_stage_display_name" {
  default = "nodejs-build-pipeline"
}

variable "build_pipeline_stage_description"{
  default = "nodejs managed build stage"
}

variable "deliver_artifact_stage_display_name" {
  default = "deliver-artifact"
}

variable "deploy_stage_display_name" {
  default = "deploy-artifact"
}

variable "build_pipeline_stage_image" {
  default = "OL7_X86_64_STANDARD_10"
}

variable "build_pipeline_stage_wait_criteria_wait_duration" {
  default = "waitDuration"
}

variable "build_pipeline_stage_wait_criteria_wait_type" {
  default = "ABSOLUTE_WAIT"
}

variable "build_pipeline_stage_stage_execution_timeout_in_seconds" {
  default = 36000
}

/*
variable "registry_display_name" {
  default = "node-express-getting-starter"
}
*/

variable "container_repository_is_public" {
  default = true
}

variable "deploy_artifact_argument_substitution_mode" {
  default = "SUBSTITUTE_PLACEHOLDERS"
}

/*
variable "deploy_artifact_display_name" {
  default = "node-express-getting-starter"
}
*/

locals {
  ocir_docker_repository = join("", [lower(lookup(data.oci_identity_regions.current_region.regions[0], "key")), ".ocir.io"])
  #ocir_docker_repository = join("", [lower(lookup(data.oci_identity_regions.home_region.regions[0], "key")), ".ocir.io"])
  #ocir_namespace = lookup(data.oci_identity_tenancy.oci_tenancy, "name" )
  ocir_namespace = lookup(data.oci_objectstorage_namespace.ns, "namespace")
}

#variable "ocir_region" {
# default = "iad"}

variable "deploy_artifact_deploy_artifact_source_deploy_artifact_source_type" {
  default = "OCIR"
}

variable "deploy_artifact_deploy_artifact_type" {
  default = "DOCKER_IMAGE"
}

variable "repository_repository_type" {
  default = "HOSTED"
}

variable "deploy_artifact_type" {
  default = "KUBERNETES_MANIFEST"
}

variable "deploy_pipeline_description" {
  default = "Devops CI/CD Pipleline demo for OKE"
}

variable "deploy_artifact_source_type" {
  default = "INLINE"
}

variable "deploy_pipeline_deploy_pipeline_parameters_items_default_value" {
  default = "example"
}

variable "deploy_pipeline_deploy_pipeline_parameters_items_description" {
  default = "exampleapp"
}

variable "deploy_pipeline_deploy_pipeline_parameters_items_name" {
  default = "namespace"
}

variable "deploy_stage_deploy_stage_type" {
  default = "OKE_DEPLOYMENT"
}

variable "deploy_stage_description" {
  default = "ci/cd deployment to OKE"
}

variable "execute_deployment" {
  default = true
}

variable "build_pipeline_stage_is_pass_all_parameters_enabled" {
  default = true
}

