CLASS lhc_Client DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR Client RESULT result.
    METHODS createnewclient FOR DETERMINE ON SAVE
      IMPORTING keys FOR client~createnewclient.
    METHODS checkphonenumber FOR VALIDATE ON SAVE
      IMPORTING keys FOR client~checkphonenumber.

ENDCLASS.

CLASS lhc_Client IMPLEMENTATION.

  METHOD get_instance_features.
  ENDMETHOD.

  METHOD createNewClient.

    READ ENTITIES OF ZSTY_I_CLNT IN LOCAL MODE
      ENTITY Client
        FIELDS ( ClientId )
          WITH CORRESPONDING #( keys )
    RESULT DATA(lt_clients).

    DATA(ls_client) = lt_clients[ 1 ].

    CHECK ls_client-ClientId IS INITIAL.

    SELECT
        MAX( client_id )
      FROM zsty_d_client0
      INTO @DATA(lv_maxID).

    DATA(lv_nextID) = condense( val = CONV string( lv_maxID + 1 ) ).


    MODIFY ENTITIES OF ZSTY_I_CLNT IN LOCAL MODE
      ENTITY Client
        UPDATE
          FIELDS ( ClientId )
          WITH VALUE #( FOR key IN keys
                          ( %key = key-%key
                            ClientId = lv_nextID ) )
    FAILED   DATA(lt_failed)
    REPORTED DATA(lt_reported).

  ENDMETHOD.

  METHOD checkPhoneNumber.

    READ ENTITIES OF ZSTY_I_CLNT IN LOCAL MODE
      ENTITY Client
        FIELDS ( ClientPhoneNumber )
          WITH CORRESPONDING #( keys )
    RESULT DATA(lt_clients).

    DATA(ls_client) = lt_clients[ 1 ].

   CHECK CONV string( ls_client-ClientPhoneNumber ) CN ` 0123456789()+-`.

    APPEND VALUE #( ClientUuid = ls_client-ClientUuid )
       TO failed-client.

    APPEND VALUE #( ClientUuid                 = ls_client-ClientUuid
                    %state_area                = 'checkPhoneNumber'
                    %is_draft                  = if_abap_behv=>mk-on
                    %msg                       = NEW zcm_sty_rap(
                                                     severity = if_abap_behv_message=>severity-error
                                                     textid   = zcm_sty_rap=>incorrect_phone_number )
                    %element-ClientPhoneNumber = if_abap_behv=>mk-on )
       TO reported-client.

  ENDMETHOD.

ENDCLASS.
