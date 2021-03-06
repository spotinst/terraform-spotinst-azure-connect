variable "spotinst_token" {
  type        = string
  description = "Spotinst API Token"
  sensitive   = true
}
variable "debug" {
  type        = bool
  description = "Add flag to expose sensitive variables for troubleshooting"
  default     = false
}
variable "end_date" {
  type        = string
  description = "(Optional) The End Date which the Password is valid until, formatted as a RFC3339 date string (e.g. 2018-01-01T01:02:03Z). Changing this field forces a new resource to be created."
  default     = "2099-01-01T01:02:03Z"
}
variable "app_display_name" {
  type        = string
  description = "Display name of the App Registrant"
  default     = null
}
variable "secret_display_name" {
  type        = string
  description = "Display name of the secret"
  default     = null
}
variable "actions" {
  type = list(string)
  description = "list of policies to add to the Spot Role "
  default = [
    "Microsoft.Authorization/roleAssignments/read",
    "Microsoft.Compute/availabilitySets/read",
    "Microsoft.Compute/availabilitySets/vmSizes/read",
    "Microsoft.Compute/disks/read",
    "Microsoft.Compute/disks/write",
    "Microsoft.Compute/disks/delete",
    "Microsoft.Compute/disks/beginGetAccess/action",
    "Microsoft.Compute/images/read",
    "Microsoft.Compute/images/write",
    "Microsoft.Compute/snapshots/read",
    "Microsoft.Compute/virtualMachines/*",
    "Microsoft.Compute/virtualMachineScaleSets/read",
    "Microsoft.Compute/virtualMachineScaleSets/instanceView/read",
    "Microsoft.Compute/virtualMachineScaleSets/networkInterfaces/read",
    "Microsoft.Compute/virtualMachineScaleSets/publicIPAddresses/read",
    "Microsoft.Compute/virtualMachineScaleSets/virtualMachines/extensions/read",
    "Microsoft.ContainerService/managedClusters/read",
    "Microsoft.ContainerService/managedClusters/agentPools/read",
    "Microsoft.Insights/MetricDefinitions/Read",
    "Microsoft.Insights/Metrics/Read",
    "Microsoft.Insights/AutoscaleSettings/Read",
    "Microsoft.Insights/AutoscaleSettings/providers/Microsoft.Insights/MetricDefinitions/Read",
    "Microsoft.ManagedIdentity/userAssignedIdentities/assign/action",
    "Microsoft.ManagedIdentity/userAssignedIdentities/read",
    "Microsoft.ManagedIdentity/identities/read",
    "Microsoft.NetApp/netAppAccounts/read",
    "Microsoft.NetApp/netAppAccounts/write",
    "Microsoft.NetApp/netAppAccounts/capacityPools/write",
    "Microsoft.NetApp/netAppAccounts/capacityPools/read",
    "Microsoft.NetApp/netAppAccounts/capacityPools/delete",
    "Microsoft.NetApp/netAppAccounts/capacityPools/volumes/write",
    "Microsoft.NetApp/netAppAccounts/capacityPools/volumes/read",
    "Microsoft.NetApp/netAppAccounts/capacityPools/volumes/delete",
    "Microsoft.NetApp/netAppAccounts/capacityPools/volumes/snapshots/write",
    "Microsoft.NetApp/netAppAccounts/capacityPools/volumes/snapshots/read",
    "Microsoft.NetApp/netAppAccounts/capacityPools/volumes/ReplicationStatus/read",
    "Microsoft.NetApp/netAppAccounts/capacityPools/volumes/DeleteReplication/action",
    "Microsoft.NetApp/netAppAccounts/capacityPools/volumes/ResyncReplication/action",
    "Microsoft.NetApp/netAppAccounts/capacityPools/volumes/AuthorizeReplication/action",
    "Microsoft.NetApp/netAppAccounts/capacityPools/volumes/ReInitializeReplication/action",
    "Microsoft.NetApp/netAppAccounts/capacityPools/volumes/BreakReplication/action",
    "Microsoft.Network/applicationGateways/read",
    "Microsoft.Network/applicationGateways/backendhealth/action",
    "Microsoft.Network/applicationGateways/backendAddressPools/join/action",
    "Microsoft.Network/applicationSecurityGroups/joinIpConfiguration/action",
    "Microsoft.Network/applicationSecurityGroups/read",
    "Microsoft.Network/dnsZones/read",
    "Microsoft.Network/dnsZones/A/read",
    "Microsoft.Network/dnsZones/write",
    "Microsoft.Network/dnsZones/A/write",
    "Microsoft.Network/dnsZones/A/delete",
    "Microsoft.Network/loadBalancers/read",
    "Microsoft.Network/loadBalancers/backendAddressPools/read",
    "Microsoft.Network/loadBalancers/backendAddressPools/write",
    "Microsoft.Network/loadBalancers/backendAddressPools/join/action",
    "Microsoft.Network/networkInterfaces/read",
    "Microsoft.Network/networkInterfaces/write",
    "Microsoft.Network/networkInterfaces/delete",
    "Microsoft.Network/networkInterfaces/join/action",
    "Microsoft.Network/networkInterfaces/ipconfigurations/read",
    "Microsoft.Network/networkSecurityGroups/read",
    "Microsoft.Network/networkSecurityGroups/join/action",
    "Microsoft.Network/publicIPAddresses/read",
    "Microsoft.Network/publicIPAddresses/write",
    "Microsoft.Network/publicIPAddresses/delete",
    "Microsoft.Network/publicIPAddresses/join/action",
    "Microsoft.Network/routeTables/read",
    "Microsoft.Network/virtualNetworks/read",
    "Microsoft.Network/virtualNetworks/subnets/join/action",
    "Microsoft.Network/virtualNetworks/subnets/read",
    "Microsoft.Network/virtualNetworks/virtualMachines/read",
    "Microsoft.Network/virtualNetworks/subnets/write",
    "Microsoft.Resources/tags/write",
    "Microsoft.Resources/subscriptions/resourceGroups/read"
  ]
}