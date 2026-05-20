CLASS zcl_products_wind DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_rap_query_provider .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_PRODUCTS_WIND IMPLEMENTATION.


  METHOD if_rap_query_provider~select.
   DATA(top)     = io_request->get_paging( )->get_page_size( ).
    DATA(skip)    = io_request->get_paging( )->get_offset( ).
    DATA(requested_fields)  = io_request->get_requested_elements( ).
    DATA(sort_order)    = io_request->get_sort_elements( ).
    data(filter) = io_request->get_filter( ).

    DATA:
      ls_entity_key    TYPE ztest_northwind1=>tys_product,
      ls_business_data TYPE ztest_northwind1=>tys_product,
      lt_business_data TYPE TABLE OF ztest_northwind1=>tys_product,
      lo_http_client   TYPE REF TO if_web_http_client,
      lo_client_proxy  TYPE REF TO /iwbep/if_cp_client_proxy.



    TRY.
        " Create http client
        DATA(lo_destination) = cl_http_destination_provider=>create_by_url( 'https://services.odata.org' ).
        lo_http_client = cl_web_http_client_manager=>create_by_http_destination( lo_destination ).
        lo_client_proxy = /iwbep/cl_cp_factory_remote=>create_v2_remote_proxy(
          EXPORTING
             is_proxy_model_key       = VALUE #( repository_id       = 'DEFAULT'
                                                 proxy_model_id      = 'ZTEST_NORTHWIND1'
                                                 proxy_model_version = '0001' )
            io_http_client             = lo_http_client
            iv_relative_service_root   = '/v2/northwind/northwind.svc' ).

        ASSERT lo_http_client IS BOUND.

        DATA: lo_read_list_request    TYPE REF TO /iwbep/if_cp_request_read_list,
              lo_entity_list_resource TYPE REF TO /iwbep/if_cp_resource_list,
              lo_read_list_response   TYPE REF TO /iwbep/if_cp_response_read_lst.

        lo_entity_list_resource = lo_client_proxy->create_resource_for_entity_set( 'PRODUCTS' ).
        lo_read_list_request = lo_entity_list_resource->create_request_for_read( ).
        lo_read_list_response = lo_read_list_request->execute( ).
        lo_read_list_response->get_business_data( IMPORTING et_business_data = lt_business_data ).

      CATCH /iwbep/cx_cp_remote INTO DATA(lx_remote).

      CATCH /iwbep/cx_gateway INTO DATA(lx_gateway).

      CATCH cx_web_http_client_error INTO DATA(lx_web_http_client_error).

        RAISE SHORTDUMP lx_web_http_client_error.

    ENDTRY.

    io_response->set_total_number_of_records( lines( lt_business_data  ) ).

    TYPES : tty_products TYPE STANDARD TABLE OF zi_products_wind WITH EMPTY KEY.


    DATA(lt_data) = VALUE tty_products(
      FOR ls_data IN lt_business_data
      ( product_id = ls_data-product_id
        category_id = ls_data-category_id
        product_name = ls_data-product_name
        quantity_per_unit = ls_data-quantity_per_unit
        supplier_id = ls_data-supplier_id
        unit_price = ls_data-unit_price
        units_on_order = ls_data-units_on_order
        reorder_level = ls_data-reorder_level
        units_in_stock = ls_data-units_in_stock )
    ).
    io_response->set_data( lt_data ).
  ENDMETHOD.
ENDCLASS.
