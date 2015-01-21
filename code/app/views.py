from flask import render_template
from app import app
import pymysql as mdb

db = mdb.connect(user="root", host="localhost", db="shoptiques", charset='utf8')

@app.route('/')
@app.route('/index')
def index():
	return render_template("index.html",
        title = 'Home', user = { 'nickname': 'Miguel' },
        )

@app.route('/db')
def cities_page():
	with db: 
		cur = db.cursor()

		mysql_str = """
			SELECT supplier_order_line_item.id, supplier_order.order_id,
       			   supplier_product_variant.product_variant_id, orders.user_id
  				FROM supplier_order_line_item LEFT JOIN (supplier_order, supplier_product_variant)
    				ON (supplier_order_line_item.supplier_order_id = supplier_order.id AND
         				supplier_order_line_item.supplier_product_variant_id = supplier_product_variant.id)
          			LEFT JOIN orders
            			ON (supplier_order.order_id = orders.id)
            				LIMIT 10
		"""
		cur.execute(mysql_str)
		query_results = cur.fetchall()
	
	records = []
	for result in query_results:
		records.append(dict(order_id=result[1], product_variant_id=result[2], user_id=result[3]))
	return render_template('cities.html', records=records) 
	