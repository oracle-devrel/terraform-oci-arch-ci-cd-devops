## Copyright (c) 2022, Oracle and/or its affiliates. 
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

# Create log and log group

resource "oci_logging_log_group" "test_log_group" {
  compartment_id = var.compartment_ocid
  display_name   = "devops_log_group_${random_string.deploy_id.result}"
  defined_tags   = { "${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
}

resource "oci_logging_log" "test_log" {
  #Required
  display_name = "devops_log_group_log"
  log_group_id = oci_logging_log_group.test_log_group.id
  log_type     = "SERVICE"

  #Optional
  configuration {
    #Required
    source {
      #Required
      category    = "all"
      resource    = oci_devops_project.test_project.id
      service     = "devops"
      source_type = "OCISERVICE"
    }

    #Optional
    compartment_id = var.compartment_ocid
  }

  is_enabled         = true
  retention_duration = var.project_logging_config_retention_period_in_days
  defined_tags       = { "${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
}

# Create OCI Notification

resource "oci_ons_notification_topic" "test_notification_topic" {
  compartment_id = var.compartment_ocid
  name           = "devopstopic_${random_string.deploy_id.result}"
  defined_tags   = { "${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
}

# Create devops project

resource "oci_devops_project" "test_project" {
  compartment_id = var.compartment_ocid
  name           = "devopsproject_${random_string.deploy_id.result}"

  notification_config {
    #Required
    topic_id = oci_ons_notification_topic.test_notification_topic.id
  }

  #Optional
  description  = var.project_description
  defined_tags = { "${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
}
