node-vk-music-sync
==================

Sync your music from vk.com to your computer.

## How to install
1. You need to install [NodeJS](http://nodejs.org/) and [PhantomJS](http://phantomjs.org/)

2. Install npm module globally
  ```sh
  npm install -g node-vk-music-sync
  ```
3. You need to fill email/telephone and password in users/main.json or create new config for support multiple accounts. And as you can change maximum download threads and directory for downloads
  ```json
  {
    "email": "youremail@example.com",
    "passw": "yourpassword",
    "dlThreads": 4,
    "dlPath": "#{__dirname}/cache"
  }
  ```

4. Start app
  ```sh
  vksync
  ```

  or start with custom user from config in 'users' folder
  ```sh
  vksync <config_name>
  ```
