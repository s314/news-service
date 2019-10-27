# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
  # Add entry to read later
  buttonrl = null;
  $(".rl_submit").click (event) ->
    buttonrl = $(event.target);
  $(this)
    .on "ajax:beforeSend", (evt, xhr, settings) ->
      $(buttonrl)
        .addClass('disabled')
        .attr('disabled', 'disabled');
    .on "ajax:success", (data, status, xhr) ->
      parsed = data.detail[0];
      $(buttonrl)
        .tooltip('hide')
        .removeClass("btn-primary")
        .addClass("btn-outline-primary")
        .html("<i class=\"fa fa-check\"></i>");

jQuery ->
# Add entry to moderate
  buttonln = null;
  $(".ln_submit").click (event) ->
    buttonln = $(event.target);
  $(this)
    .on "ajax:beforeSend", (evt, xhr, settings) ->
      $(buttonln)
        .addClass('disabled')
        .attr('disabled', 'disabled');
    .on "ajax:success", (data, status, xhr) ->
      parsed = data.detail[0];
      $(buttonln)
        .tooltip('hide')
        .parent().empty()
        .parent().html("Уведомлено");