node-vk-music-sync
==================

Sync your music from vk.com to your computer.

## How to install
1. You need to install [NodeJS](http://nodejs.org/) and [PhantomJS](http://phantomjs.org/) (for easiest authorization)

2. Install npm module globally
  ```sh
  npm install -g node-vk-music-sync
  ```
3. Fill email/telephone and password in */usr/local/lib/node_modules/node-vk-music-sync/profiles/main.json* or create new config for multiple accounts support. And as you can change maximum download threads and directory for download (by default in current folder).
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

  or start with custom user from config in module 'profiles' folder
  ```sh
  vksync <config_name>
  ```
