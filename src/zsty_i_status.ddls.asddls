@AbapCatalog.sqlViewName: 'ZSTYISTATUS'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Serch help for status'

define view ZSTY_I_STATUS
  as select from zsty_d_status0 as Status 
  {
    key statusid as StatusId,
      statusname as StatusName
}
