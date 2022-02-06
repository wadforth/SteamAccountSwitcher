# Steam Account Switcher
Basic Batch Script to allow seamless switching between up to 7 accounts.

### Short-term
- [x] **Switching Process**
- [x] **Config Implementation** 
- [x] **Allow user to input how many accounts**
- [x] **Edit/delete accounts (you can do this manually by just deleting the config file)**

### Long-term
- [x] **Switch to Python**
- [x] **Updated interface**
- [x] **Convert to executable**

### Extras
- [ ] **Config encryption (not needed as it is created in your local appdata, but can be done)**

# How does it work?
Quite simple actually. The batch file is ran and checks to see if Steam is currently open, if it is it'll close the process. It will then check to see if you already have a pre-existing config file in the location the batch originally stores it.

For the Python script/binary it works similary.  You'll have 5 input forms to enter an account in. Once saved, you can then choose on a different window to switch between each.

If it is your first time set-up it will prompt you to enter your main account and your alternate account. If you've already set-up before, it will take you directly to the account selection where you can input your choice of which account you want to login to.

Once an account has been selected it will alter your registry to allow you to bypass the Steam login page.
### **YOU DO NEED TO FIRST LOGIN TO BOTH ACCOUNTS USING THE SCRIPT TO ALLOW THE SEEMLESS SWITCHING**

# What data is stored?
All data is stored locally, so there is no need to worry of where your data is getting sent to. The only data that is being stored is your username. 

A simple text config file is getting stored at
>~Documents/SteamAccountSwitcher/config.txt

An option has been added to delete the data.

# Why?
Well, the way Steam is currently set-up (in my experience anyway), after you log out of an account, you always have to login to the other account even if your machine is trusted and you've logged in and selected remember password before. This can become tedious if you're constantly switching, especially if you have 2FA enabled. The script fully bypass' entering your password and 2FA (after first time using the script).

# Images

![screen1](https://user-images.githubusercontent.com/45768489/152704982-ed0613a7-5bba-4b49-b9d8-7d9a28f52f9f.png)          ![screen2](https://user-images.githubusercontent.com/45768489/152704987-0d6681fe-cb19-432c-9390-c17db2af44f6.png)


