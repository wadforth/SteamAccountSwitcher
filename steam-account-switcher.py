from tkinter import *
from tkinter import ttk
from ttkthemes import ThemedTk
import os
import wmi
import subprocess
import webbrowser


class SteamAccountSwitcher:
    def __init__(self):
        super().__init__()


path = os.path.expanduser("~\Documents\SteamAccountSwitcher")
filepath = os.path.join(path, "config.txt")

account_list = []


def read_config():
    with open(filepath) as f:
        for line in f:
            account_list.append(line.strip())
    print(account_list)


def clear_file_check():
    os.remove(filepath)
    return


def first_time():

    app = ThemedTk(theme="arc")
    app.config(bg="#F5F6F7")

    app.title("Setup")
    app.geometry("250x260")

    accounts_label = ttk.Label(app, text="Accounts - Setup", font="Helvetica")
    accounts_label.place(x=65, y=10)
    accounts_label.config(background="#F5F6F7", foreground="#6A626D")

    ttk.Separator(app, orient="horizontal").place(width=330, y=37)

    account1 = StringVar()
    account2 = StringVar()
    account3 = StringVar()
    account4 = StringVar()
    account5 = StringVar()

    entry1 = ttk.Entry(app, textvariable=account1, justify=CENTER).place(
        width=200, x=40, y=57
    )
    entry2 = ttk.Entry(app, textvariable=account2, justify=CENTER).place(
        width=200, x=40, y=87
    )
    entry3 = ttk.Entry(app, textvariable=account3, justify=CENTER).place(
        width=200, x=40, y=117
    )
    entry4 = ttk.Entry(app, textvariable=account4, justify=CENTER).place(
        width=200, x=40, y=147
    )
    entry5 = ttk.Entry(app, textvariable=account5, justify=CENTER).place(
        width=200, x=40, y=177
    )

    account1_label = ttk.Label(app, text="#1", font="Helvetica")
    account1_label.place(x=15, y=59)
    account1_label.config(background="#F5F6F7", foreground="#6A626D")

    account2_label = ttk.Label(app, text="#2", font="Helvetica")
    account2_label.place(x=15, y=89)
    account2_label.config(background="#F5F6F7", foreground="#6A626D")

    account3_label = ttk.Label(app, text="#3", font="Helvetica")
    account3_label.place(x=15, y=119)
    account3_label.config(background="#F5F6F7", foreground="#6A626D")

    account4_label = ttk.Label(app, text="#4", font="Helvetica")
    account4_label.place(x=15, y=149)
    account4_label.config(background="#F5F6F7", foreground="#6A626D")

    account5_label = ttk.Label(app, text="#5", font="Helvetica")
    account5_label.place(x=15, y=179)
    account5_label.config(background="#F5F6F7", foreground="#6A626D")

    config_label = ttk.Label(app, text="Config Location", font=("Helvetica", 10))
    config_label.place(x=17, y=215)
    config_label.config(background="#F5F6F7", foreground="#6A626D")

    config_location = ttk.Label(app, text=path, font=("Helvetica", 7))
    config_location.place(x=15, y=239)
    config_location.config(background="#F5F6F7", foreground="#6A626D")

    def write_file():
        with open(filepath, "w") as file:
            file.write(account1.get() + "\n")
            if len(account2.get()) != 0:
                file.write(account2.get() + "\n")
            if len(account3.get()) != 0:
                file.write(account3.get() + "\n")
            if len(account4.get()) != 0:
                file.write(account4.get() + "\n")
            if len(account5.get()) != 0:
                file.write(account2.get())

    ttk.Button(
        app,
        text="Save",
        width=10,
        command=lambda: [
            os.makedirs(path),
            os.open(filepath, os.O_CREAT),
            write_file(),
            app.destroy(),
            main(),
        ],
    ).place(x=155, y=205)

    ttk.Entry(app)
    app.resizable(False, False)
    app.mainloop()


def config_exist():
    if not os.path.exists(filepath):
        first_time()
    else:
        return


def main():
    config_exist()
    read_config()

    app = ThemedTk(theme="arc")
    app.config(bg="#F5F6F7")
    frame = Frame(app)

    app.title("Steam Account Switcher")

    accounts_label = ttk.Label(app, text="Accounts", font="Helvetica")
    accounts_label.place(x=95, y=10)
    accounts_label.config(background="#F5F6F7", foreground="#6A626D")

    ttk.Separator(app, orient="horizontal").place(width=330, y=37)

    def callback(url):
        webbrowser.open_new(url)

    author = ttk.Label(app, text=" @wadforth  ", font=("Helvetica", 10), cursor="hand2")
    author.pack(side=RIGHT, anchor=SE)
    author.config(background="#F5F6F7", foreground="#6A626D")
    author.bind("<Button-1>", lambda e: callback("http://www.github.com/wadforth"))

    y_placement = 50
    for item in account_list:
        button = ttk.Button(
            app,
            width="30",
            text=item,
            command=lambda x=item: [
                x,
                os.system("taskkill /im steam.exe /F"),
                subprocess.call(
                    "powershell.exe reg add HKCU\Software\Valve\Steam /v AutoLoginUser /t REG_SZ /d  "
                    + x
                    + " /f"
                ),
                subprocess.call(
                    "powershell.exe reg add HKCU\Software\Valve\Steam /v RememberPassword /t REG_DWORD /d 1 /f"
                ),
                os.system('start "" steam://open/main'),
                app.destroy(),
            ],
        )
        button.place(y=y_placement, x=25)
        y_placement += 40

        ttk.Button(
            app,
            text="Edit",
            width=4,
            command=lambda: [
                app.destroy(),
                os.remove(filepath),
                os.rmdir(path),
                first_time(),
            ],
        ).place(x=190, y=5)

    if len(account_list) == 5:
        app.geometry("250x260")
    elif len(account_list) == 4:
        app.geometry("250x220")
    elif len(account_list) == 3:
        app.geometry("250x180")
    else:
        app.geometry("250x140")

    app.resizable(False, False)
    app.mainloop()


if __name__ == "__main__":
    main()
