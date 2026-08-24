# Dummy hostname resource
resource "random_pet" "hostname" {
  length    = 2
  separator = "-"
  prefix    = var.dev_box.id
}

# The "virtual machine" itself: a built-in terraform_data resource that just
# carries the rendered specification in state.
resource "terraform_data" "dev_box" {
  # Re-create the box when its hardware or image changes.
  triggers_replace = {
    os        = var.dev_box.os
    cpu       = var.dev_box.cpu
    memory_gb = var.dev_box.memory_gb
    disk_gb   = var.dev_box.disk_gb
  }

  input = {
    instance_id    = var.dev_box.id
    classification = var.dev_box.classification
    owner          = var.dev_box.owner
    hostname       = random_pet.hostname.id
    os             = var.dev_box.os
    cpu            = tonumber(var.dev_box.cpu)
    memory_gb      = tonumber(var.dev_box.memory_gb)
    disk_gb        = tonumber(var.dev_box.disk_gb)
  }
}

# Dummy attached disk.
resource "terraform_data" "data_disk" {
  input = {
    name        = "${var.dev_box.id}-data"
    size_gb     = tonumber(var.dev_box.disk_gb)
    attached_to = terraform_data.dev_box.output.instance_id
  }
}
