@EndUserText.label: 'Consumption CDS for Appointments'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true


define view entity ZSTY_C_APP 
  as projection on ZSTY_I_APP //as Appointment
  
{

      key  AppointmentUuid,
           ClientUuid,                    
           
           AppointmentId,
           AppointmppointmentDate,
           AppointmentBegTime,
           AppointmentEndTime,
           
           @UI.textArrangement: #TEXT_LAST
           @ObjectModel.text.element: [ 'ClientLastName' ] 
           ClientId,
           
           @UI.textArrangement: #TEXT_LAST
           @ObjectModel.text.element: [ 'DoctorLastName' ]                                
           DoctorId, 
            
           @UI.textArrangement: #TEXT_LAST
           @ObjectModel.text.element: [ 'ServiceName' ]   
           ServiceId,
           
           @UI.textArrangement: #TEXT_ONLY
           @ObjectModel.text.element: [ 'StatusName' ]          
           Status,
           
           @UI.hidden: true
           _Client.ClientLastName,
           @UI.hidden: true
           _Service.ServiceName,
           @UI.hidden: true
           _Doctor.DoctorLastName,
           @UI.hidden: true
           _Status.StatusName,    
                    
           LocalCreatedBy,
           LocalCreatedAt,
           LocalLastChangedBy,
           LocalLastChangedAt,            
           LastChangedAt, 
      
           ImageUrl,                                      
           
           /* Associations */
           _Client : redirected to parent ZSTY_C_CLNT
                  
}
