import random
import tkinter as tk
##DataBase connectivity
from mysql import connector
from mysql.connector import Error
def connect_to_database():
    db_connection = None
    try:
        db_connection = connector.connect(host="localhost", user="root", passwd='180262@Jashu',
                                          auth_plugin='mysql_native_password', db='timetable_db')
        #db_connection = connector.connect(host="3.21.185.210", user="user1", passwd='jashu@123',
        #                                  auth_plugin='mysql_native_password', db='timetable_db')
        print("DataBase Connection Successful")
    except Error as e:
        print("Error in connecting to the database: ", e)
    return db_connection
database_connection=connect_to_database()
print("Database Connection: ",database_connection)
def execute_command(db,query):
    cursor=db.cursor()
    try:
        cursor.execute(query)
        if "select" in query:
            result=cursor.fetchall()
            for k in result:
                print(k)
        else:
            print("Query Executed Successfully")
            db.commit()
    except Error as e:
        print(e)
def show_in_gui(db,query):
    cursor=db.cursor()
    try:
        cursor.execute(query)
        import table_view as tv
        result=cursor.fetchall()
        tv.cal(tv.time_table_data(result))
    except Error as e:
        print(e)
        

def get_subjects(db,query):
    subjects=[]
    cursor=db.cursor()
    try:
        cursor.execute(query)
        result=cursor.fetchall()
        for k in result:
            subjects.append(str(k)[2:-3])
    except Error as e:
        print(e)
    return subjects
###TIME TABLE GENERATOR
subjects=get_subjects(database_connection,'select course_name from courses;')
print('Subjects: ',subjects)
#print(subjectss)
#subjects=['FLAT','PE-1','CNS','IDE-1','DBMS','SE','Student_life','OE-1','CSD(q/v)','SE Lab','CSD Coding','IDE-1 LAB','DBMS Lab','PE-1 lab']



def push_timeTable(total_week_timetable):
    query='delete from time_table;'
    execute_command(database_connection,query)
    for day_wise in total_week_timetable:
        command='insert into time_table values("{0}","{1}","{2}","{3}","{4}","{5}","{6}","{7}","{8}","{9}");'.format(day_wise[0],
                                                                                                                    day_wise[1],
                                                                                                                    day_wise[2],
                                                                                                                    day_wise[3]
                                                                                                                    ,day_wise[4],
                                                                                                                    day_wise[5],
                                                                                                                    day_wise[6],
                                                                                                                    day_wise[7],
                                                                                                                    day_wise[8],
                                                                                                                    day_wise[9],
                                                                                                                    )
        execute_command(database_connection,command)
    show_in_gui(database_connection,'select * from timings union select * from time_table;')
def show_time_table():
    show_in_gui(database_connection,'select * from timings union select * from time_table;')
def load_timeTable(subjects):
    days = ['monday', 'tuesday', 'wednesday', 'thursday', 'friday']
    day_timetable = []
    total_week_timetable = []
    for day in days:
        while len(day_timetable)<=7:
            sub=random.choice(subjects)
            if day_timetable.count(sub)<1:
                day_timetable.append(sub)
        day_timetable.insert(4,'LUNCH')
        day_timetable.insert(0,day)
        total_week_timetable.append(day_timetable)
        day_timetable=[]
    #update_time_table(total_week_timetable)
    push_timeTable(total_week_timetable)

##Selection Window
root=tk.Tk()
frame=tk.Frame(root)
btn1=tk.Button(frame,text='Update Time Table',command=lambda:load_timeTable(subjects)).pack()
btn2=tk.Button(frame,text='Show Time Table',command=show_time_table).pack()
frame.pack()
root.geometry('400x400')
root.mainloop()