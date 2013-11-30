exports.initialize = (args) ->
  configName = if args.length isnt 0 then args[0] else 'main'
  params = require "#{__dirname}/users/#{configName}.json"
  params.appID = '4027411'
  params.appSecret = 'MDn6yOgRLmkWBbm1PTFL'

  vkAuth = require('./lib/vkAuth')(params)
  musicParser = require('./lib/musicParser')(params)

  vkAuth.initialize (token) ->
    if token is null then throw "Can't authorize on vk.com server. Aborted."
    musicParser.getCollectionFromServer token, (music) ->
      musicParser.downloadCollection()