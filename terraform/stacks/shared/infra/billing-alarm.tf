locals {
  alarm = {
    name                = "account-billing-alarm-${lower(var.currency)}-${var.env_profile}"
    description         = var.aws_account_id == null ? "Billing consolidated alarm >= ${var.currency} ${var.monthly_billing_threshold}" : "Billing alarm account ${var.aws_account_id} >= ${var.currency} ${var.monthly_billing_threshold}"
    comparison_operator = "GreaterThanOrEqualToThreshold"
    evaluation_periods  = "1"
    metric_name         = "EstimatedCharges"
    namespace           = "AWS/Billing"
    period              = "28800"
    statistic           = "Maximum"
    threshold           = var.monthly_billing_threshold
    alarm_actions       = var.create_sns_topic ? concat([aws_sns_topic.billing_alarm[0].arn], var.sns_topic_arns) : var.sns_topic_arns

    dimensions = {
      currency       = var.currency
      linked_account = var.aws_account_id == null ? data.aws_caller_identity.current.account_id : var.aws_account_id
    }
  }
}
resource "aws_sns_topic" "billing_alarm" {
  count             = var.create_sns_topic ? 1 : 0
  name              = "billing_alarm-${lower(var.currency)}-${var.env_profile}"
  kms_master_key_id = data.aws_kms_key.keys.arn
  tags              = merge({ Name = format("%s-billing_alarm", local.prefix_name_tag) }, local.default_tags)
}
resource "aws_sns_topic_subscription" "billing_alarm" {
  count     = var.create_sns_topic ? 1 : 0
  topic_arn = aws_sns_topic.billing_alarm[0].arn
  protocol  = "email"
  endpoint  = var.create_sns_email
}
resource "aws_cloudwatch_metric_alarm" "billing_alarm" {
  alarm_name          = lookup(local.alarm, "name")
  alarm_description   = lookup(local.alarm, "description")
  comparison_operator = lookup(local.alarm, "comparison_operator")
  evaluation_periods  = lookup(local.alarm, "evaluation_periods", "1")
  metric_name         = lookup(local.alarm, "metric_name")
  namespace           = lookup(local.alarm, "namespace", "AWS/Billing")
  period              = lookup(local.alarm, "period", "28800")
  statistic           = lookup(local.alarm, "statistic", "Maximum")
  threshold           = lookup(local.alarm, "threshold", "30")
  alarm_actions       = lookup(local.alarm, "alarm_actions")

  dimensions = {
    Currency      = lookup(lookup(local.alarm, "dimensions"), "currency")
    LinkedAccount = lookup(lookup(local.alarm, "dimensions"), "linked_account", null)
  }

  tags = merge({ Name = format("%s-billing_alarm", local.prefix_name_tag) }, local.default_tags)
}