@AbapCatalog.sqlViewName: 'ZSTYICLNT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Client'
define root view ZSTY_I_CLNT 
  as select from zsty_d_client0 as Clients
  
  composition [1..*] of ZSTY_I_APP as _Appointment
  
{ 

  key client_uuid           as ClientUuid,

      client_id             as ClientId,
      client_phone_number   as ClientPhoneNumber,
      client_first_name     as ClientFirstName,
      client_last_name      as ClientLastName,
      
      @Semantics.user.createdBy: true
      local_created_by      as LocalCreatedBy,
      @Semantics.systemDateTime.createdAt: true
      local_created_at      as LocalCreatedAt,
      @Semantics.user.lastChangedBy: true
      local_last_changed_by as LocalLastChangedBy,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_changed_at as LocalLastChangedAt,             
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at       as LastChangedAt,
      
      'sap-icon://customer' as ImageUrl,
      
      _Appointment
}
