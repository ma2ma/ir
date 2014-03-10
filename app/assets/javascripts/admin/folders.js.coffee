# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
	$("#add_folder_group").select2
		createSearchChoice: (term, data) ->
			if $(data).filter( -> this.text.localeCompare(term) is 0 ).length is 0
				{id:term, text:term}
		multiple: false,
		data: ->
			result = JSON.parse $("#add_folder_group_data").val()
			li = []
			for item in result
				li.push({id: item['_id']['$oid'],text: item['name'] })
			return { text:'text', results: li }

	$("#edit_folder_group").select2
		createSearchChoice: (term, data) ->
			if $(data).filter( -> this.text.localeCompare(term) is 0 ).length is 0
				{id:term, text:term}
		multiple: false,
		data: ->
			result = JSON.parse $("#edit_folder_group_data").val()
			li = []
			for item in result
				li.push({id: item['_id']['$oid'],text: item['name'] })
			return { text:'text', results: li }
	$("#edit_folder_group").select2 "val", $("#edit_folder_group_value").val()

	
	$("#add_folder_submit").click  (event) ->
  		if $(this).parent().parent().parent().valid() is false
    		#$("#error-text").text "填写信息不完整。"
    		false
    $("#edit_folder_submit").click  (event) ->
  		if $(this).parent().parent().parent().valid() is false
    		#$("#error-text").text "填写信息不完整。"
    		false

    #Make the dashboard widgets sortable Using jquery UI
	$(".connectedSortable").sortable(
	  placeholder: "sort-highlight"
	  connectWith: ".connectedSortable"
	  handle: ".box-header, .nav-tabs"
	  forcePlaceholderSize: true
	  dropOnEmpty: true
	  zIndex: 999999
	).disableSelection()
	$(".box-header, .nav-tabs").css "cursor", "move"

	##############################################
	#配置文档属性页面
	##############################################
	hide_option =  -> 
		$("#add_property_maxmin_pane").hide();
		$("#add_property_strformat_pane").hide();
		$("#add_property_ext_pane").hide();
		$("#add_property_options_pane").hide();
		$("#add_property_xy_pane").hide();
		$("#add_property_filetype_pane").hide();
	fix_custom_option = (arg) ->
		hide_option();
		switch arg
			when "string"
				$("#add_property_maxmin_pane").slideDown();
				$("#add_property_ext_pane").slideDown();
				$("#add_property_strformat_pane").slideDown();
			when "text"
				$("#add_property_maxmin_pane").slideDown();
				$("#add_property_strformat_pane").slideDown();
			when "integer","number"
				$("#add_property_maxmin_pane").slideDown();
				$("#add_property_ext_pane").slideDown();
			when "enum","muli_enum"
				$("#add_property_options_pane").slideDown();
			when "file"
				$("#add_property_maxmin_pane").slideDown();
				$("#add_property_filetype_pane").slideDown();
			when "data_sheet"
				$("#add_property_xy_pane").slideDown();
			when "array"
				$("#add_property_maxmin_pane").slideDown();
			else

	$("#enum_options").tagsManager hiddenTagListName: "addhidden-property[enum_option]"
	$("#file_type").tagsManager hiddenTagListName: "addhidden-property[file_type]"
	
	fix_custom_option('string');
	$('#add_property_custom_pane').hide();
	$('#add_property_custom').on "switch-change", (e, data) ->
        $('#add_property_custom_pane').slideToggle()

    $('#add_property_adv_pane').hide();
	$('#add_property_adv').on "switch-change", (e, data) ->
        $('#add_property_adv_pane').slideToggle()

    $("#add_property_type").on 'change', (e)->
    	fix_custom_option(e.val)
	
	


