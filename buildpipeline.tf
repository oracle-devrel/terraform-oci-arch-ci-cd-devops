## Copyright (c) 2022, Oracle and/or its affiliates. 
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

resource "oci_devops_build_pipeline" "test_build_pipeline" {

  #Required
  project_id = oci_devops_project.test_project.id

  description  = var.build_pipeline_description
  display_name = var.build_pipeline_display_name
}

