# A select table with supplier_order_line_item.id and order_id
SELECT supplier_order_line_item.id, supplier_order.order_id
  FROM supplier_order_line_item
    JOIN supplier_order
      ON (supplier_order_id = supplier_order.id)
        LIMIT 100;

# B select table with supplier_order_line_item.id and product_variant_id
SELECT supplier_order_line_item.id, product_variant_id
    FROM supplier_order_line_item
        JOIN supplier_product_variant
              ON (supplier_product_variant_id = supplier_product_variant.id)
                LIMIT 100;

# C select table with order_id and user_id
SELECT supplier_order.order_id, orders.user_id
   FROM supplier_order
      JOIN orders
        ON (supplier_order.order_id = orders.id)
          LIMIT 100;

# join supplier_order and supplier_product_variant with supplier_order_line_item
SELECT supplier_order_line_item.id, supplier_order.order_id,
       supplier_product_variant.product_variant_id, orders.user_id
  FROM supplier_order_line_item LEFT JOIN (supplier_order, supplier_product_variant)
    ON (supplier_order_line_item.supplier_order_id = supplier_order.id AND
        supplier_order_line_item.supplier_product_variant_id = supplier_product_variant.id)
          LEFT JOIN orders
            ON (supplier_order.order_id = orders.id)
              LIMIT 10;
