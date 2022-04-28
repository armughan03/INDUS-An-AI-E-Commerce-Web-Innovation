from flask import Flask, render_template, redirect, flash, url_for, session, logging, request, jsonify
from flask_mysqldb import MySQL
from wtforms import Form, StringField, TextAreaField, PasswordField, validators, HiddenField, IntegerField, SelectField, SelectMultipleField
from werkzeug.utils import secure_filename
from passlib.hash import sha256_crypt
from functools import wraps
import time
from datetime import timedelta
import re
import os
import pickle
import json
import random
import nltk
# nltk.download('punkt')
import numpy as np

'''
    RECOMMENDATION SYSTEM LIBRARIES
'''
import pandas as pd
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.metrics.pairwise import linear_kernel

'''
    DEEP LEARNING LIBRARIES
'''
import tensorflow as tflow
from keras.models import load_model

from nltk.stem.lancaster import LancasterStemmer
app = Flask(__name__)

# Config MySQL
app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = ''
app.config['MYSQL_DB'] = 'indus'
app.config['MYSQL_CURSORCLASS'] = 'DictCursor'

# Config Paths
app.config['UPLOAD_PATH'] = "static/uploads/"
app.config['PRODUCT_PATH'] = "static/products/"

# Image extensions allowed
ALLOWED_EXTENSIONS = set(['txt', 'pdf', 'png', 'jpg', 'jpeg', 'gif'])

# Init MySQL
mysql = MySQL(app)


'''
    ============================================
            RECOMMENDATION SYSTEM CODE STARTS
    ============================================
'''

# ===============================================================
                        # TRAIN THE ENGINE
# ===============================================================

ds = pd.read_csv("recommendation//WebProducts.csv")

tf = TfidfVectorizer(analyzer='word', ngram_range=(1, 3), min_df=0, stop_words='english')
tfidf_matrix = tf.fit_transform(ds['description'])

cosine_similarities = linear_kernel(tfidf_matrix, tfidf_matrix)

results = {}

for idx, row in ds.iterrows():
    similar_indices = cosine_similarities[idx].argsort()[:-100:-1]
    similar_items = [(cosine_similarities[idx][i], ds['id'][i]) for i in similar_indices]

    # First item is the item itself, so remove it.
    # Each dictionary entry is like: [(1,2), (3,4)], with each tuple being (score, item_id)
    results[row['id']] = similar_items[1:]
        
# print('done!')

# ===============================================================
                        # PREDICT
# ===============================================================

# function to get a friendly item name from the description field, given an item ID
def item(id):
    return ds.loc[ds['id'] == id]['description'].tolist()[0].split(' - ')[0]

# Just reads the results out of the dictionary. No real logic here.
def recommend(item_id, num):
    # print("Recommending " + str(num) + " products similar to " + item(item_id) + "...")
    # print("-------")
    recs = results[item_id][:num]
    return recs

'''
    ============================================
            RECOMMENDATION SYSTEM CODE ENDS
    ============================================
'''


'''
    ============================================
                SHOP ROUTES
    ============================================
''' 


@app.route('/')
def index():
    return render_template('index.html')

@app.route('/about')
def about():
    return render_template('about.html')

@app.route('/red')
def red():
    return redirect(url_for('/'))

@app.route('/shop')
def shop():
    limit = 12
    page = request.args.get('page', 1, type=int)
    
    cur = mysql.connection.cursor()
    query = "SELECT COUNT(*) FROM products"
    cur.execute(query)
    row = cur.fetchone()
    
    product_count = row['COUNT(*)']

    # for calculation of no of pages for pagination purpose
    num_of_pages = product_count / limit
    if(num_of_pages > int(num_of_pages)):
        num_of_pages +=1
    
    num_of_pages = int(num_of_pages)

    if product_count > 0:
        if product_count > limit and page != 1:
            offset = limit * page - limit
        else:
            offset = 0
    
        query = "SELECT * FROM products LIMIT %s OFFSET %s" % (limit, offset)
        # app.logger.info(query)
        cur.execute(query)
        product_rows = cur.fetchall()
    else:
        flash("There are no products in the inventory.","warning")
        return render_template('shop.html')
 
    # Close connection
    cur.close()

    return render_template('shop.html', product_rows = product_rows, num_of_pages=num_of_pages)
    
