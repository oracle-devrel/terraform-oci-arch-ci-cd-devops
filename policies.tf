## Copyright (c) 2022, Oracle and/or its affiliates.
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

resource "oci_identity_dynamic_group" "devopsgroup1" {
  provider       = oci.home_region
  name           = "devopsdyngroup-${random_id.tag.hex}"
  description    = "DevOps deploy pipeline dynamic group"
  compartment_id = var.tenancy_ocid
  matching_rule  = "ALL {resource.type = 'devopsdeploypipeline', resource.compartment.id = '${var.compartment_ocid}'}"
}

resource "oci_identity_dynamic_group" "devopsgroup2" {
  provider       = oci.home_region
  name           = "CodeReposDynamicGroup-${random_id.tag.hex}"
  description    = "DevOps code repository dynamic group"
  compartment_id = var.tenancy_ocid
  matching_rule  = "ALL {resource.type = 'devopsrepository'}"
}


resource "oci_identity_dynamic_group" "devopsgroup3" {
  provider       = oci.home_region
  name           = "MyDynamicGroup-${random_id.tag.hex}"
  description    = "DevOps repository build pipeline dynamic group"
  compartment_id = var.tenancy_ocid
  matching_rule  = "ALL {resource.type = 'devopsbuildpipeline'}"
}


resource "oci_identity_policy" "devopspolicy" {
  provider       = oci.home_region
  name           = "devops-policies-${random_id.tag.hex}"
  description    = "policy created for devops"
  compartment_id = var.compartment_ocid

  statements = [
    "Allow group Administrators to manage devops-family in compartment id ${var.compartment_ocid}",
    "Allow group Administrators to manage all-artifacts in compartment id ${var.compartment_ocid}",
    "Allow dynamic-group ${oci_identity_dynamic_group.devopsgroup1.name} to manage all-resources in compartment id ${var.compartment_ocid}",
  ]
}

resource "oci_identity_policy" "devopsrootpolicy" {
  provider       = oci.home_region
  name           = "devops-root-policies-${random_id.tag.hex}"
  description    = "policy created for root compartment"
  compartment_id = var.tenancy_ocid

  statements = [
    "Allow dynamic-group ${oci_identity_dynamic_group.devopsgroup2.name} to manage all-resources in tenancy",
    "Allow dynamic-group ${oci_identity_dynamic_group.devopsgroup3.name} to manage all-resources in tenancy",
  ]
}
