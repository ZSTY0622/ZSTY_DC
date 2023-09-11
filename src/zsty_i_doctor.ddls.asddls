@AbapCatalog.sqlViewName: 'ZSTYIDOCTOR'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Serch help for doctor'
define view ZSTY_I_DOCTOR as select from zsty_d_doctor0 {

    key doctor_id     as DoctorId,
    doctor_first_name as DoctorFirstName,
    doctor_last_name  as DoctorLastName

}
