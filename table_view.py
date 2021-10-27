from tkinter import *
if __name__=='__main__':
    pass
class Table:
    
    def __init__(self,root,total_rows,total_columns):
        # code for creating table
        for i in range(total_rows):
            for j in range(total_columns):
                if i==0 or i==1 or j==0:
                    self.e = Entry(root, width=13, fg='red',
                                font=('Arial',12,'bold'))
                    
                    self.e.grid(row=i, column=j)
                    self.e.insert(END, lst[i][j])
                else:
                    self.e = Entry(root, width=13, fg='blue',
                                font=('Arial',12,'bold'))
                    
                    self.e.grid(row=i, column=j)
                    self.e.insert(END, lst[i][j])

def time_table_data(time_table=None):
    global lst
    try:
        lst = time_table
    except exception:
        print(exception)
        lst=print('Line36: ',time_table)
    return lst
def cal(lst):
    total_rows = len(lst)
    total_columns = len(lst[0])

# create root window
    root = Tk()
    root.title('Time Table')
    t = Table(root,total_rows,total_columns)
    root.mainloop()