# Instance Always Free
resource "oci_core_instance" "always_free_instance" {
  availability_domain = data.oci_identity_availability_domains.ad.availability_domains[0].name
  compartment_id      = oci_identity_compartment.compartment.id
  shape               = var.instance_shape

  create_vnic_details {
    assign_public_ip = true
    subnet_id        = oci_core_subnet.subnet.id
  }

  source_details {
    source_id   = "ocid1.image.oc1.eu-paris-1.aaaaaaaa2hq6wa3dwoo5u7aaeqsgyxpxn4md4lpwkyac6dznvfk7imfqr24a"
    source_type = "image"

    /**
    Issue in the OCI provider.
    See : https://github.com/oracle/terraform-provider-oci/issues/2102
    instance_source_image_filter_details {
      compartment_id = var.tenancy_ocid
      operating_system = "Canonical Ubuntu"
      operating_system_version = "22.04"
    }
    **/
  }

  metadata = {
    ssh_authorized_keys = file(var.ssh_public_key_path)
    user_data = base64encode(templatefile("${path.module}/resources/userdata.sh", {}))
  }
}

data "oci_identity_availability_domains" "ad" {
  compartment_id = var.tenancy_ocid
}