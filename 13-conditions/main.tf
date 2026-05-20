variable "x" {}

output "x" {
  value = var.x % 2 == 1 ? "Given number is Odd Number" : "Given number is Even Number"
}




