module "rgm" {
  source  = "../../Modules/1RGS"
  rgnames = var.rgnames

}

module "vnetm" {
  depends_on = [module.rgm]
  source     = "../../Modules/2VNETS"
  vnets      = var.vnets

}
module "subnetm" {
  depends_on = [module.vnetm]
  source     = "../../Modules/3SUBNETS"
  subnets    = var.subnets
}

module "pipm" {
  depends_on = [module.rgm]
  source     = "../../Modules/4PUBLIC IPS"
  pips       = var.pips

}

module "nicm" {
  depends_on = [module.rgm, module.vnetm, module.subnetm, module.pipm]
  source     = "../../Modules/5NIC"
  nics       = var.nics

}
module "nsgm" {
  depends_on    = [module.rgm]
  source        = "../../Modules/6NSG"
  nsgs          = var.nsgs
  security_rule = var.security_rule
}


module "nsgassm" {
  depends_on = [module.rgm, module.vnetm, module.subnetm, module.nicm]
  source     = "../../Modules/7NSGASS"
  nsgass     = var.nsgass
}


module "vms" {
  depends_on = [module.rgm, module.nicm]
  source     = "../../Modules/8VM"
  vms        = var.vms

}


