CLASS lhc_appointment DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR Appointment RESULT result.
    METHODS completeAppointment FOR MODIFY
      IMPORTING keys FOR ACTION Appointment~completeAppointment RESULT result.
    METHODS createNewAppointment FOR DETERMINE ON SAVE
      IMPORTING keys FOR Appointment~createNewAppointment.
    METHODS cancelAppointment FOR MODIFY
      IMPORTING keys FOR ACTION Appointment~cancelAppointment RESULT result.
    METHODS checkStatus FOR VALIDATE ON SAVE
      IMPORTING keys FOR Appointment~checkStatus.
    METHODS checkAppointmentEndTime FOR VALIDATE ON SAVE
      IMPORTING keys FOR Appointment~checkAppointmentEndTime.

ENDCLASS.

CLASS lhc_appointment IMPLEMENTATION.

  METHOD get_instance_features.

    READ ENTITIES OF ZSTY_I_CLNT IN LOCAL MODE
      ENTITY Appointment
        FIELDS ( Status )
        WITH CORRESPONDING #( keys )
    RESULT DATA(lt_Appointment)
    FAILED failed.

    result = VALUE #(
      FOR ls_Appointment IN lt_Appointment (
        %key                                = ls_Appointment-%key
        %features-%action-completeAppointment = COND #( WHEN ls_Appointment-Status = '3' THEN
                                                             if_abap_behv=>fc-o-disabled
                                                        ELSE if_abap_behv=>fc-o-enabled )
        %features-%action-cancelAppointment = COND #( WHEN ls_Appointment-Status = '1' THEN
                                                             if_abap_behv=>fc-o-disabled
                                                        ELSE if_abap_behv=>fc-o-enabled )
      ) ).

  ENDMETHOD.

  METHOD completeAppointment.

    MODIFY ENTITIES OF ZSTY_I_CLNT IN LOCAL MODE
      ENTITY Appointment
        UPDATE
          FIELDS ( Status )
          WITH VALUE #( FOR key IN keys
                          ( %key = key-%key
                            Status = '3' ) )
    FAILED   DATA(lt_failed)
    REPORTED DATA(lt_reported).

    READ ENTITIES OF ZSTY_I_CLNT IN LOCAL MODE
      ENTITY Appointment
        ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(lt_appointments).

    result = VALUE #( FOR ls_appointment IN lt_appointments
                        ( %tky   = ls_appointment-%tky
                          %param = ls_appointment ) ).

  ENDMETHOD.

  METHOD createNewAppointment.

    READ ENTITIES OF ZSTY_I_CLNT IN LOCAL MODE
      ENTITY Appointment
        FIELDS ( AppointmentId
                 AppointmppointmentDate
                 Status )
          WITH CORRESPONDING #( keys )
    RESULT DATA(lt_appointments).

    DATA(ls_appointment) = lt_appointments[ 1 ].

    CHECK ls_appointment-AppointmentId IS INITIAL.

    SELECT
        MAX( appointment_id )
      FROM zsty_d_app0
      INTO @DATA(lv_maxID).

    DATA(lv_nextID) = condense( val = CONV string( lv_maxID + 1 ) ).

    DATA(lv_appointmentdate) = COND d( WHEN ls_appointment-AppointmppointmentDate IS INITIAL THEN
                                            cl_abap_context_info=>get_system_date( )
                                       ELSE ls_appointment-AppointmppointmentDate ).

    DATA(lv_status) = COND string( WHEN ls_appointment-Status IS INITIAL THEN
                                        '2'
                                   ELSE ls_appointment-Status ).

    MODIFY ENTITIES OF ZSTY_I_CLNT IN LOCAL MODE
      ENTITY Appointment
        UPDATE
          FIELDS ( AppointmentId
                   AppointmppointmentDate
                   Status )
          WITH VALUE #( FOR key IN keys
                          ( %key                   = key-%key
                            AppointmentId          = lv_nextID
                            AppointmppointmentDate = lv_appointmentdate
                            Status                 = lv_status ) )
    FAILED   DATA(lt_failed)
    REPORTED DATA(lt_reported).

  ENDMETHOD.

  METHOD cancelAppointment.

    MODIFY ENTITIES OF ZSTY_I_CLNT IN LOCAL MODE
      ENTITY Appointment
        UPDATE
          FIELDS ( Status )
          WITH VALUE #( FOR key IN keys
                          ( %key = key-%key
                            Status = '1' ) )
    FAILED   DATA(lt_failed)
    REPORTED DATA(lt_reported).

    READ ENTITIES OF ZSTY_I_CLNT IN LOCAL MODE
      ENTITY Appointment
        ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(lt_appointments).

    result = VALUE #( FOR ls_appointment IN lt_appointments
                        ( %tky   = ls_appointment-%tky
                          %param = ls_appointment ) ).

  ENDMETHOD.

  METHOD checkStatus.

      READ ENTITIES OF ZSTY_I_CLNT IN LOCAL MODE
      ENTITY Appointment
        FIELDS ( ClientUuid
                 Status )
          WITH CORRESPONDING #( keys )
    RESULT DATA(lt_appointments).

    DATA(ls_appointment) = lt_appointments[ 1 ].

   CHECK  ls_appointment-Status  NOT BETWEEN 1 AND 3.

    APPEND VALUE #( ClientUuid = ls_appointment-ClientUuid )
       TO failed-client.

    APPEND VALUE #( ClientUuid                 = ls_appointment-ClientUuid
                    %state_area                = 'checkStatus'
                    %is_draft                  = if_abap_behv=>mk-on
                    %msg                       = NEW zcm_sty_rap(
                                                     severity = if_abap_behv_message=>severity-error
                                                     textid   = zcm_sty_rap=>incorrect_status ) )
       TO reported-client.
  ENDMETHOD.

  METHOD checkAppointmentEndTime.
        READ ENTITIES OF ZSTY_I_CLNT IN LOCAL MODE
      ENTITY Appointment
        FIELDS ( ClientUuid
                 AppointmentBegTime
                 AppointmentEndTime )
          WITH CORRESPONDING #( keys )
    RESULT DATA(lt_appointments).

    DATA(ls_appointment) = lt_appointments[ 1 ].

      IF ls_appointment-AppointmentEndTime < ls_appointment-AppointmentBegTime.

        APPEND VALUE #( ClientUuid = ls_appointment-ClientUuid )
          TO failed-client.

        APPEND VALUE #( ClientUuid                      = ls_appointment-ClientUuid
                        %state_area                     = 'checkAppointmentEndTime'
                        %is_draft                       = if_abap_behv=>mk-on
                        %msg                            = NEW zcm_sty_rap(
                                                              textid    = zcm_sty_rap=>incorrect_end_time
                                                              severity  = if_abap_behv_message=>severity-error ) )
           TO reported-client.

      ENDIF.

  ENDMETHOD.

ENDCLASS.

*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