@app.route('/shop/men')
def shop_men():
    limit = 12
    page = request.args.get('page', 1, type=int)
    
    cur = mysql.connection.cursor()
    query = "SELECT COUNT(*) FROM products WHERE prd_category = '%s' " % ("men")
    # app.logger.info(query)
    cur.execute(query)
    row = cur.fetchone()
    
    product_count = row['COUNT(*)']

    # for calculation of no of pages for pagination purpose
    num_of_pages = product_count / limit
    if(num_of_pages > int(num_of_pages)):
        num_of_pages +=1
    
    num_of_pages = int(num_of_pages)

    if product_count > 0:
        if product_count > limit and page != 1:
            offset = limit * page - limit
        else:
            offset = 0
    
        query = "SELECT * FROM products WHERE prd_category = '%s' LIMIT %s OFFSET %s" % ("men",limit, offset)
        # app.logger.info(query)
        cur.execute(query)
        product_rows = cur.fetchall()
    else:
        flash("There are no products in the inventory.","warning")
        return render_template('shop-men.html')
 
    # Close connection
    cur.close()

    return render_template('shop-men.html', product_rows = product_rows, num_of_pages=num_of_pages)

@app.route('/shop/women')
def shop_women():
    limit = 12
    page = request.args.get('page', 1, type=int)
    
    cur = mysql.connection.cursor()
    query = "SELECT COUNT(*) FROM products WHERE prd_category = '%s' " % ("women")
    # app.logger.info(query)
    cur.execute(query)
    row = cur.fetchone()
    
    product_count = row['COUNT(*)']

    # for calculation of no of pages for pagination purpose
    num_of_pages = product_count / limit
    if(num_of_pages > int(num_of_pages)):
        num_of_pages +=1
    
    num_of_pages = int(num_of_pages)

    if product_count > 0:
        if product_count > limit and page != 1:
            offset = limit * page - limit
        else:
            offset = 0
    
        query = "SELECT * FROM products WHERE prd_category = '%s' LIMIT %s OFFSET %s" % ("women",limit, offset)
        # app.logger.info(query)
        cur.execute(query)
        product_rows = cur.fetchall()
    else:
        flash("There are no products in the inventory.","warning")
        return render_template('shop-men.html')
 
    # Close connection
    cur.close()

    return render_template('shop-women.html', product_rows = product_rows, num_of_pages=num_of_pages)

@app.route('/shop/kids')
def shop_kids():
    limit = 12
    page = request.args.get('page', 1, type=int)
    
    cur = mysql.connection.cursor()
    query = "SELECT COUNT(*) FROM products WHERE prd_category = '%s' OR prd_category = '%s' " % ("boy","girl")
    # app.logger.info(query)
    cur.execute(query)
    row = cur.fetchone()
    
    product_count = row['COUNT(*)']

    # for calculation of no of pages for pagination purpose
    num_of_pages = product_count / limit
    if(num_of_pages > int(num_of_pages)):
        num_of_pages +=1
    
    num_of_pages = int(num_of_pages)

    if product_count > 0:
        if product_count > limit and page != 1:
            offset = limit * page - limit
        else:
            offset = 0
    
        query = "SELECT * FROM products WHERE prd_category = '%s' OR prd_category = '%s' LIMIT %s OFFSET %s" % ("boy","girl",limit, offset)
        # app.logger.info(query)
        cur.execute(query)
        product_rows = cur.fetchall()
    else:
        flash("There are no products in the inventory.","warning")
        return render_template('shop-kids.html')
    # Close connection
    cur.close()

    return render_template('shop-kids.html', product_rows = product_rows, num_of_pages=num_of_pages)

def get_all_products():
    cur = mysql.connection.cursor()
    cur.execute("SELECT * FROM products")
    products = cur.fetchall()
    cur.close()
    return products

# RECOMMENDATION ENGINE IS CALLED HERE
@app.route('/shop/products',methods=['GET','POST'])
def shop_single():
    article_no = request.args.get('prd')
    session['prd'] = article_no
    cur = mysql.connection.cursor()
    #cur.execute("SELECT * FROM products WHERE article_no = %s", [article_no])
    cur.execute("SELECT * FROM products, product_sizes WHERE products.article_no = %s AND products.article_no = product_sizes.article_no", [article_no])
    product = cur.fetchone()
    cur.close()
    recommendations = recommend(article_no, num=8)
    #app.logger.info(recommendations)
    return render_template('shop-single.html', product=product, recommendations=recommendations, products=get_all_products())

# Called in the shop_single method

