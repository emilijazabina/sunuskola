from flask import Flask, render_template, request, redirect, url_for, session
from flask_mysqldb import mysql

app = Flask(__name__)
#app.secret_key = 'Kobijs'

app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = ''
app.config['MYSQL_DB'] = 'sunuskola'

mysql = MySQL(app)


@app.route('/')
def Index():
    return render_template('Index.html')


@app.route('/PasnLogin', methods=['GET', 'POST']) #pasniedzēju pieslēgšanās
def PasnLogin():
    msg = ''
    if request.method == 'POST' and 'lietotajvards' in request.form and 'parole' in request.form:
        username = request.form['lietotajvards']
        password = request.form['parole']
        cursor = mysql.connection.cursor(mysql.cursors.DictCursor)
        cursor.execute('SELECT * FROM lietotaji WHERE lietotajvards = % s AND parole = % s', (lietotajvards, parole,))
        account = cursor.fetchone()
        if account:
            session['loggedin'] = True
            session['id'] = account['id']
            session['lietotajvards'] = account['lietotajvards']
            msg = 'Pievienošanās veiksmīga!'
            return render_template('PasnNodarb.html', msg=msg)
        else:
            msg = 'NEpareizs lietotājvārds vai parole!'
    return render_template('PasnLogin.html')


@app.route('/logout') #pasniedzēju logout
def logout():
    session.pop('loggedin', None)
    session.pop('id', None)
    session.pop('username', None)
    return redirect(url_for('Pasnlogin'))


@app.route('/PasnNodarb') #pasniedzeju apskatu sadaļa
def PasnNodarb():
    cur = mysql.connection.cursor()
    cur.execute("SELECT n.datums, g.vecuma_grupa, g.max_dal_sk, n.apraksts FROM vaditajs as v join grupa as g on g.vaditaja_id = v.id join nodarbiba as n on n.grupas_id = g.id WHERE v.id = 1")
    data = cur.fetchall()
    cur.close()
    return render_template('PasnNodarb.html')


@app.route('/PasnGrupas')
def PasnGrupas():
    return render_template('PasnGrupas.html')


@app.route('/PasnZin')
def PasnZin():
    cur = mysql.connection.cursor()
    cur.execute("SELECT sutitaja_epasts, zina FROM zinas")
    data = cur.fetchall()
    cur.close()
    return render_template('PasnZin.html')


@app.route('/Kontakti') #lietotaju apskatu sadaļas
def Kontakti():
    return render_template('Kontakti.html')


@app.route('/jaunumi')
def jaunumi():
    return render_template('jaunumi.html')


@app.route('/jautajumi') #lietotaju apskatu sadaļas
def jautajumi():
    return render_template('jautajumi.html')


@app.route('/meklesana')
def meklesana():
    return render_template('meklesana.html')


@app.route('/nodarbinuKal')
def nodaribuKal():
    return render_template('nod-kal.html')


@app.route('/pieteikties') #pieteikuma sadaļa
def pieteikties():
    return render_template('pieteikties.html')
def insert():
    if request.method == "POST":
        flash("Data Inserted Successfully")
        name = request.form['pieteikuma_datums']
        email = request.form['komentars']
        phone = request.form['phone']
        cur = mysql.connection.cursor()
        cur.execute("INSERT INTO students (pieterikuma_datums,komentars,saimnieka_id,nodarbibas_id) VALUES (%s, %s, %s)", (name, email, phone))
        mysql.connection.commit()
        return redirect(url_for('Index'))

@app.route('/paldiesPieteikums')
def paldiesPieteikums():
    return render_template('paldiesPieteikums.html')
@app.route('/search', methods=['GET', 'POST'])
def search():
    if request.method == "POST":
        db = MySQLdb.connect(user="root", passwd="", db="cs324", host="127.0.0.1")
        c=db.cursor()
        c.executemany('select p.nosaukums, s.nosaukums, s.reg_nr, s.adrese, s.epasts, s.telefons from sunuskolas as s join pilseta as p on p.id = s.pilsetas_id', request.form['search'])
        for r in c.fetchall():
            print (r[0],r[1],r[2],r[3],r[4], r[5])
            return redirect(url_for('search')) # <- Here you jump away from whatever result you create
    return render_template('meklesana.html')


if __name__ == "__main__":
    app.run(debug=True)
