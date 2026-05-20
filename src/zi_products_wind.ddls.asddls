@EndUserText.label: 'products custom entity'
@ObjectModel.query.implementedBy: 'ABAP:ZCL_PRODUCTS_WIND'
define custom entity zi_products_wind

{
      @EndUserText.label: 'Product ID'
      @UI.lineItem      : [{ position: 10 }]
  key product_id        : abap.numc(10);
      @EndUserText.label: 'Product Name'
      @UI.lineItem      : [{ position: 20 }]
      product_name      : abap.char(20);
      @EndUserText.label: 'Supplier ID'
      @UI.lineItem      : [{ position: 30 }]
      supplier_id       : abap.numc(10);
      @EndUserText.label: 'Category ID'
      @UI.lineItem      : [{ position: 40 }]
      category_id       : abap.numc(10);
      @EndUserText.label: 'Quantity Per Unit'
      @UI.lineItem      : [{ position: 50 }]
      quantity_per_unit : abap.char(40);
      @EndUserText.label: 'Unit Price'
      @UI.lineItem      : [{ position: 60 }]
      unit_price        : abap.char(10);
      @EndUserText.label: 'Units In Stock'
      @UI.lineItem      : [{ position: 70 }]
      units_in_stock    : abap.numc(10);
      @EndUserText.label: 'Units On Order'
      @UI.lineItem      : [{ position: 80 }]
      units_on_order    : abap.numc(10);
      @EndUserText.label: 'Reorder Level'
      @UI.lineItem      : [{ position: 90 }]
      reorder_level     : abap.numc(10);
}
