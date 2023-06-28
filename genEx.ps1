param (
  [Parameter(Mandatory = $true, Position = 0)]
  [Alias("d", "dir", "directory")]
  [string]$directoryName,
  [Parameter(Mandatory = $false, Position = 1)]
  [Alias("t", "temp", "template")]
  [ValidateSet("ts", "js")]
  [string]$templateExtension = "js"
    
)

# Create the directory if it doesn't exist
if (-not (Test-Path -Path $directoryName -PathType Container)) {
  Write-Host "[*] Creating directory => $directoryName"
  New-Item -ItemType Directory -Name $directoryName -Path "./" | Out-Null
  Write-Host "[+] Directory ($directoryName) Created Successfully.`n"
}
else {
  Write-Host "[-] Directory ($directoryName) already exists!"
  return
}

Set-Location $directoryName

# Create package.json file
Write-Host "[*] Creating file => package.json"
Invoke-Expression -Command "npm init -y" | Out-Null

# Edit package.json scripts  
$packageJson = Get-Content -Raw -Path "./package.json" | ConvertFrom-Json
$packageJson.scripts = @{
  "test"     = "echo `"Error: no test specified`" && exit 1"
  "start"    = "nodemon --exec ts-node index.ts"
  "migrate"  = "knex migrate:latest"
  "rollback" = "knex migrate:rollback"
  "seed"     = "knex seed:run"
}
$updatedJson = $packageJson | ConvertTo-Json -Depth 4
$updatedJson | Set-Content -Path "./package.json"

Write-Host "[+] File (package.json) Created Successfully.`n"

# Install packages
Write-Host "[*] Installing npm Packages"
if ($templateExtension -eq "ts") {
  Invoke-Expression -Command "npm i axios bcrypt cors dotenv express jsonwebtoken knex mysql multer node-cron nodemon uuid nodemailer typescript ts-node" | Out-Null
  Invoke-Expression -Command "npm i -D @types/node-cron @types/nodemailer @types/express @types/node @types/jsonwebtoken @types/multer" | Out-Null
}
else {
  Invoke-Expression -Command "npm i axios bcrypt cors dotenv express jsonwebtoken knex mysql multer node-cron nodemon uuid nodemailer" | Out-Null
}
Write-Host "[+] npm Packages Successfully Installed.`n"

# Create configs directory
Write-Host "[*] Creating directory => configs"
New-Item -ItemType Directory -Name "configs" -Path "./" | Out-Null
Write-Host "[+] Directory (configs) Created Successfully.`n"

# Place file(s) for configs directory
Set-Location "./configs"

Write-Host "[*] Creating file => configs/db.$templateExtension"
New-Item -ItemType File -Name "db.$templateExtension" -Path "./" | Out-Null

# Create Knex configuration
if ($templateExtension -eq "ts") {
  @'
import type { Knex } from "knex";
import * as dotenv from "dotenv";
import { join } from "path";

// Configure .env file
dotenv.config();

export default {
  client: "mysql",
  connection: {
    host: process.env.DB_HOST,
    database: process.env.DB_LOCAL_DBNAME,
    user: process.env.DB_LOCAL_USER,
    password: process.env.DB_LOCAL_PASSWORD,
  },
  seeds: {
    directory: join("..", "models", "seeds"),
  },
  migrations: {
    directory: join("..", "models", "migrations"),
  },
} as { [key: string]: Knex.Config };
'@ | Set-Content -Path "./db.$templateExtension"
}
else {
  @'
import * as dotenv from "dotenv";
import { join } from "path";

// Configure .env file
dotenv.config();

/**
 * @type { Object.<string, import("knex").Knex.Config> }
 */

export default {
  client: "mysql",
  connection: {
    host: process.env.DB_HOST,
    database: process.env.DB_LOCAL_DBNAME,
    user: process.env.DB_LOCAL_USER,
    password: process.env.DB_LOCAL_PASSWORD,
  },
  seeds: {
    directory: join(__dirname, "models", "seeds"),
  },
  migrations: {
    directory: join(__dirname, "models", "migrations"),
  },
};
'@ | Set-Content -Path "./db.$templateExtension"
}

Write-Host "[+] File (configs/db.$templateExtension) Created Successfully.`n"
Write-Host "[*] Creating file => configs/mail.$templateExtension"
New-Item -ItemType File -Name "mail.$templateExtension" -Path "./" | Out-Null

# content
@'
import * as nodemailer from "nodemailer";
import * as dotenv from "dotenv";

// Configure .env file
dotenv.config();

// Example nodemailer configuration
async function configureTransporter() {
  try {
    // Create a transporter using SMTP
    const transporter = nodemailer.createTransport({
      host: process.env.SMTP_HOST,
      port: Number(process.env.SMTP_PORT),
      secure: process.env.SMTP_SECURE === 'true',
      auth: {
        user: process.env.SMTP_USERNAME,
        pass: process.env.SMTP_PASSWORD,
      },
    });

    return transporter;
  } catch (error) {
    console.error('Error configuring Nodemailer transporter:', error);
    throw error;
  }
}

export { configureTransporter }
'@ | Set-Content -Path "./mail.$templateExtension"

Write-Host "[+] File (configs/mail.$templateExtension) Created Successfully.`n"

# Create tsconfig configuration
if ($templateExtension -eq "ts") {
  Write-Host "[*] Creating file => configs/tsconfig.json"
  New-Item -ItemType File -Name "tsconfig.json" -Path "./" | Out-Null
  
  # contents
  @'
{
  "compilerOptions": {
    "target": "es6",
    "module": "commonjs",
    "outDir": "../dist",
    "strict": true,
    "esModuleInterop": true
  },
  "include": ["*.ts"]
}
    
'@ | Set-Content -Path "./tsconfig.json"
    
  Write-Host "[+] File (configs/tsconfig.json) Created Successfully.`n"
}
Set-Location ".."

# Create controllers directory
Write-Host "[*] Creating directory => controllers"
New-Item -ItemType Directory -Name "controllers" -Path "./" | Out-Null
Write-Host "[+] Directory (controllers) Created Successfully.`n"

# Place api sub-directory for controllers
Set-Location "./controllers"
Write-Host "[*] Creating directory => controllers/api"
New-Item -ItemType Directory -Name "api" -Path "./" | Out-Null
Write-Host "[+] Directory (controllers/api) Created Successfully.`n"


# Place files for controllers/api directory
Set-Location "./api"
Write-Host "[*] Creating file => controllers/api/index.$templateExtension"
New-Item -ItemType File -Name "index.$templateExtension" -Path "./" | Out-Null

# contents
if ($templateExtension -eq "ts") {
  @'
import type { Request, Response, RequestHandler } from 'express';
import * as query from "../../models/queries"

// Your controller functions go here...
const sample: RequestHandler = async (req: Request, res: Response) => {
  query.fetchUsernames() // sample fake query
  res.json({ success: "Sample response" });
}

module.exports = {
    sample
};    
'@ | Set-Content -Path "./index.$templateExtension"
}
else {
  @'
// import queries
import * as query from "../../models/queries"

// Your controller functions go here...
module.exports.sample = async (req, res) => {
  query.fetchUsernames() // sample fake query
  res.json({ success: "Sample response" });
}
'@ | Set-Content -Path "./index.$templateExtension"
}

Write-Host "[+] File (controllers/api/index.$templateExtension) Created Successfully.`n"

Set-Location ".."

# Place auth sub-directory for controllers
Write-Host "[*] Creating directory => controllers/auth"
New-Item -ItemType Directory -Name "auth" -Path "./" | Out-Null
Write-Host "[+] Directory (controllers/auth) Created Successfully.`n"


# Place files for controllers/api directory
Set-Location "./auth"
Write-Host "[*] Creating file => controllers/auth/index.$templateExtension"
New-Item -ItemType File -Name "index.$templateExtension" -Path "./" | Out-Null

# contents
if ($templateExtension -eq "ts") {
  @'
import type { Request, Response, RequestHandler } from 'express';
import * as query from "../../models/queries"
import * as jwtUtils from "../../utils/jwt"

// Your controller functions go here...
const sampleLogin: RequestHandler = async (req: Request, res: Response) => {
  try {
    query.login() // sample fake query
    const token = jwtUtils.generateAccessToken('user1')
    res.json({ token });
  } catch (error) {
    return res.status(500).json({ error });
  }
} 

module.exports = {
  sampleLogin
};    
'@ | Set-Content -Path "./index.$templateExtension"
}
else {
  @'
// import queries
import * as query from "../models/queries"
import * as jwtUtils from "../../utils/jwt"

// Your controller functions go here...
module.exports.sample = async (req, res) => {
  try {
    query.login() // sample fake query
    const token = jwtUtils.generateAccessToken('user1')
    res.json({ token });
  } catch (error) {
    return res.status(500).json({ error });
  }
}
'@ | Set-Content -Path "./index.$templateExtension"
}

Write-Host "[+] File (controllers/auth/index.$templateExtension) Created Successfully.`n"

Set-Location "../.."

# Create middlewares directory
Write-Host "[*] Creating directory => middlewares"
New-Item -ItemType Directory -Name "middlewares" -Path "./" | Out-Null
Write-Host "[+] Directory (middlewares) Created Successfully.`n"

# Place file(s) for middlewares directory
Set-Location "./middlewares"
Write-Host "[*] Creating file => auth.$templateExtension"
New-Item -ItemType File -Name "auth.$templateExtension" -Path "./" | Out-Null
Write-Host "[+] File (auth.$templateExtension) Created Successfully.`n"

Set-Location ".."

# Create models directory
Write-Host "[*] Creating directory => models"
New-Item -ItemType Directory -Name "models" -Path "./" | Out-Null
Write-Host "[+] Directory (models) Created Successfully.`n"

# Place sub-directories for models
Set-Location "./models"

# Place models/migration sub-directory
Write-Host "[*] Creating directory + sample => models/migrations"
New-Item -ItemType Directory -Name "migrations" -Path "./" | Out-Null
Write-Host "[+] directory (models/migrations) Created Successfully.`n"

# Create a knex migration file sample
Set-Location "./migrations"
Invoke-Expression -Command "knex migrate:make test --knexfile ../../configs/db.ts -x ts" | Out-Null
Set-Location ".."

# Place models/seeds sub-directory
Write-Host "[*] Creating directory + sample => models/seeds"
New-Item -ItemType Directory -Name "seeds" -Path "./" | Out-Null

# Create a knex migration file sample
Set-Location "./seeds"
Invoke-Expression -Command "knex seed:make test --knexfile ../../configs/db.ts -x ts" | Out-Null
Set-Location ".."

Write-Host "[+] directory (models/seeds) Created Successfully.`n"

# Place models/queries sub-directory
Write-Host "[*] Creating directory => models/queries"
New-Item -ItemType Directory -Name "queries" -Path "./" | Out-Null
Write-Host "[+] directory (models/queries) Created Successfully.`n"

Set-Location "./queries"

Write-Host "[*] Creating file => models/queries/index.$templateExtension"
New-Item -ItemType File -Name "index.$templateExtension" -Path "./" | Out-Null

# contents
if ($templateExtension -eq "ts") {
  @'
// knex configuration
import knexConfig from "../../configs/db";
import { knex } from "knex";
const db = knex(knexConfig);

// Your query functions go here...

// Ex: Query all usernames
function fetchUsernames(): object {
  return {};
}
// Ex: Query for login
function login(): object {
  // process
  return {};
}

export { fetchUsernames, login };
'@ | Set-Content -Path "./index.$templateExtension"
}
else {
  @'
// knex configuration
import knexConfig from "../../configs/db";
import { knex } from "knex";
const db = knex(knexConfig);

// Your query functions go here...

// Ex: Query all usernames
function fetchUsernames(){
  return {};
}

// Ex: Query for login
function login(): object {
  // process
  return {};
}
export { fetchUsernames, login };
'@ | Set-Content -Path "./index.$templateExtension"
}

Write-Host "[+] File (models/queries/index.$templateExtension) Created Successfully.`n"

Set-Location "../.."

# Create routes directory
Write-Host "[*] Creating directory => routes"
New-Item -ItemType Directory -Name "routes" -Path "./" | Out-Null
Write-Host "[+] Directory (routes) Created Successfully.`n"

# Place /routes/api sub-directory
Set-Location "./routes"
Write-Host "[*] Creating directory => routes/api"
New-Item -ItemType Directory -Name "api" -Path "./" | Out-Null
Write-Host "[+] directory (routes/api) Created Successfully.`n"

# Place sample file(s) into routes/api
Set-Location "./api"
Write-Host "[*] Creating file => routes/api/index.$templateExtension"
New-Item -ItemType File -Name "index.$templateExtension" -Path "./" | Out-Null

# contents
if ($templateExtension -eq "ts") {
  @'
import {Router} from "express"
import * as multer from "multer"
import * as apiRoute from "../../controllers/api"

'@ | Set-Content -Path "./index.$templateExtension"
}
else {
  @'
import {Router} from "express"
import * as multer from "multer"
import * as apiRoute from "../../controllers/api"

'@ | Set-Content -Path "./index.$templateExtension"
}

Write-Host "[+] File (routes/api/index.$templateExtension) Created Successfully.`n"

Set-Location ".."

# Place /routes/auth sub-directory
Write-Host "[*] Creating directory => routes/auth"
New-Item -ItemType Directory -Name "auth" -Path "./" | Out-Null
Write-Host "[+] directory (routes/auth) Created Successfully.`n"

# Place sample file(s) into routes/auth
Set-Location "./auth"
Write-Host "[*] Creating file => routes/auth/index.$templateExtension"
New-Item -ItemType File -Name "index.$templateExtension" -Path "./" | Out-Null

# contents
if ($templateExtension -eq "ts") {
  @'
import {Router} from "express"
import * as authRoute from "../../controllers/auth"

'@ | Set-Content -Path "./index.$templateExtension"
}
else {
  @'
import {Router} from "express"
import * as authRoute from "../../controllers/auth"

'@ | Set-Content -Path "./index.$templateExtension"
}

Write-Host "[+] File (routes/api/index.$templateExtension) Created Successfully.`n"

Set-Location "../.."

# Create utils directory
Write-Host "[*] Creating directory => utils"
New-Item -ItemType Directory -Name "utils" -Path "./" | Out-Null
Write-Host "[+] Directory (utils) Created Successfully.`n"

# Place file(s) for utils directory
Set-Location "./utils"
Write-Host "[*] Creating file => cron.$templateExtension"
New-Item -ItemType File -Name "cron.$templateExtension" -Path "./" | Out-Null

# contents
@'
import * as cron from "node-cron"

// Your cron functions go here...
cron.schedule("0 0 * * 0", async () => {
    try {
      console.log("Task 1 Completed")
    } catch (error) {
      console.error("Task 1 failed:", error);
    }
  });
'@ | Set-Content -Path "./cron.$templateExtension"

Write-Host "[+] File (cron.$templateExtension) Created Successfully.`n"

Write-Host "[*] Creating file => jwt.$templateExtension"
New-Item -ItemType File -Name "jwt.$templateExtension" -Path "./" | Out-Null

# contents
if ($templateExtension -eq "ts") {
  @'
import * as jwt from "jsonwebtoken";
import * as dotenv from "dotenv";

// Configure .env file
dotenv.config();

// Your jwt functions go here...
// Customize the payload according to your application

// Generate token
const generateAccessToken = (username: string): string | boolean => {
  if (!username || !process.env.JWT_SIGN_KEY) {
    return false; // username or secret key is undefined or empty
  }
  return jwt.sign(username, process.env.JWT_SIGN_KEY, { expiresIn: "24h" });
};

// Verify token
const verifyAccessToken = (token: string): boolean => {
  try {
    if (!token || !process.env.JWT_SIGN_KEY) {
      return false; // Token or secret key is undefined or empty
    }
    jwt.verify(token, process.env.JWT_SIGN_KEY);
    return true;
  } catch (error) {
    return false; // Token verification failed
  }
};

export {
  generateAccessToken,
  verifyAccessToken,
};
'@ | Set-Content -Path "./jwt.$templateExtension"
}
else {
  @'
import * as jwt from "jsonwebtoken";
import * as dotenv from "dotenv";

// Configure .env file
dotenv.config();
  
// Your jwt functions go here...
// Customize the payload according to your application

// Generate token
module.exports.generateAccessToken = (username) => {
  return jwt.sign(username, process.env.JWT_SIGN_KEY, { expiresIn: "24h" });
};

// Verify token
module.exports.verifyAccessToken = (token) => {
  try {
    jwt.verify(token, process.env.JWT_SIGN_KEY);
    return true;
  } catch (error) {
    return false;
  }
};
'@ | Set-Content -Path "./jwt.$templateExtension"
}

Write-Host "[+] File (jwt.$templateExtension) Created Successfully.`n"

Set-Location ".."

# Create public directory
Write-Host "[*] Creating directory => public"
New-Item -ItemType Directory -Name "public" -Path "./" | Out-Null
Write-Host "[+] Directory (public) Created Successfully.`n"

# Place sub-directories for public
Set-Location "./public"

# Place public/images sub-directory
Write-Host "[*] Creating directory => public/images"
New-Item -ItemType Directory -Name "images" -Path "./" | Out-Null
Write-Host "[+] directory (public/images) Created Successfully.`n"

# Place public/videos sub-directory
Write-Host "[*] Creating directory => public/videos"
New-Item -ItemType Directory -Name "videos" -Path "./" | Out-Null
Write-Host "[+] directory (public/videos) Created Successfully.`n"

Set-Location ".."


# Create Index.js/ts
Write-Host "[*] Creating file => index.$templateExtension"
New-Item -ItemType File -Name "index.$templateExtension" -Path "./" | Out-Null
Write-Host "[+] File (index.$templateExtension) Created Successfully.`n"

# Create .env file
Write-Host "[*] Creating file => .env"
New-Item -ItemType File -Name ".env" -Path "./" | Out-Null

# contents
@'
# Nodemailer variables
SMTP_HOST=your_smtp_host
SMTP_PORT=your_smtp_port
SMTP_USERNAME=your_smtp_username
SMTP_PASSWORD=your_smtp_password

# DB variables
DB_HOST=your_db_host
DB_LOCAL_DBNAME=your_db_name
DB_LOCAL_USER=your_db_username
DB_LOCAL_PASSWORD=your_db_password

# Other variables
JWT_SIGN_KEY=$(Invoke-Expression -Command 'node -e "console.log(require(''crypto'').randomBytes(32).toString(''hex''))"').Trim()
'@ | Set-Content -Path "./.env"

Write-Host "[+] File (.env) Created Successfully.`n"

# create .env-sample file
Write-Host "[*] Creating file => .env-sample"
New-Item -ItemType File -Name ".env-sample" -Path "./" | Out-Null

# contents
@'
# Nodemailer variables
SMTP_HOST=your_smtp_host
SMTP_PORT=your_smtp_port
SMTP_USERNAME=your_smtp_username
SMTP_PASSWORD=your_smtp_password

# DB variables
DB_HOST=your_db_host
DB_LOCAL_DBNAME=your_db_name
DB_LOCAL_USER=your_db_username
DB_LOCAL_PASSWORD=your_db_password

# Other variables
JWT_SIGN_KEY=your_jwt_sign_key
'@ | Set-Content -Path "./.env-sample"

Write-Host "[+] File (.env-sample) Created Successfully.`n"

# create README file
Write-Host "[*] Creating file => README.md"
New-Item -ItemType File -Name "README.md" -Path "./" | Out-Null

Write-Host "[+] File (README.md) Created Successfully.`n"

# contents
@'
<h1 align="center" id="title">Title</h1>
<p>[project img]</p>
<p id="description">Desciption</p>
<h2>* Demo</h2>
[https://Example.com](#)
<h2>Database Schema:</h2>
<p>[db schema img]</p>
<h2>* External API's :</h2>
*   [External API 1](#)
*   [External API 2](#)
*   [External API 3](#)
<h2>* End-points:</h2>
Here's an overview of all end-points used in the API:
*   GET / => Welcome Message 
<h2>* Installation Steps:</h2>
<p>1. STEP</p>
```
$ git command #1
```
<p>2. STEP</p>

```
$ command #2
```
<p>3. STEP</p>
```
$ command #3
```
<p>4. STEP</p>
```
$ command #4
```
<p>5. STEP</p>
```
$ command #5
```
<p>6. STEP</p>
```
$ command #6
```
<p>7. STEP</p>
```
$ command #7
```
<h2>* Contribution Guidelines:</h2>
1\. Fork the repository\. <br>
2\. Create a new branch: ```git checkout -b feature-name``` <br>
3\. Make your changes\. <br>
4\. Commit your changes: ```git commit -m 'Add some feature'```  <br>
5\. Push to the branch: ```git push origin feature-name``` <br>
6\. Submit a pull request <br>
<h2>* Built with</h2>
Technologies used in the project:
*   Node.js / Express.js
*   Knex.js / MySQL
*   Technology Example (1)
*   Technology Example (2)
*   Technology Example (3)
'@ | Set-Content -Path "./README.md"

# init git
Write-Host "[*] Initializing => Git"
New-Item -ItemType File -Name ".gitignore" -Path "./" | Out-Null

# contents
@'
/node_modules/
.env
'@ | Set-Content -Path "./.gitignore"
Invoke-Expression -Command "git init" | Out-Null

Write-Host "[+] Git Initialized Successfully.`n"