# The whole developer box is described by a single map variable.
# Everything is a string so the value stays a plain map(string); numeric
# fields (cpu, memory_gb, disk_gb) are converted in locals.
variable "dev_box" {
  type = object({
    id             = string
    classification = string
    owner          = string
    os             = optional(string, "ubuntu-24.04")
    cpu            = optional(string, "4")
    memory_gb      = optional(string, "16")
    disk_gb        = optional(string, "200")
  })
  description = <<-EOT
    Specification of the virtual developer box.

    Required keys:
      id             - unique identifier of the box
      classification - data classification: public | internal | confidential | restricted
      owner          - e-mail address of the person responsible for the box

    Optional keys (defaults applied in locals):
      os, cpu, memory_gb, disk_gb
  EOT

  default = {
    id             = "devbox-001"
    classification = "internal"
    owner          = "t.zhang"
    os             = "ubuntu-24.04"
    cpu            = "4"
    memory_gb      = "16"
    disk_gb        = "200"
  }
}