@app.route('/shop/products/addtocart', methods=['POST'])
def add_to_cart():
    article_no = request.form['article_no']
    size_selected = request.form['size']
    quantity = request.form['quantity']
    if 'discount_price' in session:
        disc_price = session['discount_price']
    else:
        disc_price = 0

    if size_selected and quantity and size_selected != 'nosize' and quantity != "0":
        # Cart Session Starts here
        if 'cart' in session:
            # if product is not in the cart then add it
            if not any(article_no in d for d in session['cart']):
                #app.logger.info('adding a product in cart')
                session['cart'].update({article_no: [quantity, size_selected, disc_price]})
                return jsonify({'success': 'Product added to cart!'})
            # if the product is already in the cart, update the quantity
            elif any(article_no in d for d in session['cart']):
                #app.logger.info('updating the quantity')
                session['cart'].update({article_no: [quantity, size_selected, disc_price]})
                return jsonify({'success': 'Product added to cart!'})
        else:
            # start the cart if already not created and add the product in it.
            #app.logger.info('starting a cart')
            session['cart'] = { article_no: [quantity, size_selected, disc_price] }
            return jsonify({'success': 'Product added to cart!'})
   
    return jsonify({'error': 'Please select size and quantity'})

@app.route('/cart')
def display_cart():
    if 'cart' in session:
        # app.logger.info(prods)
        # app.logger.info(len(prods))
        cur = mysql.connection.cursor()
        cur.execute("SELECT * FROM products")
        products = cur.fetchall()
        cur.close()
    #app.logger.info('cart' in session)
        calculate_total_amount()
        return render_template('cart.html', products=products)
    return render_template('cart.html')

@app.route('/remove_cart_item/<string:article_no>', methods=['POST'])
def remove_cart_item(article_no):
    if 'cart' in session:
        session['cart'].pop(article_no)
        # app.logger.info(session['cart'].items())
        return redirect(url_for('display_cart'))
    
@app.route('/contact')
def contact():
    return render_template('contact.html')

def prepare_order():
    if 'cart' in session:
        prods = session['cart']
        # app.logger.info(prods)
        # app.logger.info(len(prods))
        cur = mysql.connection.cursor()
        cur.execute("SELECT * FROM products")
        products = cur.fetchall()

        # CREATE AN ENTRY INTO ORDERS TABLE
        last_order_id = 0
        status = 'pending'
        
        if last_order_id == 0:
            cur.execute('INSERT INTO orders(order_status) VALUES(%s)',[status])
            last_order_id = cur.lastrowid # STORE THE LAST CREATED ORDER_ID SO MORE PRODUCTS CAN BE ADDED
            mysql.connection.commit()
        if last_order_id > 0:
            for product in products:
                if product['article_no'] in prods:
                    # app.logger.info(prods[p][0])
                    p = product['article_no']
                    # app.logger.info(p)
                    quantity = prods[p][0]
                    
                    # app.logger.info(total_amount)
                    # app.logger.info(product['article_no'])
                    # CREATE AN ENTRY INTO ORDER_ITEMS TABLE
                    cur.execute('INSERT INTO order_items(order_id, item, quantity, price) VALUES(%s,%s,%s,%s)',(
                        last_order_id, product['article_no'], quantity, product['prd_price']
                    ))
                    mysql.connection.commit()
        cur.close()

def calculate_total_amount():
     if 'cart' in session:
        prods = session['cart']
        cur = mysql.connection.cursor()
        cur.execute("SELECT * FROM products")
        products = cur.fetchall()
        total_amount = 0
        for product in products:
            if product['article_no'] in prods:
                prd_id = product['article_no']
                quantity = prods[prd_id][0]
                # app.logger.info(p)
                if prods[prd_id][2] != 0:
                    price = prods[prd_id][2]
                else:
                    price  = product['prd_price']
                    
                total_amount += (int(quantity) * int(price))
        session.pop('discount_price', None)
        session['total_amount'] = total_amount

@app.route('/checkout')
def checkout():
     if 'cart' in session:
        # app.logger.info(prods)
        # app.logger.info(len(prods))
        cur = mysql.connection.cursor()
        cur.execute("SELECT * FROM products")
        products = cur.fetchall()
        cur.close()
   # prepare_order()
        return render_template('checkout.html',products=products)

# CLASS FOR USER REGISTRATION
class RegisterForm(Form):
    name = StringField('Name', [validators.Length(min=1, max=100)], render_kw={"placeholder":"Name"})
    email = StringField('Email', [validators.Length(min=4, max=50)], render_kw={"placeholder":"Email"})
    password = PasswordField('Password', [
        validators.DataRequired(),
        validators.EqualTo('confirm_password', message='Passwords do not match')
    ], render_kw={"placeholder":"Password"})
    confirm_password = PasswordField('Confirm Password', render_kw={"placeholder":"Confirm Password"})


