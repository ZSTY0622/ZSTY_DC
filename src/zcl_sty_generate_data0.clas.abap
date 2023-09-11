CLASS zcl_sty_generate_data0 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
    METHODS fill_client
      IMPORTING
        out TYPE REF TO if_oo_adt_classrun_out.
    METHODS fill_doctor
      IMPORTING
        out TYPE REF TO if_oo_adt_classrun_out.
    METHODS fill_service
      IMPORTING
        out TYPE REF TO if_oo_adt_classrun_out.
    METHODS fill_appointment
      IMPORTING
        out TYPE REF TO if_oo_adt_classrun_out.
    METHODS fill_status
      IMPORTING
        out TYPE REF TO if_oo_adt_classrun_out.
ENDCLASS.


CLASS zcl_sty_generate_data0 IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    fill_client( out ).
    fill_doctor( out ).
    fill_service( out ).
    fill_appointment( out ).
    fill_status( out ).

  ENDMETHOD.

  METHOD fill_client.
    DATA: it_data TYPE TABLE OF zsty_d_client0.

      it_data = VALUE #(
      ( client_uuid = '2A6E73C24CC41EDD9BEAFDD40818B0FF' client_id = '1' client_phone_number = '+375(44)546-32-11' client_first_name = 'Natali' client_last_name = 'Lublina' )
      ( client_uuid = '2A6E73C24CC41EDD9BEAFDD40818B2FF' client_id = '2' client_phone_number = '+375(44)546-32-12' client_first_name = 'Lusya'  client_last_name = 'Suhaya' )
      ( client_uuid = '2A6E73C24CC41EDD9BEAFDD40818B3FF' client_id = '3' client_phone_number = '+375(44)546-32-13' client_first_name = 'Nikola' client_last_name = 'Zuckov' )
      ( client_uuid = '2A6E73C24CC41EDD9BEAFDD40818B4FF' client_id = '4' client_phone_number = '+375(44)546-32-14' client_first_name = 'Pavel'  client_last_name = 'Morozov' )
      ( client_uuid = '2A6E73C24CC41EDD9BEAFDD40818B5FF' client_id = '5' client_phone_number = '+375(44)546-32-15' client_first_name = 'Ivan'   client_last_name = 'Zub' )
      ).
          DELETE FROM zsty_d_client0.
          INSERT zsty_d_client0 FROM TABLE @It_data.
     IF sy-subrc = 0.
       out->write( |{ sy-dbcnt } records are inserted!| ).
     ELSE.
       out->write( 'error' ).
     ENDIF.

     COMMIT WORK.

   ENDMETHOD.

  METHOD fill_doctor.
    DATA: it_data TYPE TABLE OF zsty_d_doctor0.

      it_data = VALUE #(
      ( doctor_id = '1'  doctor_first_name = 'Alex'    doctor_last_name = 'Smirnov' specialization_id = '1' )
      ( doctor_id = '2'  doctor_first_name = 'Marina'  doctor_last_name = 'Zubova'  specialization_id = '1' )
      ( doctor_id = '3'  doctor_first_name = 'Oleg'    doctor_last_name = 'Polik'   specialization_id = '2' )
      ( doctor_id = '4'  doctor_first_name = 'Ivan'    doctor_last_name = 'Karibov' specialization_id = '2' )
      ( doctor_id = '5'  doctor_first_name = 'Mark'    doctor_last_name = 'Baranov' specialization_id = '3' )
      ( doctor_id = '6'  doctor_first_name = 'Dmitry'  doctor_last_name = 'Mironov' specialization_id = '4' )
      ( doctor_id = '7'  doctor_first_name = 'Elena'   doctor_last_name = 'Trus'    specialization_id = '5' )
      ).
        DELETE FROM zsty_d_doctor0.
        INSERT zsty_d_doctor0 FROM TABLE @it_data.
        IF sy-subrc = 0.
          out->write( |{ sy-dbcnt } records are inserted!| ).
        ELSE.
          out->write( 'error' ).
        ENDIF.

        COMMIT WORK.

  ENDMETHOD.


  METHOD fill_service.
    DATA: it_data TYPE TABLE OF zsty_d_service0.

      it_data = VALUE #(
      ( service_id = '1'  service_name = 'Consultation of a dentist-therapist'      price = '16.50' duration = '20' specialization_id = '1' specialization_name = 'therapist')
      ( service_id = '2'  service_name = 'Consultation of a dentist-surgeon'        price = '16.50' duration = '20' specialization_id = '2' specialization_name = 'surgeon')
      ( service_id = '3'  service_name = 'Consultation of a dentist-orthodontist'   price = '22.50' duration = '20' specialization_id = '3' specialization_name = 'orthodontist')
      ( service_id = '4'  service_name = 'Consultation of a dentist-orthopedist'    price = '16.50' duration = '20' specialization_id = '4' specialization_name = 'orthopedist')
      ( service_id = '5'  service_name = 'Consultation of a dentist-implantolig'    price = '16.50' duration = '20' specialization_id = '5' specialization_name = 'implantolig')
      ( service_id = '6'  service_name = 'Ultrasonic teeth cleaning'                price = '150'   duration = '60' specialization_id = '1' specialization_name = 'therapist')
      ).
          DELETE FROM zsty_d_service0.
          INSERT zsty_d_service0 FROM TABLE @it_data.
          IF sy-subrc = 0.
            out->write( |{ sy-dbcnt } records are inserted!| ).
          ELSE.
            out->write( 'error' ).
          ENDIF.

          COMMIT WORK.

  ENDMETHOD.

  METHOD fill_appointment.
    DATA: it_data TYPE TABLE OF zsty_d_app0.

      it_data = VALUE #(
      ( appointment_uuid = '2A6E73C24CC41EDD9BEAFDD40828B1FF'  client_uuid = '2A6E73C24CC41EDD9BEAFDD40818B3FF'
        appointment_id = '1'  appointment_date = '20221218'  appointment_beg_time = '165000' appointment_end_time = '171000' client_id = '3' doctor_id = '2' service_id = '1' status = '2')
      ( appointment_uuid = '2A6E73C24CC41EDD9BEB03D16BD8D104'  client_uuid = '2A6E73C24CC41EDD9BEAFDD40818B0FF'
        appointment_id = '2'  appointment_date = '20221226'  appointment_beg_time = '100000' appointment_end_time = '102000' client_id = '1' doctor_id = '7' service_id = '5' status = '2')
      ( appointment_uuid = '2A6E73C24CC41EDD9BEAFDD40828B3FF'  client_uuid = '2A6E73C24CC41EDD9BEAFDD40818B4FF'
        appointment_id = '3'  appointment_date = '20221216'  appointment_beg_time = '085000' appointment_end_time = '091000' client_id = '4' doctor_id = '6' service_id = '4' status = '2')
      ( appointment_uuid = '2A6E73C24CC41EDD9BEAFDD40828B4FF'  client_uuid = '2A6E73C24CC41EDD9BEAFDD40818B5FF'
        appointment_id = '4'  appointment_date = '20221203'  appointment_beg_time = '140000' appointment_end_time = '143000' client_id = '5' doctor_id = '3' service_id = '2' status = '2')
      ( appointment_uuid = '2A6E73C24CC41EDD9BEAFDD40828B5FF'  client_uuid = '2A6E73C24CC41EDD9BEAFDD40818B2FF'
        appointment_id = '5'  appointment_date = '20221203'  appointment_beg_time = '140000' appointment_end_time = '140000' client_id = '2' doctor_id = '1' service_id = '1' status = '2')
      ( appointment_uuid = '2A6E73C24CC41EDD9BEB07DA9DD5D106'  client_uuid = '2A6E73C24CC41EDD9BEAFDD40818B0FF'
        appointment_id = '6'  appointment_date = '20221205'  appointment_beg_time = '140000' appointment_end_time = '140000' client_id = '1' doctor_id = '1' service_id = '1' status = '2')
      ).
        DELETE FROM zsty_d_app0.
        INSERT zsty_d_app0 FROM TABLE @it_data.
        IF sy-subrc = 0.
          out->write( |{ sy-dbcnt } records are inserted!| ).
        ELSE.
          out->write( 'error' ).
        ENDIF.

        COMMIT WORK.

   ENDMETHOD.


  METHOD fill_status.
    DATA: it_data TYPE TABLE OF zsty_d_status0.

      it_data = VALUE #(
      ( statusid = '2'  statusname = 'Booked'   )
      ( statusid = '1'  statusname = 'Canceled' )
      ( statusid = '3'  statusname = 'Done'     )

      ).
        DELETE FROM zsty_d_status0.
        INSERT zsty_d_status0 FROM TABLE @it_data.
        IF sy-subrc = 0.
          out->write( |{ sy-dbcnt } records are inserted!| ).
        ELSE.
          out->write( 'error' ).
        ENDIF.

        COMMIT WORK.

  ENDMETHOD.

ENDCLASS.
