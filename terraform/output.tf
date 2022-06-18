output "internal_ip_address_vm_instance_ForEach" {
  value = values(yandex_compute_instance.ForEach).*.network_interface.0.ip_address
}

output "external_ip_address_vm_instance_ForEach" {
  value = values(yandex_compute_instance.ForEach).*.network_interface.0.nat_ip_address
}

output "internal_ip_address_vm_instance_Node" {
  value = yandex_compute_instance.Node.*.network_interface.0.ip_address
}

output "external_ip_address_vm_instance_Node" {
  value = yandex_compute_instance.Node.*.network_interface.0.nat_ip_address
}
