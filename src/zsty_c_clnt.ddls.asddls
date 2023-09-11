@EndUserText.label: 'Consumption CDS for Clients'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
//@Search.searchable: true
//@ObjectModel.semanticKey: ['ClientUuid']


define root view entity ZSTY_C_CLNT 
  provider contract transactional_query
  as projection on ZSTY_I_CLNT //as Clients
  
  {
     key  ClientUuid,
          ClientId,
          ClientFirstName,
          ClientLastName,
          ClientPhoneNumber,

          LocalCreatedBy,
          LocalCreatedAt,
          LocalLastChangedBy,
          LocalLastChangedAt, 
          LastChangedAt,           
     
          ImageUrl,           
                  
          /* Associations */
           _Appointment : redirected to composition child ZSTY_C_APP
         
}