# USER REGISTER
@app.route('/register', methods=['GET', 'POST'])
def register():
    form = RegisterForm(request.form)
    if request.method == 'POST' and form.validate():
        name = form.name.data
        email = form.email.data
        password = sha256_crypt.hash(str(form.password.data))
        user_type = 'customer'

        already_registered = email_exists(email)

        # if the email is not already registered only then register
        if(already_registered <= 0):
            # Create cursor
            cur = mysql.connection.cursor()

            # Execute query
            cur.execute("INSERT INTO users(name, email, password, user_type) VALUES(%s, %s, %s, %s)",
            (name, email, password, user_type))

            # Commit to DB
            mysql.connection.commit()

            # Close connection
            cur.close()

            flash('You are now registered and can log in', 'success')
            
            time.sleep(3)

            return redirect(url_for('index'))
        else:
            flash('Email already registered! Please login with your existing id or enter another email.', 'warning')

    return render_template('register.html', form=form)


'''
    ============================================
                SHARED FUNCTIONS
    ============================================
''' 

# Check if user is logged in
def is_logged_in(f):
    @wraps(f)
    def wrap(*args, **kwargs):
        if 'logged_in' in session:
            return f(*args, **kwargs)
        else:
            flash('Unauthorized, Please login first!', 'danger')
            return redirect(url_for('admin_login'))
    return wrap

# Check if email is already associated to an account
def email_exists(email):
    # Create cursor
    cur = mysql.connection.cursor()
    # Execute query
    result = cur.execute("SELECT * FROM users WHERE email = %s", [email])
    # Close connection
    cur.close()
    # app.logger.info(str(result))
    return result

# Expire Session
@app.before_request
def make_session_permanent():
    session.permanent = True
    app.permanent_session_lifetime = timedelta(minutes=60)

# for file Upload
def allowed_file(filename):
    return '.' in filename and \
           filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS

def file_upload(file):
    if file.filename == '':
        flash('No selected file','danger')
        return redirect(request.url)
    if file and allowed_file(file.filename):
        filename = secure_filename(file.filename)
        f = os.path.join(app.config['UPLOAD_PATH'], filename)
        # app.logger.info(f)
        file.save(f)
        return f

def product_upload(file):
    if file.filename == '':
        flash('No selected file','danger')
        return redirect(request.url)
    if file and allowed_file(file.filename):
        filename = secure_filename(file.filename)
        f = os.path.join(app.config['PRODUCT_PATH'], filename)
        # app.logger.info(f)
        file.save(f)
        return f

def count_rows(tablename, condition="none"):
    cur = mysql.connection.cursor()
    # Get users
    if condition == "none":
        query = "SELECT COUNT(*) FROM {table}".format(**dict(table=tablename))
    else:
        query = "SELECT COUNT(*) FROM {table} WHERE user_type = '%s'".format(**dict(table=tablename)) %(condition)
    
    cur.execute(query)
    row = cur.fetchone()
    row_count = row['COUNT(*)']
    # app.logger.info(row_count)
    # Close connection
    cur.close()
    return row_count


'''
    ============================================
            ADMIN PANEL ROUTES STARTS
    ============================================
''' 

# ADMIN LOGIN
@app.route('/admin/login', methods=['GET', 'POST'])
def admin_login():
    if request.method == 'POST':
        email = request.form['email']
        password_candidate = request.form['password']

        # Create cursor
        cur = mysql.connection.cursor()

        # Execute query
        result = cur.execute("SELECT * FROM users WHERE email = %s", [email])

        if result > 0:
            # Get stored hash
            data = cur.fetchone()
            password = data['password']
            user_type = data['user_type']

            #Compare the passwords
            if sha256_crypt.verify(str(password_candidate), password) and user_type == "admin":
                #Passed
                session['logged_in'] = True
                session['name'] = data['name']
                session['image_path'] = data['image_path']

                flash('Login successful!', 'success')
                return redirect(url_for('admin'))
            else:
                error = 'Invalid email or password! Please try again'
                return render_template('admin/login.html', error=error)
            # Close connection
            cur.close()
        else:
            error = 'Email not registered!'
            return render_template('admin/login.html', error=error)

    return render_template('admin/login.html')

# ADMIN LOGOUT
@app.route('/admin/logout')
@is_logged_in
def admin_logout():
    session.clear()
    flash('Logout successful!', 'success')
    return redirect(url_for('admin_login'))

@app.route('/admin')
@app.route('/admin/dashboard')
@is_logged_in
def admin():
    product_count = count_rows("products")
    admin_count = count_rows("users", "admin")
    return render_template('admin/dashboard.html', product_count = product_count, admin_count = admin_count)

