variable "service_name" {
  type        = string
  description = "サービス名"
}

variable "env" {
  type        = string
  description = "環境名(stg, prodなど)"
}

variable "service_role_name" {
  type        = string
  description = "リポジトリに格納するイメージのサービス内ロール"
}

variable "image_tag_mutability" {
  type        = string
  default     = "IMMUTABLE"
  description = "タグの上書きを許容するか（MUTABLE、IMMUTABLE）"

  validation {
    condition     = contains(["MUTABLE", "IMMUTABLE"], var.image_tag_mutability)
    error_message = "image_tag_mutabilityはMUTABLEまたはIMMUTABLEを指定してください"
  }
}

variable "lifecycle_policy" {
  type        = string
  default     = null
  nullable    = true
  description = "リポジトリのライフサイクルポリシーJSON。nullの場合は未タグイメージを30日で削除するデフォルトポリシーを使用"

  validation {
    condition = (
      var.lifecycle_policy == null || (
        can(jsondecode(var.lifecycle_policy)) &&
        can(jsondecode(var.lifecycle_policy).rules)
      )
    )
    error_message = "lifecycle_policyはrulesキーを持つ有効なJSON文字列を指定してください"
  }
}
