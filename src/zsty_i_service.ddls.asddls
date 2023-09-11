@AbapCatalog.sqlViewName: 'ZSTYISERVICE'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Serch help for service'
define view ZSTY_I_SERVICE as select from zsty_d_service0 {

    key service_id as ServiceId,
      service_name as ServiceName

}