# USERS
# ============== Display Admin or Customer Users =============

class AdminForm(Form):
    name = StringField('Name', [validators.Length(min=1, max=100)], render_kw={"placeholder":"Name"})
    email = StringField('Email', [validators.Length(min=4, max=50)], render_kw={"placeholder":"Email"})
    password = PasswordField('Password', [
        validators.DataRequired(),
        validators.EqualTo('confirm_password', message='Passwords do not match')], 
    render_kw={"placeholder":"Password"})
    confirm_password = PasswordField('Confirm Password', render_kw={"placeholder":"Confirm Password"})

@app.route('/admin/create', methods = ['GET', 'POST'])
@is_logged_in
def create_admin():
    form = AdminForm(request.form)
    if request.method == 'POST' and form.validate():
        name = form.name.data
        email = form.email.data
        password = sha256_crypt.hash(str(form.password.data))
        user_type = 'admin'

        # for file upload
        if 'image' not in request.files:
            # set a default image
            image_path = "../../static/uploads/default.jpg"
        else:
            file = request.files['image']
            image_path = file_upload(file)
            image_path = "../../" + str(image_path)
            # app.logger.info(image_path)


        already_registered = email_exists(email)

        # if the email is not already registered only then register
        if(already_registered <= 0):
            # Create cursor
            cur = mysql.connection.cursor()

            # Execute query
            cur.execute("INSERT INTO users(name, email, password, user_type, image_path) VALUES(%s, %s, %s, %s, %s)",
            (name, email, password, user_type, image_path))

            # Commit to DB
            mysql.connection.commit()

            # Close connection
            cur.close()

            flash('Admin Created', 'success')
        else:
            flash('Email already registered! Please enter another email.', 'warning')

    return render_template('admin/admincreate.html', form = form)

@app.route('/admin/users/<page>')
@is_logged_in
def users(page):
    result, user_rows = get_user_rows(page)
    if page == "customer" and  result > 0:
        return render_template('admin/customers.html', user_rows = user_rows)
    elif page == "customer":
        return render_template('admin/customers.html')
    elif page == "admin" and result > 0:
        return render_template('admin/admins.html', user_rows = user_rows)
    elif page == "admin":
        return render_template('admin/admins.html')

def get_user_rows(user_type):
    # Create cursor
    cur = mysql.connection.cursor()

    # Get users
    result = cur.execute("SELECT * FROM users WHERE user_type = %s", [user_type])

    user_rows = cur.fetchall()
    
    # Close connection
    cur.close()

    return result, user_rows

# Delete an Admin
@app.route('/users/delete/<id>')
@is_logged_in
def delete_admin(id):
    cur = mysql.connection.cursor()
    cur.execute("DELETE FROM users WHERE user_type = 'admin' AND id = %s", [id])
    mysql.connection.commit()
    cur.close()
    flash('Admin deleted', 'success')

    return redirect(url_for('users', page='admin')) 


# PRODUCTS
# ============== Adding a Product =============

#Pagination
def paginate(page_num, limit):
    offset = 10
    cur = mysql.connection.cursor()

    query = "SELECT COUNT(*) FROM PRODUCTS"
    cur.execute(query)

    row = cur.fetchone()
    product_count = row['COUNT(*)']

    if(product_count >= 0):
        if(product_count > limit):
            offset = page_num * offset
            query = "SELECT COUNT(*) FROM PRODUCTS LIMIT %s OFFSET %s" % (limit, offset)
    
        cur.execute(query)
    cur.close()


@app.route('/admin/products/display')
@is_logged_in
def products():
    limit = 10
    page = request.args.get('page', 1, type=int)
    
    cur = mysql.connection.cursor()
    query = "SELECT COUNT(*) FROM PRODUCTS"
    cur.execute(query)
    row = cur.fetchone()
    
    product_count = row['COUNT(*)']

    # for calculation of no of pages for pagination purpose
    num_of_pages = product_count / limit
    if(num_of_pages > int(num_of_pages)):
        num_of_pages +=1
    
    num_of_pages = int(num_of_pages)

    if product_count > 0:
        if product_count > limit and page != 1:
            offset = limit * page - limit
        else:
            offset = 0
    
        query = "SELECT * FROM PRODUCTS LIMIT %s OFFSET %s" % (limit, offset)
        app.logger.info(query)
        cur.execute(query)
        product_rows = cur.fetchall()
    else:
        flash("There are no products in the inventory.","warning")
        return render_template('admin/productsdisplay.html')
 
    # Close connection
    cur.close()

    return render_template('admin/productsdisplay.html', product_rows = product_rows, num_of_pages=num_of_pages)

