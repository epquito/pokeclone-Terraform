# SNS Topic
variable "sns_topic_name_eventbridge" {
  description = "Name of the SNS Topic for eventbridge"
  type = string
}

variable "sns_topic_name_eks" {
  description = "Name of the SNS Topic for eks"
  type = string
}
variable "asg_sns_topic_name"{
  description = "Name of the SNS Topic for sns"
  type = string

}

#sns subscriptions 
variable "sns_topic_email_eventbridge" {
  description = "email used for the sns topic"
  type = string
}

variable "sns_subscription_email_EKS" {
  description = "email used for the sns  for EKS"
  type = string
}


variable "asg_sns_subscription_email" {
  description = "email used for the sns topic for ASG of EKS"
  type = string
}



