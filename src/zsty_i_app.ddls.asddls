@AbapCatalog.sqlViewName: 'ZSTYIAPP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Appointment'
define view ZSTY_I_APP 
  as select from zsty_d_app0 as Appointment
  
  association to parent ZSTY_I_CLNT as _Client
                                      on $projection.ClientUuid = _Client.ClientUuid  
                                      
//  association [1]    to ZSTY_I_APP as _AppointmentEndTime
//                                      on $projection.AppointmentEndTime = _AppointmentEndTime.AppointmentEndTime                                     
                                      
  association [1]    to ZSTY_I_DOCTOR as _Doctor 
                                      on $projection.DoctorId = _Doctor.DoctorId     
                                                                       
  association [1]    to ZSTY_I_SERVICE as _Service 
                                      on $projection.ServiceId = _Service.ServiceId
                                                                                                                                                                                         
  association [1]    to ZSTY_I_STATUS as _Status 
                                      on $projection.Status = _Status.StatusId
{
   key appointment_uuid      as AppointmentUuid,
       client_uuid           as ClientUuid,
       appointment_id        as AppointmentId,
       appointment_date      as AppointmppointmentDate,
       appointment_beg_time  as AppointmentBegTime,
       appointment_end_time  as AppointmentEndTime,
       client_id             as ClientId,           
       doctor_id             as DoctorId,      
       service_id            as ServiceId,          
       status                as Status,
       
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
        
       _Client,
//       _AppointmentEndTime,
       _Doctor,
       _Service,
       _Status
}
