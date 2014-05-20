# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

#This javascript uses Mustache.js to render JSON from a
#separate app!


$ ->
  #loads JSON listing of campaigns on home page
  $.ajax
    url: "http://localhost:3000/api/v1/campaigns/"
    dataType: "json"
    method: "get"
    data:
      access_token: "INSERT TOKEN"
    error: ->
      alert("ERROR")
    success: (data) ->
      #pop up alert removed:
      #alert("SUCCESS")
      template = $("#campaign-listing-template").html()
      Mustache.parse(template)
      for campaign in data
        rendered_template = Mustache.render(template, campaign)
        #(renders defined html template, then @campaign method to call on it
        #e.g.in views {{title}} same as @campaign.title
        $("#campaigns").append rendered_template

  #renders the show page of a specific campaign when link is clicked
  $("#campaigns").on "click", ".title", ->
    #below triggers alert if you want that:
    #alert($(@).data("id"));
    $.ajax
      url: "http://localhost:3000/api/v1/campaigns/" + $(@).data("id")
      dataType: "json"
      method: "get"
      data:
        access_token: "INSERT TOKEN HERE"
      error: ->
        alert("error")
      success: (data) ->
        #alert("succees!")
        template = $("#single-campaign-display").html()
        rendered = Mustache.render(template, data)
        $("#single-campaign-container").hide()
        $("#single-campaign-container").html rendered
        $("#campaigns").fadeOut 50, ->
          $("#single-campaign-container").fadeIn(50)

    false
  #Ajax back button to return to list of campaigns
  $("#single-campaign-container").on "click", ".back", ->
    $("#single-campaign-container").fadeOut 400, ->
      $("#campaigns").fadeIn 300