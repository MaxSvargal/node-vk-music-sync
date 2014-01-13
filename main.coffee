fs = require 'fs'

exports.initialize = (args) ->
  configName = if args.length isnt 0 then args[0] else 'main'
  configPath = "#{__dirname}/profiles/#{configName}.json"
  fs.exists configPath, (exists) ->
    if not exists 
      console.log "Config #{configName} doesn't exists."
      return

    params = require configPath
    params.appID = '4027411'
    params.appSecret = 'MDn6yOgRLmkWBbm1PTFL'
    params.dlPath = if isnt params.dlPath then process.cwd() else params.dlPath

    vkAuth = require('./lib/vkAuth')(params)
    musicParser = require('./lib/musicParser')(params)

    vkAuth.initialize (token) ->
      if token is null then throw "Can't authorize on vk.com server. Aborted."
      musicParser.getCollectionFromServer token, (music) ->
        musicParser.downloadCollection()