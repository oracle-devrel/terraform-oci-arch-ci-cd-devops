## Copyright (c) 2022, Oracle and/or its affiliates. 
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

resource "oci_devops_build_run" "test_build_run_1" {

  depends_on = [oci_devops_build_pipeline_stage.test_build_pipeline_stage,
    oci_devops_build_pipeline_stage.test_deliver_artifact_stage,
    oci_devops_build_pipeline_stage.test_deploy_stage,
    oci_devops_deploy_stage.test_deploy_stage,
  module.oci-oke[0].node_pool]

  #Required
  build_pipeline_id = oci_devops_build_pipeline.test_build_pipeline.id

  #Optional
  display_name = "build_run_${random_id.tag.hex}"

  provisioner "local-exec" {
    command = "sleep 300"
  }

}

# output "build_digest_output" {
#   value = oci_devops_build_run.test_build_run.build_outputs[0].delivered_artifacts[0].items[0].delivered_artifact_hash
# }