class ProductForm(Form):
    prd_article = StringField('Product Article No',[validators.Length(min=1, max=100)
    , validators.DataRequired()], render_kw={"placeholder":"Article No"})
    prd_name = StringField('Product Name', [
            validators.Length(min=1, max=100), 
            validators.DataRequired()
        ], render_kw={"placeholder":"Name"})
    prd_type = StringField('Product Category', [
            validators.Length(min=1, max=100), 
            validators.DataRequired()
        ], render_kw={"placeholder":"Product Category"})
    prd_category = StringField('Product Type', [
            validators.Length(min=1, max=100), 
            validators.DataRequired()
        ], render_kw={"placeholder":"Product Type"})
   
    prd_description = TextAreaField('Product Description', [validators.DataRequired()], render_kw={"placeholder":"Description"})
    prd_price = IntegerField('Product Price', [validators.DataRequired()], render_kw={"placeholder":"Price"})
    prd_min_price = IntegerField('Product Minimum Acceptable Price', [validators.DataRequired()], render_kw={"placeholder":"Minimum Acceptable Price"})
    size_s = IntegerField('Size Small' , render_kw={"placeholder":"Enter Quantity for Small", "value":0})
    size_m = IntegerField('Size Medium' , render_kw={"placeholder":"Enter Quantity for Medium", "value":0})
    size_l = IntegerField('Size Large' , render_kw={"placeholder":"Enter Quantity for Large", "value":0})
    size_xl = IntegerField('Size Extra Large' , render_kw={"placeholder":"Enter Quantity for Extra Large", "value":0})


@app.route('/admin/addproduct', methods = ['GET', 'POST'])
@is_logged_in
def add_product():
    form = ProductForm(request.form)
    if request.method == 'POST' and form.validate():
        article_no = form.prd_article.data
        prd_name = form.prd_name.data
        prd_category = form.prd_category.data
        prd_type = form.prd_type.data
        prd_description = form.prd_description.data
        prd_price = form.prd_price.data
        prd_min_price = form.prd_min_price.data
        
        size_s = 0 if form.size_s.data <= 0 else form.size_s.data
        size_m = 0 if form.size_m.data <= 0 else form.size_m.data
        size_l = 0 if form.size_l.data <= 0 else form.size_l.data
        size_xl = 0 if form.size_xl.data <= 0 else form.size_xl.data


        # for file upload
        if 'prd_image' not in request.files:
            # set a default image
            image_path = "../../static/products/default.jpg"
        else:
            file = request.files['prd_image']
            image_path = product_upload(file)
            image_path = "../../" + str(image_path)
            # app.logger.info(image_path)

        cur = mysql.connection.cursor()

        # Execute query
        cur.execute("INSERT INTO products(article_no,prd_name, prd_description, prd_type, prd_category ,prd_price,prd_min_price, image_path) VALUES(%s, %s, %s, %s, %s)",
        (article_no, prd_name, prd_description,prd_type,prd_category, prd_price,prd_min_price, image_path))

        cur.execute("INSERT INTO product_sizes(article_no, size_s, size_m, size_l, size_xl) VALUES(%s, %s, %s, %s, %s)",
        (article_no, size_s, size_m, size_l, size_xl))

            # Commit to DB
        mysql.connection.commit()

        # Close connection
        cur.close()

        flash('Product Added', 'success')

    return render_template('admin/productsadd.html', form = form)


# ORDERS
# ============== All orders details here =============
@app.route('/admin/orders')
@is_logged_in
def orders():
    return render_template('admin/orders.html')


@app.route('/blank', methods=['GET','POST'])
def upload():
    if request.method == 'POST':
        file = request.files['image']
        f = os.path.join(app.config['UPLOAD_PATH'], file.filename)
        app.logger.info(f)
        # add your custom code to check that the uploaded file is a valid image and not a malicious file (out-of-scope for this post)
        file.save(f)

    return render_template('admin/blank.html')

'''
    ============================================
            ADMIN PANEL ROUTES ENDS
    ============================================
''' 


'''
    ============================================
                CHATBOT CODE STARTS
    ============================================
''' 
graph = tflow.compat.v1.get_default_graph()

stemmer = LancasterStemmer()

data = pickle.load( open("chatbot//training_data", "rb") )
words = data['words']
documents = data['documents']
classes = data['classes']

with open('chatbot//intent.json') as json_data:
    intents = json.load(json_data)

# load the model
tflow.compat.v1.enable_eager_execution()
model = load_model('chatbot/chatmodel.h5')

