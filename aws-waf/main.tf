resource "aws_wafregional_ipset" "this" {
  for_each = var.rules

  name = each.key

  ip_set_descriptor {
    type  = each.value["ip_type"]
    value = each.value["ip_cidr"]
  }
}

resource "aws_wafregional_rule" "this" {
  for_each    = var.rules
  name        = each.key
  metric_name = each.key

  predicate {
    data_id = aws_wafregional_ipset.this[each.key].id
    negated = false
    type    = each.value["predicate_type"] #"IPMatch"
  }

}

resource "aws_wafregional_web_acl" "this" {
  name        = var.name
  metric_name = var.name

  default_action {
    type = var.acl_default_action #"ALLOW"
  }

  dynamic "rule" {
    for_each = var.rules

    content {
      action {
        type = rule.value["action_type"] #"BLOCK"
      }

      priority = rule.value["priority"] #1
      rule_id  = aws_wafregional_rule.this[rule.key].id
      type     = rule.value["type"] #"REGULAR"
    }
  }
}

resource "aws_wafregional_web_acl_association" "this" {
  resource_arn = var.association_resource_arn
  web_acl_id   = aws_wafregional_web_acl.this.id
}