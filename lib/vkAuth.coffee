https = require 'https'
phantom = require 'phantom'
colors = require 'colors'
code = null
params = null

getToken = (callback) ->
  options =
    host: 'oauth.vk.com'
    port: 443
    path: "/access_token?client_id=#{params.appID}" + 
      "&client_secret=#{params.appSecret}" +
      "&code=#{code}"

  https.get options, (res) ->
    response = new String
    res.setEncoding 'utf8'
    res.on 'data', (chunk) -> response += chunk
    res.on 'end', ->
      json = JSON.parse response
      if json.access_token
        console.log "Auth successed!".green
        callback json.access_token
      else
        throw json.error

getPermissions = (callback) ->
  phantom.create (ph) ->
    ph.createPage (page) ->
      page.set 'onUrlChanged', (url) ->
        console.log "URL changed by script: ".grey , url.underline

      page.set 'onLoadFinished', (success) ->
        if success is 'fail' then callback null
        console.log "Load status ".grey , success

      page.set 'onNavigationRequested', (url) ->
        console.log "URL changed: ".grey , url.underline
        match = url.match /#code=(.*)/
        if match
          code = match[1]
          ph.exit()
          callback()

      # Fix page.evaluate for pass variables inside sandbox
      evaluate = (page, func) ->
        args = [].slice.call arguments, 2
        fn = "function() { return (" + func.toString() + ").apply(this, " + JSON.stringify(args) + ");}"
        page.evaluate fn

      # Login into vk.com
      page.open "https://vk.com", (status) ->
        evaluate page, (params) ->
          form = document.getElementById 'quick_login_form'
          emailField = document.getElementById 'quick_email'
          passField = document.getElementById 'quick_pass'
          emailField.value = params.email
          passField.value = params.passw
          form.submit()
        , params

      getCode = ->
        url = "https://oauth.vk.com" +
          "/authorize/?client_id=#{params.appID}" +
          "&scope=audio" +
          "&response_type=code"
        page.open url, (status) ->
          page.evaluate ->
            btn = document.getElementById 'install_allow'
            btn.click()

      # Try to get code
      setTimeout getCode, 4000


module.exports = (options) ->
  initialize: (callback) ->
    params = options
    getPermissions (status) ->
      if status is null then callback null
      getToken (token) ->
        callback token



