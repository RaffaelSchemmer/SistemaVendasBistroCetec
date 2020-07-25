<img alt="GoStack" src="https://s7.gifyu.com/images/banner1e0b6f65bf2500fd.gif" />

<div align="center">
  <h2>
    Real-Time Anonimous Voting System Using Cloud Computing
  </h2>
  <h4>
    :star: Star us on GitHub — it helps!
  </h4>
  

</div>
<img alt="GoStack" src="https://s7.gifyu.com/images/principal72614a5bfd5d7140.png" />


## 🧿 About the Application Purpose
<div align="justify">
  In this GitHub repository, you will find a <b>complete parametrizable application</b> (full-stack and multiple technology) that allow anonimous real-time votation. This application was developed :bulb:, to the CETEC 2019 scientific show , that happened in july of 2019 📅 in Caxias do Sul, RS in Brazil. 
</div>

## :rocket: About the Application Architecture and Technologies
<div align="justify">
The architecture of application was developed to running in three different types of machines and technologies. 1️⃣ First machine, are a responsible touchable screen that running Windows. In this machine, we running a Delphi / VCL application that renders a GRID with knowledge areas of high school (like mathematics and physics). When user select an area, application draw a LIST with the works of area. User need to select one work (using your finger to scroll the list and select a work). When one work is select, the application call a web service, using internal IPv4, and a static user/password. To guarantee the conference of vote, this application write in a local TXT file with all votes. All this values, including areas, works, IPv4, user and password, need to be set staticaly in TXT files.  2️⃣ In server (second machine) we have the web service (write in PHP) that receive the request of user and insert the vote in a MySQL DBMS. The user / password mechanisms guarantee that only the votation machine access the database of votation. The last application 3️⃣ of architecture, is a web application write with php and html / css and ajax / javascript. After 1s a web page execute and AJAX request (to a PHP web service), that select all votes of MySQL DBMS and render the results in a BIG pie chart. This graph is responsible, to allow that all user view the votation status, in your mobile phone. Still, allow that CETEC show the result in a BIG TVs. In the server side of our real application, we use the IaaS Virtual Machine of Google Cloud Platform with static IPv4. We install an NGINX Http Server (with PHP) and a MySQL server.
</div>

## ✅ Requirements to Installing the Application
<div align="justify">
User need to configure all areas of knowledge (areas.txt) and the related works (trabalhos.txt) and the file of server configuration (conf.txt). Note that the IPv4, user and password need to be change. This 3 files are availabled in the folder bin of project. Note that EXE file (only read in Windows machines) will read this 3 files to start the main application. In the server side you need to run a http service with PHP and a MySQL Server. Remember to import the database.sql  of database folder (that create all tables do DB) and to put insereVoto.php and index.php in www folder of http service. Lastly, modify the admin and password variables of PHP to match of default user and password defines in MySQL server.

</div>

## 💻 Requirements to Running the Application

- Server with Linux like Ubuntu Server 20.04 LTS
- Server with IPv4 static in Internet
- Server that running Http Web Services (NGINX)
- Server running Mysql Services
- We recommend that server have a name (like votingcetec.app)
- Server with Php 5 or Later (7 is the best)
- Computer with Windows Xp or Later
- Computer with Browser like Chrome or Internet Explorer

## ❤️ Community and Contributions to Future Work
<div align="justify">
Our major dreaming of this project, is that the community uses this magic tool to evaluate "the feeling" of people, about some subject (like a scientific show), with are implemented in our study case. But, we are open to new ideas to grow this project to the next level. With future work, that you can implement, we suggest a mobile version of Delphi (using FMX). This will allow that every people of show, can vote independently.
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
