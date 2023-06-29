<h1 align="center" id="title">Generate Express (genEx)</h1>

<p align="center"><img src="https://gcdnb.pbrd.co/images/NY49j63eiR6T.jpg?o=1"></p>

<p id="description">
Are you tired of spending endless hours structuring your ExpressJS projects from scratch? Say goodbye to the hassle and welcome a game-changing solution! Introducing GenEx, a powerful and small PowerShell script designed to streamline your project setup process and elevate your development experience to new heights.

With GenEx, you can bid farewell to the tedious manual creation of project structures. Inspired by the convenience of popular tools like CRA (create-react-app) and Vite, this innovative script empowers you to effortlessly generate an efficient folder structure for your small, medium, or even large-scale applications. It also provides you essential (listed below) including MySQL/Knex library</p>

<h2>🏗️ Effortless Setup:</h2>

No more wasting precious time on mundane project structuring tasks! GenEx automates the process, allowing you to kickstart your projects in seconds. Focus on what truly matters—building exceptional applications.

<h2>📁 Optimal Folder Structure:</h2>

A well-thought-out folder structure that caters to the unique needs of ExpressJS applications. It ensures a logical organization of files, making it a breeze to navigate and maintain your codebase. Say goodbye to chaos and welcome order!

<p align="center"><img src="https://gcdnb.pbrd.co/images/n6xsPOnhO4aZ.png?o=1" height="400" width="150">
<img src="https://gcdnb.pbrd.co/images/vbkwUqAr7TKK.png?o=1" height="400" width="150"></p>
<h2>🕸️ Packages installed by default:</h2>

*   express
*   axios
*   bcrypt
*   cors
*   dotenv
*   jsonwebtoken
*   knex
*   mysql
*   multer
*   node-cron
*   nodemon
*   uuid
*   nodemailer
*   typescript (if selected TypeScript)
*   ts-node (if selected TypeScript)

<h2>💡 Save Time, Boost Quality:</h2>
By eliminating the repetitive and time-consuming task of manually setting up project structures, ExpressJS Project Structurer empowers you to dedicate your valuable time to enhancing the quality of your projects. Invest your efforts where they truly count and unlock the full potential of your applications.

<h2>🌟 Key Features:</h2>

*   Rapidly create an optimal folder structure for your ExpressJS projects
*   Tailored for small to medium and potentially large-scale applications
*   Intuitive and easy-to-use script for developers of all levels
*   MySQL/Knex is set for your configuration
*   git initialized by default
*   JWT setup with a random string generated from crypto library in .env file
*   and other boilerplates!
  
Don't let tedious project setup slow you down. Supercharge your ExpressJS development process with ExpressJS Project Structurer and witness a new era of efficiency and quality. Get started today and revolutionize the way you build exceptional applications! ✨

<h2>🛠️ Installation Steps:</h2>

<p>0. Must haves</p>

```
Node
Knex (globally installed)
Powershell
```

<p>1. Open PowerShell and clone the repo</p>

```
$ git clone https://github.com/NB071/GenEx
```
<p>2. Navigate to the project's folder</p>

```
$ cd GenEx
```

<p>3. Check and modify your execution policy if needed</p>

```
$ Get-ExecutionPolicy

it should be `RemoteSigned`
if it's not, change it:

$ Set-ExecutionPolicy <Unrestricted/RemoteSigned>
```


<p>You could run the script now. However, for later uses, I recommend creating an alias (depending on your OS and shell you are currently using)</p>

<h2>📜 Script Usage and tips:</h2>

```
$ <script> [-d/-dir/-directory] <PROJECT'S_FOLDER_NAME> [-t/-temp/-template] <Extension type: js | ts>
$ ./genEx.ps1 -d example -t ts
```
<p>TIP: the extension type is optional, and the default creates js files</p>
<p>TIP: if you're in a rush, you can only run:</p>

```
$ <script> <PROJECT'S_FOLDER_NAME> <Extension type: js | ts>
$ ./genEx.ps1 example ts
```
<p>TIP: if you're in a rush, you can only run:</p>

<h2>📑 What to do after ?</h2>
<p>1. setup your db</p>
<p>2. setup your environment variables</p>
<p>3. customize the structure if needed</p>
<p>4. develop your application</p>
<p>5. connect your repo</p>
<p>6. edit README.md</p>

<h2>🍰 Contribution Guidelines:</h2>

1\. Fork the repository\. <br>
2\. Create a new branch: ```git checkout -b feature-name``` <br>
3\. Make your changes\. <br>
4\. Commit your changes: ```git commit -m 'Add some feature'```  <br>
5\. Push to the branch: ```git push origin feature-name``` <br>
6\. Submit a pull request <br>
<b>I warmly welcome any ideas and feedback from all!</b>

  <h2>🔐 Security:</h3>
  <p>This script is open-source and initially developed for my personal use. Its purpose is only to create files and folders. There is no malicious activity involved in any part of this script!</p>
  

<h2>💻 Built with</h2>

Powershell
