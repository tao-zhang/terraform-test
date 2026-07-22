output "name" {
  description = "Hostname of the virtual developer box."
  value       = random_pet.hostname.id
}

output "dev_box" {
  description = "Rendered specification of the virtual developer box."
  value       = terraform_data.dev_box.output
}

output "data_disk" {
  description = "Dummy data disk attached to the box."
  value       = terraform_data.data_disk.output
}