def clean_up_sentence(sentence):
    # tokenize the pattern
    sentence_words = nltk.word_tokenize(sentence)
    # stem each word
    sentence_words = [stemmer.stem(word.lower()) for word in sentence_words]
    return sentence_words

# return bag of words array: 0 or 1 for each word in the bag that exists in the sentetnce
 
def bow(sentence, words, show_details=False):
    # tokenize the pattern
    sentence_words = clean_up_sentence(sentence)
    # bag of words
    bag = [0]*len(words)
    for s in sentence_words:
        for i,w in enumerate(words):
            if w == s:
                bag[i] = 1
                if show_details:
                    print("found in bag: %s" % w)
    return(np.array(bag))

# create a data structure to hold user context
context = {}

ERROR_THRESHOLD = 0.65
def classify(sentence):
    # generate probabilities from the model
    p = bow(sentence, words)
    
    d = len(p)
    f = len(documents)-2
    a = np.zeros([f, d])
    tot = np.vstack((p, a))
    
    with graph.as_default():
        # json_file = open('chatbot//intent.json','r')
        # loaded_model_json = json_file.read()
        # json_file.close()
        # loaded_model = tflow.keras.models.model_from_json(loaded_model_json)
        loaded_model  = load_model('chatbot/chatmodel.h5')
        #load weights into new model
        # loaded_model.load_weights("chatbot//chatmodel.h5")
        print("Loaded Model from disk")
        #compile and evaluate loaded model
        # loaded_model.compile(loss='sparse_categorical_crossentropy',optimizer='adam',metrics=['accuracy'])
        # perform the prediction
        results = loaded_model.predict(tot)[0]
        print(results)
        # print(out)
        # print(class_names[np.argmax(out)])
        # # convert the response to a string
        # response = class_names[np.argmax(out)]
        # results = model.predict(tot)[0]
    
    # filter out predictions below a threshold
    results = [[i, r] for i, r in enumerate(results) if r > ERROR_THRESHOLD]
    # sort by strength of probability
    results.sort(key=lambda x: x[1], reverse=True)
    return_list = []
    
    for r in results:        
        return_list.append((classes[r[0]], r[1]))
        
    # return tuple of intent and probability
    return return_list

user_offer_count = 1
bot_offer_count = 1

# FOR EXTRACTING THE AMOUNT FROM FUNCTION
def extract_amount(sentence): 
    # if amount is present extract the amount
    try:
        sentence = sentence.lower()
        if "rs." in sentence:
            price_start = str.find(sentence, "rs.") # store the index of 'Rs.'
            price_end = str.find(sentence, "/-") # store the index of '/-'
            amount = sentence[price_start+3:price_end] # extract the amount
            amount = amount.strip() # remove spaces
            return int(amount)
    except:
        return 'invalid_amount'

def track_user_offer(userText):
    userText = userText.lower()
    if 'rs.' in userText:
        global user_offer_count
        user_offer_count += 1
        #app.logger.info(user_offer_count)
    return user_offer_count

def track_bot_offers():
    global bot_offer_count
    bot_offer_count += 1
    return bot_offer_count
     
def create_offer(min_acceptable_price,original_price,bot_offer_count,user_offer,give_offer=False): 
    # checks 
        #1 the offer bot make is not more than the minimum acceptable price
        #2 the offer bot make is not more than original price
        #3 the offer bot make is not more than user offer
    #1 calculate percentage discount
    discount_percentage = int(((original_price - min_acceptable_price)/original_price) * 100)
    #2 divide the percentage discount by 4 i.e. total number of offers
    percentage_per_step = (discount_percentage / 4)
    app.logger.info(give_offer)
    if give_offer:
        # first offer
        if bot_offer_count == 1:
            app.logger.info('bot offer 1 is executing')
            discounted_amount = (original_price/100) * (percentage_per_step*1)
            bot_offer = original_price - discounted_amount
            return round(int(bot_offer), -2)
        # 2nd offer
        elif bot_offer_count == 2:
            app.logger.info('bot offer 2 is executing')
            discounted_amount = (original_price/100) * (percentage_per_step*2)
            bot_offer = original_price - discounted_amount
            app.logger.info(bot_offer)
            return round(int(bot_offer), -2)
        # 3rd offer
        elif bot_offer_count == 3:
            app.logger.info('bot offer 3 is executing')
            discounted_amount = (original_price/100) * (percentage_per_step*3)
            bot_offer = original_price - discounted_amount
            return round(int(bot_offer), -2)
        # last full and final offer
        else:
            app.logger.info('bot offer final is executing')
            discounted_amount = (original_price/100) * (percentage_per_step*4)
            bot_offer = original_price - discounted_amount
            return round(int(bot_offer), -2)
        
