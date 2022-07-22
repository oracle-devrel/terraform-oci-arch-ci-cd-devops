## Copyright (c) 2022, Oracle and/or its affiliates. 
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

resource "oci_devops_deploy_environment" "test_environment" {
  display_name            = "oke_environment_${random_id.tag.hex}"
  description             = "oke based enviroment"
  deploy_environment_type = "OKE_CLUSTER"
  project_id              = oci_devops_project.test_project.id
  cluster_id              = var.create_new_oke_cluster ? module.oci-oke[0].cluster.id : var.existent_oke_cluster_id
  defined_tags            = { "${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
}

#  Add var to choose between an existing Articat and an inline one

resource "oci_devops_deploy_artifact" "test_deploy_oke_artifact" {
  argument_substitution_mode = var.deploy_artifact_argument_substitution_mode
  deploy_artifact_type       = var.deploy_artifact_type
  project_id                 = oci_devops_project.test_project.id

  deploy_artifact_source {
    deploy_artifact_source_type = var.deploy_artifact_source_type #INLINE,GENERIC_ARTIFACT_OCIR
    base64encoded_content       = templatefile("${path.module}/manifest/gettingstarted-manifest.yaml", { region = "${local.ocir_docker_repository}", name = "${local.ocir_namespace}", image = "${oci_artifacts_container_repository.test_container_repository.display_name}", hash = "$${BUILDRUN_HASH}", namespace = "$${namespace}" })
  }
  defined_tags = { "${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
}

resource "oci_devops_deploy_pipeline" "test_deploy_pipeline" {
  #Required
  project_id   = oci_devops_project.test_project.id
  description  = var.deploy_pipeline_description
  display_name = "devops-oke-pipeline_${random_id.tag.hex}"

  deploy_pipeline_parameters {
    items {
      name          = var.deploy_pipeline_deploy_pipeline_parameters_items_name
      default_value = var.deploy_pipeline_deploy_pipeline_parameters_items_default_value
      description   = var.deploy_pipeline_deploy_pipeline_parameters_items_description
    }
  }
  defined_tags = { "${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
}

resource "oci_devops_deploy_stage" "test_deploy_stage" {
  #Required
  deploy_pipeline_id = oci_devops_deploy_pipeline.test_deploy_pipeline.id
  deploy_stage_predecessor_collection {
    #Required
    items {
      #Required
      id = oci_devops_deploy_pipeline.test_deploy_pipeline.id
    }
  }
  deploy_stage_type = var.deploy_stage_deploy_stage_type


  description  = var.deploy_stage_description
  display_name = "deploy_to_OKE_${random_id.tag.hex}"

  kubernetes_manifest_deploy_artifact_ids = [oci_devops_deploy_artifact.test_deploy_oke_artifact.id]
  oke_cluster_deploy_environment_id       = oci_devops_deploy_environment.test_environment.id
  defined_tags                            = { "${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
}

/*
resource "oci_devops_deployment" "test_deployment1" {
  count      = var.execute_deployment ? 1 : 0
  depends_on = [oci_devops_deploy_stage.test_deploy_stage]
  #Required
  deploy_pipeline_id = oci_devops_deploy_pipeline.test_deploy_pipeline.id
  deployment_type    = "PIPELINE_DEPLOYMENT"

  #Optional
  display_name = "devopsdeployment_${random_id.tag.hex}"
}
*/
