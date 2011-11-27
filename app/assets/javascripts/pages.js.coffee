# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready () ->
	$("#top-bar").hide()
	$(".login-link").show()
	if($('.notice').text() == 'Type in the password again to register.') 
		$("#top-bar").slideToggle(300, () ->
			$('.password-form').focus()
		)
	$(".show").click () ->
		$('.show').hide();
		$(".choices").fadeIn(500)
	$("span.login").click () ->
		$(".login-link").hide()
		$("#top-bar").slideToggle(300, () ->
			$('.username-form').focus()
		)
	$('#overlay').center()
	$('span.info').click () ->
		$('#overlay-bg').show()
		$('#overlay-inner').append('<p>To register, just log in with a desired username and password – and a user</p>')
		$('#overlay').show()
	$('#overlay-bg').click () ->
		$('#overlay-bg').hide()
		$('#overlay-inner').html('')
		$('#overlay').hide()
	$('.youtube').addClass('shadow');
	$('.feed-item p').click () ->
		$('#overlay-inner').html('')
		$('#overlay-inner').append('<iframe frameborder="0" height="294" src="http://www.youtube.com/embed/' + $(this).data('youtube') + '?rel=0&amp;hd=1&amp;wmode=Opaque&amp;showinfo=0&amp;iv_load_policy=3" width="520">allowfullscreen&gt;</iframe>')
		$('#overlay-inner').append('<h2>'+$(this).data('title')+'</h2>')
		$('#overlay-inner').append('<p>'+$(this).data('runtime')+' minutes</p>')
		$('#overlay-inner').append('<p>'+$(this).data('description')+'</p>')
		$('#overlay').center()
		$('#overlay-bg').show()
		$('#overlay').show()

jQuery.fn.center = () ->
	this.css("position","absolute")
	this.css("top", (($(window).height() - this.outerHeight()) / 2) + $(window).scrollTop() + "px")
	this.css("left", (($(window).width() - this.outerWidth()) / 2) + $(window).scrollLeft() + "px")
	return this