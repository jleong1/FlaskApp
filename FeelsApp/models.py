from flask.ext.sqlalchemy import SQLAlchemy
from werkzeug import generate_password_hash, check_password_hash

db = SQLAlchemy()

#use the below to load a sql script but don't know where this would be executed
def init_from_script(script):
    Base.metadata.drop_all(db_engine)
    Base.metadata.create_all(db_engine)

    # HACK ALERT: we can do this using sqlite3 low level api, then reopen session.
    f = open(script)
    script_str = f.read().strip()
    global db_session
    db_session.close()
    import sqlite3
    conn = sqlite3.connect(db_file_name)
    conn.executescript(script_str)
    conn.commit()

    db_session = Session()

class User(db.Model):
  __tablename__ = 'users'
  uid = db.Column(db.Integer, primary_key = True)
  firstname = db.Column(db.String(100))
  lastname = db.Column(db.String(100))
  email = db.Column(db.String(120), unique=True)
  pwdhash = db.Column(db.String(54))

  def __init__(self, firstname, lastname, email, password):
    self.firstname = firstname.title()
    self.lastname = lastname.title()
    self.email = email.lower()
    self.set_password(password)

  def set_password(self, password):
    self.pwdhash = generate_password_hash(password)

  def check_password(self, password):
    return check_password_hash(self.pwdhash, password)

#Don't know if Categor1, Category2, etc., are being generated correctly, some error when execuing app, may need to make a new models.pyc
class Category1(db.Model):
    __tablename__= 'c1'
    c1_id = db.Column(db.Integer, primary_key = True)
    c1_name = db.Column(db.String(45))
    def __init__(self,c1_id,c1_name):
        self.c1_id = c1_id
        self.c1_name = c1_name

class Category2(db.Model):
    __tablename__= 'c2'
    c2_id = db.Column(db.Integer, primary_key = True)
    c2_name = db.Column(db.String(45))
    c1_id = db.Column(db.Integer, db.ForeignKey('Category.c1_id'))
    c1_name = db.Column(db.String(45), db.ForeignKey('Category1.c1_name'))

    def __init__(self,c2_id,c2_name,c1_id,c1_name):
        self.c2_id = c2_id
        self.c2_name = c2_name
        self.c1_id = c1_id
        self.c1_name = c1_name

class Emotions(db.Model):
    __tablename__='emots'
    emot_id = db.Column(db.Integer, primary_key=True)
    emot_name = db.Column(db.String(45))
    c2_id =  db.Column(db.Integer, db.ForeignKey('Category2.c2_id'))
    c2_name = db.Column(db.String(45), db.ForeignKey('Category2.c2_name')

    def __init__(self,emot_id,emot_name,c2_id,c2_name):
        self.c2_id = c2_id
        self.c2_name = c2_name
        self.emot_id = emot_id
        self.emot_name = emot_name

class CharThings(db.Model):
    __tablename__='ChTn'
    ChTn_id = db.Column(db.Integer, primary_key=True)
    ChTn_url = db.column(db.String(300))
    ChTn_name = db.Column(db.String(45))
    emot_id =  db.Column(db.Integer, db.ForeignKey('Emotions.emot_id'))
    emot_name = db.Column(db.String(45), db.ForeignKey('Emotions.emot_name')

    def __init__(self,emot_id,emot_name,ChTn_id,ChTn_name,ChTn_url):
        self.ChTn_id = ChTn_id
        self.ChTn_name = ChTn_name
        self.emot_id = emot_id
        self.emot_name = emot_name
        self.ChTn_url = ChTn_url
