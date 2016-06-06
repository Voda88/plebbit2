# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

#activate full image modal

$(document).on "click", ".thumbnail", ->
	$('.modal-body').empty()
	title = $(this).attr('title')
	$('.modal-title').html title
	$(@innerHTML).appendTo '.modal-body'
	$('#myModal').removeClass 'hide'
	$('#myModal').modal show: true
	return

#Check picture size

$('#topic_picture').bind 'change', ->
	size_in_megabytes = @files[0].size / 1024 / 1024
	if size_in_megabytes > 15
		alert 'Maksimikuvakoko 15MB'
	return
