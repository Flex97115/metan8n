output "instance_public_ip" {
  value = oci_core_instance.always_free_instance.public_ip
}