<img alt="GoStack" src="https://s7.gifyu.com/images/Design-sem-nome-1d17c9865e9dcb5cf.gif" />

<div align="center">
  <h2>
    Ticket Sales and Entrance Mananging System Using QR Code and Cloud Computing
  </h2>
  <h4>
    :star: Star us on GitHub — it helps!
  </h4>
   

</div>
<img alt="GoStack" src="https://s7.gifyu.com/images/68747470733a2f2f73372e67696679752e636f6d2f696d616765732f31303030613437623630653535386536302e706e67.png" />
<img alt="GoStack" src="https://s7.gifyu.com/images/Screenshot_20190618-232516.png" />

## 🧿 About the Application Purpose
<div align="justify">
In this GitHub repository, you will find a <b>complete parametrizable application</b> (full-stack and multiple technology) that allow managing ticket sales and entrance mananging, using QR Code using a camera of a mobile application. This application was developed :bulb:, to the CETEC 2019 Bistro Event, that happened in august of 2019 📅 in Flores da Cunha, RS in Brazil. 
</div>

## :rocket: About the Application Architecture and Technologies
<div align="justify">
The architecture of application was developed to running in three different types of machines and applications. 1️⃣ First machine, are responsible to make a sell. In this machine, we running a Delphi / VCL Windows application. This application implements two complete CRUDs. One, to make a login in the system and two, to make a ticket sell. All the operation of this CRUDs are made using 3 web services (that store DBMS). One WS is related to login. Other WSs are responsible to return some information about the festivity and to receive the data about the selling. This data contains the information about the customer like name/e-mail and others. The aplication are responsible to send a e-mail to customer, that contains a QR-Code ticket of purchase. Our application are security guarantee that all data are encrypted, both in transmission of data as in database storing. 2️⃣ In server (second machine) we have the 5 web services (write in PHP) that response about login, about the festivity and to allow the register a purchase. All this information are stored in a MySQL DBMS. Both Delphi and PHP using the user / password mechanisms guarantee that only the votation machine access the database of votation. The last application 3️⃣ of architecture, is a Delphi/FMX responsible android mobile application that implement two complete CRUDs. One, to make a login in the system and two, to authenticate a ticket. All the operation of this CRUDs are made using 2 web services (that store DBMS). One WS is related to login. Other WSs are responsible to receive a SHA string and to validate that this string is active (nobody uses the QR Ticket) or is inative (somebody uses the QR Ticket one time). If ticket is active, WS turn this ticket inative (put false in DMBS) and return true and the mobile application informs the screen GREEN that allow user to pass. Else, WS turn +1 ocurrence of cheat and return false and the mobile application informs the screen RED that not allow user to pass.
</div>

## ✅ Requirements to Installing the Application
<div align="justify">
In Delphi/VCL application, user need to configure the IPv4, user and password (in source code). This files are availabled in the folder src of project. Remember to recompile the EXE file after this changes. Note that EXE file (only running in windows machines) will read this informations, to call the web service. In the server side you need to run a http service with PHP and a MySQL Server. Remember to import the database.sql of database folder (that create all tables to DB) and to put login.php, insereIngresso.php and consultaIngresso.php in www folder of http service. Lastly, modify the admin and password variables of PHP to match of default user and password defines in MySQL server.
</div>

## 💻 Requirements to Running the Application

- Server with Linux like Ubuntu Server 20.04 LTS
- Server with IPv4 static in Internet
- Server that running Http Web Services (NGINX)
- Server running Mysql Services
- Server with Php 5 or Later (7 is the best)
- Computer with Windows Xp or Later
- Mobile cellphone with Android or iOS

## ❤️ Community and Contributions to Future Work
<div align="justify">
Our major dreaming of this project, is that the community uses this magic tool to selling more (whatever kind of product you sell), like we achieved when we developing and apply our study case. But, we are open to new ideas to grow this project to the next level. With future work, that you can implement, we suggest a mobile version of Delphi (using FMX) of selling application. This will allow that every people of sales team, can sell using your cellphone.
</div>

## 📫 Have a question? Want to chat? Ran into a problem?
<div align="justify">
We are really open and interest in your opinion about this tool and his ideia. Feel free to contact us with [e-mail](raffael.schemmer@gmail.com).
</div>

## 🤝 Found a bug? Missing a specific feature?
<div align="justify">
Feel free to <b>file a new issue</b> with a respective title and description on this repository. If you already found a solution to your problem, <b>we would love to review your pull request</b>!
</div>

## 📘 License

This project uses MIT license. See the file [LICENSE](LICENSE) to more details.

---

Made with 💜 by Raffael Schemmer :wave: [See my Online CV!](https://www.raffael.dev)
