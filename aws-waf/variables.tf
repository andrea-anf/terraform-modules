variable "name" {
  type        = string
  description = "The name or description of the web ACL"
}

variable "rules" {
  type = map(object({
    type           = string
    predicate_type = string
    action_type    = string
    ip_type        = string
    ip_cidr        = string
    priority       = number
  }))
  description = "List of rule to apply to WAF ACL"
}

/*  */

/* 
variable rule_name {
  type        = string
  description = "The name or description of the rule"
}

variable rule_type {
  type        = string
  description = "The rule type, either REGULAR, as defined by Rule, RATE_BASED, as defined by RateBasedRule, or GROUP, as defined by RuleGroup. The default is REGULAR. If you add a RATE_BASED rule, you need to set type as RATE_BASED. If you add a GROUP rule, you need to set type as GROUP"
}

variable rule_predicate_type {
  type        = string
  description = "The type of predicate in a rule. Valid values: ByteMatch, GeoMatch, IPMatch, RegexMatch, SizeConstraint, SqlInjectionMatch, or XssMatch"
}

variable rule_action_type {
  type        = string
  description = "Configuration block of the action that CloudFront or AWS WAF takes when a web request matches the conditions in the rule"
}

variable rule_priority {
  type        = number
  description = "Specifies the order in which the rules in a WebACL are evaluated. Rules with a lower value are evaluated before rules with a higher value"
}
 */
variable "acl_default_action" {
  type        = string
  description = "The action that you want AWS WAF Regional to take when a request doesn't match the criteria in any of the rules that are associated with the web ACL"
}

variable "association_resource_arn" {
  type        = string
  description = "ARN of the resource to associate with. For example, an Application Load Balancer or API Gateway Stage"
}
