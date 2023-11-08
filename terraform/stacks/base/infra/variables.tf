# Declaration of variables that should be set in the *.tfvars file
# Common variables
variable "organization" {
  description = "Organization Code"
  type        = string    
}
variable "aws_account_id" {
  description = "AWS Account Id"
  type        = string    
}
variable "environment" {
  description = "Environment"
  type        = string    
}
variable "technical_owner" {
  description = "Email address of technical owner"
  type        = string       
}
variable "service" {
  description = "Service name"
  type        = string      
  validation {
    condition     = length(var.service) < 10
    error_message = "The service value must be a less 10 characters"
  }    
}
variable "stack_name" {
  description = "Stack name"
  type        = string       
}
variable "region" {
  description = "Default AWS region"
  type        = string       
}

# Billing Alarm Variables
variable "create_sns_topic" {
  description = "Creates a SNS Topic if `true`."
  type        = bool
}
variable "sns_topic_arns" {
  description = "List of SNS topic ARNs to be used. If `create_sns_topic` is `true`, it merges the created SNS Topic by this module with this list of ARNs"
  type        = list(string)
  default     = []
}
variable "currency" {
  description = "Short notation for currency type (e.g. USD, CAD, EUR)"
  type        = string
  default     = "AUD"
}
variable "monthly_billing_threshold" {
  description = "The threshold for which estimated monthly charges will trigger the metric alarm."
  type        = string
  default     = "30"
}