def get_product_info(article_no):
    cur = mysql.connection.cursor()
    cur.execute("SELECT prd_price, prd_min_price FROM products WHERE article_no = %s", [article_no])
    product = cur.fetchone()
    cur.close()
    return product['prd_price'], product['prd_min_price']

def response(sentence, userID, min_acceptable_price,user_offer, original_price, show_details=False):
    results = classify(sentence)
    # print('Result:', results)

    # if we have a classification then find the matching intent tag
    if results:
        #loop as long as there are matches to process
        while results:
            for i in intents['intents']:
                # find a tag matching the first result
                if i['tag'] == results[0][0]:
                    # set the context for this intent if necessary
                    if 'context_set' in i:
                        if show_details: print('context: ', i['context_set'])
                        context[userID] = i['context_set']
                        
                    # check if this intent is contextual and applies to this user's conversation
                    if not 'context_filter' in i or \
                        (userID in context and 'context_filter' in i and i['context_filter'] == context[userID]):
                        if show_details: print('tag:', i['tag'])  
                        
                        if i['tag'] == 'customeroffers':
                            # if customer has made an offer and evaluation of that offer returns True means that offer is acceptable
                            if ((user_offer >= min_acceptable_price) and (user_offer <= original_price)):
                                accept_response = 'suitable offer by the customer'
                                return accept_response
                            elif user_offer > original_price or user_offer == 0:
                                #TODO  set some pattern for foolish offers so that bot can utter dialogues about it
                                response = 'foolish offer'
                                return response
                            # else if customer has made an offer and evaluation of that offer returns False indicating that offer is unnacceptable so make an offer
                            elif user_offer < min_acceptable_price:
                                # increment the number of offers
                                bot_offer_count = track_bot_offers()
                                # app.logger.info(bot_offer_count)
                                # prepare an offer from bot side
                                bot_offer = create_offer(min_acceptable_price, original_price, bot_offer_count,user_offer,True)
                                session['bot_offer'] = bot_offer
                                res = random.choice(i['responses'])

                                # if bot has offered more than 4 offers and is on final offer then activate final offer responses
                                if bot_offer_count > 3:
                                    response = "final offer+" + str(bot_offer)
                                    return response

                                if '___' in res:
                                    res = res.replace('___', str(bot_offer))
                                    return res
                        # if the user accepts the deal offered by the bot
                        elif i['tag'] == 'deal':
                            if 'discount_price' not in session:
                                session['discount_price'] = session['bot_offer']
                                session.pop('bot_offer',None)
                            return random.choice(i['responses'])
                            

                        # a random response from the intent
                        return random.choice(i['responses'])
            results.pop(0)



@app.route("/get")
def get_bot_response():
    userText = request.args.get('msg')
    user_offer = extract_amount(userText)
    # keep in track the number of offers made by a user.
    prd_id = session['prd']
    # get original price and minimum acceptable price from the database
    original_price, min_acceptable_price = get_product_info(prd_id)
    time.sleep(0.5)
    try: 
        res = response(userText, '123',min_acceptable_price, user_offer, original_price)
        if (user_offer == 'invalid_amount'):
            res = response("bla bla", '123',min_acceptable_price, user_offer, original_price)
        elif res == 'suitable offer by the customer':
            accept_response = 'suitable offer by the customer'
            res = response(accept_response, '123',min_acceptable_price, user_offer, original_price)
            if '___' in res:
                res = res.replace('___', str(user_offer))
                if 'discount_price' not in session:
                    session['discount_price'] = user_offer
        elif res == 'foolish offer':
            deny_foolish_offer = res
            res = response(deny_foolish_offer, '123',min_acceptable_price, user_offer, original_price)
        elif 'final offer' in res:
            res_split = res.split('+')
            final_offer = res_split[1]
            res = response(res_split[0], '123',min_acceptable_price, user_offer, original_price)
            if '___' in res:
                res = res.replace('___', str(final_offer))
    except TypeError:
        # app.logger.info('except')
        res = response("bla bla", '123',min_acceptable_price, user_offer, original_price)

    return str(res)

'''
    ============================================
                CHATBOT CODE ENDS
    ============================================
''' 

if __name__ == '__main__':
    app.secret_key = 'indush'
    app.run(debug=True, port=5050)


# SELECT products.prd_name, size_s, size_m from products, product_sizes WHERE products.article_no="pr001" AND products.article_no = product_sizes.article_no

# context wont change until you reset it. no need to set context filter for all intents related to negotiate price
