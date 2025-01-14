
# Création d'un compartiment
resource "oci_identity_compartment" "compartment" {
  compartment_id = var.tenancy_ocid
  name           = "${var.environment}-compartment"
  description    = "Compartment for ${var.environment} environment"
}


resource "oci_core_vcn" "vcn" {
  compartment_id = oci_identity_compartment.compartment.id
  cidr_block     = var.vcn_cidr
  display_name   = "${var.environment}-VCN"
  dns_label      = "${var.environment}-vcn"
}

resource "oci_core_internet_gateway" "ig" {
  compartment_id = oci_identity_compartment.compartment.id
  vcn_id         = oci_core_vcn.vcn.id
  display_name   = "${var.environment}-Internet-Gateway"
}

# Create a Subnet
resource "oci_core_subnet" "subnet" {
  compartment_id = oci_identity_compartment.compartment.id
  vcn_id         = oci_core_vcn.vcn.id
  cidr_block     = var.subnet_cidr
  display_name   = "${var.environment}-Subnet"
  dns_label = "${var.environment}-subnet"

  # Assign a public IP if this is a public subnet
  prohibit_public_ip_on_vnic = false
}
